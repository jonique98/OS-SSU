#include "types.h"
#include "user.h"


int main(int argc, char *argv[]) {
  const char *args[] = {"wrong arguments", "NEWPROC_CALL", 0};
  int ret;
  printf(1, "test forknexec syscall\n");
  ret = forknexec(args[0], args);
  printf(1, "returned %d\n", ret);
  exit();
}
