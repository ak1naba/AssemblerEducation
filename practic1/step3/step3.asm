section .bss
    A1 resb 1

section .text
    global _start

_start:
    mov eax, 5          ; Загружаем значение 5 в регистр eax
    mov ebx, 2          ; Загружаем значение 2 в регистр ebx
    add eax, ebx        ; Складываем значения в eax и ebx, результат сохраняется в eax
    mov [A1], al        ; Сохраняем только младший байт eax (al) в переменную A1

    ; Завершение программы
    mov eax, 60         ; Номер системного вызова для выхода (exit)
    xor edi, edi        ; Статус выхода 0
    syscall             ; Вызов системного вызова
