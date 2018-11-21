section .data
    out_str0    db "Enter the numbers from 1 to 16 in any order : ", 0
    out_str1    db "%3d %3d %3d %3d", 0xa, 0
    out_str2    db "row sums : ", 0
    out_str3    db "column sums : ", 0
    out_str4    db "diagonal sums : ", 0
    out_str5    db "%3d ", 0
    out_str6    db 0xa, 0
    out_str7    db "%3d %3d", 0ax, 0
    out_str8    db "Thats a magic square", 0xa, 0
    in_str0     db "%d", 0

    counter     dq 1

section .text

extern scanf
extern printf

global main

;; Main procedure, asks to enter 16 numbers in any order, print them in a 4 x 4
;; square, prints the sums of the columns, rows and diagonals and print if its a
;; magic square

main:
    push        rbp
    mov         rbp, rsp

    sub         rsp, 96

    mov         rdi, out_str0
    call        printf

scan_loop:
    mov         ecx, [counter]
    mov         rdi, in_str0
    mov         rsi, rbp

    ;; Calculate address in stack with rbp - (4 * counter)
    ;; There are 16 numbers stored, from rbp-4 to rbp-64

    mov         eax, 4
    mul         ecx
    sub         rsi, rax
    add         ecx, 1
    mov         [counter], ecx

    call        scanf

    mov         ecx, [counter]
    cmp         ecx, 17
    jne         scan_loop

    ;; Print the numbers in 4 rows with 4 numbers
    ;; The number of the current row is stored in rbp-68
    mov         [rbp-68], dword 0

print_loop:
    ;; Calculate the offset of the current row of the square on the stack
    ;; Its 16 * number_of_row
    mov         eax, 16
    mul         dword [rbp-68]
    ;; Copy the base-pointer into rbx
    ;; Substract the offset from the base-pointer
    mov         rbx, rbp
    sub         rbx, rax
    add         [rbp-68], dword 1 ; Increase the row_counter

    mov         rdi, out_str1
    mov         rsi, [rbx-4]      ; First number of the row
    mov         rdx, [rbx-8]
    mov         rcx, [rbx-12]
    mov         r8,  [rbx-16]     ; Fourth number of the row

    call        printf
    cmp         [rbp-68], dword 4
    jne         print_loop

    ;; Set row_number to 0
    mov         [rbp-68], dword 0
    ;; Save one row_sum in [rbp-72]
    mov         [rbp-72], dword 0
    ;; Save wether its a magic square or not in [rbp-76]
    mov         [rbp-76], dword 1
    ;; Space for saving the sum temporary
    mov         [rbp-80], dword 0

    mov         rdi, out_str2
    call        printf

row_sum:
    ;; store the address of the current row in rbx
    mov         eax, 16
    mul         dword [rbp-68]
    ;; Copy the base-pointer into rbx
    ;; Substract the offset from the base-pointer
    mov         rbx, rbp
    sub         rbx, rax
    add         [rbp-68], dword 1 ; Increase the row_counter

    mov         eax, [rbx-4]
    add         eax, [rbx-8]
    add         eax, [rbx-12]
    add         eax, [rbx-16]
    mov         [rbp-80], eax

    ;; Print the row sum
    mov         rdi, out_str5
    mov         rsi, rax
    call        printf

    ;; Here we store the sum of the first row in [rbp-72] to compare it
    ;; later with the other sums, to check wether this is a magic square or not.
    mov         eax, [rbp-80]
    cmp         [rbp-68], dword 1
    jne         not_1st_row
    mov         [rbp-72], eax     ; save 1st sum

not_1st_row:
    ;; compare the current sum with the 1st row sum, to check wether its a
    ;; magic square or not.
    cmp         eax, [rbp-72]
    jne         no_magic_square_r
    jmp         mbe_magic_square_r

no_magic_square_r:
    ;; Set the var, indicating thats a magic square to 0
    mov         [rbp-76], dword 0

mbe_magic_square_r:
    cmp         [rbp-68], dword 4
    jne         row_sum

    ;; print line-break
    mov         rdi, out_str6
    call        printf

    ;; store col_number in [rbp-68]
    mov         [rbp-68], dword 0

    mov         rdi, out_str3
    call        printf

col_sum:
    ;; The distance between 2 numbers of the same column in the stack is 16
    ;; bytes. So the 4 numbers from the 1st column are [rbp-4], [rbp-20],
    ;; [rbp-36], [rbp-52].
    ;; To get the 4 numbers of the second column we need to sub 4 from every
    ;; address.
    mov         eax, 4
    mul         dword [rbp-68]
    ;; Copy the base-pointer into rbx
    ;; Substract the offset from the base-pointer
    mov         rbx, rbp
    sub         rbx, rax
    add         [rbp-68], dword 1 ; Increase the row_counter

    mov         eax, [rbx-4]
    add         eax, [rbx-20]
    add         eax, [rbx-36]
    add         eax, [rbx-52]
    mov         [rbp-80], eax

    ;; Print sum of the column
    mov         rdi, out_str5
    mov         rsi, rax
    call        printf

    mov         eax, [rbp-80]
    cmp         eax, [rbp-72]
    jne         no_magic_square_c
    je          mbe_magic_square_c

no_magic_square_c:
    mov         [rbp-76], dword 0

mbe_magic_square_c:
    cmp         [rbp-68], dword 4
    jne         col_sum

    ;; Print line-break
    mov         rdi, out_str6
    call        printf


    ;; Print the diagonal sums
    mov         rdi, out_str4
    call        printf

    mov         eax, [rbp-4]
    add         eax, [rbp-24]
    add         eax, [rbp-44]
    add         eax, [rbp-64]

    mov         ebx, [rbp-16]
    add         ebx, [rbp-28]
    add         ebx, [rbp-40]
    add         ebx, [rbp-52]

    ;; Store both diagonal sums on the stack
    mov         [rbp-80], eax
    mov         [rbp-84], ebx

    mov         rdi, out_str7
    mov         rsi, rax
    mov         rdx, rbx
    call        printf

    mov         eax, [rbp-80]
    mov         ebx, [rbp-84]

    cmp         eax, ebx
    jne         no_magic_square_d
    mov         ebx, [rbp-72]
    cmp         eax, ebx
    jne         no_magic_square_d

    mov         eax, 1
    cmp         eax, [rbp-76]
    jne         end

    mov         rdi, out_str8
    call        printf

no_magic_square_d:
    mov         [rbp-76], dword 0

end:
    add         rsp, 96
    ret
