#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "elf.h"

int sys_forknexec(void) {
    char *path, *argv[MAXARG];
    int i;
    uint uargv, uarg;

    if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
      return -1;
    }
    memset(argv, 0, sizeof(argv));
    for(i=0;; i++){
      if(i >= NELEM(argv))
        return -1;
      if(fetchint(uargv+4*i, (int*)&uarg) < 0)
        return -1;
      if(uarg == 0){
        argv[i] = 0;
        break;
      }
      if(fetchstr(uarg, &argv[i]) < 0)
        return -1;
    }

    const int pid = forknexec((const char*)path, (const char**)argv);

    return pid;
}