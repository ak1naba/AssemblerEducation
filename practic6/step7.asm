section .data
    user_input      dd 10    ; test value           
    in_range_msg    db "Number is in range", 0xA
    in_range_len    equ $ - in_range_msg

    out_range_msg   db "Number is out of range", 0xA
    out_range_len   equ $ - out_range_msg

section .text
    global _start

_start:
    mov eax, [user_input]

    cmp eax, 10
    jl .out_of_range

    cmp eax, 50
    jg .out_of_range

.in_range:
    mov eax, 4         
    mov ebx, 1         
    mov ecx, in_range_msg
    mov edx, in_range_len
    int 0x80
    jmp .exit

.out_of_range:
    mov eax, 4
    mov ebx, 1
    mov ecx, out_range_msg
    mov edx, out_range_len
    int 0x80

.exit:
    mov eax, 1         
    xor ebx, ebx
    int 0x80
