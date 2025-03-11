; Локально не поехал, в вируталках поехал

section .bss
    A4 resb 1      

section .text
    global _start

_start:
    mov eax, 10     
    mov ebx, 2       

    mul ebx          

    mov [A4], al    

    mov eax, 1       
    mov ebx, 0       
    int 80h          
