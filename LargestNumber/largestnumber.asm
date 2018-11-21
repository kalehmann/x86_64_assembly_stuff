section .data
    out_str1    db "Please enter a floating point number : ", 0
    out_str2    db "The largest number was : %.2f", 0xa, 0
    in_str1     db "%lf",0
section .text

extern scanf
extern printf

global main

main:
    push        rbp
    mov         rbp, rsp
    sub         rsp, 32
    ;; The largest entered number will be stored in [rbp-8]
    mov         [rbp-12], dword 0

loop:
    mov         rdi, out_str1
    call        printf

    mov         rdi, in_str1
    mov         rsi, rbp
    sub         rsi, 4
    call        scanf

    subsd       xmm0, xmm0          ; Set xmm0 to zero, not shure if necessary
    movsd       xmm1, [rbp-4]
    ucomisd     xmm1, xmm0          ; Exit if zero was entered
    jz          end

    ;; Check if the entered number is larger than the largest number entered
    ;; before.
    ucomisd     xmm1, [rbp-12]
    jb          loop
    movsd       [rbp-12], xmm1
    jmp         loop

end:
    mov         rdi, out_str2
    ;; Tell printf that one argument is in xmm0
    mov         eax, 1
    movsd       xmm0, [rbp-12]      ; Get the largest number
    call        printf

    add         rsp, 32
    pop         rbp
    ret
