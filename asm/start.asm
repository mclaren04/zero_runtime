; Entrypoint wrapper
; NASM dialect

global _start
extern main

section .text
_start:
	mov eax, [esp]	; eax = argc
	mov ecx, esp	;
	add ecx, 4	; ecx = argv
	push ecx	;
	push eax	; Pass parameters for main in reverse order
	call main
	add esp, 8	; Remove main parameters from the stack
	mov ebx, eax	; ebx = main(argc, argv)
	mov eax, 1	; eax = number of syscall exit 
	int 80h		; Trigger exit syscall
