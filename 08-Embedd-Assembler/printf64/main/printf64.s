.global app_main

.section .rodata

message: .asciz "64-Bit-Wert: 0x%llx\n"

.text

app_main:
    la   a0, message
    li   a2, 0xdeadbeef
    li   a3, 0x12345678
    call printf

loop:
    li   a0, 150
    call vTaskDelay

    j    loop
