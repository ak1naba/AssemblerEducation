section .data
    msg_set      db "Bit 5 is set.", 0xA, 0
    msg_not_set  db "Bit 5 is not set.", 0xA, 0
    newline      db 0xA, 0

section .text
    global _start

_start:
    mov eax, 0x04       ; test value 0x24

    test eax, 1 << 5     
    jz bit_not_set        

   
    mov eax, 4          
    mov ebx, 1          
    mov ecx, msg_set
    mov edx, 13         
    int 0x80
    jmp set_bits        

bit_not_set:
    mov eax, 4          
    mov ebx, 1          
    mov ecx, msg_not_set
    mov edx, 18          ne
    int 0x80

set_bits:
    or eax, (1 << 2) | (1 << 5)  

    mov eax, 1          
    xor ebx, ebx      
    int 0x80