section .data
    prompt db "Enter day number (1-7): ", 0
    format_in db "%d", 0
    monday db "Monday", 0
    tuesday db "Tuesday", 0
    wednesday db "Wednesday", 0
    thursday db "Thursday", 0
    friday db "Friday", 0
    saturday db "Saturday", 0
    sunday db "Sunday", 0
    format_out db "%s", 10, 0
    error_msg db "Invalid day number!", 10, 0
    day_num dd 0

section .text
    global main
    extern scanf, printf, ExitProcess

main:
    sub rsp, 40

    lea rcx, [rel prompt]
    call printf
    add rsp, 8

    lea rcx, [rel format_in]
    lea rdx, [rel day_num]
    call scanf
    add rsp, 8

    mov eax, [rel day_num]

    cmp eax, 1
    jl .invalid
    cmp eax, 7
    jg .invalid

    cmp eax, 1
    je .case1
    cmp eax, 2
    je .case2
    cmp eax, 3
    je .case3
    cmp eax, 4
    je .case4
    cmp eax, 5
    je .case5
    cmp eax, 6
    je .case6
    cmp eax, 7
    je .case7

.case1:
    lea rdx, [rel monday]
    jmp .print

.case2:
    lea rdx, [rel tuesday]
    jmp .print

.case3:
    lea rdx, [rel wednesday]
    jmp .print

.case4:
    lea rdx, [rel thursday]
    jmp .print

.case5:
    lea rdx, [rel friday]
    jmp .print

.case6:
    lea rdx, [rel saturday]
    jmp .print

.case7:
    lea rdx, [rel sunday]
    jmp .print

.print:
    lea rcx, [rel format_out]
    call printf
    jmp .exit

.invalid:
    lea rcx, [rel error_msg]
    call printf

.exit:
    add rsp, 40
    xor eax, eax
    ret
