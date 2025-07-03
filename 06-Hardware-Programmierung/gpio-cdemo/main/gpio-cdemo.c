#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

extern void init_gpio(int gpio_pin);
extern void toggle_gpio(int gpio_pin);

void app_main(void) {
  const uint8_t LED_PIN = 10;

  init_gpio(LED_PIN);

  while (1) {
    toggle_gpio(LED_PIN);
    vTaskDelay(150);
  }
}
