; Executable Name: fibonacci
; Version 		 : 1.0
; Created		 : Nov. 8, 2017
; Author		 : Joseph Guidry
; Description    : Implement the function F(N)
;				   0               for n = 0
;				   1               for n = 1
;                  F(n-2) + F(n-1) for n > 1

; ./fibonacci <N>
;+==============================================================================================================+
	extern	printf			; external C function
	extern 	scanf			; external C function
	extern	strtoul			; external C function

	global	main
;+==============================================================================================================+
	SECTION .data
msg1: db "Loop msg %d", 10, 0
msg2: db "print msg", 10, 0
msg3: db "update msg", 10, 0

Echo:
	db "The command line is: %s %s", 10, 0

scanf_prompt:	db "Please enter the desired Fibonacci Number(0 - 200):", 0
printf_prompt:  db "%016llx%016llx%016llx%016llx%016llx%016llx", 10, 0
error_prompt:   db "No value was entered",10,"Please enter a single integer(0 - 500)", 10, 0

total:	dq 0, 0, 0, 0, 0, 0

a: 		dq 0, 0, 0, 0, 0, 0
b:		dq 1, 0, 0, 0, 0, 0
;+==============================================================================================================+
	SECTION .bss

temp:	resq	1	; This will be for N in F(N).
;+==============================================================================================================+
	SECTION .text
main:
	push	r15
	mov		r15, rsi

	cmp 	edi, 1				; Check if the CL args == 1  (jump on equal)
	je 		help

	;cmp 	edi, 2
	;jne 	Usage_Error			;If more than 1 CL arguement => ERROR ( jump on not equal )
		
	;Print what is entered on the command line if arguments are successful-> could remove later.
	mov 	rdi, Echo
	mov 	rsi, [r15]
	mov 	rdx, [r15 + 8]
	xor 	rax, rax
	call 	printf

	; Convert arguement to input value
	mov rdi, [r15 + 8]
	mov rdx, 10
	lea rsi, [rsp]
	call strtoul
	mov rcx, [rsp]
	mov qword[temp], rax
	
	cmp qword[temp], 0
	je 	print_output;

	mov rbx, qword[temp]

fib_loop:
	mov rdi, msg1
	mov rsi, rbx
	call printf

	; Move the value of a = b
	mov rdx, qword [b]
	mov qword [a], rdx
	mov rdx, qword[b + 8]
	mov qword[a + 8], rdx
	mov rdx, qword[b + 16]
	mov qword[a + 16], rdx
	mov rdx, qword[b + 24]
	mov qword[a + 24], rdx
	mov rdx, qword[b + 32]
	mov qword[a + 32], rdx
	mov rdx, qword[b + 40]
	mov qword[a + 40], rdx

	; Move the value b = total
	mov rax, qword[total]
	mov qword[b], rax
	mov rax, qword[total + 8]
	mov qword[b + 8], rax
	mov rax, qword[total + 16]
	mov qword[b + 16], rax
	mov rax, qword[total + 24]
	mov qword[b + 24], rax
	mov rax, qword[total + 32]
	mov qword[b + 32], rax
	mov rax, qword[total + 40]
	mov qword[b + 40], rax
	;jmp update_a_and_b

	mov rax, qword[a]
	add rax, qword[b]
	mov qword[total], rax
	
	mov rax, qword[a + 8]
	adc rax, qword[b + 8]
	mov qword[total + 8], rax

	mov rax, qword[a + 16]
	adc rax, qword[b + 16]
	mov qword[total + 16], rax

	mov rax, qword[a + 24]
	adc rax, qword[b + 24]
	mov qword[total + 24], rax

	mov rax, qword[a + 32]
	adc rax, qword[b + 32]
	mov qword[total + 32], rax

	mov rax, qword[a + 40]
	adc rax, qword[b + 40]
	mov qword[total + 40], rax

	cmp ebx, 1
	je print_output	

	dec ebx
	jmp fib_loop
	jmp Return

print_output:	; The values need to be in reverse order!
	mov rdi, msg2
	call printf

	mov rdi, printf_prompt
	mov rsi, [total + 40]
	mov rdx, [total + 32]
	mov rcx, [total + 24]
	mov r8, [total + 16]
	mov r9, [total + 8]
	push qword[total]
	xor rax, rax	
	call printf
	pop qword[temp]

; This would provide a proper exit
Return:
	pop 	r15	
	ret

help:
	; NEED TO HAVE FLOURISH PRINT OUT/SCANF STUFF.
	mov 	rdi, error_prompt
	call 	printf
	jmp		Return
