section .data
    ar1 db 1, 3, 5, 7
    ar2 db 2, 4, 6, 8
    ar1_len equ 4
    ar2_len equ 4
    result db 8 dup(0)

section .bss
    output resb 100

section .text
    global _start

_start:
    mov esi, ar1             
    mov edi, ar2              
    mov ebx, result          
    mov ecx, ar1_len + ar2_len 

merge_loop:
    cmp esi, ar1 + ar1_len
    jae copy_remaining_ar2
    cmp edi, ar2 + ar2_len
    jae copy_remaining_ar1

    mov al, [esi]
    mov dl, [edi]
    cmp al, dl
    jg copy_from_ar2

copy_from_ar1:
    mov [ebx], al
    inc esi
    jmp next_element

copy_from_ar2:
    mov [ebx], dl
    inc edi

next_element:
    inc ebx
    loop merge_loop

copy_remaining_ar1:
    cmp esi, ar1 + ar1_len
    jae copy_remaining_ar2
    mov al, [esi]
    mov [ebx], al
    inc esi
    inc ebx
    jmp copy_remaining_ar1

copy_remaining_ar2:
    cmp edi, ar2 + ar2_len
    jae convert_to_string
    mov al, [edi]
    mov [ebx], al
    inc edi
    inc ebx
    jmp copy_remaining_ar2

convert_to_string:

    mov esi, result
    mov edi, output
    mov ecx, ar1_len + ar2_len

convert_loop:
    mov al, [esi]
    call int_to_str
    inc esi
    loop convert_loop

    mov byte [edi-1], 0     

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, edi
    sub edx, output
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

int_to_str:
    mov ah, 0
    mov bl, 10
    div bl
    add al, '0'
    add ah, '0'

    cmp al, '0'
    je single_digit

    stosb
    mov al, ah
    stosb
    jmp add_comma

single_digit:
    mov al, ah
    stosb

add_comma:
    mov al, ','
    stosb
    ret
