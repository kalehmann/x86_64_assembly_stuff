section .data
    out_str0    db "Enter ISBN : ", 0
    out_str1    db "GS1 prefix : %d", 0ax, 0
    out_str2    db "Group identifier : %d", 0ax, 0
    out_str3    db "Publisher code : %d", 0ax, 0
    out_str4    db "Item number : %d", 0ax, 0
    out_str5    db "Check digit : %d", 0ax, 0
    in_str0     db "%d-%d-%d-%d-%d", 0

section .text

extern scanf
extern printf

global main

main:
    push        rbp
    mov         rbp, rsp

    mov         rdi, out_str0
    call        printf
    sub         rsp, 32       ; allocate 32 byte on stack

    mov         rdi, in_str0
    mov         rsi, rbp
    sub         rsi, 4        ; rbp-4   :  GS1 prefix
    mov         rdx, rbp
    sub         rdx, 8        ; rbp-8   :  Group identifier
    mov         rcx, rbp
    sub         rcx, 12       ; rbp-12  :  Publisher code
    mov         r8,  rbp
    sub         r8,  16       ; rbp-16  :  Item number
    mov         r9,  rbp
    sub         r9,  20       ; rbp-20  :  Check digit
    call        scanf

    mov         rdi, out_str1
    mov         rsi, [rbp-4]
    call        printf

    mov         rdi, out_str2
    mov         rsi, [rbp-8]
    call        printf

    mov         rdi, out_str3
    mov         rsi, [rbp-12]
    call        printf

    mov         rdi, out_str4
    mov         rsi, [rbp-16]
    call        printf

    mov         rdi, out_str5
    mov         rsi, [rbp-20]
    call        printf

    add         rsp, 32

    pop         rbp
    ret
