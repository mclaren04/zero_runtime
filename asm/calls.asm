; system call wrappers
; NASM dialect

global sys_read
global sys_write
global sys_errno

; common part for syscalls with 3 params
generic_sys_call_3:
	push ebp		; 
	mov ebp, esp		; Prologue
	push ebx		; Save ebx to follow CDECL convention
	mov ebx, [ebp+8]	; Due to Linux syscall convention
	mov ecx, [ebp+12]	;   ebx, ecx, and edx take 1-3 parameters
	mov edx, [ebp+16]	;   of the syscall
	int 80h			; Make a syscall
	mov edx, eax
	and edx, 0xfffff000	;
	cmp edx, 0xfffff000	; Check if error
	jnz .ok
	mov [sys_errno], eax	; Save error code to the exported variable
	mov eax, -1		; If it's an error function returns -1
.ok:	pop ebx			; Restore ebx
	mov esp, ebp		;
	pop ebp			;
	ret			; Epilogue

sys_read:
	mov eax, 3		; Due to Linux syscall convention
	jmp generic_sys_call_3	;   number of the syscall is passed through eax

sys_write:
	mov eax, 4
	jmp generic_sys_call_3

section .bss
sys_errno resd 1

