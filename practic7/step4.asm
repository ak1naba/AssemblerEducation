section .data
    array db 1, 2, 3, 4, 5, 6, 7, 8, -1, -2, -3, -4, -5, -6, -7, 8
    array_len equ 16
    positive db 'Positive: ', 0
    negative db 'Negative: ', 0
    odd db 'Odd: ', 0
    even db 'Even: ', 0
    newline db 0xA, 0

section .bss
    pos_count resb 1
    neg_count resb 1
    odd_count resb 1
    even_count resb 1

section .text
    global _start

_start:
    mov byte [pos_count], 0
    mov byte [neg_count], 0
    mov byte [odd_count], 0
    mov byte [even_count], 0

    mov ecx, array_len
    mov esi, array

process_array:
    lodsb              
    test al, al        
    jz next_element    
    js increment_neg   
    inc byte [pos_count]
    jmp check_parity

increment_neg:
    inc byte [neg_count]

check_parity:
    test al, 1          
    jnz increment_odd   
    inc byte [even_count]
    jmp next_element

increment_odd:
    inc byte [odd_count]

next_element:
    loop process_array

    call print_positive
    call print_negative
    call print_odd
    call print_even

    mov eax, 1         
    xor ebx, ebx
    int 0x80

print_positive:
    mov eax, 4          
    mov ebx, 1         
    mov ecx, positive
    mov edx, 10
    int 0x80

    mov al, [pos_count]
    add al, '0'
    mov [pos_count], al
    mov eax, 4
    mov ebx, 1
    mov ecx, pos_count
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

print_negative:
    mov eax, 4
    mov ebx, 1
    mov ecx, negative
    mov edx, 10
    int 0x80

    mov al, [neg_count]
    add al, '0'
    mov [neg_count], al
    mov eax, 4
    mov ebx, 1
    mov ecx, neg_count
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

print_odd:
    mov eax, 4
    mov ebx, 1
    mov ecx, odd
    mov edx, 5
    int 0x80

    mov al, [odd_count]
    add al, '0'
    mov [odd_count], al
    mov eax, 4
    mov ebx, 1
    mov ecx, odd_count
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

print_even:
    mov eax, 4
    mov ebx, 1
    mov ecx, even
    mov edx, 6
    int 0x80

    mov al, [even_count]
    add al, '0'
    mov [even_count], al
    mov eax, 4
    mov ebx, 1
    mov ecx, even_count
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret
