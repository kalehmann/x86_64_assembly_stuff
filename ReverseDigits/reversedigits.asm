section .data
    out_str0    db "Enter a two-digits number : ", 0
    out_str1    db "The reversal is : %d%d", 0ax, 0
    in_str0     db "%d",0

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

    ;; Get number into [rbp-4]
    mov         rdi, in_str0
    mov         rsi, rbp
    sub         rsi, 4
    call        scanf

    ;; Divide the number through 10, store the reminder in edx (second digit)
    ;; and the first digit in eax
    mov         ecx, 10
    mov         edx, 0
    mov         eax, [rbp-4]
    div         ecx

    ;; Print digits in reversed order
    mov         rdi, out_str1
    mov         esi, edx
    mov         edx, eax
    call        printf

    add         rsp, 16
    pop         rbp
    ret
