section .data
    array db 23, 21, 5, 7    
    array_len equ 4           
    result db 4 dup(0)        

section .bss
    output resb 100          

section .text
    global _start

_start:
    mov ecx, array_len      
    mov esi, array + array_len - 1
    mov edi, result           

copy_loop:
    mov al, [esi]            
    mov [edi], al             
    dec esi                   
    inc edi                  
    loop copy_loop          

    mov esi, result          
    mov edi, output         
    mov ecx, array_len      

convert_loop:
    mov al, [esi]             
    call int_to_str          
    inc esi                 
    loop convert_loop         

    mov byte [edi-1], 0      

    mov eax, 4              
    mov ebx, 1                
    mov ecx, output          
    mov edx, edi              
    sub edx, output           
    int 0x80                  

    mov eax, 1              
    xor ebx, ebx              
    int 0x80                 

int_to_str:
    mov ah, 0                
    mov bl, 10               
    div bl                   
    add al, '0'              
    add ah, '0'             

    cmp al, '0'
    je single_digit

    stosb                   
    mov al, ah              
    stosb                  
    jmp add_comma

single_digit:
    mov al, ah                
    stosb                    

add_comma:
    mov al, ','               
    stosb                    
    ret
