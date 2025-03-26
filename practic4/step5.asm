section .data
    phrase db 'Привет, мир!', 0  
    result db 6 dup(0)           

section .text
    global _start

_start:
    lea esi, [phrase + 14]  
    lea edi, [result]      

    mov eax, [esi]
    mov [edi], eax
    
    mov ax, [esi + 4]
    mov [edi + 4], ax

    mov byte [edi + 6], 0

    
    mov eax, 4            
    mov ebx, 1            
    mov ecx, result       
    mov edx, 6            
    int 0x80              

    mov eax, 1            
    xor ebx, ebx           
    int 0x80               