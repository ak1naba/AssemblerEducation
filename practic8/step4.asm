%macro Print_Msg 2
    mov eax, 4      
    mov ebx, 1     
    mov ecx, %1    
    mov edx, %2    
    int 0x80
%endmacro

section .data
    msg1 db "Hello, World!", 0xA
    len1 equ $ - msg1
    msg2 db "exmple message.", 0xA
    len2 equ $ - msg2

section .text
    global _start

_start:
    Print_Msg msg1, len1   
    Print_Msg msg2, len2    

    mov eax, 1      
    xor ebx, ebx   
    int 0x80