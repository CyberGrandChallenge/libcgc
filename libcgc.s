
.macro sys_call n
	movl	$\n, %eax
.endm

.macro do_syscall
	int	$0x80
.endm

.macro syscall_arg_1
	pushl	%ebx
	movl	8(%esp), %ebx
	do_syscall
	popl	%ebx
	ret
.endm

.macro syscall_arg_2
	pushl	%ebx
	pushl	%ecx
	movl	12(%esp), %ebx
	movl	16(%esp), %ecx
	do_syscall
	popl	%ecx
	popl	%ebx
	ret
.endm

.macro syscall_arg_3
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	movl	16(%esp), %ebx
	movl	20(%esp), %ecx
	movl	24(%esp), %edx
	do_syscall
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
.endm

.macro syscall_arg_4
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%esi
	movl	20(%esp), %ebx
	movl	24(%esp), %ecx
	movl	28(%esp), %edx
	movl	32(%esp), %esi
	do_syscall
	popl	%esi
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
.endm

.macro syscall_arg_5
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%esi
	pushl	%edi
	movl	24(%esp), %ebx
	movl	28(%esp), %ecx
	movl	32(%esp), %edx
	movl	36(%esp), %esi
	movl	40(%esp), %edi
	do_syscall
	popl	%edi
	popl	%esi
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
.endm

.macro syscall_arg_6
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%esi
        pushl   %edi
	pushl	%ebp
	movl	28(%esp), %ebx
	movl	32(%esp), %ecx
	movl	36(%esp), %edx
	movl	40(%esp), %esi
	movl	44(%esp), %edi
	movl	48(%esp), %ebp
	do_syscall
	popl	%ebp
	popl	%edi
	popl	%esi
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret
.endm

	.global _start
_start:
	call main
	pushl %eax
	call _terminate

	.global _terminate
_terminate:
	sys_call 1
	syscall_arg_1

	.global transmit
transmit:
	sys_call 2
	syscall_arg_4

	.global receive
receive:
	sys_call 3
	syscall_arg_4

	.global fdwait
fdwait:
	sys_call 4
	syscall_arg_5

	.global allocate
allocate:
	sys_call 5
	syscall_arg_3

	.global deallocate
deallocate:
	sys_call 6
	syscall_arg_2

	.global random
random:
	sys_call 7
	syscall_arg_3
