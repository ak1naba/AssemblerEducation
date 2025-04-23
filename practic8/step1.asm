section .data
    prompt db "Модуль числа: ", 0
    num1 dd -5           ; test value
    newline db 10, 0

section .bss
    buffer resb 10

section .text
    global _start

_start:
    mov eax, [num1]
    cmp eax, 0
    jge print_result    

    neg eax

print_result:
    lea edi, [buffer + 9] 
    mov byte [edi], 0    
    mov ebx, 10          
    
convert_loop:
    dec edi
    xor edx, edx
    div ebx               
    add dl, '0'           
    mov [edi], dl
    test eax, eax
    jnz convert_loop     

    mov eax, 4           
    mov ebx, 1           
    mov ecx, prompt
    mov edx, 25         
    int 0x80

    mov eax, 4           
    mov ebx, 1            
    mov ecx, edi          
    lea edx, [buffer + 10]
    sub edx, edi          
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1           
    xor ebx, ebx         
    int 0x80