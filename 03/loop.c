#include "types.h"
#include "user.h"

int loop()
{
	int pid = getpid();

	printf(1, "runing process:%d priority:%d\n", pid, get_proc_priority(pid));
	while (1)
	{
		if(get_proc_count(pid) > 2000)
		{
			sleep(5000);
			break;
		}
	}
	exit();
}