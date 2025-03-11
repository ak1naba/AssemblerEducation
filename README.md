# Архитектура ЭВМ

Репозиторий создан для отправки выполеннных лабораторныъ работ по дисциплине Архитектура ЭВМ

## Установка
Установил локально по инструкции с сайта  
[Metanint](https://metanit.com/assembler/nasm/1.5.php)

## Ход выполения
Работы распределены по папкам, в них будет файлы ассемблера и тектосвые файлы

## Базовая комплиляция
1. Открываем папку с работой
2. Компиляция
```bash
nasm -f win64 [....].asm -o [....].o
```
3. Компоновка
```bash
ld [....].o -o [....].exe
```
4. Запуск
```bash
[....].exe
```

> [!WARNING]  
> Работать из CMD, не PowerShell