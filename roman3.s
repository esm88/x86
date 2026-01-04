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

thousands:

cmp eax, 1000
jl nine_hundred

mov [edi], byte 'M'
inc edi
sub eax, 1000
jmp thousands

nine_hundred:

cmp eax, 900
jl five_hundred

mov [edi], byte 'C'
inc edi
mov [edi], byte 'M'
inc edi
sub eax, 900
jmp ninety  ; hundreds not needed

five_hundred:

cmp eax, 500
jl four_hundred
mov [edi], byte 'D'
inc edi
sub eax, 500
jmp hundreds

four_hundred:

cmp eax, 400
jl hundreds
mov [edi], byte 'C'
inc edi
mov [edi], byte 'D'
inc edi
sub eax, 400
jmp ninety  ; hundreds not needed

hundreds:

cmp eax, 100
jl ninety

mov [edi], byte 'C'
inc edi
sub eax, 100
jmp hundreds

ninety:

cmp eax, 90
jl fifty

mov [edi], byte 'X'
inc edi
mov [edi], byte 'C'
inc edi
sub eax, 90
jmp nine    ; tens not needed

fifty:

cmp eax, 50
jl forty
mov [edi], byte 'L'
inc edi
sub eax, 50
jmp tens

forty:

cmp eax, 40
jl tens
mov [edi], byte 'X'
inc edi
mov [edi], byte 'L'
inc edi
sub eax, 40
jmp nine    ; tens not needed

tens:

cmp eax, 10
jl nine
mov [edi], byte 'X'
inc edi
sub eax, 10
jmp tens

nine:

cmp eax, 9
jl five
mov [edi], byte 'I'
inc edi
mov [edi], byte 'X'
inc edi
sub eax, 9
jmp end_roman   ; ones not needed

five:

cmp eax, 5
jl four
mov [edi], byte 'V'
inc edi
sub eax, 5
jmp ones

four:

cmp eax, 4
jl ones
mov [edi], byte 'I'
inc edi
mov [edi], byte 'V'
inc edi
sub eax, 4
jmp end_roman   ; ones not needed

ones:

cmp eax, 0
je end_roman
mov [edi], byte 'I'
inc edi
dec eax
jmp ones

jmp end_roman

error:

mov [edi], byte 'E'
inc edi

end_roman:

mov [edi], byte `\n` ; newline
inc edi
mov [edi], byte 0 ; null-terminate

leave
ret
