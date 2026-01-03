; to_roman function for x86
; (C) 2026, Ellie McNeill
; converts number to roman numerals
; using 'standard' subtractive form.
; works for values up to 3,999.
; 'E' is returned for errors.
; this function works by using repeated
; subtraction until an underflow occurs.
; it then un-does the last operation by
; re-adding the last value and backspacing
; the character pointer (edi).
; note that 900/400, 90/40, 9/4 are all
; special cases as they are subtractive.
; loops are only needed for 1000/100/10/1s

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

mov [edi], byte 'M'
inc edi
sub eax, 1000
jns thousands

; underflow occured:

add eax, 1000
dec edi     ; backspace

; 900

mov [edi], byte 'C'
inc edi
mov [edi], byte 'M'
inc edi

sub eax, 900
jns ninety  ; hundreds not needed

add eax, 900
sub edi, 2  ; backspace 2 chars

; 500:

mov [edi], byte 'D'
inc edi
sub eax, 500
jns hundreds

add eax, 500
dec edi

; 400:

mov [edi], byte 'C'
inc edi
mov [edi], byte 'D'
inc edi
sub eax, 400
jns ninety  ; hundreds not needed

add eax, 400
sub edi, 2

hundreds:

mov [edi], byte 'C'
inc edi
sub eax, 100
jns hundreds

add eax, 100
dec edi

ninety:

mov [edi], byte 'X'
inc edi
mov [edi], byte 'C'
inc edi
sub eax, 90
jns nine    ; tens not needed

add eax, 90
sub edi, 2

; 50:

mov [edi], byte 'L'
inc edi
sub eax, 50
jns tens

add eax, 50
dec edi

; 40:

mov [edi], byte 'X'
inc edi
mov [edi], byte 'L'
inc edi
sub eax, 40
jns nine    ; tens not needed

add eax, 40
sub edi, 2

tens:

mov [edi], byte 'X'
inc edi
sub eax, 10
jns tens

add eax, 10
dec edi

nine:

mov [edi], byte 'I'
inc edi
mov [edi], byte 'X'
inc edi
sub eax, 9
jns end_roman   ; ones not needed

add eax, 9
sub edi, 2

; five:

mov [edi], byte 'V'
inc edi
sub eax, 5
jns ones

add eax, 5
dec edi

; four:

mov [edi], byte 'I'
inc edi
mov [edi], byte 'V'
inc edi
sub eax, 4
jns end_roman   ; ones not needed

add eax, 4
sub edi, 2

ones:

mov [edi], byte 'I'
inc edi
dec eax
jns ones

dec edi
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
