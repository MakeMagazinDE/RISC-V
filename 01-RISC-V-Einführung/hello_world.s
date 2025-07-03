.global app_main

app_main:
    la a0, helloworld
    call puts
    j app_main

.data
helloworld: .asciz "Hello, world!"
