# 과제 2

평생교육학과 20181259 조수민

# xv_6 forknexec

---

forknexec 시스템 콜

프로세스를 만들고(fork) 유저 application을 실행(exec)하는 시스템 콜

# 개발환경

---

m1 macOS Monterey arm64

# 수정 및 작성한 소스코드

---

### Makefile

- line30 : forknexec의 오브젝트 파일 추가
- line186 : forknexec의 테스트 어플리케이션 forknexectest 추가
- line256 : forknexectest 소스파일 추가

### forknexec

- forknexec 함수의 wrapper 함수를 정의한 파일

### forknexectest_err.c

- forknexec 인자 에러를 테스트하기 위한 함수

### proc.c

- line537 ~ : forknexec 함수 정의

### syscall.c

- line106 : forknexec wrapper 함수 참조 선언
- line130 : 시스템 콜 함수를 배열에 저장하여 시스템 콜 넘버와 주소값 연결

### syscall.h

- line23 : 시스템 콜 넘버 선언

### user.h

- line26 : forknexec 함수 헤더 선언

### usys.S

- 시스템 콜 호출을 위한 어셈블리 코드를 정의

# 과제 수행 중 발생한 문제점과 해결 방법

---

### 문제점

1. 시스템 콜 호출에 wrapper함수를 사용하는 구조에 익숙하지 않아서 초기엔 forknexec을 직접 호출함
2. forknexec.c 함수의 헤더파일 include 중 정의가 중복되는 부분이 있었음

### 해결 방법

1. 다른 시스템 콜 호출 방식을 레퍼런스로 공부하고 forknexec.c 파일을 추가, wrapper 함수를 정의하고 구조를 변경
2. include하는 순서를 변경
