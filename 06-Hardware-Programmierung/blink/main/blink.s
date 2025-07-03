.global app_main

.set LED_PIN, 10

.set GPIO_BASE,       0x60091000
.set GPIO_OUT_REG,    0x04
.set GPIO_ENABLE_REG, 0x20

.set IO_MUX_MATRIX,     0x60090000
.set IO_MUX_GPIO10_REG, 0x04 + LED_PIN * 4

.text

app_main:
    li   a0, GPIO_BASE

    lw   a1, GPIO_ENABLE_REG(a0)
    ori  a1, a1, (1 << LED_PIN)
    sw   a1, GPIO_ENABLE_REG(a0)

    li   a0, IO_MUX_MATRIX

    lw   a1, IO_MUX_GPIO10_REG(a0)

    # IO_MUX_GPIO10_MCU_SEL löschen
    li   a2, 0xffff8fff
    and  a1, a1, a2

    # IO_MUX_GPIO10_MCU_SEL setzen
    li   a2, 0x00001000
    or   a1, a1, a2

    # IO_MUX_GPIO10_FUN_DRV löschen
    li   a2, 0xfffff3ff
    and  a1, a1, a2

    # IO_MUX_GPIO10_FUN_DRV setzen
    li   a2, 0x00000c00
    or   a1, a1, a2

    sw   a1, IO_MUX_GPIO10_REG(a0)

loop:
    li   a0, GPIO_BASE
    lw   a1, GPIO_OUT_REG(a0)
    xori a1, a1, (1 << LED_PIN)
    sw   a1, GPIO_OUT_REG(a0)

    li   a0, 150
    call vTaskDelay

    j    loop

