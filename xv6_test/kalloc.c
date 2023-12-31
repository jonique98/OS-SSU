// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "proc.h"


extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
} kmem;

uint num_free_pages; // number of free pages
uint pgrefcount[PHYSTOP >> PGSHIFT]; // page reference count
// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.

uint get_refcount(uint p) {
  if(p >= PHYSTOP || p < (uint)V2P(end))
    panic("get_refcount");

  uint refcount = pgrefcount[p >> PGSHIFT];
  return refcount;  
}

void inc_refcount(uint p) {
  if(p >= PHYSTOP || p < (uint)V2P(end))
    panic("inc_refcount"); 

  ++pgrefcount[p >> PGSHIFT];
}

void dec_refcount(uint p){
  if(p >= PHYSTOP || p < (uint)V2P(end))
    panic("dec_refcount");

  --pgrefcount[p >> PGSHIFT];
}

uint getNumFreePages(void) {
 if(kmem.use_lock)
    acquire(&kmem.lock);
  uint free_pages = num_free_pages;
  if(kmem.use_lock)
    release(&kmem.lock);
  return free_pages;
}

void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  num_free_pages = 0;
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    pgrefcount[V2P(p) >> PGSHIFT] = 0;          // initialse the reference count to 0
    kfree(p);
  }
}
//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  if(kmem.use_lock)
    acquire(&kmem.lock);

  r = (struct run*)v;

  if(get_refcount(V2P(v)) > 0)         
    --pgrefcount[V2P(v) >> PGSHIFT];

  if(get_refcount(V2P(v)) == 0){
    memset(v, 1, PGSIZE);
    ++num_free_pages;
    r->next = kmem.freelist;
    kmem.freelist = r;

  }
  if(kmem.use_lock)
    release(&kmem.lock);
}


// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r){
    --num_free_pages;                                  
    kmem.freelist = r->next;
    pgrefcount[V2P((char*)r) >> PGSHIFT] = 1;
  }
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}

