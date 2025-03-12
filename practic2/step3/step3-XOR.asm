section .text
    global _start

_start:
    mov ax, 100
    mov bx, 200
    xor ax, bx
    xor bx, ax
    xor ax, bx

    mov eax, 1
    mov ebx,0
    int 80h;  
