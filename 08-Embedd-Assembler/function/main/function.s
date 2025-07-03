.global app_main, sum

          .struct 0
save_fp:  .space  4
save_ra:  .space  4
variable: .space  4
          .balign 8

stackframe_size = . - save_fp

.section .rodata

message:   .asciz "Summe: %d\n"
variables: .asciz "Variable: %d\n"

.text

sum:
    # Prolog der Funktion
    addi sp, sp, -stackframe_size
    sw   fp, save_fp(sp)
    sw   ra, save_ra(sp)
    addi fp, sp, +stackframe_size

    li   t0, 42
    # Variable über den Stack-Pointer adressieren
    sw   t0, variable(sp)

    # Alle Argumente in t0 aufsummieren
    mv   t0, a0
    add  t0, t0, a1
    add  t0, t0, a2
    add  t0, t0, a3
    add  t0, t0, a4
    add  t0, t0, a5
    add  t0, t0, a6
    add  t0, t0, a7
    # 9. Argument über Frame-Pointer adressieren
    lw   t1, 0(fp)
    add  t0, t0, t1
    
    # Summe der Argumente ausgeben
    la   a0, message
    mv   a1, t0
    call printf

    # Lokale Variable ausgeben
    la   a0, variables
    lw   a1, variable(sp)
    call printf

    # Epilog der Funktion
    lw   ra, save_ra(sp)
    lw   fp, save_fp(sp)
    addi sp, sp, +stackframe_size
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
    addi sp, sp, -4
    li   t0, 9
    sw   t0, 0(sp)
    call sum
    addi sp, sp, 4

loop:
    li   a0, 150
    call vTaskDelay

    j    loop

