; to_roman function for x86
; (C) 2026, Ellie McNeill
; converts number to roman numerals.
; notation is strictly 'additive'.

section .text

ST_VALUE equ 12 ; value to convert
ST_BUFFER equ 8 ; buffer to store chars

global to_roman

to_roman:

push ebp
mov ebp, esp

mov eax, ebp[ST_VALUE]
mov edi, ebp[ST_BUFFER]

ten:    ; tens

sub eax, 10
cmp eax, 0
jl underflow_ten ; underflow!

mov [edi], byte 'x'
inc edi
jmp ten

underflow_ten:

add eax, 10 ; fix underflow

five:   ; fives

sub eax, 5
cmp eax, 0
jl underflow_five

mov [edi], byte 'v'
inc edi
jmp five

underflow_five:

add eax, 5 ; fix underflow

one:    ; ones

dec eax
cmp eax, 0
jl end_to_roman ; underflow!

mov [edi], byte 'i'
inc edi
jmp one

end_to_roman:

mov [edi], byte 0Ah ; newline
inc edi
mov [edi], byte 0 ; terminate

mov esp, ebp
pop ebp
ret
