extern malloc
global _start

section .text

_start:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD [rbp-24], rdi
	mov	edi, 9
	call	malloc
	mov	QWORD [rbp-8], rax
	mov	DWORD [rbp-12], 0
	jmp	.L2
.L3:
	mov	eax, DWORD [rbp-12]
	sal	eax, 3
	mov	rdx, QWORD [rbp-24]
	mov	ecx, eax
	shr	rdx, cl
	mov	rcx, rdx
	mov	eax, 7
	sub	eax, DWORD [rbp-12]
	movsx	rdx, eax
	mov	rax, QWORD [rbp-8]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE [rax], dl
	add	DWORD [rbp-12], 1
.L2:
	cmp	DWORD [rbp-12], 7
	jle	.L3
	mov	rax, QWORD [rbp-8]
	add	rax, 8
	mov	BYTE [rax], 0
	mov	rax, QWORD [rbp-8]
	leave
	ret
