section .data
    ; Fixed initial values
    population dq 1000
    social_welfare dq 50
    jobs dq 200
    happiness dq 75
    money dq 1000000  ; Initial treasury money
    turns_left dq 10   ; Total turns available
    factories dq 0     ; Number of factories built

    ; Building costs
    house_cost equ 10000
    hospital_cost equ 30000
    factory_cost equ 50000

    ; Income values
    factory_income_per_turn equ 15000
    base_income_per_turn equ 20000

    ; Interface messages
    msg_welcome db "City Management Simulator (10 turns)", 10, 0
    msg_stats db "Current city statistics:", 10
              db "Population: %d", 10
              db "Social welfare: %d", 10
              db "Jobs: %d", 10
              db "Happiness: %d", 10
              db "Treasury: %d", 10
              db "Factories: %d", 10
              db "Turns left: %d", 10, 0
    build_prompt db "What to build? (1 - House, 2 - Hospital, 3 - Factory, 0 - End turn): ", 0
    turn_end_msg db "Ending turn... Income calculated.", 10, 0
    game_over_msg db "Game over! Final statistics:", 10, 0
    not_enough_money db "Not enough money for construction!", 10, 0
    built_success db "Construction completed successfully!", 10, 0
    invalid_choice db "Invalid choice! Please select 0-3.", 10, 0
    income_msg db "Income this turn: %d (base) + %d (from factories) = %d", 10, 0
    house_effect db "Effect: Population +50", 10, 0
    hospital_effect db "Effect: Social welfare +10, Happiness +5, Jobs +20", 10, 0
    factory_effect db "Effect: Jobs +30, Factory added", 10, 0
    msg_no_more_turns db "Turns have ended! No more actions available.", 10, 0

    ; Format strings
    build_choice_format db "%d", 0

section .text
    global main
    extern printf, scanf, ExitProcess

%macro print_stats 0
    sub rsp, 32
    lea rcx, [rel msg_stats]
    mov rdx, [rel population]
    mov r8, [rel social_welfare]
    mov r9, [rel jobs]
    mov rax, [rel happiness]
    mov [rsp+32], rax
    mov rax, [rel money]
    mov [rsp+40], rax
    mov rax, [rel factories]
    mov [rsp+48], rax
    mov rax, [rel turns_left]
    mov [rsp+56], rax
    call printf
    add rsp, 32
%endmacro

%macro build_structure 2
    mov rax, [rel money]
    sub rax, %1
    js %%not_enough_funds
    mov [rel money], rax
    lea rcx, [rel built_success]
    call printf
    lea rcx, [rel %2]
    call printf
    jmp %%end_build
%%not_enough_funds:
    lea rcx, [rel not_enough_money]
    call printf
%%end_build:
%endmacro

main:
    sub rsp, 40

    lea rcx, [rel msg_welcome]
    call printf
    print_stats

game_loop:
    mov rax, [rel turns_left]
    test rax, rax
    jz turns_ended
    
    print_stats
    jmp build_menu

turns_ended:
    lea rcx, [rel msg_no_more_turns]
    call printf
  

build_menu:
    lea rcx, [rel build_prompt]
    call printf

    lea rcx, [rel build_choice_format]
    lea rdx, [rsp+32]
    call scanf

    mov eax, [rsp+32]
    cmp eax, 0
    je end_turn
    cmp eax, 1
    je build_house
    cmp eax, 2
    je build_hospital
    cmp eax, 3
    je build_factory

    lea rcx, [rel invalid_choice]
    call printf
    jmp build_menu

build_house:
    build_structure house_cost, house_effect
    mov rax, [rel population]
    add rax, 50
    mov [rel population], rax
    mov rax, [rel turns_left]   
    dec rax
    mov [rel turns_left], rax
    print_stats
    jmp game_loop              

build_hospital:
    build_structure hospital_cost, hospital_effect
    mov rax, [rel social_welfare]
    add rax, 10
    mov [rel social_welfare], rax
    mov rax, [rel happiness]
    add rax, 5
    mov [rel happiness], rax
    mov rax, [rel jobs]
    add rax, 20
    mov [rel jobs], rax
    mov rax, [rel turns_left]  
    dec rax
    mov [rel turns_left], rax
    print_stats
    jmp game_loop              

build_factory:
    build_structure factory_cost, factory_effect
    mov rax, [rel jobs]
    add rax, 30
    mov [rel jobs], rax
    mov rax, [rel factories]
    inc rax
    mov [rel factories], rax
    mov rax, [rel turns_left]   
    dec rax
    mov [rel turns_left], rax
    print_stats
    jmp game_loop              

end_turn:
    lea rcx, [rel turn_end_msg]
    call printf

    mov rbx, base_income_per_turn
    mov rax, [rel factories]
    imul rax, factory_income_per_turn
    add rbx, rax

    push rbx
    sub rsp, 32
    lea rcx, [rel income_msg]
    mov rdx, base_income_per_turn
    mov r8, [rel factories]
    imul r8, factory_income_per_turn
    mov r9, rbx
    call printf
    add rsp, 40

    mov rax, [rel money]
    add rax, rbx
    mov [rel money], rax

    mov rax, [rel turns_left]
    dec rax
    mov [rel turns_left], rax

    print_stats
    jmp game_loop 

game_over:
    lea rcx, [rel game_over_msg]
    call printf
    print_stats

    xor ecx, ecx
    call ExitProcess
