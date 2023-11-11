#include "types.h"
#include "user.h"

int make_process_loop()
{
	int pid = getpid();

	printf(1, "runing process:%d priority:%d\n", pid, get_proc_priority(pid));
	while (1)
	{
	}
	exit();
}

int fork_process_with_priority(int priority)
{
	int pid = fork();
	if (pid > 0)
	{
		set_proc_priority(pid, priority);
	}
	else if (pid == 0)
	{
		make_process_loop();
		exit();
	}
	return pid;
}

int starvation_test()
{
	printf(1, "starvation test\n");
	printf(1, "starvation을 예방할 수 있는지 테스트\n\n");

	//부모 프로세스의 우선순위를 낮게(7) 설정
	set_proc_priority(getpid(), 7);
	printf(1, "parent process:%d created with priority:%d\n",getpid(), get_proc_priority(getpid()));
	printf(1, "🙏wait please🙏\n\n");

	//우선순위가 높은 프로세스를 무한루프로 생성
	int pid1 = fork_process_with_priority(3);
	int pid2 = fork_process_with_priority(2);

	//프로세스를 runnable 상태로 만들기 위해 sleep
	sleep(20);

	//stratvation이 발생한다면 우선순위가 높은 위에 두 프로세스가 영원히 돌게 되고 아래 문장은 출력되지 않음
	kill(pid1);
	kill(pid2);
	printf(1, "\nparent process:%d end with priority:%d\n", getpid(), get_proc_priority(getpid()));
	printf(1, "starvation test success✅\n", pid1);

	wait();
	wait();
	printf(1, "----------------------------------------\n\n");
	return 0;
}

int fork_priority_test()
{
	printf(1, "fork priority test\n");
	printf(1, "fork한 프로세스의 우선순위가 부모 프로세스와 같은지 테스트\n\n");

	//부모 프로세스의 우선순위를 임의로(8)로 설정하고 fork
	set_proc_priority(getpid(), 8);
	int parent_priority = get_proc_priority(getpid());
	int pid = fork();
	if (pid == 0)
	{
		int child_priority = get_proc_priority(getpid());
		//자식 프로게스의 우선순위가 부모와 같은지 확인
		if (child_priority == parent_priority)
		{
			printf(1, "parent priority:%d\nchild priority:%d\n", parent_priority, child_priority);
			printf(1, "fork priority test success✅\n");
		}
		else
		{
			printf(1, "parent priority:%d\nchild priority:%d\n", parent_priority, child_priority);
			printf(1, "fork priority test failed❌\n");
		}
		exit();
	}
	wait();
	printf(1, "----------------------------------------\n\n");
	return pid;
}

int default_priority_test()
{
	printf(1, "\ndefault priority test\n");
	printf(1, "priority의 디폴트 값이 5인지 테스트\n\n");

	//프로세스가 생성되자 마자 디폴트 우선순위를 확인
	int priority = get_proc_priority(getpid());
	if (priority == 5)
		printf(1, "default priority:%d\ndefault test success✅\n", get_proc_priority(getpid()));
	else
		printf(1, "default priority:%d\ndefault test failed❌\n", get_proc_priority(getpid()));
	printf(1, "----------------------------------------\n\n");

	return 0;
}

int preemptive_test()
{

	printf(1, "preemptive test\n");
	printf(1, "우선순위가 높은 프로세스가 선점형으로 실행되는지 테스트\n\n");

	//효율적인 테스트를 위해 부모 프로세스의 우선순위를 가장 낮게 설정
	set_proc_priority(getpid(), 1);

	//부모 프로세스가 sleep 할 때 마다,
	//프로세스 테이블의 runnable 중 가장 우선순위의 프로세스가 선점적으로 실행되어야 함
	int pid1 = fork_process_with_priority(9);
	sleep(10);
	int pid2 = fork_process_with_priority(5);
	sleep(10);
	int pid3 = fork_process_with_priority(3);
	sleep(10);

	//실행 안되는 프로세스
	int pid4 = fork_process_with_priority(10);
	sleep(10);


	kill(pid1);
	kill(pid2);
	kill(pid3);
	kill(pid4);
	printf(1, "\n더 낮은 priority의 프로세스가 생성되면 선점으로 실행돼야 함\n결과 확인 요망\n");
	wait();
	wait();
	wait();
	wait();
	printf(1, "----------------------------------------\n\n");

	return 0;
}

int main()
{
	default_priority_test();

	preemptive_test();

	fork_priority_test();

	starvation_test();

	exit();
}
