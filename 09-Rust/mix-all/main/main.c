#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

extern int rust_main(void);
extern void init_gpio(int gpio_pin);
extern void toggle_gpio(int gpio_pin);

void app_main(void) {
    printf("Hello world from C!\n");

    int result = rust_main();

    printf("Rust returned code: %d\n", result);

    const uint8_t LED_PIN = 10;

    init_gpio(LED_PIN);

    while (1) {
      toggle_gpio(LED_PIN);
      vTaskDelay(150);
    }
}
