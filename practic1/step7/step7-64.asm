section .bss
    A1 resb 1      
    A2 resb 1      
    A3 resb 1      
    A4 resb 1      

section .text
    global _start

_start:
    mov byte [rel A1], 7
    mov byte [rel A2], 2
    mov byte [rel A3], 3

    mov al, byte [rel A1]  

    add al, byte [rel A3]  

    xor ah, ah    

    mov bl, byte [rel A2]  

    div bl      

    mov byte [rel A4], al  

    mov eax, 60   
    xor edi, edi  
    syscall       
