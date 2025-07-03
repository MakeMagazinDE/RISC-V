.global app_main

.section .rodata

message: .asciz "%d, %d, %d, %d, %d, %d, %d, %d, %d\n"
length:  .asciz "Anzahl Zeichen: %d\n"

.text

app_main:
    la   a0, message
    li   a1, 1
    li   a2, 2
    li   a3, 3
    li   a4, 4
    li   a5, 5
    li   a6, 6
    li   a7, 7
    addi sp, sp, -8
    li   t0, 9
    sw   t0, 4(sp)
    li   t0, 8
    sw   t0, 0(sp)
    call printf
    addi sp, sp, 8

    # Ergebnis (a0) ausgeben.
    mv   a1, a0
    la   a0, length
    call printf

loop:
    li   a0, 150
    call vTaskDelay

    j    loop
