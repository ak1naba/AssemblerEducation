section .data
    num1    dd 15 ; test value
    num2    dd 45 ; test value
    num3    dd 10 ; test value
    buffer  db 10 dup(0)    
    newline db 0xA

section .text
    global _start

_start:
    mov eax, [num1]
    mov ebx, [num2]
    cmp eax, ebx
    jge .check3
    mov eax, ebx

.check3:
    mov ebx, [num3]
    cmp eax, ebx
    jge .print
    mov eax, ebx

.print:
    mov edi, buffer
    call int_to_string

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

int_to_string:
    push eax
    push ebx
    push ecx
    push edx

    mov ebx, 10
    xor ecx, ecx

    .convert:
        xor edx, edx
        div ebx
        add dl, '0'
        push edx
        inc ecx
        test eax, eax
        jnz .convert

    .output:
        pop eax
        mov [edi], al
        inc edi
        loop .output

    mov byte [edi], 0

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
