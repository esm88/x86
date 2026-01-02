section .text

global count_chars

count_chars:

push ebp
mov ebp, esp

mov eax, 0
mov ebx, [ebp+8]    ;   start of string

count_loop:

cmp [ebx + eax], byte 0
je end_count

inc eax
jmp count_loop

end_count:  ; result is in eax

mov esp, ebp
pop ebp
ret
