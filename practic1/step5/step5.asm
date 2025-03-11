; Локально не поехал, в вируталках поехал

section .bss
    A3 resb 1     

section .text
    global _start

_start:
    mov eax, 10    
    mov ebx, 2       

    xor edx, edx    
    div ebx          

    mov [A3], al    

   
    mov eax, 1       
    mov ebx, 0       
    int 80h        
