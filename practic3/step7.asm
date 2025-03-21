section .data
    var1 db 'Я', 0
    var2 db 'Студент', 0
    result db 18 dup(0)

section .text
    global _start

_start:
    mov ax, [var1]           
    mov [result], ax        
    mov byte [result + 2], ' '
    lea esi, [var2]          
    lea edi, [result + 3]    
    mov ecx, 4              
    
copy_loop:
    mov ax, [esi]           
    mov [edi], ax          
    add esi, 2              
    add edi, 2              
    loop copy_loop         
    
    mov byte [edi], 0     
    
    mov eax, 4               
    mov ebx, 1               
    mov ecx, result          
    mov edx, 18            
    int 0x80                
    
    mov eax, 1              
    xor ebx, ebx           
    int 0x80                 
