#include <stdio.h>

void app_main() {
  uint32_t counter;
  uint32_t max_counter;

  asm (
      "sw x0, %[counter]\n"
      "li t0, 42\n"
      "sw t0, %[max_counter]\n"

      : [counter] "=m" (counter), [max_counter] "=m" (max_counter)
      : /* No InputOperands */
      : "t0"
  );

  printf("counter=%ld, max_counter=%ld\n", counter, max_counter);
}
