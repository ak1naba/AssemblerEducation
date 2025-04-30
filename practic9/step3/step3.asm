section .data
    msg db "Enter 3 numbers: ", 0
    format_in db "%d %d %d", 0   
    format_out db "Average: %d", 10, 0 
    num1 dd 0                    
    num2 dd 0                    
    num3 dd 0                   

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
    lea r9, [rel num3]          
    call scanf
    add rsp, 8                 

    mov eax, [rel num1]           
    add eax, [rel num2]          
    add eax, [rel num3]         
    mov ebx, 3                   
    cdq                          
    idiv ebx                    

    lea rcx, [rel format_out]     
    mov edx, eax                
    call printf
    add rsp, 8                   

    xor ecx, ecx                 
    call ExitProcess
