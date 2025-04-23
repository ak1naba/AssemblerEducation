%macro Print_Msg 2
    mov eax, 4      
    mov ebx, 1      
    mov ecx, %1     
    mov edx, %2   
    int 0x80
%endmacro

%macro Calc_Expression 4
    mov eax, %2    
    imul eax, %3   
    mov ebx, %4    
    imul ebx, 2    
    sub eax, ebx   
    mov %1, eax    
%endmacro

section .data
    msg_result db "Result: ", 0
    msg_newline db 0xA, 0
    x dd 5
    y dd 3
    z dd 4
    result dd 0

section .bss
    buffer resb 12  

section .text
    global _start

_start:
    Calc_Expression [result], [x], [y], [z]

    mov eax, [result]
    lea edi, [buffer + 11] 
    mov byte [edi], 0      
    mov ebx, 10           

    ; Проверяем знак
    test eax, eax
    jns convert_loop
    neg eax
    mov byte [buffer], '-' 
    inc edi              

convert_loop:
    dec edi
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz convert_loop

    mov ecx, edi
    lea edx, [buffer]
    sub edx, ecx

    Print_Msg msg_result, 8
    Print_Msg edi, edx
    Print_Msg msg_newline, 1

    mov eax, 1
    xor ebx, ebx
    int 0x80
