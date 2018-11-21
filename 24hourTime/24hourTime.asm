section .data
    out_str0    db "Enter a time in 12-hour format : ", 0
    out_str1    db "Equivalent 24-hour time : %02d:%02d", 0xa, 0
    in_str0     db "%d:%d%s", 0

section .text

extern  printf
extern  scanf
extern  toupper

global main

main:
    push        rbp
    mov        	rbp, rsp
    sub        	rsp, 16

    mov        	rdi, out_str0
    call      	printf

    ;; Asks the  user to enter a time in 12-hour format. Stores the hours
    ;; in [rbp-4], the minutes in [rbp-8] and the prefix in [rbp-12]
    mov        	rdi, in_str0
    mov        	rsi, rbp
    sub        	rsi, 4
    mov        	rdx, rbp
    sub        	rdx, 8
    mov        	rcx, rbp
    sub        	rcx, 12
    call      	scanf

    ;; Test the prefix
    ;; Test if prefix starts with space
    mov        	al, [rbp-12]
    cmp        	[rbp-12], byte 0x20
    je        	with_space

no_space:
    ;; convert first char to upper
    mov        	al, [rbp-12]
    mov        	rdi, rax
    call      	toupper
    ;; test if first char == 'P'
    cmp        	eax, 0x50
    je        	PM
    jmp        	AM

with_space:
    ;; Convert the second char to uppercase
    mov        	al, [rbp-13]
    mov        	rdi, rax
    call      	toupper
    ;; Test if second char equals 'P'
    cmp        	eax, 0x50
    je        	PM
    jmp        	AM

PM:
    add        	[rbp-4], dword 12
    mov        	rdi, out_str1
    mov        	rsi, [rbp-4]
    mov        	rdx, [rbp-8]
    call      	printf
    jmp       	end
AM:
    mov        	rdi, out_str1
    mov        	rsi, [rbp-4]
    mov        	rdx, [rbp-8]
    call      	printf

end:
    add        	rsp, 16
    pop        	rbp
    ret
