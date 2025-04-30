section .data
    prompt db "Enter a number: ", 0
    format_in db "%d", 0         
    format_out db "%d", 10, 0    
    buffer dd 0                   

section .text
    global main
    extern scanf, printf, ExitProcess

main:
    sub rsp, 40

    lea rcx, [rel prompt]         
    call printf
    add rsp, 8                   
  
    lea rcx, [rel format_in]      
    lea rdx, [rel buffer]         
    call scanf
    add rsp, 8                   

    lea rcx, [rel format_out]    
    mov rdx, [rel buffer]        
    call printf
    add rsp, 8                   

    xor ecx, ecx                  
    call ExitProcess
