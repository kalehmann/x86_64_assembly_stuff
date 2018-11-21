section .data
    amount      dq 0
    str1        db "Please enter an amount : ", 0
    str2        db "%d", 0
    str3        db "%d-Notes : %d", 0xa, 0
    str4        db "Remainder : %d", 0xa, 0
    notes       db 50, 20, 10, 5  ; List of supported notes

    rmd         dq 0
    addr        times 2 dq 0
    cnt         dq 0

section .text

extern scanf
extern printf

global main

main:
    push        rbp
    mov         rbp, rsp

    mov         rdi, str1
    call        printf

    mov         rdi, str2
    mov         rsi, amount
    call        scanf


    mov         eax, [amount]
    mov         ecx, 4        ; Number of supported notes
    mov         r8, notes

top:
    dec         ecx
    mov         edx, 0
    mov         bl , [r8]     ; Assign the worth of the bill to bl starting with
                              ; the highest bill, ending with the lowest
    add         r8, 1
    cmp         eax, 0
    je          zero          ; Skip division, if eax == 0
    div         bx            ; edx:eax / bx
zero:
    mov         [rmd], edx    ; Save the reminder
    mov         [cnt], ecx    ; Save the counter
    mov         [addr], r8    ; Save current array address

    ;; Call printf with the address to str3 in rdi, the worth of the bill in
    ;; rsi, the number of bills in edx
    mov         rdi, str3
    mov         rsi, rbx
    mov         rdx, rax
    call        printf

    ;; Get everything back from the stack
    mov         eax, [rmd]    ; Get the reminder back
    mov         ecx, [cnt]    ; Get counter
    mov         r8, [addr]    ; Get current array address

    cmp         ecx, 0
    jne         top

    ;; Print the rest below 5
    mov         rdi, str4
    mov         esi, eax
    call        printf

    pop         rbp
    ret
