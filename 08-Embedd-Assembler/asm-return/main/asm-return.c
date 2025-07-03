#include <stdio.h>

int foo() {
  asm ("li a0, 42");
}

void app_main() {
  printf("foo: %d\n", foo());
}
