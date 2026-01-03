; to_roman function for x86
; (C) 2026, Ellie McNeill
; converts number to roman numerals
; using 'standard' subtractive form.
; works for values up to 3,999.
; 'E' is returned for errors.

section .text

ST_VALUE equ 12 ; value to convert
ST_BUFFER equ 8 ; buffer to store chars

global to_roman

to_roman:

enter 0, 0

mov eax, ebp[ST_VALUE]
mov edi, ebp[ST_BUFFER]

cmp eax, 0
jle error
cmp eax, 4000
jge error

thousand: ; thousands

mov edx, 0 ; edx must be 0 for division
mov ebx, 1000 ; divisor
idiv ebx
; now: eax = quotient, edx = remainder
cmp eax, 0
je five_hundred

thousand_loop:

; quotient eax becomes loop counter

mov [edi], byte 'M'
inc edi ; pointer to current char
dec eax
cmp eax, 0
jg thousand_loop

five_hundred: ; five-hundreds

mov eax, edx ; remainder becomes new dividend
cmp eax, 900
jge nine_hundred
cmp eax, 500
jl hundred

mov [edi], byte 'D'
inc edi
sub eax, 500
mov edx, eax
jmp hundred

nine_hundred:

mov [edi], byte 'C'
inc edi
mov [edi], byte 'M'
inc edi
sub eax, 900
mov edx, eax

hundred: ; hundreds

mov eax, edx ; use remainder
mov edx, 0
cmp eax, 400
jge four_hundred
mov ebx, 100
idiv ebx
cmp eax, 0
je fifty

hundred_loop:

mov [edi], byte 'C'
inc edi
dec eax
cmp eax, 0
jg hundred_loop
jmp fifty

four_hundred:

mov [edi], byte 'C'
inc edi
mov [edi], byte 'D'
inc edi
sub eax, 400
mov edx, eax

fifty: ; fifties

mov eax, edx ; use remainder
cmp eax, 90
jge ninety
cmp eax, 50
jl ten

mov [edi], byte 'L'
inc edi
sub eax, 50
mov edx, eax
jmp ten

ninety:

mov [edi], byte 'X'
inc edi
mov [edi], byte 'C'
inc edi
sub eax, 90
mov edx, eax

ten:    ; tens

mov eax, edx ; use remainder
mov edx, 0
mov ebx, 10
idiv ebx
cmp eax, 0
je five
cmp eax, 4
je forty

ten_loop:

mov [edi], byte 'X'
inc edi
dec eax
cmp eax, 0
jg ten_loop
jmp five

forty:

mov [edi], byte 'X'
inc edi
mov [edi], byte 'L'
inc edi

five:   ; fives

mov eax, edx ; use remainder
cmp eax, 9
je nine
cmp eax, 4
je four

mov edx, 0
mov ebx, 5
idiv ebx
cmp eax, 0
je one

five_loop:

mov [edi], byte 'V'
inc edi
dec eax
cmp eax, 0
jg five_loop
jmp one

nine:

mov [edi], byte 'I'
inc edi
mov [edi], byte 'X'
inc edi
mov edx, 0
jmp one

four:

mov [edi], byte 'I'
inc edi
mov [edi], byte 'V'
inc edi
mov edx, 0

one:    ; ones

mov eax, edx ; remainder

one_loop:

dec eax
cmp eax, 0
jl end_to_roman ; underflow!

mov [edi], byte 'I'
inc edi
jmp one_loop

error:

mov [edi], byte 'E'
inc edi

end_to_roman:

mov [edi], byte 0Ah ; newline
inc edi
mov [edi], byte 0 ; null-terminate

leave
ret
