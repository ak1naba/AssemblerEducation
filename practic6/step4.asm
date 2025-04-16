section .data
    number  dd 8          ; test value
    even_msg db 'Even', 0 
    odd_msg  db 'Odd', 0  

section .text
    global _start

_start:
    mov eax, [number]    
    mov ebx, 2           
    xor edx, edx        
    div ebx             
    
    test edx, edx       
    jz .even             
    jmp .odd             

.even:
    mov eax, 4            
    mov ebx, 1          
    mov ecx, even_msg    
    mov edx, 4           
    int 0x80              
    jmp .exit

.odd:
    mov eax, 4            
    mov ebx, 1            
    mov ecx, odd_msg     
    mov edx, 3          
    int 0x80             

.exit:
    mov eax, 1           
    xor ebx, ebx         
    int 0x80             