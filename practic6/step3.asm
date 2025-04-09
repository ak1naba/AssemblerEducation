section .data
    newline db 10

    equal_msg db "Числа равны", 0              
    greater_msg db "1 число больше 2", 0       
    less_msg db "1 число меньше 2", 0          

section .text
    global _start

print_string:
    mov eax, 4       
    mov ebx, 1      
    int 0x80
    ret

_start:
    mov eax, 2       
    mov ebx, 1     

    cmp eax, ebx
    je .equal
    ja .greater
    jb .less

.equal:
    mov ecx, equal_msg
    mov edx, 22      
    call print_string
    jmp .done
    
.greater:
    mov ecx, greater_msg
    mov edx, 28      
    call print_string
    jmp .done

.less:
    mov ecx, less_msg
    mov edx, 29      
    call print_string

.done:
    mov ecx, newline
    mov edx, 1
    call print_string

    mov eax, 1        
    xor ebx, ebx      
    int 0x80