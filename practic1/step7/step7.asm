section .bss
    A1 resb 1      
    A2 resb 1     
    A3 resb 1      
    A4 resb 1    

section .text
    global _start

_start:
    mov byte [A1], 7
    mov byte [A2], 2
    mov byte [A3], 3

    movzx rax, byte [A1] 
    
    movzx rbx, byte [A3]  

    add rax, rbx         

    movzx rcx, byte [A2]  

    cqo                   
    idiv rcx             


    mov [A4], al          

   
    mov eax, 1       
    mov ebx, 0       
    int 80h               
