#include <stdio.h>

void app_main() {
  printf("Hello, world!\n");
  asm ("nop\n"
       "\tnop\n");
}
