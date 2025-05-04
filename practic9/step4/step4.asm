section .data
    msg db "Enter 5 numbers: ", 0
    format_in db "%d %d %d %d %d", 0
    format_out_max db "Max: %d", 10, 0
    format_out_min db "Min: %d", 10, 0
    format_out_sum db "Sum: %d", 10, 0
    num1 dd 0
    num2 dd 0
    num3 dd 0
    num4 dd 0
    num5 dd 0

section .bss
    max resd 1
    min resd 1
    sum resd 1

section .text
    global main
    extern scanf, printf, ExitProcess

main:
    sub rsp, 40

    lea rcx, [rel msg]
    call printf
    add rsp, 8

    ; Ввод пяти чисел
    lea rcx, [rel format_in]
    lea rdx, [rel num1]
    lea r8, [rel num2]
    lea r9, [rel num3]
    lea rax, [rel num4]
    mov [rsp+32], rax
    lea rax, [rel num5]
    mov [rsp+40], rax
    call scanf
    add rsp, 8

    mov eax, [rel num1]
    mov [rel max], eax
    mov [rel min], eax
    mov [rel sum], eax

    mov eax, [rel num2]
    cmp eax, [rel max]
    jle .next_max2
    mov [rel max], eax
.next_max2:

    mov eax, [rel num3]
    cmp eax, [rel max]
    jle .next_max3
    mov [rel max], eax
.next_max3:

    mov eax, [rel num4]
    cmp eax, [rel max]
    jle .next_max4
    mov [rel max], eax
.next_max4:

    mov eax, [rel num5]
    cmp eax, [rel max]
    jle .next_max5
    mov [rel max], eax
.next_max5:

    mov eax, [rel num2]
    cmp eax, [rel min]
    jge .next_min2
    mov [rel min], eax
.next_min2:

    mov eax, [rel num3]
    cmp eax, [rel min]
    jge .next_min3
    mov [rel min], eax
.next_min3:

    mov eax, [rel num4]
    cmp eax, [rel min]
    jge .next_min4
    mov [rel min], eax
.next_min4:

    mov eax, [rel num5]
    cmp eax, [rel min]
    jge .next_min5
    mov [rel min], eax
.next_min5:

    mov eax, [rel num2]
    add [rel sum], eax

    mov eax, [rel num3]
    add [rel sum], eax

    mov eax, [rel num4]
    add [rel sum], eax

    mov eax, [rel num5]
    add [rel sum], eax

    lea rcx, [rel format_out_max]
    mov edx, [rel max]
    call printf
    add rsp, 8

    lea rcx, [rel format_out_min]
    mov edx, [rel min]
    call printf
    add rsp, 8

    lea rcx, [rel format_out_sum]
    mov edx, [rel sum]
    call printf
    add rsp, 8

    xor ecx, ecx
    call ExitProcess
