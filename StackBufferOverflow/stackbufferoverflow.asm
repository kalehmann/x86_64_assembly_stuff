;; This program shows the use of a stackoverflow. It asks the user to enter a
;; password and if the password entered is not equal to "ScrtPsswrd", it should
;; print "Access denied". But we dont check the length of the password entered by
;; the user, so if it is longer than 30 chars, it overwrites a var which
;; determinates wether the user has rootaccess or not.

section .data
    out_str0    db "Enter password : ", 0
    access_str  db "You have root access", 0xa, 0
    denied_str  db "Access denied", 0xa, 0
    pwd         db "ScrtPsswrd", 0

section .text

extern printf
extern gets
extern strcmp

global main

main:
    push        rbp
    mov         rbp, rsp

    sub         rsp, 32

    mov         rdi, out_str0
    call        printf
    ;; If this var is 0, root access is denied
    mov         [rbp-4], dword 0
    ;; The buffer for the password is only 28 bytes long. If the entered
    ;; password is longer, it overwrites first the var at [rbp-4] and then the
    ;; return address of the main procedure
    mov         rdi, rbp
    sub         rdi, 32
    call        gets          ; Get password without checking its length

    mov         rdi, rbp
    sub         rdi, 32
    mov         rsi, pwd
    ;; Compare the entered password with the root password
    call        strcmp

    cmp         rax, 0
    jne         nonequal
    ;; Set the var at [rbp-4] to 1 if the passwords are equal. If they are not
    ;; equal, we dont need to do anything, the value of [rbp-4] is allready
    ;; zero.
    ;; Except, the entered password is longer than 28 bytes ;)
    mov         [rbp-4], dword 1
nonequal:
    cmp         [rbp-4], dword 0
    je          daccess

    mov         rdi, access_str
    call        printf
    jmp         end

daccess:
    mov         rdi, denied_str
    call        printf

end:
    add         rsp, 32

    pop         rbp
    ret
