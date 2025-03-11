section .bss
    A2 resb 1     

section .text
    global _start

_start:
    mov rax, 10     
    mov rbx, 2      

    xor rdx, rdx     
    div rbx       

    mov [rel A2], al

    mov eax, 60      
    xor edi, edi    
    syscall         
