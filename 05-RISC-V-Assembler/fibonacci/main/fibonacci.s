.global app_main

.set max_index, 9

.section .rodata

title: .asciz "Die ersten %d Fibonacci-Zahlen lauten:\n"
.p2align 2
number: .asciz "%3d: %d\n"

.text

app_main:
    la   a0, title      # Titel-Zeile ausgeben
    li   a1, max_index + 1
    call printf

    li   s2, 0          # s2 = fib(0)
    li   s3, 1          # s3 = fib(1)

    la   a0, number     # fib(0) ausgeben
    mv   a1, x0
    mv   a2, s2
    call printf

    la   a0, number     # fib(1) ausgeben
    li   a1, 1
    mv   a2, s3
    call printf

    li   s4, 2          # s4 ist der Index; wir starten bei fib(2)
loop:
    mv   s5, s3         # s3 retten
    add  s3, s3, s2     # s3 = fib(n) = fib(n - 1) + fib(n - 2)
    mv   s2, s5         # s2 ist jetzt das alte s3

    la   a0, number     # fib(n) ausgeben
    mv   a1, s4
    mv   a2, s3
    call printf

    li   t0, max_index
    bge  s4, t0, end    # Maximaler Index erreicht?
    addi s4, s4, 1
    j    loop

end:
    li   a0, 1000
    call vTaskDelay     # Watchdog besänftigen
    j    end
