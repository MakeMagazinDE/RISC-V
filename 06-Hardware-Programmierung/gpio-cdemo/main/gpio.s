.global init_gpio, toggle_gpio

.set GPIO_BASE,       0x60091000
.set GPIO_OUT_REG,    0x04
.set GPIO_ENABLE_REG, 0x20

.set IO_MUX_MATRIX,    0x60090000
.set IO_MUX_GPIOn_REG, 0x04

.set IO_MUX_GPIOn_FUN_DRV, 10
.set IO_MUX_GPIOn_MCU_SEL, 12
.set DRIVE_STRENGTH, 0b11
.set FUNCTION_GPIO, 1

.text

# a0 -> GPIO_PIN
init_gpio:
    li   t0, GPIO_BASE

    lw   t1, GPIO_ENABLE_REG(t0)
    li   t2, 1
    sll  t2, t2, a0
    or   t1, t1, t2
    sw   t1, GPIO_ENABLE_REG(t0)

    li   t0, IO_MUX_MATRIX
    add  t0, t0, IO_MUX_GPIOn_REG
    mv   t1, a0     # t0 = GPIO_PIN
    slli t1, t1, 2  # t0 = GPIO_PIN * 4
    add  t0, t0, t1 # t0 = IO_MUX_MATRIX + IO_MUX_GPIOn_REG + GPIO_PIN * 4

    lw   t1, (t0)

    # IO_MUX_GPIOn_MCU_SEL löschen
    li   t2, ~(0b111 << IO_MUX_GPIOn_MCU_SEL)
    and  t1, t1, t2

    # IO_MUX_GPIOn_MCU_SEL setzen
    li   t2, (FUNCTION_GPIO << IO_MUX_GPIOn_MCU_SEL)
    or   t1, t1, t2

    # IO_MUX_GPIOn_FUN_DRV löschen
    li   t2, ~(0b11 << IO_MUX_GPIOn_FUN_DRV)
    and  t1, t1, t2

    # IO_MUX_GPIOn_FUN_DRV setzen
    li   t2, (DRIVE_STRENGTH << IO_MUX_GPIOn_FUN_DRV)
    or   t1, t1, t2

    sw   t1, (t0)
    ret

# a0 -> GPIO_PIN
toggle_gpio:
    li   t0, GPIO_BASE
    lw   t1, GPIO_OUT_REG(t0)
    li   t2, 1
    sll  t2, t2, a0
    xor  t1, t1, t2
    sw   t1, GPIO_OUT_REG(t0)
    ret
