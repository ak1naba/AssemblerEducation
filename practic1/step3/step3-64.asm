section .bss
    A1 resb 1 

section .text
    global _start

_start:
    mov rax, 5          
    mov rbx, 3        
    add rax, rbx        
    mov [rel A1], al   

    mov eax, 60        
    xor edi, edi       
    syscall           
