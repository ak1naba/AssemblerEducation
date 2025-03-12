section .text
    global _start

_start:
    mov eax, 50
    mov ebx, 30
    mul ebx        
    mov ecx, eax   

    mov eax, 1
    mov ebx,0
    int 80h;  
