section .data
    zero        dw "nolla",0
    one         dw "yksi",0
    two         dw "kaksi",0
    three       dw "kolme",0
    four        dw "neljä",0
    five        dw "viisi",0
    six         dw "kuusi",0
    seven       dw "seitsemän",0
    eigth       dw "kahdeksan",0
    nine        dw "yhdeksän",0
    ten         dw "kymmenen",0
    teen        dw "toista",0
    ty          dw "kymmentä",0

    nums        dq zero, one, two, three, four, five, six, seven, eigth, nine

    out_str0    dw "Enter a number between 0 and 99 : ",0
    out_str1    dw "The number is writen in finnish : ",0
    out_str2    dw "Error, %d isn't a number between 0 and 9", 0xa, 0
    in_str0     dw "%d",0
    newline     dw 0xa, 0

section .text

extern printf
extern scanf

global main
global printfinnum

printfinnum:
    ;; This procedure prints a one-digit finish number from rdi
    push        rbp
    mov         rbp, rsp

    cmp         rdi, 9
    ja          p_err
    ;; Nums is an array with the addresses of the number-strings
    mov         rax, rdi
    mov         rcx, 8    ; 8 byte per address
    mul         rcx
    mov         rdi, nums
    add         rdi, rax  ; You have to use add because the heap rises upwards
    ; rdi now contains the address to the address of the number-string
    mov         rdi, [rdi]  ; get the address of the number-string
    mov         rsi, zero
break:
    jmp         print

p_err:
    mov         rsi, rdi
    mov         rdi, out_str2
    jmp         print


print:
    call        printf
    pop         rbp
    ret

main:
    push        rbp
    mov         rbp, rsp

    sub         rsp, 16

    mov         rdi, out_str0
    call        printf

    mov         rdi, in_str0
    mov         rsi, rbp
    call        scanf

    mov         rdi, out_str1
    call        printf

    ;; Test wether the number is greater or lower ten
    cmp         [rbp], dword 10
    jb          single_digit
    je          e_ten
    ;; Get first digit to eax and second digit to edx
    mov         rdx, 0
    mov         eax, [rbp]
    mov         ecx, 10
    div         ecx
    ;; Check wether the number is greater or equal 20 OR between 10 and 20
    cmp         eax, dword 2
    jae         ae_twenty
    jmp         b_twenty

e_ten:
    mov         rdi, ten
    call        printf
    jmp         end

single_digit:
    mov         edi, [rbp]
    call        printfinnum
    jmp         end

b_twenty:
    ;; Number between ten and twenty
    ;; Print second digit and add "toista" to it
    mov         edi, edx
    call        printfinnum
    mov         rdi, teen
    call        printf
    jmp         end

ae_twenty:
    ;; number between 100 and 19
    ;; print first digit
    mov         [rbp], eax
    mov         [rbp-4], edx
    mov         rdi, rax
    call        printfinnum
    ;; Print "kymmentä"
    mov         rdi, ty
    call        printf
    ;; Print second digit only if not equal to zero
    cmp         [rbp-4], dword 0
    je          end
    mov         edi, [rbp-4]
    call        printfinnum

end:
    mov         rdi, newline
    call        printf

    add         rsp, 16

    pop         rbp
    ret
