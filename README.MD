# 01
## helloworld! 출력하기

###helloworld.c
```
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char **argv){
	printf(1,"Hello World\n");
	exit();
}

```

# 02
## forknexec 시스템 콜 추가
fork이후 생성된 프로세스가 exec을 통해 파라미터로 받은 유저 어플리케이션을 실행하는 시스템콜

### proc.c
```
int forknexec(const char *path, const char **args)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -2;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -2;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  char *s, *last;
  int off;
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();

  if((ip = namei((char *)path)) == 0){
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; args[argc]; argc++) {
    if(argc >= MAXARG)
      return -1;
    sp = (sp - (strlen(args[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, args[argc], strlen(args[argc]) + 1) < 0)
      return -1;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // args pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=(char *)path; *s; s++)
    if(*s == '/')
      last = s+1;
  safestrcpy(np->name, last, sizeof(np->name));

  // Commit to the user image.
  oldpgdir = np->pgdir;
  np->pgdir = pgdir;
  np->sz = sz;
  np->tf->eip = elf.entry;  // main
  np->tf->esp = sp;
  switchuvm(np);
  freevm(oldpgdir);

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return wait();

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -2;
}

```

# 03
## priority 스케쥴링 구현
proc.c의 scheduler 함수를 수정해서 priority 스케쥴링을 구현한다.

기아 현상을 예방하위해 우선순위 순으로 queue를 통해 구현, 우선순위 프로세스를 먼저 실행하고 더 많은 실행시간을 부여한다.

### proc.c
```
void scheduler(void) {

  const long priority_slice = 100;

  struct proc *readyQueue[NPROC];

  struct proc *p;
  struct proc *run_proc;
  struct cpu *c = mycpu();
  c->proc = 0;

  for (;;) {
    sti();
    acquire(&ptable.lock);

    int length = 0;
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
      if (p->state != RUNNABLE)
        continue;
      readyQueue[length++] = p;
    }

    for (int i = 0; i < length - 1; i++) {
      for (int j = i + 1; j < length; j++) {
        if (readyQueue[j]->priority < readyQueue[i]->priority) {
          struct proc *temp = readyQueue[i];
          readyQueue[i] = readyQueue[j];
          readyQueue[j] = temp;
          }
      }
    }

    for (int i = 0; i < length; i++) {
      run_proc = readyQueue[i];
      for(int j = 0; j < priority_slice - ((run_proc->priority - 1) * 10); j++) {
        if(run_proc->state != RUNNABLE)
          break;

        c->proc = run_proc;
        switchuvm(run_proc);
        run_proc->state = RUNNING;

        (run_proc->count)++;
        swtch(&(c->scheduler), run_proc->context);
        switchkvm();
      }
      c->proc = 0;
    }
  release(&ptable.lock);
  }
}

```

# 04
## copy-on-write 구현
기존 fork를 통해 생성된 프로세스가 페이지 테이블에서 같은 물리 메모리를 가리키도록 하고, 프로세스가 해당 물리 메모리에 쓰기를 시도할 때, pagefault를 발생시켜서 새로운 물리 메모리(페이지 테이블)를 할당, 새로운 메모리를 가리키도록 한다.

### vm.c

```
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

 if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");

    *pte &= ~PTE_W;  // read-only로 만듬
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    // if((mem = kalloc()) == 0)
      // goto bad;
    // memmove(mem, (char*)P2V(pa), PGSIZE);      
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    inc_refcount(pa);
  }
  lcr3(V2P(pgdir));    
  return d;

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}

void pagefault()
{
    uint va = rcr2();
    if(va < 0){
      panic("pagefault: rcr2 < 0");
      return;
    }
    pte_t *pte = walkpgdir(myproc()->pgdir, (void*)va, 0);

    uint pa = PTE_ADDR(*pte);
    uint refCount = get_refcount(pa);
    char *mem;

    if(refCount > 1) {
      if((mem = kalloc()) == 0) {
        panic("allocate failed\n");
        return;
      }
      memmove(mem, (char *)P2V(pa), PGSIZE);
      *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;

      dec_refcount(pa);
    }
    else if(refCount == 1)
      *pte |= PTE_W;

    lcr3(V2P(myproc()->pgdir));
}


```

