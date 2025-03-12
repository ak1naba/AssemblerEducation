section .text
    global _start

_start:
    mov ax, 100
    mov bx, 200
    add ax, bx
    sub bx, ax
    neg bx
    add ax, bx
    sub ax, bx
    neg ax

    mov eax, 1
    mov ebx,0
    int 80h;  
