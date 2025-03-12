section .text
    global _start

_start:
    mov eax, 15
    mov ebx, eax
    mov ecx, 25

  
    mov eax, 1
    mov ebx,0
    int 80h;  
