Makefile
	컴파일 PREFIX i686-elf- 로 지정
	QEMU 패스 구체적 명
	CFLAGS에  -Werror 없앰
	(다른 환경에서 빌드 하기 위해서는 다시 수정 필요)

helloworld.c
	helloworld를 출력하는 c언어 소스코드
helloworld
	helloworld의 실행파
helloworld.o
	helloworld.c를 컴파일 한 목적코드
helloworld.asam
	어셈블리어 소스코드
helloworld.d
	소스 의존성 파일
helloworld.sym
	디버깅에 필요한 함수 및 변수를 저장한 심볼 파일

