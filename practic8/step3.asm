section .data
    msg_power     db "Number is a power of two.", 0xA, 0
    msg_not_power db "Number is not a power of two.", 0xA, 0

section .text
    global _start

_start:
    mov eax, 17          ; test value

    test eax, eax
    jz not_power

    mov ebx, eax        
    dec ebx             
    and ebx, eax        
    jz is_power         

not_power:
    mov eax, 4           
    mov ebx, 1          
    mov ecx, msg_not_power
    mov edx, 28        
    int 0x80
    jmp exit

is_power:
    mov eax, 4           
    mov ebx, 1           
    mov ecx, msg_power
    mov edx, 25         
    int 0x80

exit:
    mov eax, 1         
    xor ebx, ebx        
    int 0x80