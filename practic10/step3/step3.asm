section .data
    prompt db "Enter card code (3 digits): ", 0
    format_in db "%d", 0
    error_msg db "Invalid card code!", 10, 0
    
  ; Названия мастей (Card suits)
    spades db "Spades", 0       ; Пики
    clubs db "Clubs", 0         ; Трефы
    diamonds db "Diamonds", 0   ; Бубны
    hearts db "Hearts", 0       ; Червы
    
    ; Названия достоинств (Card ranks)
    two db "Two", 0         ; Двойка
    three db "Three", 0     ; Тройка
    four db "Four", 0       ; Четверка
    five db "Five", 0       ; Пятерка
    six db "Six", 0         ; Шестерка
    seven db "Seven", 0     ; Семерка
    eight db "Eight", 0     ; Восьмерка
    nine db "Nine", 0       ; Девятка
    ten db "Ten", 0         ; Десятка
    jack db "Jack", 0       ; Валет
    queen db "Queen", 0     ; Дама
    king db "King", 0       ; Король
    ace db "Ace", 0         ; Туз
    
    format_out db "%s of %s", 10, 0
    card_code dd 0

section .text
    global main
    extern scanf, printf

main:
    sub rsp, 40

    lea rcx, [rel prompt]
    call printf
    add rsp, 8

    lea rcx, [rel format_in]
    lea rdx, [rel card_code]
    call scanf
    add rsp, 8

    mov eax, [rel card_code]
    cmp eax, 100
    jl .invalid
    cmp eax, 499
    jg .invalid

   
    mov ecx, eax       
    mov ebx, 100        
    xor edx, edx       
    div ebx             
   
    cmp eax, 1
    jl .invalid
    cmp eax, 4
    jg .invalid
 
    cmp edx, 2
    jl .invalid
    cmp edx, 14
    jg .invalid

    cmp eax, 1
    je .spades
    cmp eax, 2
    je .clubs
    cmp eax, 3
    je .diamonds
    cmp eax, 4
    je .hearts

.spades:
    lea rsi, [rel spades]
    jmp .determine_rank

.clubs:
    lea rsi, [rel clubs]
    jmp .determine_rank

.diamonds:
    lea rsi, [rel diamonds]
    jmp .determine_rank

.hearts:
    lea rsi, [rel hearts]

.determine_rank:
    cmp edx, 2
    je .rank_two
    cmp edx, 3
    je .rank_three
    cmp edx, 4
    je .rank_four
    cmp edx, 5
    je .rank_five
    cmp edx, 6
    je .rank_six
    cmp edx, 7
    je .rank_seven
    cmp edx, 8
    je .rank_eight
    cmp edx, 9
    je .rank_nine
    cmp edx, 10
    je .rank_ten
    cmp edx, 11
    je .rank_jack
    cmp edx, 12
    je .rank_queen
    cmp edx, 13
    je .rank_king
    cmp edx, 14
    je .rank_ace

.rank_two:
    lea rdi, [rel two]
    jmp .print_card

.rank_three:
    lea rdi, [rel three]
    jmp .print_card

.rank_four:
    lea rdi, [rel four]
    jmp .print_card

.rank_five:
    lea rdi, [rel five]
    jmp .print_card

.rank_six:
    lea rdi, [rel six]
    jmp .print_card

.rank_seven:
    lea rdi, [rel seven]
    jmp .print_card

.rank_eight:
    lea rdi, [rel eight]
    jmp .print_card

.rank_nine:
    lea rdi, [rel nine]
    jmp .print_card

.rank_ten:
    lea rdi, [rel ten]
    jmp .print_card

.rank_jack:
    lea rdi, [rel jack]
    jmp .print_card

.rank_queen:
    lea rdi, [rel queen]
    jmp .print_card

.rank_king:
    lea rdi, [rel king]
    jmp .print_card

.rank_ace:
    lea rdi, [rel ace]

.print_card:
    lea rcx, [rel format_out]
    mov rdx, rdi       
    mov r8, rsi        
    call printf
    jmp .exit

.invalid:
    lea rcx, [rel error_msg]
    call printf

.exit:
    add rsp, 40
    xor eax, eax
    ret