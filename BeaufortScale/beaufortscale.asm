section .data
    out_str0    db "Enter a wind speed in knots : ", 0
    in_str0     db "%d",0

    wind_force0 db "Calm", 0xa, 0
    wind_force1 db "Light air", 0xa, 0
    wind_force2 db "Breeze", 0xa, 0
    wind_force3 db "Gale", 0xa, 0
    wind_force4 db "Storm", 0xa, 0
    wind_force5 db "Hurricane", 0xa, 0

section .text

extern printf
extern scanf

global main

main:
    push        rbp
    mov         rbp, rsp
    sub         rsp, 16

    mov         rdi, out_str0
    call        printf

    ;; Asks the user to enter the wind speed and stores them in [rsp-4]
    mov         rdi, in_str0
    mov         rsi, rbp
    sub         rsi, 4
    call        scanf

    ;; Compare the wind speed to the numbers from the beaufort scale, jump
    ;; to a label, where the correspondending string-address gets copied to
    ;; rdi and then jump to the end, where the string gets printed.
    cmp         [rbp-4], dword 1
    jbe         wind_f_0
    cmp         [rbp-4], dword 3
    jbe         wind_f_1
    cmp         [rbp-4], dword 27
    jbe         wind_f_2
    cmp         [rbp-4], dword 47
    jbe         wind_f_3
    cmp         [rbp-4], dword 63
    jbe         wind_f_4
    jmp         wind_f_5

wind_f_0:
    mov         rdi, wind_force0
    jmp         prnt_res
wind_f_1:
    mov         rdi, wind_force1
    jmp         prnt_res
wind_f_2:
    mov         rdi, wind_force2
    jmp         prnt_res
wind_f_3:
    mov         rdi, wind_force3
    jmp         prnt_res
wind_f_4:
    mov         rdi, wind_force4
    jmp         prnt_res
wind_f_5:
    mov         rdi, wind_force5
    jmp         prnt_res

prnt_res:
    call        printf
    add         rsp, 16
    pop         rbp
    ret
