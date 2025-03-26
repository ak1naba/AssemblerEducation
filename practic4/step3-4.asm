section .data
    newline db 10, 0           
    result_msg db "Result: ", 0

section .bss
    buffer resb 4 

section .text
    global _start

_start:
    mov eax, 7
    add eax, 1
    add eax, 5
    
    mov edi, buffer
    call int_to_ascii
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 9
    int 0x80
   
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 4
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
  
    mov eax, 1
    xor ebx, ebx
    int 0x80

int_to_ascii:
    mov ecx, 10     
    mov esi, edi    
    add esi, 3     
    mov byte [esi], 0 
    dec esi
.loop:
    xor edx, edx
    div ecx         
    add dl, '0'    
    mov [esi], dl   
    dec esi
    test eax, eax
    jnz .loop
    
    inc esi         
    ret
