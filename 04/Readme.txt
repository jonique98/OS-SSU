cowtest.c - copy on write 테스트 함수

kalloc.c - free_pages와 pgrefcount 변수 정의, kalloc, kfree, freerange 등의 함수에서 해당 변수 초기화 및 증감 연산

mmu.h - 주소값 비트 연산 매크로 정의

syscall.c - getNumFreePages 시스템콜

trap.c - T_PGFLT 발생 시 핸들러 추가

vm.c - copyuvm수정을 통해 자식 프로세스가 부모 프로세스의 페이지 테이블을 참조하고, read-only하게 설정, pagefault를 통해 pagefault handler 정의
