	.file	"fixedpoint_tests.c"
	.text
	.section	.rodata
.LC0:
	.string	"test_whole_part"
.LC1:
	.string	"%s..."
.LC2:
	.string	"passed!"
.LC3:
	.string	"test_frac_part"
.LC4:
	.string	"test_create_from_hex"
.LC5:
	.string	"test_format_as_hex"
.LC6:
	.string	"test_negate"
.LC7:
	.string	"test_add"
.LC8:
	.string	"test_sub"
.LC9:
	.string	"test_is_overflow_pos"
.LC10:
	.string	"test_is_err"
.LC11:
	.string	"test_halve"
.LC12:
	.string	"test_compare"
.LC13:
	.string	"test_fixedpoint_double"
.LC14:
	.string	"test_fixedpoint_is_zero"
.LC15:
	.string	"test_fixedpoint_is_neg"
	.align 8
.LC16:
	.string	"test_fixedpoint_is_overflow_neg"
	.align 8
.LC17:
	.string	"test_fixedpoint_is_overflow_pos"
	.align 8
.LC18:
	.string	"testfixedpoint_is_underflow_neg"
	.align 8
.LC19:
	.string	"testfixedpoint_is_underflow_pos"
.LC20:
	.string	"testfixedpoint_is_valid"
.LC21:
	.string	"All tests passed!"
.LC22:
	.string	"%d test(s) failed\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$176, %rsp
	movl	%edi, -164(%rbp)
	movq	%rsi, -176(%rbp)
	cmpl	$1, -164(%rbp)
	jle	.L2
	movq	-176(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, tctest_testname_to_execute(%rip)
.L2:
	call	tctest_register_signal_handlers
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L3
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L4
.L3:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L6
	call	setup
	movq	%rax, -8(%rbp)
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	test_whole_part
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L4
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC0, %edi
	call	*%rax
	jmp	.L4
.L6:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L4
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC0, %edi
	call	*%rax
.L4:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L7
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L8
.L7:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L9
	call	setup
	movq	%rax, -16(%rbp)
	movl	$.LC3, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	test_frac_part
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L8
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC3, %edi
	call	*%rax
	jmp	.L8
.L9:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L8
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC3, %edi
	call	*%rax
.L8:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L10
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC4, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L11
.L10:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L12
	call	setup
	movq	%rax, -24(%rbp)
	movl	$.LC4, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	test_create_from_hex
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L11
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC4, %edi
	call	*%rax
	jmp	.L11
.L12:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L11
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC4, %edi
	call	*%rax
.L11:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L13
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L14
.L13:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L15
	call	setup
	movq	%rax, -32(%rbp)
	movl	$.LC5, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	test_format_as_hex
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L14
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC5, %edi
	call	*%rax
	jmp	.L14
.L15:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L14
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC5, %edi
	call	*%rax
.L14:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L16
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L17
.L16:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L18
	call	setup
	movq	%rax, -40(%rbp)
	movl	$.LC6, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	test_negate
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L17
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC6, %edi
	call	*%rax
	jmp	.L17
.L18:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L17
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC6, %edi
	call	*%rax
.L17:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L19
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC7, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L20
.L19:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L21
	call	setup
	movq	%rax, -48(%rbp)
	movl	$.LC7, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	test_add
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L20
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC7, %edi
	call	*%rax
	jmp	.L20
.L21:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L20
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC7, %edi
	call	*%rax
.L20:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L22
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC8, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L23
.L22:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L24
	call	setup
	movq	%rax, -56(%rbp)
	movl	$.LC8, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	test_sub
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L23
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC8, %edi
	call	*%rax
	jmp	.L23
.L24:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L23
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC8, %edi
	call	*%rax
.L23:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L25
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC9, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L26
.L25:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L27
	call	setup
	movq	%rax, -64(%rbp)
	movl	$.LC9, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	test_is_overflow_pos
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L26
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC9, %edi
	call	*%rax
	jmp	.L26
.L27:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L26
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC9, %edi
	call	*%rax
.L26:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L28
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC10, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L29
.L28:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L30
	call	setup
	movq	%rax, -72(%rbp)
	movl	$.LC10, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	test_is_err
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L29
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC10, %edi
	call	*%rax
	jmp	.L29
.L30:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L29
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC10, %edi
	call	*%rax
.L29:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L31
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC11, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L32
.L31:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L33
	call	setup
	movq	%rax, -80(%rbp)
	movl	$.LC11, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	test_halve
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L32
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC11, %edi
	call	*%rax
	jmp	.L32
.L33:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L32
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC11, %edi
	call	*%rax
.L32:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L34
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC12, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L35
.L34:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L36
	call	setup
	movq	%rax, -88(%rbp)
	movl	$.LC12, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	test_compare
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L35
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC12, %edi
	call	*%rax
	jmp	.L35
.L36:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L35
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC12, %edi
	call	*%rax
.L35:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L37
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC13, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L38
.L37:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L39
	call	setup
	movq	%rax, -96(%rbp)
	movl	$.LC13, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	test_fixedpoint_double
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L38
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC13, %edi
	call	*%rax
	jmp	.L38
.L39:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L38
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC13, %edi
	call	*%rax
.L38:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L40
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC14, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L41
.L40:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L42
	call	setup
	movq	%rax, -104(%rbp)
	movl	$.LC14, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	test_fixedpoint_is_zero
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L41
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC14, %edi
	call	*%rax
	jmp	.L41
.L42:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L41
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC14, %edi
	call	*%rax
.L41:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L43
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC15, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L44
.L43:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L45
	call	setup
	movq	%rax, -112(%rbp)
	movl	$.LC15, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	test_fixedpoint_is_neg
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L44
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC15, %edi
	call	*%rax
	jmp	.L44
.L45:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L44
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC15, %edi
	call	*%rax
.L44:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L46
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC16, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L47
.L46:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L48
	call	setup
	movq	%rax, -120(%rbp)
	movl	$.LC16, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	test_fixedpoint_is_overflow_neg
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L47
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC16, %edi
	call	*%rax
	jmp	.L47
.L48:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L47
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC16, %edi
	call	*%rax
.L47:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L49
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC17, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L50
.L49:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L51
	call	setup
	movq	%rax, -128(%rbp)
	movl	$.LC17, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	test_fixedpoint_is_overflow_pos
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L50
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC17, %edi
	call	*%rax
	jmp	.L50
.L51:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L50
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC17, %edi
	call	*%rax
.L50:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L52
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC18, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L53
.L52:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L54
	call	setup
	movq	%rax, -136(%rbp)
	movl	$.LC18, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	testfixedpoint_is_underflow_neg
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L53
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC18, %edi
	call	*%rax
	jmp	.L53
.L54:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L53
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC18, %edi
	call	*%rax
.L53:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L55
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC19, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L56
.L55:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L57
	call	setup
	movq	%rax, -144(%rbp)
	movl	$.LC19, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	testfixedpoint_is_underflow_pos
	movq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L56
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC19, %edi
	call	*%rax
	jmp	.L56
.L57:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L56
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC19, %edi
	call	*%rax
.L56:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L58
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC20, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L59
.L58:
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L60
	call	setup
	movq	%rax, -152(%rbp)
	movl	$.LC20, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	testfixedpoint_is_valid
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
	movl	$.LC2, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L59
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC20, %edi
	call	*%rax
	jmp	.L59
.L60:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L59
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC20, %edi
	call	*%rax
.L59:
	movl	tctest_failures(%rip), %eax
	testl	%eax, %eax
	jne	.L61
	movl	$.LC21, %edi
	call	puts
	jmp	.L62
.L61:
	movl	tctest_failures(%rip), %eax
	movl	%eax, %esi
	movl	$.LC22, %edi
	movl	$0, %eax
	call	printf
.L62:
	movq	tctest_on_complete(%rip), %rax
	testq	%rax, %rax
	je	.L63
	movq	tctest_on_complete(%rip), %rdx
	movl	tctest_num_executed(%rip), %eax
	movl	tctest_num_executed(%rip), %ecx
	movl	tctest_failures(%rip), %esi
	subl	%esi, %ecx
	movl	%eax, %esi
	movl	%ecx, %edi
	call	*%rdx
.L63:
	movl	tctest_failures(%rip), %eax
	testl	%eax, %eax
	setg	%al
	movzbl	%al, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.globl	setup
	.type	setup, @function
setup:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movl	$168, %edi
	call	malloc
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	fixedpoint_create
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, (%rbx)
	movq	%rdx, 8(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 16(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	fixedpoint_create
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 24(%rbx)
	movq	%rdx, 32(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 40(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 48(%rbx)
	movq	%rdx, 56(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 64(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movabsq	$4611686018427387904, %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 72(%rbx)
	movq	%rdx, 80(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 88(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movabsq	$1016197948440, %rdx
	movabsq	$20159855850, %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 96(%rbx)
	movq	%rdx, 104(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 112(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movabsq	$84774664425391, %rdx
	movl	$265024469, %esi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 120(%rbx)
	movq	%rdx, 128(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 136(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movq	$-1, %rdx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 144(%rbx)
	movq	%rdx, 152(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 160(%rbx)
	movq	-24(%rbp), %rbx
	leaq	-64(%rbp), %rax
	movq	$-1, %rdx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, 144(%rbx)
	movq	%rdx, 152(%rbx)
	movq	-48(%rbp), %rax
	movq	%rax, 160(%rbx)
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	setup, .-setup
	.globl	cleanup
	.type	cleanup, @function
cleanup:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	cleanup, .-cleanup
	.section	.rodata
	.align 8
.LC23:
	.string	"0UL == fixedpoint_whole_part(objs->zero)"
.LC24:
	.string	"failed ASSERT %s at line %d\n"
	.align 8
.LC25:
	.string	"1UL == fixedpoint_whole_part(objs->one)"
	.align 8
.LC26:
	.string	"0UL == fixedpoint_whole_part(objs->one_half)"
	.align 8
.LC27:
	.string	"0UL == fixedpoint_whole_part(objs->one_fourth)"
	.align 8
.LC28:
	.string	"0x4b19efceaUL == fixedpoint_whole_part(objs->large1)"
	.align 8
.LC29:
	.string	"0xfcbf3d5UL == fixedpoint_whole_part(objs->large2)"
	.text
	.globl	test_whole_part
	.type	test_whole_part, @function
test_whole_part:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$107, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L69
	movl	$107, %edx
	movl	$.LC23, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L69:
	movl	$108, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$1, %rax
	je	.L70
	movl	$108, %edx
	movl	$.LC25, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L70:
	movl	$109, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L71
	movl	$109, %edx
	movl	$.LC26, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L71:
	movl	$110, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L72
	movl	$110, %edx
	movl	$.LC27, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L72:
	movl	$111, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	movabsq	$20159855850, %rdx
	cmpq	%rdx, %rax
	je	.L73
	movl	$111, %edx
	movl	$.LC28, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L73:
	movl	$112, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$265024469, %rax
	je	.L75
	movl	$112, %edx
	movl	$.LC29, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L75:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	test_whole_part, .-test_whole_part
	.section	.rodata
	.align 8
.LC30:
	.string	"0UL == fixedpoint_frac_part(objs->zero)"
	.align 8
.LC31:
	.string	"0UL == fixedpoint_frac_part(objs->one)"
	.align 8
.LC32:
	.string	"0x8000000000000000UL == fixedpoint_frac_part(objs->one_half)"
	.align 8
.LC33:
	.string	"0x4000000000000000UL == fixedpoint_frac_part(objs->one_fourth)"
	.align 8
.LC34:
	.string	"0xec9a1e2418UL == fixedpoint_frac_part(objs->large1)"
	.align 8
.LC35:
	.string	"0x4d1a23c24fafUL == fixedpoint_frac_part(objs->large2)"
	.text
	.globl	test_frac_part
	.type	test_frac_part, @function
test_frac_part:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$117, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L77
	movl	$117, %edx
	movl	$.LC30, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L77:
	movl	$118, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L78
	movl	$118, %edx
	movl	$.LC31, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L78:
	movl	$119, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L79
	movl	$119, %edx
	movl	$.LC32, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L79:
	movl	$120, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$4611686018427387904, %rdx
	cmpq	%rdx, %rax
	je	.L80
	movl	$120, %edx
	movl	$.LC33, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L80:
	movl	$121, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$1016197948440, %rdx
	cmpq	%rdx, %rax
	je	.L81
	movl	$121, %edx
	movl	$.LC34, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L81:
	movl	$122, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-8(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$84774664425391, %rdx
	cmpq	%rdx, %rax
	je	.L83
	movl	$122, %edx
	movl	$.LC35, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L83:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	test_frac_part, .-test_frac_part
	.section	.rodata
.LC36:
	.string	"f6a5865.00f2"
.LC37:
	.string	"fixedpoint_is_valid(val1)"
	.align 8
.LC38:
	.string	"0xf6a5865UL == fixedpoint_whole_part(val1)"
	.align 8
.LC39:
	.string	"0x00f2000000000000UL == fixedpoint_frac_part(val1)"
.LC40:
	.string	"-0"
.LC41:
	.string	"val2.tag == 1"
.LC42:
	.string	"val2.whole_part == 0x0UL"
.LC43:
	.string	"val2.frac_part == 0x0UL"
.LC44:
	.string	"3.4"
.LC45:
	.string	"val3.tag == 1"
.LC46:
	.string	"val3.whole_part == 0x3UL"
	.align 8
.LC47:
	.string	"val3.frac_part == 0x4000000000000000UL"
.LC48:
	.string	"2.5"
.LC49:
	.string	"val4.tag == 1"
.LC50:
	.string	"val4.whole_part == 0x2UL"
	.align 8
.LC51:
	.string	"val4.frac_part == 0x5000000000000000UL"
.LC52:
	.string	"-1.7"
.LC53:
	.string	"val5.tag == -1"
.LC54:
	.string	"val5.whole_part == 0x1UL"
	.align 8
.LC55:
	.string	"val5.frac_part == 0x7000000000000000UL"
.LC56:
	.string	"-0.4"
.LC57:
	.string	"val6.tag == -1"
.LC58:
	.string	"val6.whole_part == 0x0UL"
	.align 8
.LC59:
	.string	"val6.frac_part == 0x4000000000000000UL"
.LC60:
	.string	"0.8"
.LC61:
	.string	"val7.tag == 1"
.LC62:
	.string	"val7.whole_part == 0x0UL"
	.align 8
.LC63:
	.string	"val7.frac_part == 0x8000000000000000UL"
.LC64:
	.string	"val8.tag == 1"
.LC65:
	.string	"val8.whole_part == 0x0UL"
.LC66:
	.string	"val8.frac_part == 0x0UL"
.LC67:
	.string	".2"
.LC68:
	.string	"valss2.tag == 1"
.LC69:
	.string	"valss2.whole_part == 0x0UL"
	.align 8
.LC70:
	.string	"valss2.frac_part == 0x2000000000000000UL"
.LC71:
	.string	"valssssss2.tag == 1"
	.align 8
.LC72:
	.string	"valssssss2.whole_part == 0x0UL"
.LC73:
	.string	"valssssss2.frac_part == 0x0UL"
.LC74:
	.string	"-.2"
.LC75:
	.string	"valee2.tag == -1"
.LC76:
	.string	"valee2.whole_part == 0x0UL"
	.align 8
.LC77:
	.string	"valee2.frac_part == 0x2000000000000000UL"
.LC78:
	.string	"2"
.LC79:
	.string	"v2al2.tag == 1"
.LC80:
	.string	"v2al2.whole_part == 0x2UL"
.LC81:
	.string	"v2al2.frac_part == 0x0UL"
.LC82:
	.string	"-2"
.LC83:
	.string	"vael2.tag == -1"
.LC84:
	.string	"vael2.whole_part == 0x2UL"
.LC85:
	.string	"vael2.frac_part == 0x0UL"
	.align 8
.LC86:
	.string	"-2222222222222222.1234567390abcdef"
.LC87:
	.string	"val1232.tag == -1"
	.align 8
.LC88:
	.string	"val1232.whole_part == 0x2222222222222222UL"
	.align 8
.LC89:
	.string	"val1232.frac_part == 0x1234567390abcdefUL"
.LC90:
	.string	"-.3333333333333333"
.LC91:
	.string	"val1d2.tag == -1"
.LC92:
	.string	"val1d2.whole_part == 0x0UL"
	.align 8
.LC93:
	.string	"val1d2.frac_part == 0x3333333333333333UL"
.LC94:
	.string	"3333333333333333"
.LC95:
	.string	"valasdss2.tag == 1"
.LC96:
	.string	"valasdss2.frac_part == 0x0UL"
	.align 8
.LC97:
	.string	"valasdss2.whole_part == 0x3333333333333333UL"
.LC98:
	.string	"-3333333333333333"
.LC99:
	.string	"valh2.tag == -1"
.LC100:
	.string	"valh2.frac_part == 0x0UL"
	.align 8
.LC101:
	.string	"valh2.whole_part == 0x3333333333333333UL"
.LC102:
	.string	"-333333333333333333333"
.LC103:
	.string	"fixedpoint_is_err(valgg2)"
.LC104:
	.string	"1234567890abcdef1"
.LC105:
	.string	"fixedpoint_is_err(valdsf2)"
.LC106:
	.string	"1234567890abcgwwww"
.LC107:
	.string	"fixedpoint_is_err(val2rwc)"
.LC108:
	.string	"wwww2390abcgwwww"
.LC109:
	.string	"fixedpoint_is_err(vqal2)"
.LC110:
	.string	"...90abcgwwww"
.LC111:
	.string	"fixedpoint_is_err(vall2)"
	.text
	.globl	test_create_from_hex
	.type	test_create_from_hex, @function
test_create_from_hex:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$720, %rsp
	movq	%rdi, -712(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC36, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$131, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L85
	movl	$131, %edx
	movl	$.LC37, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L85:
	movl	$133, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$258627685, %rax
	je	.L86
	movl	$133, %edx
	movl	$.LC38, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L86:
	movl	$135, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$68116944363978752, %rdx
	cmpq	%rdx, %rax
	je	.L87
	movl	$135, %edx
	movl	$.LC39, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L87:
	leaq	-64(%rbp), %rax
	movl	$.LC40, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$138, tctest_assertion_line(%rip)
	movl	-48(%rbp), %eax
	cmpl	$1, %eax
	je	.L88
	movl	$138, %edx
	movl	$.LC41, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L88:
	movl	$139, tctest_assertion_line(%rip)
	movq	-64(%rbp), %rax
	testq	%rax, %rax
	je	.L89
	movl	$139, %edx
	movl	$.LC42, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L89:
	movl	$140, tctest_assertion_line(%rip)
	movq	-56(%rbp), %rax
	testq	%rax, %rax
	je	.L90
	movl	$140, %edx
	movl	$.LC43, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L90:
	leaq	-96(%rbp), %rax
	movl	$.LC44, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$143, tctest_assertion_line(%rip)
	movl	-80(%rbp), %eax
	cmpl	$1, %eax
	je	.L91
	movl	$143, %edx
	movl	$.LC45, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L91:
	movl	$144, tctest_assertion_line(%rip)
	movq	-96(%rbp), %rax
	cmpq	$3, %rax
	je	.L92
	movl	$144, %edx
	movl	$.LC46, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L92:
	movl	$145, tctest_assertion_line(%rip)
	movq	-88(%rbp), %rax
	movabsq	$4611686018427387904, %rdx
	cmpq	%rdx, %rax
	je	.L93
	movl	$145, %edx
	movl	$.LC47, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L93:
	leaq	-128(%rbp), %rax
	movl	$.LC48, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$148, tctest_assertion_line(%rip)
	movl	-112(%rbp), %eax
	cmpl	$1, %eax
	je	.L94
	movl	$148, %edx
	movl	$.LC49, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L94:
	movl	$149, tctest_assertion_line(%rip)
	movq	-128(%rbp), %rax
	cmpq	$2, %rax
	je	.L95
	movl	$149, %edx
	movl	$.LC50, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L95:
	movl	$150, tctest_assertion_line(%rip)
	movq	-120(%rbp), %rax
	movabsq	$5764607523034234880, %rdx
	cmpq	%rdx, %rax
	je	.L96
	movl	$150, %edx
	movl	$.LC51, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L96:
	leaq	-160(%rbp), %rax
	movl	$.LC52, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$153, tctest_assertion_line(%rip)
	movl	-144(%rbp), %eax
	cmpl	$-1, %eax
	je	.L97
	movl	$153, %edx
	movl	$.LC53, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L97:
	movl	$154, tctest_assertion_line(%rip)
	movq	-160(%rbp), %rax
	cmpq	$1, %rax
	je	.L98
	movl	$154, %edx
	movl	$.LC54, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L98:
	movl	$155, tctest_assertion_line(%rip)
	movq	-152(%rbp), %rax
	movabsq	$8070450532247928832, %rdx
	cmpq	%rdx, %rax
	je	.L99
	movl	$155, %edx
	movl	$.LC55, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L99:
	leaq	-192(%rbp), %rax
	movl	$.LC56, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$158, tctest_assertion_line(%rip)
	movl	-176(%rbp), %eax
	cmpl	$-1, %eax
	je	.L100
	movl	$158, %edx
	movl	$.LC57, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L100:
	movl	$159, tctest_assertion_line(%rip)
	movq	-192(%rbp), %rax
	testq	%rax, %rax
	je	.L101
	movl	$159, %edx
	movl	$.LC58, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L101:
	movl	$160, tctest_assertion_line(%rip)
	movq	-184(%rbp), %rax
	movabsq	$4611686018427387904, %rdx
	cmpq	%rdx, %rax
	je	.L102
	movl	$160, %edx
	movl	$.LC59, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L102:
	leaq	-224(%rbp), %rax
	movl	$.LC60, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$163, tctest_assertion_line(%rip)
	movl	-208(%rbp), %eax
	cmpl	$1, %eax
	je	.L103
	movl	$163, %edx
	movl	$.LC61, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L103:
	movl	$164, tctest_assertion_line(%rip)
	movq	-224(%rbp), %rax
	testq	%rax, %rax
	je	.L104
	movl	$164, %edx
	movl	$.LC62, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L104:
	movl	$165, tctest_assertion_line(%rip)
	movq	-216(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L105
	movl	$165, %edx
	movl	$.LC63, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L105:
	leaq	-256(%rbp), %rax
	movl	$.LC40, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$168, tctest_assertion_line(%rip)
	movl	-240(%rbp), %eax
	cmpl	$1, %eax
	je	.L106
	movl	$168, %edx
	movl	$.LC64, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L106:
	movl	$169, tctest_assertion_line(%rip)
	movq	-256(%rbp), %rax
	testq	%rax, %rax
	je	.L107
	movl	$169, %edx
	movl	$.LC65, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L107:
	movl	$170, tctest_assertion_line(%rip)
	movq	-248(%rbp), %rax
	testq	%rax, %rax
	je	.L108
	movl	$170, %edx
	movl	$.LC66, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L108:
	leaq	-288(%rbp), %rax
	movl	$.LC67, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$173, tctest_assertion_line(%rip)
	movl	-272(%rbp), %eax
	cmpl	$1, %eax
	je	.L109
	movl	$173, %edx
	movl	$.LC68, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L109:
	movl	$174, tctest_assertion_line(%rip)
	movq	-288(%rbp), %rax
	testq	%rax, %rax
	je	.L110
	movl	$174, %edx
	movl	$.LC69, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L110:
	movl	$175, tctest_assertion_line(%rip)
	movq	-280(%rbp), %rax
	movabsq	$2305843009213693952, %rdx
	cmpq	%rdx, %rax
	je	.L111
	movl	$175, %edx
	movl	$.LC70, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L111:
	leaq	-320(%rbp), %rax
	movl	$.LC40, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$178, tctest_assertion_line(%rip)
	movl	-304(%rbp), %eax
	cmpl	$1, %eax
	je	.L112
	movl	$178, %edx
	movl	$.LC71, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L112:
	movl	$179, tctest_assertion_line(%rip)
	movq	-320(%rbp), %rax
	testq	%rax, %rax
	je	.L113
	movl	$179, %edx
	movl	$.LC72, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L113:
	movl	$180, tctest_assertion_line(%rip)
	movq	-312(%rbp), %rax
	testq	%rax, %rax
	je	.L114
	movl	$180, %edx
	movl	$.LC73, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L114:
	leaq	-352(%rbp), %rax
	movl	$.LC74, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$183, tctest_assertion_line(%rip)
	movl	-336(%rbp), %eax
	cmpl	$-1, %eax
	je	.L115
	movl	$183, %edx
	movl	$.LC75, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L115:
	movl	$184, tctest_assertion_line(%rip)
	movq	-352(%rbp), %rax
	testq	%rax, %rax
	je	.L116
	movl	$184, %edx
	movl	$.LC76, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L116:
	movl	$185, tctest_assertion_line(%rip)
	movq	-344(%rbp), %rax
	movabsq	$2305843009213693952, %rdx
	cmpq	%rdx, %rax
	je	.L117
	movl	$185, %edx
	movl	$.LC77, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L117:
	leaq	-384(%rbp), %rax
	movl	$.LC78, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$188, tctest_assertion_line(%rip)
	movl	-368(%rbp), %eax
	cmpl	$1, %eax
	je	.L118
	movl	$188, %edx
	movl	$.LC79, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L118:
	movl	$189, tctest_assertion_line(%rip)
	movq	-384(%rbp), %rax
	cmpq	$2, %rax
	je	.L119
	movl	$189, %edx
	movl	$.LC80, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L119:
	movl	$190, tctest_assertion_line(%rip)
	movq	-376(%rbp), %rax
	testq	%rax, %rax
	je	.L120
	movl	$190, %edx
	movl	$.LC81, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L120:
	leaq	-416(%rbp), %rax
	movl	$.LC82, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$193, tctest_assertion_line(%rip)
	movl	-400(%rbp), %eax
	cmpl	$-1, %eax
	je	.L121
	movl	$193, %edx
	movl	$.LC83, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L121:
	movl	$194, tctest_assertion_line(%rip)
	movq	-416(%rbp), %rax
	cmpq	$2, %rax
	je	.L122
	movl	$194, %edx
	movl	$.LC84, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L122:
	movl	$195, tctest_assertion_line(%rip)
	movq	-408(%rbp), %rax
	testq	%rax, %rax
	je	.L123
	movl	$195, %edx
	movl	$.LC85, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L123:
	leaq	-448(%rbp), %rax
	movl	$.LC86, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$198, tctest_assertion_line(%rip)
	movl	-432(%rbp), %eax
	cmpl	$-1, %eax
	je	.L124
	movl	$198, %edx
	movl	$.LC87, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L124:
	movl	$199, tctest_assertion_line(%rip)
	movq	-448(%rbp), %rax
	movabsq	$2459565876494606882, %rdx
	cmpq	%rdx, %rax
	je	.L125
	movl	$199, %edx
	movl	$.LC88, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L125:
	movl	$200, tctest_assertion_line(%rip)
	movq	-440(%rbp), %rax
	movabsq	$1311768445820063215, %rdx
	cmpq	%rdx, %rax
	je	.L126
	movl	$200, %edx
	movl	$.LC89, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L126:
	leaq	-480(%rbp), %rax
	movl	$.LC90, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$203, tctest_assertion_line(%rip)
	movl	-464(%rbp), %eax
	cmpl	$-1, %eax
	je	.L127
	movl	$203, %edx
	movl	$.LC91, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L127:
	movl	$204, tctest_assertion_line(%rip)
	movq	-480(%rbp), %rax
	testq	%rax, %rax
	je	.L128
	movl	$204, %edx
	movl	$.LC92, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L128:
	movl	$205, tctest_assertion_line(%rip)
	movq	-472(%rbp), %rax
	movabsq	$3689348814741910323, %rdx
	cmpq	%rdx, %rax
	je	.L129
	movl	$205, %edx
	movl	$.LC93, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L129:
	leaq	-512(%rbp), %rax
	movl	$.LC94, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$208, tctest_assertion_line(%rip)
	movl	-496(%rbp), %eax
	cmpl	$1, %eax
	je	.L130
	movl	$208, %edx
	movl	$.LC95, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L130:
	movl	$209, tctest_assertion_line(%rip)
	movq	-504(%rbp), %rax
	testq	%rax, %rax
	je	.L131
	movl	$209, %edx
	movl	$.LC96, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L131:
	movl	$210, tctest_assertion_line(%rip)
	movq	-512(%rbp), %rax
	movabsq	$3689348814741910323, %rdx
	cmpq	%rdx, %rax
	je	.L132
	movl	$210, %edx
	movl	$.LC97, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L132:
	leaq	-544(%rbp), %rax
	movl	$.LC98, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$213, tctest_assertion_line(%rip)
	movl	-528(%rbp), %eax
	cmpl	$-1, %eax
	je	.L133
	movl	$213, %edx
	movl	$.LC99, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L133:
	movl	$214, tctest_assertion_line(%rip)
	movq	-536(%rbp), %rax
	testq	%rax, %rax
	je	.L134
	movl	$214, %edx
	movl	$.LC100, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L134:
	movl	$215, tctest_assertion_line(%rip)
	movq	-544(%rbp), %rax
	movabsq	$3689348814741910323, %rdx
	cmpq	%rdx, %rax
	je	.L135
	movl	$215, %edx
	movl	$.LC101, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L135:
	leaq	-576(%rbp), %rax
	movl	$.LC102, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$218, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-560(%rbp)
	pushq	-568(%rbp)
	pushq	-576(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L136
	movl	$218, %edx
	movl	$.LC103, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L136:
	leaq	-608(%rbp), %rax
	movl	$.LC104, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$221, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-592(%rbp)
	pushq	-600(%rbp)
	pushq	-608(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L137
	movl	$221, %edx
	movl	$.LC105, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L137:
	leaq	-640(%rbp), %rax
	movl	$.LC106, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$224, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-624(%rbp)
	pushq	-632(%rbp)
	pushq	-640(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L138
	movl	$224, %edx
	movl	$.LC107, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L138:
	leaq	-672(%rbp), %rax
	movl	$.LC108, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$227, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-656(%rbp)
	pushq	-664(%rbp)
	pushq	-672(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L139
	movl	$227, %edx
	movl	$.LC109, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L139:
	leaq	-704(%rbp), %rax
	movl	$.LC110, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$230, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-688(%rbp)
	pushq	-696(%rbp)
	pushq	-704(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L141
	movl	$230, %edx
	movl	$.LC111, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L141:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	test_create_from_hex, .-test_create_from_hex
	.section	.rodata
.LC112:
	.string	"0"
.LC113:
	.string	"0 == strcmp(s, \"0\")"
.LC114:
	.string	"1"
.LC115:
	.string	"0 == strcmp(s, \"1\")"
.LC116:
	.string	"0 == strcmp(s, \"0.8\")"
.LC117:
	.string	"0.4"
.LC118:
	.string	"0 == strcmp(s, \"0.4\")"
.LC119:
	.string	"4b19efcea.000000ec9a1e2418"
	.align 8
.LC120:
	.string	"0 == strcmp(s, \"4b19efcea.000000ec9a1e2418\")"
.LC121:
	.string	"fcbf3d5.00004d1a23c24faf"
	.align 8
.LC122:
	.string	"0 == strcmp(s, \"fcbf3d5.00004d1a23c24faf\")"
	.align 8
.LC123:
	.string	"0 == strcmp(\"-2\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-2\")))"
.LC124:
	.string	"2.33"
	.align 8
.LC125:
	.string	"0 == strcmp(\"2.33\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"2.33\")))"
.LC126:
	.string	"-3.9"
	.align 8
.LC127:
	.string	"0 == strcmp(\"-3.9\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-3.9\")))"
.LC128:
	.string	"-0.8"
	.align 8
.LC129:
	.string	"0 == strcmp(\"-0.8\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-0.8\")))"
.LC130:
	.string	"-93939123.8"
	.align 8
.LC131:
	.string	"0 == strcmp(\"-93939123.8\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-93939123.8\")))"
.LC132:
	.string	"bbbbb.8"
	.align 8
.LC133:
	.string	"0 == strcmp(\"bbbbb.8\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"bbbbb.8\")))"
.LC134:
	.string	"-bbbbb.ffff"
	.align 8
.LC135:
	.string	"0 == strcmp(\"-bbbbb.ffff\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-bbbbb.ffff\")))"
.LC136:
	.string	"-1.ffff"
	.align 8
.LC137:
	.string	"0 == strcmp(\"-1.ffff\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-1.ffff\")))"
.LC138:
	.string	"-1.fddd"
	.align 8
.LC139:
	.string	"0 == strcmp(\"-1.fddd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-1.fddd\")))"
.LC140:
	.string	"-2111138.988"
	.align 8
.LC141:
	.string	"0 == strcmp(\"-2111138.988\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-2111138.988\")))"
.LC142:
	.string	"21111111233"
	.align 8
.LC143:
	.string	"0 == strcmp(\"21111111233\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"21111111233\")))"
.LC144:
	.string	"dddddddd"
	.align 8
.LC145:
	.string	"0 == strcmp(\"dddddddd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"dddddddd\")))"
.LC146:
	.string	"aaaaaaa"
	.align 8
.LC147:
	.string	"0 == strcmp(\"aaaaaaa\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"aaaaaaa\")))"
.LC148:
	.string	"-ab123123123"
	.align 8
.LC149:
	.string	"0 == strcmp(\"-ab123123123\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-ab123123123\")))"
.LC150:
	.string	"-123123131.ffff"
	.align 8
.LC151:
	.string	"0 == strcmp(\"-123123131.ffff\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-123123131.ffff\")))"
.LC152:
	.string	"-123123238.98888"
	.align 8
.LC153:
	.string	"0 == strcmp(\"-123123238.98888\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-123123238.98888\")))"
.LC154:
	.string	"-238.98d888"
	.align 8
.LC155:
	.string	"0 == strcmp(\"-238.98d888\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-238.98d888\")))"
.LC156:
	.string	"-2213123"
	.align 8
.LC157:
	.string	"0 == strcmp(\"-2213123\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-2213123\")))"
.LC158:
	.string	"2dd.33"
	.align 8
.LC159:
	.string	"0 == strcmp(\"2dd.33\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"2dd.33\")))"
.LC160:
	.string	"-3.9ddd"
	.align 8
.LC161:
	.string	"0 == strcmp(\"-3.9ddd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-3.9ddd\")))"
.LC162:
	.string	"-123123.8"
	.align 8
.LC163:
	.string	"0 == strcmp(\"-123123.8\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-123123.8\")))"
.LC164:
	.string	"1112323123"
	.align 8
.LC165:
	.string	"0 == strcmp(\"1112323123\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"1112323123\")))"
	.align 8
.LC166:
	.string	"0 == strcmp(\"0\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"0\")))"
.LC167:
	.string	"bb.ffff"
	.align 8
.LC168:
	.string	"0 == strcmp(\"bb.ffff\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"bb.ffff\")))"
.LC169:
	.string	"-5.dd"
	.align 8
.LC170:
	.string	"0 == strcmp(\"-5.dd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-5.dd\")))"
.LC171:
	.string	"-3331.fddd"
	.align 8
.LC172:
	.string	"0 == strcmp(\"-3331.fddd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-3331.fddd\")))"
.LC173:
	.string	"-22111138.988"
	.align 8
.LC174:
	.string	"0 == strcmp(\"-22111138.988\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-22111138.988\")))"
.LC175:
	.string	"-21111111233"
	.align 8
.LC176:
	.string	"0 == strcmp(\"-21111111233\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-21111111233\")))"
.LC177:
	.string	"-dddddddd"
	.align 8
.LC178:
	.string	"0 == strcmp(\"-dddddddd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-dddddddd\")))"
.LC179:
	.string	"-aaaaaaa"
	.align 8
.LC180:
	.string	"0 == strcmp(\"-aaaaaaa\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-aaaaaaa\")))"
.LC181:
	.string	"-d123123123"
	.align 8
.LC182:
	.string	"0 == strcmp(\"-d123123123\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-d123123123\")))"
.LC183:
	.string	"-d123123131.ffff"
	.align 8
.LC184:
	.string	"0 == strcmp(\"-d123123131.ffff\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-d123123131.ffff\")))"
.LC185:
	.string	"-aaa1.fddd"
	.align 8
.LC186:
	.string	"0 == strcmp(\"-aaa1.fddd\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-aaa1.fddd\")))"
.LC187:
	.string	"-aa123123238.98888"
	.align 8
.LC188:
	.string	"0 == strcmp(\"-aa123123238.98888\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-aa123123238.98888\")))"
.LC189:
	.string	"-a238.98d888"
	.align 8
.LC190:
	.string	"0 == strcmp(\"-a238.98d888\", fixedpoint_format_as_hex(fixedpoint_create_from_hex(\"-a238.98d888\")))"
	.text
	.globl	test_format_as_hex
	.type	test_format_as_hex, @function
test_format_as_hex:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1168, %rsp
	movq	%rdi, -1160(%rbp)
	subq	$8, %rsp
	movq	-1160(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, -8(%rbp)
	movl	$238, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L143
	movl	$238, %edx
	movl	$.LC113, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L143:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	subq	$8, %rsp
	movq	-1160(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, -8(%rbp)
	movl	$242, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$.LC114, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L144
	movl	$242, %edx
	movl	$.LC115, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L144:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	subq	$8, %rsp
	movq	-1160(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, -8(%rbp)
	movl	$246, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$.LC60, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L145
	movl	$246, %edx
	movl	$.LC116, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L145:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	subq	$8, %rsp
	movq	-1160(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, -8(%rbp)
	movl	$250, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$.LC117, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L146
	movl	$250, %edx
	movl	$.LC118, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L146:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	subq	$8, %rsp
	movq	-1160(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, -8(%rbp)
	movl	$254, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$.LC119, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L147
	movl	$254, %edx
	movl	$.LC120, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L147:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	subq	$8, %rsp
	movq	-1160(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, -8(%rbp)
	movl	$258, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$.LC121, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L148
	movl	$258, %edx
	movl	$.LC122, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L148:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$262, tctest_assertion_line(%rip)
	leaq	-1152(%rbp), %rax
	movl	$.LC82, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-1136(%rbp)
	pushq	-1144(%rbp)
	pushq	-1152(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC82, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L149
	movl	$262, %edx
	movl	$.LC123, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L149:
	movl	$263, tctest_assertion_line(%rip)
	leaq	-1120(%rbp), %rax
	movl	$.LC124, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-1104(%rbp)
	pushq	-1112(%rbp)
	pushq	-1120(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC124, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L150
	movl	$263, %edx
	movl	$.LC125, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L150:
	movl	$264, tctest_assertion_line(%rip)
	leaq	-1088(%rbp), %rax
	movl	$.LC126, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-1072(%rbp)
	pushq	-1080(%rbp)
	pushq	-1088(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC126, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L151
	movl	$264, %edx
	movl	$.LC127, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L151:
	movl	$265, tctest_assertion_line(%rip)
	leaq	-1056(%rbp), %rax
	movl	$.LC128, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-1040(%rbp)
	pushq	-1048(%rbp)
	pushq	-1056(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC128, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L152
	movl	$265, %edx
	movl	$.LC129, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L152:
	movl	$266, tctest_assertion_line(%rip)
	leaq	-1024(%rbp), %rax
	movl	$.LC130, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-1008(%rbp)
	pushq	-1016(%rbp)
	pushq	-1024(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC130, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L153
	movl	$266, %edx
	movl	$.LC131, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L153:
	movl	$267, tctest_assertion_line(%rip)
	leaq	-992(%rbp), %rax
	movl	$.LC132, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-976(%rbp)
	pushq	-984(%rbp)
	pushq	-992(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC132, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L154
	movl	$267, %edx
	movl	$.LC133, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L154:
	movl	$268, tctest_assertion_line(%rip)
	leaq	-960(%rbp), %rax
	movl	$.LC134, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-944(%rbp)
	pushq	-952(%rbp)
	pushq	-960(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC134, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L155
	movl	$268, %edx
	movl	$.LC135, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L155:
	movl	$269, tctest_assertion_line(%rip)
	leaq	-928(%rbp), %rax
	movl	$.LC136, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-912(%rbp)
	pushq	-920(%rbp)
	pushq	-928(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC136, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L156
	movl	$269, %edx
	movl	$.LC137, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L156:
	movl	$270, tctest_assertion_line(%rip)
	leaq	-896(%rbp), %rax
	movl	$.LC138, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-880(%rbp)
	pushq	-888(%rbp)
	pushq	-896(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC138, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L157
	movl	$270, %edx
	movl	$.LC139, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L157:
	movl	$271, tctest_assertion_line(%rip)
	leaq	-864(%rbp), %rax
	movl	$.LC140, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-848(%rbp)
	pushq	-856(%rbp)
	pushq	-864(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC140, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L158
	movl	$271, %edx
	movl	$.LC141, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L158:
	movl	$272, tctest_assertion_line(%rip)
	leaq	-832(%rbp), %rax
	movl	$.LC142, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-816(%rbp)
	pushq	-824(%rbp)
	pushq	-832(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC142, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L159
	movl	$272, %edx
	movl	$.LC143, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L159:
	movl	$273, tctest_assertion_line(%rip)
	leaq	-800(%rbp), %rax
	movl	$.LC144, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-784(%rbp)
	pushq	-792(%rbp)
	pushq	-800(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC144, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L160
	movl	$273, %edx
	movl	$.LC145, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L160:
	movl	$274, tctest_assertion_line(%rip)
	leaq	-768(%rbp), %rax
	movl	$.LC146, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-752(%rbp)
	pushq	-760(%rbp)
	pushq	-768(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC146, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L161
	movl	$274, %edx
	movl	$.LC147, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L161:
	movl	$275, tctest_assertion_line(%rip)
	leaq	-736(%rbp), %rax
	movl	$.LC148, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-720(%rbp)
	pushq	-728(%rbp)
	pushq	-736(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC148, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L162
	movl	$275, %edx
	movl	$.LC149, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L162:
	movl	$276, tctest_assertion_line(%rip)
	leaq	-704(%rbp), %rax
	movl	$.LC150, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-688(%rbp)
	pushq	-696(%rbp)
	pushq	-704(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC150, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L163
	movl	$276, %edx
	movl	$.LC151, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L163:
	movl	$277, tctest_assertion_line(%rip)
	leaq	-672(%rbp), %rax
	movl	$.LC138, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-656(%rbp)
	pushq	-664(%rbp)
	pushq	-672(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC138, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L164
	movl	$277, %edx
	movl	$.LC139, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L164:
	movl	$278, tctest_assertion_line(%rip)
	leaq	-640(%rbp), %rax
	movl	$.LC152, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-624(%rbp)
	pushq	-632(%rbp)
	pushq	-640(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC152, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L165
	movl	$278, %edx
	movl	$.LC153, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L165:
	movl	$279, tctest_assertion_line(%rip)
	leaq	-608(%rbp), %rax
	movl	$.LC154, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-592(%rbp)
	pushq	-600(%rbp)
	pushq	-608(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC154, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L166
	movl	$279, %edx
	movl	$.LC155, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L166:
	movl	$280, tctest_assertion_line(%rip)
	leaq	-576(%rbp), %rax
	movl	$.LC156, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-560(%rbp)
	pushq	-568(%rbp)
	pushq	-576(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC156, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L167
	movl	$280, %edx
	movl	$.LC157, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L167:
	movl	$281, tctest_assertion_line(%rip)
	leaq	-544(%rbp), %rax
	movl	$.LC158, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-528(%rbp)
	pushq	-536(%rbp)
	pushq	-544(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC158, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L168
	movl	$281, %edx
	movl	$.LC159, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L168:
	movl	$282, tctest_assertion_line(%rip)
	leaq	-512(%rbp), %rax
	movl	$.LC160, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-496(%rbp)
	pushq	-504(%rbp)
	pushq	-512(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC160, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L169
	movl	$282, %edx
	movl	$.LC161, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L169:
	movl	$283, tctest_assertion_line(%rip)
	leaq	-480(%rbp), %rax
	movl	$.LC162, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-464(%rbp)
	pushq	-472(%rbp)
	pushq	-480(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC162, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L170
	movl	$283, %edx
	movl	$.LC163, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L170:
	movl	$284, tctest_assertion_line(%rip)
	leaq	-448(%rbp), %rax
	movl	$.LC164, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-432(%rbp)
	pushq	-440(%rbp)
	pushq	-448(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC164, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L171
	movl	$284, %edx
	movl	$.LC165, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L171:
	movl	$285, tctest_assertion_line(%rip)
	leaq	-416(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-400(%rbp)
	pushq	-408(%rbp)
	pushq	-416(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC112, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L172
	movl	$285, %edx
	movl	$.LC166, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L172:
	movl	$286, tctest_assertion_line(%rip)
	leaq	-384(%rbp), %rax
	movl	$.LC167, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC167, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L173
	movl	$286, %edx
	movl	$.LC168, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L173:
	movl	$287, tctest_assertion_line(%rip)
	leaq	-352(%rbp), %rax
	movl	$.LC169, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-336(%rbp)
	pushq	-344(%rbp)
	pushq	-352(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC169, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L174
	movl	$287, %edx
	movl	$.LC170, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L174:
	movl	$288, tctest_assertion_line(%rip)
	leaq	-320(%rbp), %rax
	movl	$.LC171, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-304(%rbp)
	pushq	-312(%rbp)
	pushq	-320(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC171, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L175
	movl	$288, %edx
	movl	$.LC172, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L175:
	movl	$289, tctest_assertion_line(%rip)
	leaq	-288(%rbp), %rax
	movl	$.LC173, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC173, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L176
	movl	$289, %edx
	movl	$.LC174, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L176:
	movl	$290, tctest_assertion_line(%rip)
	leaq	-256(%rbp), %rax
	movl	$.LC175, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC175, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L177
	movl	$290, %edx
	movl	$.LC176, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L177:
	movl	$291, tctest_assertion_line(%rip)
	leaq	-224(%rbp), %rax
	movl	$.LC177, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC177, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L178
	movl	$291, %edx
	movl	$.LC178, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L178:
	movl	$292, tctest_assertion_line(%rip)
	leaq	-192(%rbp), %rax
	movl	$.LC179, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC179, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L179
	movl	$292, %edx
	movl	$.LC180, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L179:
	movl	$293, tctest_assertion_line(%rip)
	leaq	-160(%rbp), %rax
	movl	$.LC181, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC181, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L180
	movl	$293, %edx
	movl	$.LC182, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L180:
	movl	$294, tctest_assertion_line(%rip)
	leaq	-128(%rbp), %rax
	movl	$.LC183, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC183, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L181
	movl	$294, %edx
	movl	$.LC184, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L181:
	movl	$295, tctest_assertion_line(%rip)
	leaq	-96(%rbp), %rax
	movl	$.LC185, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC185, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L182
	movl	$295, %edx
	movl	$.LC186, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L182:
	movl	$296, tctest_assertion_line(%rip)
	leaq	-64(%rbp), %rax
	movl	$.LC187, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC187, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L183
	movl	$296, %edx
	movl	$.LC188, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L183:
	movl	$297, tctest_assertion_line(%rip)
	leaq	-32(%rbp), %rax
	movl	$.LC189, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_format_as_hex
	addq	$32, %rsp
	movq	%rax, %rsi
	movl	$.LC189, %edi
	call	strcmp
	testl	%eax, %eax
	je	.L185
	movl	$297, %edx
	movl	$.LC190, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L185:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	test_format_as_hex, .-test_format_as_hex
	.section	.rodata
	.align 8
.LC191:
	.string	"!fixedpoint_is_neg(objs->zero)"
.LC192:
	.string	"!fixedpoint_is_neg(objs->one)"
	.align 8
.LC193:
	.string	"!fixedpoint_is_neg(objs->one_half)"
	.align 8
.LC194:
	.string	"!fixedpoint_is_neg(objs->one_fourth)"
	.align 8
.LC195:
	.string	"!fixedpoint_is_neg(objs->large1)"
	.align 8
.LC196:
	.string	"!fixedpoint_is_neg(objs->large2)"
.LC197:
	.string	"!fixedpoint_is_neg(zero_neg)"
.LC198:
	.string	"fixedpoint_is_neg(one_neg)"
	.align 8
.LC199:
	.string	"fixedpoint_is_neg(one_half_neg)"
	.align 8
.LC200:
	.string	"fixedpoint_is_neg(one_fourth_neg)"
.LC201:
	.string	"fixedpoint_is_neg(large1_neg)"
.LC202:
	.string	"fixedpoint_is_neg(large2_neg)"
	.text
	.globl	test_negate
	.type	test_negate, @function
test_negate:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movq	%rdi, -200(%rbp)
	movl	$303, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L187
	movl	$303, %edx
	movl	$.LC191, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L187:
	movl	$304, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L188
	movl	$304, %edx
	movl	$.LC192, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L188:
	movl	$305, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L189
	movl	$305, %edx
	movl	$.LC193, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L189:
	movl	$306, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L190
	movl	$306, %edx
	movl	$.LC194, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L190:
	movl	$307, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L191
	movl	$307, %edx
	movl	$.LC195, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L191:
	movl	$308, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L192
	movl	$308, %edx
	movl	$.LC196, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L192:
	leaq	-32(%rbp), %rdx
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	leaq	-64(%rbp), %rdx
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	leaq	-96(%rbp), %rdx
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	leaq	-128(%rbp), %rdx
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	leaq	-160(%rbp), %rdx
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	leaq	-192(%rbp), %rdx
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	movl	$319, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L193
	movl	$319, %edx
	movl	$.LC197, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L193:
	movl	$322, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L194
	movl	$322, %edx
	movl	$.LC198, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L194:
	movl	$323, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L195
	movl	$323, %edx
	movl	$.LC199, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L195:
	movl	$324, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L196
	movl	$324, %edx
	movl	$.LC200, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L196:
	movl	$325, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L197
	movl	$325, %edx
	movl	$.LC201, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L197:
	movl	$326, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L198
	movl	$326, %edx
	movl	$.LC202, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L198:
	movl	$329, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L199
	movl	$329, %edx
	movl	$.LC23, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L199:
	movl	$330, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$1, %rax
	je	.L200
	movl	$330, %edx
	movl	$.LC25, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L200:
	movl	$331, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L201
	movl	$331, %edx
	movl	$.LC26, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L201:
	movl	$332, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L202
	movl	$332, %edx
	movl	$.LC27, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L202:
	movl	$333, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	movabsq	$20159855850, %rdx
	cmpq	%rdx, %rax
	je	.L203
	movl	$333, %edx
	movl	$.LC28, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L203:
	movl	$334, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$265024469, %rax
	je	.L204
	movl	$334, %edx
	movl	$.LC29, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L204:
	movl	$335, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L205
	movl	$335, %edx
	movl	$.LC30, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L205:
	movl	$336, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L206
	movl	$336, %edx
	movl	$.LC31, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L206:
	movl	$337, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	64(%rax)
	pushq	56(%rax)
	pushq	48(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$-9223372036854775808, %rdx
	cmpq	%rdx, %rax
	je	.L207
	movl	$337, %edx
	movl	$.LC32, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L207:
	movl	$338, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	88(%rax)
	pushq	80(%rax)
	pushq	72(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$4611686018427387904, %rdx
	cmpq	%rdx, %rax
	je	.L208
	movl	$338, %edx
	movl	$.LC33, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L208:
	movl	$339, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	112(%rax)
	pushq	104(%rax)
	pushq	96(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$1016197948440, %rdx
	cmpq	%rdx, %rax
	je	.L209
	movl	$339, %edx
	movl	$.LC34, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L209:
	movl	$340, tctest_assertion_line(%rip)
	subq	$8, %rsp
	movq	-200(%rbp), %rax
	pushq	136(%rax)
	pushq	128(%rax)
	pushq	120(%rax)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$84774664425391, %rdx
	cmpq	%rdx, %rax
	je	.L211
	movl	$340, %edx
	movl	$.LC35, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L211:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	test_negate, .-test_negate
	.section	.rodata
	.align 8
.LC203:
	.string	"-c7252a193ae07.7a51de9ea0538c5"
.LC204:
	.string	"d09079.1e6d601"
.LC205:
	.string	"fixedpoint_is_neg(sum)"
	.align 8
.LC206:
	.string	"0xc7252a0c31d8eUL == fixedpoint_whole_part(sum)"
	.align 8
.LC207:
	.string	"0x5be47e8ea0538c50UL == fixedpoint_frac_part(sum)"
.LC208:
	.string	"fixedpoint_is_neg(sum2)"
	.align 8
.LC209:
	.string	"0xc7252a0c31d8eUL == fixedpoint_whole_part(sum2)"
	.align 8
.LC210:
	.string	"0x5be47e8ea0538c50UL == fixedpoint_frac_part(sum2)"
.LC211:
	.string	"-d09079.1e6d601"
.LC212:
	.string	"fixedpoint_is_neg(sum3)"
	.align 8
.LC213:
	.string	"0xC7252A2643E80UL == fixedpoint_whole_part(sum3)"
	.align 8
.LC214:
	.string	"0x98BF3EAEA0538C50UL == fixedpoint_frac_part(sum3)"
.LC215:
	.string	"!fixedpoint_is_neg(sum4)"
	.align 8
.LC216:
	.string	"0UL == fixedpoint_whole_part(sum4)"
	.align 8
.LC217:
	.string	"0UL == fixedpoint_frac_part(sum4)"
.LC218:
	.string	"sum5.tag==2"
	.align 8
.LC219:
	.string	"0UL== fixedpoint_whole_part(sum5)"
	.align 8
.LC220:
	.string	"0UL == fixedpoint_frac_part(sum5)"
.LC221:
	.string	"sum6.tag==-2"
	.align 8
.LC222:
	.string	"0UL== fixedpoint_whole_part(sum6)"
	.align 8
.LC223:
	.string	"0UL == fixedpoint_frac_part(sum6)"
.LC224:
	.string	"-0.02"
.LC225:
	.string	"0.01"
.LC226:
	.string	"sum7.tag==-1"
	.align 8
.LC227:
	.string	"0UL== fixedpoint_whole_part(sum7)"
	.align 8
.LC228:
	.string	"0x0100000000000000UL == fixedpoint_frac_part(sum7)"
.LC229:
	.string	"sum8.tag ==2"
.LC230:
	.string	"-125"
.LC231:
	.string	"125"
.LC232:
	.string	"sum9.tag==1"
	.align 8
.LC233:
	.string	"0UL== fixedpoint_frac_part(lhs9)"
	.align 8
.LC234:
	.string	"0UL== fixedpoint_frac_part(rhs9)"
	.align 8
.LC235:
	.string	"0UL== fixedpoint_whole_part(sum9)"
	.align 8
.LC236:
	.string	"0UL== fixedpoint_frac_part(sum9)"
.LC237:
	.string	"sum10.tag==1"
	.align 8
.LC238:
	.string	"0UL== fixedpoint_whole_part(sum10)"
	.align 8
.LC239:
	.string	"0UL== fixedpoint_frac_part(sum10)"
	.text
	.globl	test_add
	.type	test_add, @function
test_add:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$976, %rsp
	movq	%rdi, -968(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC203, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	movl	$.LC204, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-96(%rbp), %rax
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$351, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L213
	movl	$351, %edx
	movl	$.LC205, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L213:
	movl	$352, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	movabsq	$3503398930554254, %rdx
	cmpq	%rdx, %rax
	je	.L214
	movl	$352, %edx
	movl	$.LC206, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L214:
	movl	$353, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$6621556503181757520, %rdx
	cmpq	%rdx, %rax
	je	.L215
	movl	$353, %edx
	movl	$.LC207, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L215:
	leaq	-128(%rbp), %rax
	movl	$.LC204, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-160(%rbp), %rax
	movl	$.LC203, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$357, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L216
	movl	$357, %edx
	movl	$.LC208, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L216:
	movl	$358, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	movabsq	$3503398930554254, %rdx
	cmpq	%rdx, %rax
	je	.L217
	movl	$358, %edx
	movl	$.LC209, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L217:
	movl	$359, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$6621556503181757520, %rdx
	cmpq	%rdx, %rax
	je	.L218
	movl	$359, %edx
	movl	$.LC210, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L218:
	leaq	-224(%rbp), %rax
	movl	$.LC203, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-256(%rbp), %rax
	movl	$.LC211, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-288(%rbp), %rax
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$363, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L219
	movl	$363, %edx
	movl	$.LC212, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L219:
	movl	$364, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	movabsq	$3503398957891200, %rdx
	cmpq	%rdx, %rax
	je	.L220
	movl	$364, %edx
	movl	$.LC213, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L220:
	movl	$365, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$-7440159139657708464, %rdx
	cmpq	%rdx, %rax
	je	.L221
	movl	$365, %edx
	movl	$.LC214, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L221:
	leaq	-320(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-352(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-384(%rbp), %rax
	pushq	-336(%rbp)
	pushq	-344(%rbp)
	pushq	-352(%rbp)
	pushq	-304(%rbp)
	pushq	-312(%rbp)
	pushq	-320(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$371, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L222
	movl	$371, %edx
	movl	$.LC215, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L222:
	movl	$372, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L223
	movl	$372, %edx
	movl	$.LC216, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L223:
	movl	$373, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L224
	movl	$373, %edx
	movl	$.LC217, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L224:
	leaq	-416(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	leaq	-448(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fixedpoint_create2
	leaq	-480(%rbp), %rax
	pushq	-432(%rbp)
	pushq	-440(%rbp)
	pushq	-448(%rbp)
	pushq	-400(%rbp)
	pushq	-408(%rbp)
	pushq	-416(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$379, tctest_assertion_line(%rip)
	movl	-464(%rbp), %eax
	cmpl	$2, %eax
	je	.L225
	movl	$379, %edx
	movl	$.LC218, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L225:
	movl	$380, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-464(%rbp)
	pushq	-472(%rbp)
	pushq	-480(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L226
	movl	$380, %edx
	movl	$.LC219, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L226:
	movl	$381, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-464(%rbp)
	pushq	-472(%rbp)
	pushq	-480(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L227
	movl	$381, %edx
	movl	$.LC220, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L227:
	leaq	-512(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movl	$-1, -496(%rbp)
	leaq	-544(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movl	$-1, -528(%rbp)
	leaq	-576(%rbp), %rax
	pushq	-528(%rbp)
	pushq	-536(%rbp)
	pushq	-544(%rbp)
	pushq	-496(%rbp)
	pushq	-504(%rbp)
	pushq	-512(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$389, tctest_assertion_line(%rip)
	movl	-560(%rbp), %eax
	cmpl	$-2, %eax
	je	.L228
	movl	$389, %edx
	movl	$.LC221, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L228:
	movl	$390, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-560(%rbp)
	pushq	-568(%rbp)
	pushq	-576(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L229
	movl	$390, %edx
	movl	$.LC222, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L229:
	movl	$391, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-560(%rbp)
	pushq	-568(%rbp)
	pushq	-576(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L230
	movl	$391, %edx
	movl	$.LC223, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L230:
	leaq	-608(%rbp), %rax
	movl	$.LC224, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-640(%rbp), %rax
	movl	$.LC225, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-672(%rbp), %rax
	pushq	-624(%rbp)
	pushq	-632(%rbp)
	pushq	-640(%rbp)
	pushq	-592(%rbp)
	pushq	-600(%rbp)
	pushq	-608(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$397, tctest_assertion_line(%rip)
	movl	-656(%rbp), %eax
	cmpl	$-1, %eax
	je	.L231
	movl	$397, %edx
	movl	$.LC226, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L231:
	movl	$398, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-656(%rbp)
	pushq	-664(%rbp)
	pushq	-672(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L232
	movl	$398, %edx
	movl	$.LC227, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L232:
	movl	$399, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-656(%rbp)
	pushq	-664(%rbp)
	pushq	-672(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$72057594037927936, %rdx
	cmpq	%rdx, %rax
	je	.L233
	movl	$399, %edx
	movl	$.LC228, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L233:
	leaq	-704(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fixedpoint_create2
	leaq	-736(%rbp), %rax
	movabsq	$-9223372036854775808, %rdx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	leaq	-768(%rbp), %rax
	pushq	-720(%rbp)
	pushq	-728(%rbp)
	pushq	-736(%rbp)
	pushq	-688(%rbp)
	pushq	-696(%rbp)
	pushq	-704(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$403, tctest_assertion_line(%rip)
	movl	-752(%rbp), %eax
	cmpl	$2, %eax
	je	.L234
	movl	$403, %edx
	movl	$.LC229, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L234:
	leaq	-800(%rbp), %rax
	movl	$.LC230, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-832(%rbp), %rax
	movl	$.LC231, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-864(%rbp), %rax
	pushq	-816(%rbp)
	pushq	-824(%rbp)
	pushq	-832(%rbp)
	pushq	-784(%rbp)
	pushq	-792(%rbp)
	pushq	-800(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$409, tctest_assertion_line(%rip)
	movl	-848(%rbp), %eax
	cmpl	$1, %eax
	je	.L235
	movl	$409, %edx
	movl	$.LC232, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L235:
	movl	$410, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-784(%rbp)
	pushq	-792(%rbp)
	pushq	-800(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L236
	movl	$410, %edx
	movl	$.LC233, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L236:
	movl	$411, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-816(%rbp)
	pushq	-824(%rbp)
	pushq	-832(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L237
	movl	$411, %edx
	movl	$.LC234, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L237:
	movl	$412, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-848(%rbp)
	pushq	-856(%rbp)
	pushq	-864(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L238
	movl	$412, %edx
	movl	$.LC235, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L238:
	movl	$413, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-848(%rbp)
	pushq	-856(%rbp)
	pushq	-864(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L239
	movl	$413, %edx
	movl	$.LC236, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L239:
	leaq	-896(%rbp), %rax
	movl	$.LC231, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-928(%rbp), %rax
	movl	$.LC230, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-960(%rbp), %rax
	pushq	-912(%rbp)
	pushq	-920(%rbp)
	pushq	-928(%rbp)
	pushq	-880(%rbp)
	pushq	-888(%rbp)
	pushq	-896(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$418, tctest_assertion_line(%rip)
	movl	-944(%rbp), %eax
	cmpl	$1, %eax
	je	.L240
	movl	$418, %edx
	movl	$.LC237, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L240:
	movl	$419, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-944(%rbp)
	pushq	-952(%rbp)
	pushq	-960(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L241
	movl	$419, %edx
	movl	$.LC238, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L241:
	movl	$420, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-944(%rbp)
	pushq	-952(%rbp)
	pushq	-960(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	testq	%rax, %rax
	je	.L243
	movl	$420, %edx
	movl	$.LC239, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L243:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	test_add, .-test_add
	.section	.rodata
.LC240:
	.string	"-ccf35aa3a04a3b.b105"
.LC241:
	.string	"f676e8.58"
.LC242:
	.string	"fixedpoint_is_neg(diff)"
	.align 8
.LC243:
	.string	"0xccf35aa496c124UL == fixedpoint_whole_part(diff)"
	.align 8
.LC244:
	.string	"0x0905000000000000UL == fixedpoint_frac_part(diff)"
.LC245:
	.string	"3"
	.align 8
.LC246:
	.string	"fixedpoint_compare(diff1,cor1)==0"
.LC247:
	.string	"-0.dddddddddddd"
	.align 8
.LC248:
	.string	"fixedpoint_compare(diff2,cor2)==0"
.LC249:
	.string	"-0.3"
.LC250:
	.string	"-0.2"
.LC251:
	.string	"-0.1"
	.align 8
.LC252:
	.string	"fixedpoint_compare(diff3,cor3)==0"
	.text
	.globl	test_sub
	.type	test_sub, @function
test_sub:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$496, %rsp
	movq	%rdi, -488(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC240, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	movl	$.LC241, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-96(%rbp), %rax
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_sub
	addq	$48, %rsp
	movl	$432, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L245
	movl	$432, %edx
	movl	$.LC242, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L245:
	movl	$433, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	movabsq	$57688465882923300, %rdx
	cmpq	%rdx, %rax
	je	.L246
	movl	$433, %edx
	movl	$.LC243, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L246:
	movl	$434, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$649925721224904704, %rdx
	cmpq	%rdx, %rax
	je	.L247
	movl	$434, %edx
	movl	$.LC244, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L247:
	leaq	-128(%rbp), %rax
	movl	$.LC245, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-160(%rbp), %rax
	movl	$.LC245, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_sub
	addq	$48, %rsp
	leaq	-224(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$440, tctest_assertion_line(%rip)
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L248
	movl	$440, %edx
	movl	$.LC246, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L248:
	leaq	-256(%rbp), %rax
	movl	$.LC247, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-288(%rbp), %rax
	movl	$.LC247, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-320(%rbp), %rax
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_sub
	addq	$48, %rsp
	leaq	-352(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$446, tctest_assertion_line(%rip)
	pushq	-336(%rbp)
	pushq	-344(%rbp)
	pushq	-352(%rbp)
	pushq	-304(%rbp)
	pushq	-312(%rbp)
	pushq	-320(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L249
	movl	$446, %edx
	movl	$.LC248, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L249:
	leaq	-384(%rbp), %rax
	movl	$.LC249, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-416(%rbp), %rax
	movl	$.LC250, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-448(%rbp), %rax
	pushq	-400(%rbp)
	pushq	-408(%rbp)
	pushq	-416(%rbp)
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_sub
	addq	$48, %rsp
	leaq	-480(%rbp), %rax
	movl	$.LC251, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$452, tctest_assertion_line(%rip)
	pushq	-464(%rbp)
	pushq	-472(%rbp)
	pushq	-480(%rbp)
	pushq	-432(%rbp)
	pushq	-440(%rbp)
	pushq	-448(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L251
	movl	$452, %edx
	movl	$.LC252, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L251:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	test_sub, .-test_sub
	.section	.rodata
	.align 8
.LC253:
	.string	"fixedpoint_is_overflow_pos(sum)"
	.text
	.globl	test_is_overflow_pos
	.type	test_is_overflow_pos, @function
test_is_overflow_pos:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -72(%rbp)
	leaq	-32(%rbp), %rdx
	movq	-72(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	movq	-72(%rbp), %rax
	pushq	160(%rax)
	pushq	152(%rax)
	pushq	144(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$460, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_overflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L253
	movl	$460, %edx
	movl	$.LC253, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L253:
	leaq	-112(%rbp), %rdx
	movq	-72(%rbp), %rax
	pushq	160(%rax)
	pushq	152(%rax)
	pushq	144(%rax)
	movq	-72(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movq	-112(%rbp), %rax
	movq	-104(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$463, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_overflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L254
	movl	$463, %edx
	movl	$.LC253, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L254:
	leaq	-64(%rbp), %rdx
	subq	$8, %rsp
	movq	-72(%rbp), %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_negate
	addq	$32, %rsp
	leaq	-112(%rbp), %rdx
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	movq	-72(%rbp), %rax
	pushq	160(%rax)
	pushq	152(%rax)
	pushq	144(%rax)
	movq	%rdx, %rdi
	call	fixedpoint_sub
	addq	$48, %rsp
	movq	-112(%rbp), %rax
	movq	-104(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$468, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_overflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L256
	movl	$468, %edx
	movl	$.LC253, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L256:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	test_is_overflow_pos, .-test_is_overflow_pos
	.section	.rodata
	.align 8
.LC254:
	.string	"88888888888888889.6666666666666666"
.LC255:
	.string	"fixedpoint_is_err(err1)"
	.align 8
.LC256:
	.string	"6666666666666666.88888888888888889"
.LC257:
	.string	"fixedpoint_is_err(err2)"
	.align 8
.LC258:
	.string	"-6666666666666666.8888888888888888"
.LC259:
	.string	"fixedpoint_is_valid(err3)"
.LC260:
	.string	"!fixedpoint_is_err(err3)"
.LC261:
	.string	"88888888888888889"
.LC262:
	.string	"fixedpoint_is_err(err4)"
.LC263:
	.string	"7.88888888888888889"
.LC264:
	.string	"fixedpoint_is_err(err5)"
.LC265:
	.string	"123xabc.4"
.LC266:
	.string	"fixedpoint_is_err(err6)"
.LC267:
	.string	"7.0?4"
.LC268:
	.string	"fixedpoint_is_err(err7)"
	.text
	.globl	test_is_err
	.type	test_is_err, @function
test_is_err:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$240, %rsp
	movq	%rdi, -232(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC254, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$477, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L258
	movl	$477, %edx
	movl	$.LC255, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L258:
	leaq	-64(%rbp), %rax
	movl	$.LC256, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$481, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L259
	movl	$481, %edx
	movl	$.LC257, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L259:
	leaq	-96(%rbp), %rax
	movl	$.LC258, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$485, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L260
	movl	$485, %edx
	movl	$.LC259, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L260:
	movl	$486, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L261
	movl	$486, %edx
	movl	$.LC260, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L261:
	leaq	-128(%rbp), %rax
	movl	$.LC261, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$490, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L262
	movl	$490, %edx
	movl	$.LC262, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L262:
	leaq	-160(%rbp), %rax
	movl	$.LC263, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$494, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L263
	movl	$494, %edx
	movl	$.LC264, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L263:
	leaq	-192(%rbp), %rax
	movl	$.LC265, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$498, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L264
	movl	$498, %edx
	movl	$.LC266, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L264:
	leaq	-224(%rbp), %rax
	movl	$.LC267, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$502, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	call	fixedpoint_is_err
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L266
	movl	$502, %edx
	movl	$.LC268, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L266:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	test_is_err, .-test_is_err
	.section	.rodata
.LC269:
	.string	"half1.tag ==1"
	.align 8
.LC270:
	.string	"0xf676e8UL/2 == fixedpoint_whole_part(half1)"
	.align 8
.LC271:
	.string	"0x5800000000000000UL/2 == fixedpoint_frac_part(half1)"
	.align 8
.LC272:
	.string	"0xf676e8UL == fixedpoint_whole_part(fixedpoint_double(half1))"
	.align 8
.LC273:
	.string	"0x5800000000000000UL == fixedpoint_frac_part(fixedpoint_double(half1))"
.LC274:
	.string	"-f676e8.58"
.LC275:
	.string	"half3.tag ==-1"
	.align 8
.LC276:
	.string	"0xf676e8UL/2 == fixedpoint_whole_part(half3)"
	.align 8
.LC277:
	.string	"0x5800000000000000UL/2 == fixedpoint_frac_part(half3)"
	.align 8
.LC278:
	.string	"0xf676e8UL == fixedpoint_whole_part(fixedpoint_double(half3))"
	.align 8
.LC279:
	.string	"0x5800000000000000UL == fixedpoint_frac_part(fixedpoint_double(half3))"
	.text
	.globl	test_halve
	.type	test_halve, @function
test_halve:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$272, %rsp
	movq	%rdi, -264(%rbp)
	leaq	-160(%rbp), %rax
	movl	$.LC241, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	subq	$8, %rsp
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$513, tctest_assertion_line(%rip)
	movl	-176(%rbp), %eax
	cmpl	$1, %eax
	je	.L268
	movl	$513, %edx
	movl	$.LC269, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L268:
	movl	$514, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$8076148, %rax
	je	.L269
	movl	$514, %edx
	movl	$.LC270, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L269:
	movl	$515, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$3170534137668829184, %rdx
	cmpq	%rdx, %rax
	je	.L270
	movl	$515, %edx
	movl	$.LC271, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L270:
	movl	$516, tctest_assertion_line(%rip)
	leaq	-128(%rbp), %rax
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$16152296, %rax
	je	.L271
	movl	$516, %edx
	movl	$.LC272, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L271:
	movl	$517, tctest_assertion_line(%rip)
	leaq	-96(%rbp), %rax
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$6341068275337658368, %rdx
	cmpq	%rdx, %rax
	je	.L272
	movl	$517, %edx
	movl	$.LC273, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L272:
	leaq	-224(%rbp), %rax
	movl	$.LC274, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-256(%rbp), %rax
	subq	$8, %rsp
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$521, tctest_assertion_line(%rip)
	movl	-240(%rbp), %eax
	cmpl	$-1, %eax
	je	.L273
	movl	$521, %edx
	movl	$.LC275, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L273:
	movl	$522, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$8076148, %rax
	je	.L274
	movl	$522, %edx
	movl	$.LC276, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L274:
	movl	$523, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$3170534137668829184, %rdx
	cmpq	%rdx, %rax
	je	.L275
	movl	$523, %edx
	movl	$.LC277, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L275:
	movl	$524, tctest_assertion_line(%rip)
	leaq	-64(%rbp), %rax
	subq	$8, %rsp
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_whole_part
	addq	$32, %rsp
	cmpq	$16152296, %rax
	je	.L276
	movl	$524, %edx
	movl	$.LC278, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L276:
	movl	$525, tctest_assertion_line(%rip)
	leaq	-32(%rbp), %rax
	subq	$8, %rsp
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_frac_part
	addq	$32, %rsp
	movabsq	$6341068275337658368, %rdx
	cmpq	%rdx, %rax
	je	.L278
	movl	$525, %edx
	movl	$.LC279, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L278:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	test_halve, .-test_halve
	.section	.rodata
.LC280:
	.string	"0.05"
	.align 8
.LC281:
	.string	"fixedpoint_compare(lhs1,rhs1)==-1"
	.align 8
.LC282:
	.string	"fixedpoint_compare(rhs1,lhs1)==1"
.LC283:
	.string	"-2.1"
	.align 8
.LC284:
	.string	"fixedpoint_compare(lhs2,rhs2)==-1"
	.align 8
.LC285:
	.string	"fixedpoint_compare(rhs2,lhs2)==1"
	.align 8
.LC286:
	.string	"fixedpoint_compare(lhs3,rhs3)==0"
	.align 8
.LC287:
	.string	"fixedpoint_compare(lhs4,rhs4)==-1"
	.align 8
.LC288:
	.string	"fixedpoint_compare(lhs5,rhs5)==0"
.LC289:
	.string	"2.c"
.LC290:
	.string	"2.a"
	.align 8
.LC291:
	.string	"fixedpoint_compare(lhs6,rhs6)==1"
.LC292:
	.string	"-2.a"
	.align 8
.LC293:
	.string	"fixedpoint_compare(lhs7,rhs7)==1"
	.align 8
.LC294:
	.string	"fixedpoint_compare(lhs8,rhs8)==-1"
	.text
	.globl	test_compare
	.type	test_compare, @function
test_compare:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$528, %rsp
	movq	%rdi, -520(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC251, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	movl	$.LC280, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$534, tctest_assertion_line(%rip)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$-1, %eax
	je	.L280
	movl	$534, %edx
	movl	$.LC281, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L280:
	movl	$535, tctest_assertion_line(%rip)
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$1, %eax
	je	.L281
	movl	$535, %edx
	movl	$.LC282, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L281:
	leaq	-96(%rbp), %rax
	movl	$.LC283, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-128(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$538, tctest_assertion_line(%rip)
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$-1, %eax
	je	.L282
	movl	$538, %edx
	movl	$.LC284, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L282:
	movl	$539, tctest_assertion_line(%rip)
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$1, %eax
	je	.L283
	movl	$539, %edx
	movl	$.LC285, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L283:
	leaq	-160(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$542, tctest_assertion_line(%rip)
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L284
	movl	$542, %edx
	movl	$.LC286, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L284:
	leaq	-224(%rbp), %rax
	movl	$0, %edx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movl	$-1, -208(%rbp)
	leaq	-256(%rbp), %rax
	movl	$0, %edx
	movq	$-1, %rsi
	movq	%rax, %rdi
	call	fixedpoint_create2
	movl	$546, tctest_assertion_line(%rip)
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$-1, %eax
	je	.L285
	movl	$546, %edx
	movl	$.LC287, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L285:
	leaq	-288(%rbp), %rax
	movl	$.LC40, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-320(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$549, tctest_assertion_line(%rip)
	pushq	-304(%rbp)
	pushq	-312(%rbp)
	pushq	-320(%rbp)
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L286
	movl	$549, %edx
	movl	$.LC288, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L286:
	leaq	-352(%rbp), %rax
	movl	$.LC289, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-384(%rbp), %rax
	movl	$.LC290, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$552, tctest_assertion_line(%rip)
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	pushq	-336(%rbp)
	pushq	-344(%rbp)
	pushq	-352(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$1, %eax
	je	.L287
	movl	$552, %edx
	movl	$.LC291, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L287:
	leaq	-416(%rbp), %rax
	movl	$.LC289, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-448(%rbp), %rax
	movl	$.LC292, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$555, tctest_assertion_line(%rip)
	pushq	-432(%rbp)
	pushq	-440(%rbp)
	pushq	-448(%rbp)
	pushq	-400(%rbp)
	pushq	-408(%rbp)
	pushq	-416(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$1, %eax
	je	.L288
	movl	$555, %edx
	movl	$.LC293, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L288:
	leaq	-480(%rbp), %rax
	movl	$.LC290, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-512(%rbp), %rax
	movl	$.LC289, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$558, tctest_assertion_line(%rip)
	pushq	-496(%rbp)
	pushq	-504(%rbp)
	pushq	-512(%rbp)
	pushq	-464(%rbp)
	pushq	-472(%rbp)
	pushq	-480(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	cmpl	$-1, %eax
	je	.L290
	movl	$558, %edx
	movl	$.LC294, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L290:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	test_compare, .-test_compare
	.section	.rodata
.LC295:
	.string	"0.2"
	.align 8
.LC296:
	.string	"fixedpoint_compare(sec1,cor1)==0"
.LC297:
	.string	"2.2"
.LC298:
	.string	"4.4"
	.align 8
.LC299:
	.string	"fixedpoint_compare(sec2,cor2)==0"
.LC300:
	.string	"6"
	.align 8
.LC301:
	.string	"fixedpoint_compare(sec3,cor3)==0"
	.align 8
.LC302:
	.string	"fixedpoint_compare(sec4,cor4)==0"
	.align 8
.LC303:
	.string	"fixedpoint_compare(sec5,cor5)==0"
.LC304:
	.string	"-2.2"
.LC305:
	.string	"-4.4"
	.align 8
.LC306:
	.string	"fixedpoint_compare(sec6,cor6)==0"
.LC307:
	.string	"-d"
.LC308:
	.string	"-1b"
.LC309:
	.string	"fixedpoint_compare(sec8,cor8)"
	.text
	.globl	test_fixedpoint_double
	.type	test_fixedpoint_double, @function
test_fixedpoint_double:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$688, %rsp
	movq	%rdi, -680(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC295, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-96(%rbp), %rax
	movl	$.LC117, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$568, tctest_assertion_line(%rip)
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L292
	movl	$568, %edx
	movl	$.LC296, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L292:
	leaq	-128(%rbp), %rax
	movl	$.LC297, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-160(%rbp), %rax
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-192(%rbp), %rax
	movl	$.LC298, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$573, tctest_assertion_line(%rip)
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L293
	movl	$573, %edx
	movl	$.LC299, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L293:
	leaq	-224(%rbp), %rax
	movl	$.LC245, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-256(%rbp), %rax
	subq	$8, %rsp
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-288(%rbp), %rax
	movl	$.LC300, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$578, tctest_assertion_line(%rip)
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L294
	movl	$578, %edx
	movl	$.LC301, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L294:
	leaq	-320(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-352(%rbp), %rax
	subq	$8, %rsp
	pushq	-304(%rbp)
	pushq	-312(%rbp)
	pushq	-320(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-384(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$583, tctest_assertion_line(%rip)
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	pushq	-336(%rbp)
	pushq	-344(%rbp)
	pushq	-352(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L295
	movl	$583, %edx
	movl	$.LC302, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L295:
	leaq	-416(%rbp), %rax
	movl	$.LC250, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-448(%rbp), %rax
	subq	$8, %rsp
	pushq	-400(%rbp)
	pushq	-408(%rbp)
	pushq	-416(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-480(%rbp), %rax
	movl	$.LC56, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$588, tctest_assertion_line(%rip)
	pushq	-464(%rbp)
	pushq	-472(%rbp)
	pushq	-480(%rbp)
	pushq	-432(%rbp)
	pushq	-440(%rbp)
	pushq	-448(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L296
	movl	$588, %edx
	movl	$.LC303, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L296:
	leaq	-512(%rbp), %rax
	movl	$.LC304, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-544(%rbp), %rax
	subq	$8, %rsp
	pushq	-496(%rbp)
	pushq	-504(%rbp)
	pushq	-512(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-576(%rbp), %rax
	movl	$.LC305, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$593, tctest_assertion_line(%rip)
	pushq	-560(%rbp)
	pushq	-568(%rbp)
	pushq	-576(%rbp)
	pushq	-528(%rbp)
	pushq	-536(%rbp)
	pushq	-544(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	je	.L297
	movl	$593, %edx
	movl	$.LC306, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L297:
	leaq	-608(%rbp), %rax
	movl	$.LC307, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-640(%rbp), %rax
	subq	$8, %rsp
	pushq	-592(%rbp)
	pushq	-600(%rbp)
	pushq	-608(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_double
	addq	$32, %rsp
	leaq	-672(%rbp), %rax
	movl	$.LC308, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$598, tctest_assertion_line(%rip)
	pushq	-656(%rbp)
	pushq	-664(%rbp)
	pushq	-672(%rbp)
	pushq	-624(%rbp)
	pushq	-632(%rbp)
	pushq	-640(%rbp)
	call	fixedpoint_compare
	addq	$48, %rsp
	testl	%eax, %eax
	jne	.L299
	movl	$598, %edx
	movl	$.LC309, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L299:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	test_fixedpoint_double, .-test_fixedpoint_double
	.section	.rodata
.LC310:
	.string	"fixedpoint_is_zero(fis)"
	.text
	.globl	test_fixedpoint_is_zero
	.type	test_fixedpoint_is_zero, @function
test_fixedpoint_is_zero:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC112, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$605, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_zero
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L302
	movl	$605, %edx
	movl	$.LC310, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L302:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	test_fixedpoint_is_zero, .-test_fixedpoint_is_zero
	.section	.rodata
.LC311:
	.string	"-6"
.LC312:
	.string	"fixedpoint_is_neg(fis)"
.LC313:
	.string	"-6.0"
.LC314:
	.string	"-0.6"
.LC315:
	.string	"-.6"
.LC316:
	.string	"-0.6666666666666666"
.LC317:
	.string	"-.6666666666666666"
	.text
	.globl	test_fixedpoint_is_neg
	.type	test_fixedpoint_is_neg, @function
test_fixedpoint_is_neg:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC311, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$612, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L304
	movl	$612, %edx
	movl	$.LC312, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L304:
	leaq	-80(%rbp), %rax
	movl	$.LC313, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$615, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L305
	movl	$615, %edx
	movl	$.LC312, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L305:
	leaq	-80(%rbp), %rax
	movl	$.LC314, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$618, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L306
	movl	$618, %edx
	movl	$.LC312, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L306:
	leaq	-80(%rbp), %rax
	movl	$.LC315, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$621, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L307
	movl	$621, %edx
	movl	$.LC312, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L307:
	leaq	-80(%rbp), %rax
	movl	$.LC316, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$624, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L308
	movl	$624, %edx
	movl	$.LC312, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L308:
	leaq	-80(%rbp), %rax
	movl	$.LC317, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$627, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L310
	movl	$627, %edx
	movl	$.LC312, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L310:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	test_fixedpoint_is_neg, .-test_fixedpoint_is_neg
	.section	.rodata
	.align 8
.LC318:
	.string	"-FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF"
	.align 8
.LC319:
	.string	"-0000000000000000.0000000000000001"
	.align 8
.LC320:
	.string	"fixedpoint_is_overflow_neg(sum2)"
.LC321:
	.string	"!fixedpoint_is_valid(sum2)"
	.align 8
.LC322:
	.string	"fixedpoint_is_overflow_neg(sum3)"
.LC323:
	.string	"!fixedpoint_is_valid(sum3)"
	.align 8
.LC324:
	.string	"-0000000000000000.0000000000000011"
	.align 8
.LC325:
	.string	"fixedpoint_is_overflow_neg(sum5)"
.LC326:
	.string	"!fixedpoint_is_valid(sum5)"
	.align 8
.LC327:
	.string	"-0000000000000000.0000000000001001"
	.align 8
.LC328:
	.string	"fixedpoint_is_overflow_neg(sum7)"
.LC329:
	.string	"!fixedpoint_is_valid(sum7)"
	.text
	.globl	test_fixedpoint_is_overflow_neg
	.type	test_fixedpoint_is_overflow_neg, @function
test_fixedpoint_is_overflow_neg:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$400, %rsp
	movq	%rdi, -392(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC318, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	movl	$.LC319, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-96(%rbp), %rax
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$637, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_overflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L312
	movl	$637, %edx
	movl	$.LC320, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L312:
	movl	$638, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L313
	movl	$638, %edx
	movl	$.LC321, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L313:
	leaq	-128(%rbp), %rax
	movl	$.LC318, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-160(%rbp), %rax
	movl	$.LC319, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$643, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_overflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L314
	movl	$643, %edx
	movl	$.LC322, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L314:
	movl	$644, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L315
	movl	$644, %edx
	movl	$.LC323, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L315:
	leaq	-224(%rbp), %rax
	movl	$.LC318, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-256(%rbp), %rax
	movl	$.LC324, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-288(%rbp), %rax
	pushq	-208(%rbp)
	pushq	-216(%rbp)
	pushq	-224(%rbp)
	pushq	-240(%rbp)
	pushq	-248(%rbp)
	pushq	-256(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$649, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_is_overflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L316
	movl	$649, %edx
	movl	$.LC325, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L316:
	movl	$650, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-272(%rbp)
	pushq	-280(%rbp)
	pushq	-288(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L317
	movl	$650, %edx
	movl	$.LC326, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L317:
	leaq	-320(%rbp), %rax
	movl	$.LC318, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-352(%rbp), %rax
	movl	$.LC327, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-384(%rbp), %rax
	pushq	-304(%rbp)
	pushq	-312(%rbp)
	pushq	-320(%rbp)
	pushq	-336(%rbp)
	pushq	-344(%rbp)
	pushq	-352(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$655, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	call	fixedpoint_is_overflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L318
	movl	$655, %edx
	movl	$.LC328, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L318:
	movl	$656, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-368(%rbp)
	pushq	-376(%rbp)
	pushq	-384(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L320
	movl	$656, %edx
	movl	$.LC329, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L320:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	test_fixedpoint_is_overflow_neg, .-test_fixedpoint_is_overflow_neg
	.section	.rodata
	.align 8
.LC330:
	.string	"FFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF"
	.align 8
.LC331:
	.string	"fixedpoint_is_overflow_pos(sum1)"
.LC332:
	.string	"!fixedpoint_is_valid(sum1)"
	.align 8
.LC333:
	.string	"DFFFFFFFFFFFFFFF.FFFFFFFFFFFFFFFF"
	.align 8
.LC334:
	.string	"fixedpoint_is_overflow_pos(sum2)"
	.text
	.globl	test_fixedpoint_is_overflow_pos
	.type	test_fixedpoint_is_overflow_pos, @function
test_fixedpoint_is_overflow_pos:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movq	%rdi, -200(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC330, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	movl	$.LC330, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-96(%rbp), %rax
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$667, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_overflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L322
	movl	$667, %edx
	movl	$.LC331, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L322:
	movl	$668, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L323
	movl	$668, %edx
	movl	$.LC332, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L323:
	leaq	-128(%rbp), %rax
	movl	$.LC333, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-160(%rbp), %rax
	movl	$.LC330, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_add
	addq	$48, %rsp
	movl	$674, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_overflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L324
	movl	$674, %edx
	movl	$.LC334, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L324:
	movl	$675, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L326
	movl	$675, %edx
	movl	$.LC321, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L326:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	test_fixedpoint_is_overflow_pos, .-test_fixedpoint_is_overflow_pos
	.section	.rodata
	.align 8
.LC335:
	.string	"-0000000000000000.0000000000000003"
	.align 8
.LC336:
	.string	"fixedpoint_is_underflow_neg(result4)"
.LC337:
	.string	"!fixedpoint_is_valid(result4)"
	.align 8
.LC338:
	.string	"-0000000000000000.0000000000000005"
	.align 8
.LC339:
	.string	"fixedpoint_is_underflow_neg(result5)"
.LC340:
	.string	"!fixedpoint_is_valid(result5)"
	.align 8
.LC341:
	.string	"-0000000000000000.0000000000000007"
	.align 8
.LC342:
	.string	"fixedpoint_is_underflow_neg(result6)"
.LC343:
	.string	"!fixedpoint_is_valid(result6)"
	.text
	.globl	testfixedpoint_is_underflow_neg
	.type	testfixedpoint_is_underflow_neg, @function
testfixedpoint_is_underflow_neg:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movq	%rdi, -200(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC335, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$684, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_underflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L328
	movl	$684, %edx
	movl	$.LC336, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L328:
	movl	$685, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L329
	movl	$685, %edx
	movl	$.LC337, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L329:
	leaq	-96(%rbp), %rax
	movl	$.LC338, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-128(%rbp), %rax
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$689, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_is_underflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L330
	movl	$689, %edx
	movl	$.LC339, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L330:
	movl	$690, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L331
	movl	$690, %edx
	movl	$.LC340, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L331:
	leaq	-160(%rbp), %rax
	movl	$.LC341, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	subq	$8, %rsp
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$694, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_underflow_neg
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L332
	movl	$694, %edx
	movl	$.LC342, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L332:
	movl	$695, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L334
	movl	$695, %edx
	movl	$.LC343, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L334:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	testfixedpoint_is_underflow_neg, .-testfixedpoint_is_underflow_neg
	.section	.rodata
	.align 8
.LC344:
	.string	"0000000000000000.0000000000000003"
	.align 8
.LC345:
	.string	"fixedpoint_is_underflow_pos(result4)"
	.align 8
.LC346:
	.string	"0000000000000000.0000000000000005"
	.align 8
.LC347:
	.string	"fixedpoint_is_underflow_pos(result5)"
	.align 8
.LC348:
	.string	"0000000000000000.0000000000000007"
	.align 8
.LC349:
	.string	"fixedpoint_is_underflow_pos(result6)"
	.text
	.globl	testfixedpoint_is_underflow_pos
	.type	testfixedpoint_is_underflow_pos, @function
testfixedpoint_is_underflow_pos:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movq	%rdi, -200(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC344, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-64(%rbp), %rax
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$704, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_underflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L336
	movl	$704, %edx
	movl	$.LC345, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L336:
	movl	$705, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L337
	movl	$705, %edx
	movl	$.LC337, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L337:
	leaq	-96(%rbp), %rax
	movl	$.LC346, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-128(%rbp), %rax
	subq	$8, %rsp
	pushq	-80(%rbp)
	pushq	-88(%rbp)
	pushq	-96(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$709, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_is_underflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L338
	movl	$709, %edx
	movl	$.LC347, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L338:
	movl	$710, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-112(%rbp)
	pushq	-120(%rbp)
	pushq	-128(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L339
	movl	$710, %edx
	movl	$.LC340, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L339:
	leaq	-160(%rbp), %rax
	movl	$.LC348, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	leaq	-192(%rbp), %rax
	subq	$8, %rsp
	pushq	-144(%rbp)
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	movq	%rax, %rdi
	call	fixedpoint_halve
	addq	$32, %rsp
	movl	$714, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_underflow_pos
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L340
	movl	$714, %edx
	movl	$.LC349, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L340:
	movl	$715, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-176(%rbp)
	pushq	-184(%rbp)
	pushq	-192(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	je	.L342
	movl	$715, %edx
	movl	$.LC343, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L342:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	testfixedpoint_is_underflow_pos, .-testfixedpoint_is_underflow_pos
	.section	.rodata
.LC350:
	.string	"fixedpoint_is_valid(rhs5)"
.LC351:
	.string	"-1"
.LC352:
	.string	"fixedpoint_is_valid(rhs3)"
	.text
	.globl	testfixedpoint_is_valid
	.type	testfixedpoint_is_valid, @function
testfixedpoint_is_valid:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	leaq	-32(%rbp), %rax
	movl	$.LC245, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$722, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-16(%rbp)
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L344
	movl	$722, %edx
	movl	$.LC350, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L344:
	leaq	-64(%rbp), %rax
	movl	$.LC351, %esi
	movq	%rax, %rdi
	call	fixedpoint_create_from_hex
	movl	$724, tctest_assertion_line(%rip)
	subq	$8, %rsp
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	fixedpoint_is_valid
	addq	$32, %rsp
	testl	%eax, %eax
	jne	.L346
	movl	$724, %edx
	movl	$.LC352, %esi
	movl	$.LC24, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L346:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	testfixedpoint_is_valid, .-testfixedpoint_is_valid
	.ident	"GCC: (GNU) 11.2.1 20211203 (Red Hat 11.2.1-7)"
	.section	.note.GNU-stack,"",@progbits
