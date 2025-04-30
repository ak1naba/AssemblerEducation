section .data
    msg db "Enter 2 numbers: ", 0
    format_in db "%d %d", 0     
    format_out db "Max: %d", 10, 0 
    num1 dd 0                    
    num2 dd 0                   

section .text
    global main
    extern scanf, printf, ExitProcess

main:
    sub rsp, 40

    lea rcx, [rel msg]           
    call printf
    add rsp, 8                  

    lea rcx, [rel format_in]     
    lea rdx, [rel num1]          
    lea r8, [rel num2]            
    call scanf
    add rsp, 8                   

    mov eax, [rel num1]        
    mov ebx, [rel num2]           
    cmp eax, ebx                 
    cmovl eax, ebx            

    lea rcx, [rel format_out]     
    mov edx, eax                 
    call printf
    add rsp, 8                    

    xor ecx, ecx                  
    call ExitProcess
