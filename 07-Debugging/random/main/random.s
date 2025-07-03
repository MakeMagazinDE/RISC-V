.global app_main

.set LPPERI_RNG_DATA_REG, 0x600B2808

.section .rodata

message: .asciz "Zufallszahl: %d\n"

.text

app_main:
    call bootloader_random_enable

loop:
    li   s1, LPPERI_RNG_DATA_REG
    lw   s2, 0(s1)     # s2 enthält die neue Zufallszahl
    li   s3, 6
    remu s2, s2, s3    # s2 = s2 % 6
    addi s2, s2, 1     # s2 = s2 + 1
    
    la   a0, message
    mv   a1, s2
    call printf

    li   a0, 150
    call vTaskDelay

    j    loop

