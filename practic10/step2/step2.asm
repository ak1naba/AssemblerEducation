section .data
    prompt db "Enter month number (1-12): ", 0
    format_in db "%d", 0
    winter db "Winter", 0
    spring db "Spring", 0
    summer db "Summer", 0
    autumn db "Autumn", 0
    format_out db "%s", 10, 0
    error_msg db "Invalid month number!", 10, 0
    month_num dd 0

section .text
    global main
    extern scanf, printf

main:
    sub rsp, 40

    lea rcx, [rel prompt]
    call printf
    add rsp, 8

    lea rcx, [rel format_in]
    lea rdx, [rel month_num]
    call scanf
    add rsp, 8

    mov eax, [rel month_num]

    cmp eax, 1
    jl .invalid
    cmp eax, 12
    jg .invalid

    cmp eax, 3
    jle .winter
    cmp eax, 6
    jle .spring
    cmp eax, 9
    jle .summer
    cmp eax, 12
    jle .autumn

.winter:
    lea rdx, [rel winter]
    jmp .print

.spring:
    lea rdx, [rel spring]
    jmp .print

.summer:
    lea rdx, [rel summer]
    jmp .print

.autumn:
    lea rdx, [rel autumn]
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