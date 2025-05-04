section .data
    msg db "Enter a number (0 to stop): ", 0
    format_in db "%d", 0
    format_out_count db "Count: %d", 10, 0
    format_out_sum db "Sum: %d", 10, 0
    num dd 0

section .bss
    count resd 1
    sum resd 1

section .text
    global main
    extern scanf, printf, ExitProcess

main:
    sub rsp, 40

    xor eax, eax
    mov [rel count], eax
    mov [rel sum], eax

input_loop:
    lea rcx, [rel msg]
    call printf

    lea rcx, [rel format_in]
    lea rdx, [rel num]
    call scanf

    mov eax, [rel num]
    test eax, eax
    jz done

    inc dword [rel count]

    add [rel sum], eax

    jmp input_loop

done:
    lea rcx, [rel format_out_count]
    mov edx, [rel count]
    call printf

    lea rcx, [rel format_out_sum]
    mov edx, [rel sum]
    call printf


