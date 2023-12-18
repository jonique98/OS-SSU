#include "types.h"
#include "user.h"

int fork_process_with_priority(int priority)
{
	int pid = fork();
	if (pid > 0)
	{
		set_proc_priority(pid, priority);
	}
	else if (pid == 0)
	{
		char *argv[] = {"loop", 0};
		exec(argv[0], argv);
		exit();
	}
	return pid;
}

int default_priority_test()
{
	printf(1, "\ndefault priority test\n");
	printf(1, "priority의 디폴트 값이 5인지 테스트\n\n");

	//프로세스가 생성되자 마자 디폴트 우선순위를 확인
	int priority = get_proc_priority(getpid());
	if (priority == 5)
		printf(1, "default priority:%d\ndefault priority test success✅\n", get_proc_priority(getpid()));
	else
		printf(1, "default priority:%d\ndefault priority test failed❌\n", get_proc_priority(getpid()));
	printf(1, "\n----------------------------------------\n\n");

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
	printf(1, "\n----------------------------------------\n\n");
	return pid;
}

int preemptive_test() {
  printf(1, "preemptive test\n");
  printf(1, "우선순위가 높은 프로세스가 실행되는지 테스트\n\n");

	//부모프로세스가 먼저 끝나지 않기 위해 우선순위를 높게 설정
	set_proc_priority(getpid(), 10);

    int num_processes = 10;

    int pids[num_processes];
    for (int i = 0; i < num_processes; i++) {
        pids[i] = fork_process_with_priority(num_processes - i);
    }
    sleep(100);

    process_info();

    for (int i = 0; i < num_processes; i++) {
        kill(pids[i]);
    }

    for (int i = 0; i < num_processes; i++) {
        wait();
    }

	printf(1, "우선순위인 프로세스부터 실행되는 지 확인, 우선순위대로 스케쥴링 횟수 확인\n");
	printf(1, "\n----------------------------------------\n\n");
  return 0;
}

int starvation_test() {
    printf(1, "starvation test\n");
    printf(1, "starvation을 예방할 수 있는지 테스트\n\n");

    // 부모 프로세스 다시 default priority로 설정
    set_proc_priority(getpid(), 5);

    int num_processes = 5;
    int pids[num_processes];

    // 2개의 프로세스 생성
    for (int i = 0; i < 2; i++) {
        pids[i] = fork_process_with_priority(2);
    }

		pids[2] = fork_process_with_priority(10);

		//우선순위가 더 낮은 프로세스 계속 생성
    for (int i = 0; i < 2; i++) {
        pids[i + 3] = fork_process_with_priority(2);
    }

    sleep(100);

    // 모든 프로세스 정보 출력
    process_info();

    // 모든 프로세스 종료
    for (int i = 0; i < num_processes; i++) {
        kill(pids[i]);
    }

    // 모든 프로세스 종료 대기
    for (int i = 0; i < num_processes; i++) {
        wait();
    }

    printf(1, "priority 10의 프로세스가 스케줄러에 의해 실행된 적이 있다면 starvation 없다는 의미\n");
    printf(1, "\n----------------------------------------\n\n");

    return 0;
}

// int watch_starvation(){
// 	 set_proc_priority(getpid(), 5);

// 	int pid1 = fork_process_with_priority(1);
// 	//pid1을 runnable에 올리기 위해
// 	sleep(10);

// 	int pid2 = fork_process_with_priority(10);
// 	int pid3 = fork_process_with_priority(1);
// 	sleep(10);

// 	process_info();
// 	kill(pid1);
// 	kill(pid2);
// 	kill(pid3);
// 	wait();
// 	wait();
// 	wait();

// 	printf(1, "priority 10의 프로세스가 스케줄러에 의해 실행된 적이 없다면 starvation\n");
// }

int main()
{
	default_priority_test();

	fork_priority_test();

	preemptive_test();

	starvation_test();

	// watch_starvation();

	exit();
}
