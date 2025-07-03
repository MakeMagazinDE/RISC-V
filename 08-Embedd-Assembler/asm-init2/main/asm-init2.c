#include <stdio.h>

void app_main() {
  uint32_t counter;
  uint32_t max_counter;

  asm (
      "sw x0, %0\n"
      "li t0, 42\n"
      "sw t0, %1\n"

      : "=m" (counter), "=m" (max_counter)
  );

  printf("counter=%ld, max_counter=%ld\n", counter, max_counter);
}
