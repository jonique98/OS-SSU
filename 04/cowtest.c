#include "types.h"
#include "stat.h"
#include "user.h"

int a = 1;

void test()
{
    printf(1,"fork 전 free page의 갯수 = %d\n",getNumFreePages());

    printf(1,"parent: a = %d\n",a);
    int pid = fork();
    if(pid==0)
    {
        printf(1,"Child: a = %d\n",a);
        printf(1,"자식 프로세스를 생성한 후 free page의 갯수 = %d\n",getNumFreePages());
        a = 2;
        printf(1,"Child: a = %d\n",a);
        printf(1,"a를 수정한 후 free page의 갯수 = %d\n",getNumFreePages());
        exit();
    }
    wait();
    printf(1,"Parent: a = %d\n",a);
    printf(1,"wait이후 free page의 갯수 = %d\n",getNumFreePages());
    return ;
}

int main(void)
{
    printf(1,"cowtest 시작\n\n");
    test();
    printf(1,"cowtest 종료\n");

    exit();
}
