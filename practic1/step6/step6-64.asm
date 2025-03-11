section .bss
    A4 resb 1    

section .text
    global _start

_start:
    mov rax, 10    
    mov rbx, 2     

    mul rbx        

    mov [rel A4], al    

    mov eax, 60      
    xor edi, edi     
    syscall         
