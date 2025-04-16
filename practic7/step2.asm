section .data
    str1 db 'hello', 0
    str2 db 'hello', 0
    equal_msg db 'equal', 0xA, 0
    not_equal_msg db 'not equal', 0xA, 0

section .text
    global _start

_start:
    mov esi, str1
    mov edi, str2

compare_strings:
    mov al, [esi]
    mov bl, [edi]
    cmp al, bl
    jne not_equal

    test al, al
    jz equal
    
    inc esi
    inc edi
    jmp compare_strings

equal:
    mov eax, 4          
    mov ebx, 1         
    mov ecx, equal_msg
    mov edx, 7         
    int 0x80
    jmp exit

not_equal:
    mov eax, 4         
    mov ebx, 1          
    mov ecx, not_equal_msg
    mov edx, 11         
    int 0x80

exit:
    mov eax, 1          
    xor ebx, ebx
    int 0x80
