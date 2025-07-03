.global app_main

.section .rodata

message: .asciz "Durchschnitt: %d\n"

.text

calc_avg10:
    mv   t0, x0
    add  t0, t0, a0
    add  t0, t0, a1
    add  t0, t0, a2
    add  t0, t0, a3
    add  t0, t0, a4
    add  t0, t0, a5
    add  t0, t0, a6
    add  t0, t0, a7
    lw   t1, 0(sp)
    add  t0, t0, t1
    lw   t1, 4(sp)
    add  t0, t0, t1
    li   t1, 10
    divu a0, t0, t1
    ret

app_main:
    la   a0, 1
    li   a1, 2
    li   a2, 3
    li   a3, 4
    li   a4, 5
    li   a5, 6
    li   a6, 7
    li   a7, 8
    addi sp, sp, -8
    li   t0, 10
    sw   t0, 4(sp)
    li   t0, 9
    sw   t0, 0(sp)
    call calc_avg10
    addi sp, sp, 8

    # Ergebnis (a0) ausgeben.
    mv   a1, a0
    la   a0, message
    call printf

loop:
    li   a0, 150
    call vTaskDelay

    j    loop
