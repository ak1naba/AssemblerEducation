section .data
    newline db 10
    add_msg db "Addition: ", 0
    mul_msg db "Multiplication: ", 0
    dash_msg db " - ", 0

section .bss
    buffer resb 16

section .text
    global _start

add_numbers:
    add eax, ebx
    ret

multiply_numbers:
    imul eax, ebx
    ret

print_string:
    mov eax, 4            
    mov ebx, 1            
    int 0x80
    ret

print_number:
    mov edi, buffer + 15
    mov byte [edi], 0
    mov ebx, 10

.convert_loop:
    dec edi
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .convert_loop

    mov ecx, edi
    mov edx, buffer + 16
    sub edx, edi
    call print_string

    mov ecx, newline
    mov edx, 1
    call print_string
    ret


print_operation_result:
    push eax              
    call print_string     
    
    mov ecx, dash_msg
    mov edx, 3
    call print_string
    
    pop eax               
    call print_number     
    ret

_start:
    mov eax, 5
    mov ebx, 3
    call add_numbers      
    
    mov ecx, add_msg
    mov edx, 10
    call print_operation_result  

    mov eax, 4
    mov ebx, 6
    call multiply_numbers 
    
    mov ecx, mul_msg
    mov edx, 15
    call print_operation_result  

    mov eax, 1
    xor ebx, ebx
    int 0x80