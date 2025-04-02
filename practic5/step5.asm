section .data
    prompt      db "Factorial = ", 0
    prompt_len  equ $ - prompt
    newline     db 10

section .bss
    buffer      resb 16

section .text
    global _start

_start:
    mov eax, 10                  ; test values : [0, 5, 10]
    call factorial
    
    push eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80
    
    pop eax
    call print_number
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

factorial:
    cmp eax, 1
    jle .base_case
    
    push ebx            
    mov ebx, eax        
    dec eax             
    call factorial      
    
    mul ebx             
    pop ebx             
    ret
    
.base_case:
    mov eax, 1          
    ret

print_number:
    mov edi, buffer + 15
    mov byte [edi], 0
    mov ebx, 10
    
.convert_loop:
    dec edi
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .convert_loop
    
    mov ecx, edi
    mov edx, buffer + 16
    sub edx, ecx
    
    mov eax, 4
    mov ebx, 1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret