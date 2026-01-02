; program to test the to_roman function
; (C) 2026, Ellie McNeill
; tests all values from 0 to 4000
; assemble all .s files with nasm,
; then link the .o files with ld.
; choose EITHER roman.o or roman2.o

%include "linux.s"

section .data

value dd 0

section .bss

buffer: resb 20

section .text

extern to_roman
extern count_chars
global _start

_start:

main_loop:

push dword [value]
push buffer
call to_roman
pop ecx

push buffer
call count_chars
mov edx, eax
mov eax, WRITE
mov ebx, STDOUT
mov ecx, buffer
int 80h

inc dword [value]
cmp dword [value], 4000
jle main_loop

mov eax, 1
mov ebx, 0
int 80h
