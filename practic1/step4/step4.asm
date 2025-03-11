; Локально не поехал, в вируталках поехал

section .bss
    A2 resb 1     

section .text
    global _start

_start:
    mov eax, 5      
    mov ebx, 3      
    sub eax, ebx   
    mov [A2], al   
    
    mov eax, 1
    mov ebx,0
    int 80h;   
