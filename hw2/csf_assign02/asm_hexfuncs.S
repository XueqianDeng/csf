/* Assembly language implementation of hexdump functions */

	.section .rodata
hex_tablet: .string "0123456789abcdef"
	/* TODO: add read-only data such as strings here */

	.section .text
	
	

	
	/* TODO: add functions here */
	.globl hex_write_string
hex_write_string:
	ret

	.globl hex_read
hex_read:
	ret

	.globl hex_format_offset
hex_format_offset:
	ret

	.globl hex_format_byte_as_hex
hex_format_byte_as_hex:
	subq $8, %rsp
	movq %rdi, %r10
	andq $15, %r10
	inc %rsi
	movq $hex_tablet, %r11
	movb (%r11,%r10), %cl
	movb %cl, (%rsi)
	movq %rdi, %r10
	sarq $4, %r10
	andq $15, %r10
	subq $1, %rsi
	movb (%r11,%r10), %cl
	movb %cl, (%rsi)
	movb $0, 2(%rsi)
	addq $8, %rsp
	ret


	.globl hex_to_printable
hex_to_printable:
	subq $8, %rsp
    cmpl $32, %edi
	movl $46, %r10d
    cmovl %r10d,  %edi
    cmpl $126, %edi
	cmovg %r10d, %edi
    movl %edi, %eax
    addq $8, %rsp
    ret
    

/* vim:ft=gas:
 */

	/*
 * Determine the length of specified character string.
 *
 * Parameters:
 *   s - pointer to a NUL-terminated character string
 *
 * Returns:
 *    number of characters in the string
 */
	.globl strLen
strLen:
	subq $8, %rsp                 /* adjust stack pointer */
	movq $0, %r10                 /* initial count is 0 */

.LstrLenLoop:
	cmpb $0, (%rdi)               /* found NUL terminator? */
	jz .LstrLenDone               /* if so, done */
	inc %r10                      /* increment count */
	inc %rdi                      /* advance to next character */
	jmp .LstrLenLoop              /* continue loop */

.LstrLenDone:
	movq %r10, %rax               /* return count */
	addq $8, %rsp                 /* restore stack pointer */
	ret
