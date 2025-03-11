; Локально не поехал, в вируталках поехал

section .bss
    A2 resb 1     

section .text
    global _start

_start:
    mov rax, 5      
    mov rbx, 3      
    sub rax, rbx   
    mov [rel A2], al   
    
    mov eax, 1
    mov ebx,0
    int 80h;   
