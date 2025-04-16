section .data
    num1    dd 2147483647     ; test value, overflow, max value
    num2    dd 1              ; test value
    result  dd 0            
    overflow_msg db 'Overflow detected', 0xA
    overflow_len equ $ - overflow_msg
    result_msg db 'Result: '             
    result_len equ 8
    result_buffer db 10 dup(0)             
    newline db 0xA                       

section .text
    global _start

_start:
    mov eax, [num1]
    mov ebx, [num2]
    add eax, ebx          
    mov [result], eax    

    jo .overflow_detected  

    mov eax, 4            
    mov ebx, 1             
    mov ecx, result_msg   
    mov edx, result_len   
    int 0x80

    mov eax, [result]
    mov edi, result_buffer
    call int_to_string    

    mov eax, 4             
    mov ebx, 1            
    mov ecx, result_buffer 
    mov edx, 10           
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    jmp .exit           

.overflow_detected:
    mov eax, 4             
    mov ebx, 1            
    mov ecx, overflow_msg 
    mov edx, overflow_len  
    int 0x80

.exit:
    mov eax, 1            
    xor ebx, ebx          
    int 0x80             

int_to_string:
    push ebx
    push ecx
    push edx
    mov ebx, 10           
    xor ecx, ecx         

.divide_loop:
    xor edx, edx          
    div ebx               
    add dl, '0'          
    push edx             
    inc ecx               
    test eax, eax        
    jnz .divide_loop     

.reverse_loop:
    pop eax              
    mov [edi], al         
    inc edi              
    loop .reverse_loop  

    mov byte [edi], 0   
    pop edx
    pop ecx
    pop ebx
    ret