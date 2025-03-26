section .data
    var1 db 'Я', 0
    var2 db 'Студент', 0
    result db 18 dup(0)

section .text
    global _start

_start:
    lea esi, [var2 + 2]
    lea edi, [result]

    mov ax, [esi]
    mov [edi], ax

    mov ax, [esi + 2]
    mov [edi + 2], ax

    mov byte [edi + 4], 0

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 4
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
