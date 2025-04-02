section .data
    x1      dd 10          
    x2      dd 5           ; test values : [5,10]
    y       dd 20          
    
    msg_div_zero db "на ноль делить нельзя", 10
    msg_div_zero_len equ $ - msg_div_zero
    
    result_msg db "Результат деления: "
    result_msg_len equ $ - result_msg
    
    newline db 10

section .bss
    buffer resb 16         

section .text
    global _start

_start:
    mov eax, [x1]
    mov ebx, [x2]
    mov ecx, [y]
    
    sub eax, ebx         
    
    cmp eax, 0
    je division_by_zero   
    
    mov edx, 0            
    mov ebx, eax          
    mov eax, ecx          
    div ebx               
    
    push eax              
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, result_msg_len
    int 0x80
    
    pop eax
    call print_number
    
    jmp exit

division_by_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_div_zero
    mov edx, msg_div_zero_len
    int 0x80
    
    jmp exit

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
    
    mov eax, 4
    mov ebx, 1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

exit:
    mov eax, 1            
    mov ebx, 0            
    int 0x80