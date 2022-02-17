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
	subq $8, %rsp	/* Get 8 bytes of information from the stack pointer */
	movq %rdi, %r10 /* Move the information in rdi register to r10 */
	andq $15, %r10  /* Perform bitwise operation &1111 on r10 register */
	inc %rsi
	/*
	 * rsi register contains the secod arg to the value, by doing so,
	 * we move to the second byte of the input
	 */
	movq $hex_tablet, %r11 
	movb (%r11,%r10), %cl
	movb %cl, (%rsi)
	/* we get the first char value of the 8 bytes here */
	movq %rdi, %r10
	sarq $4, %r10
	/* we move the first byte out and get the secod byte */
	andq $15, %r10
	subq $1, %rsi
	movb (%r11,%r10), %cl
	movb %cl, (%rsi)
	/* we get the second char value of the 8 byte here */
	movb $0, 2(%rsi)
	addq $8, %rsp
	/* reset everything back */
	ret


	.globl hex_to_printable
hex_to_printable:
	subq $8, %rsp /* adjust stack pointer */
	cmpl $32, %edi
	movl $46, %r10d
	cmovl %r10d,  %edi
	cmpl $126, %edi
	cmovg %r10d, %edi
	movl %edi, %eax
	/* if smaller or bigger than 32 and 126, make 46 */
	addq $8, %rsp
	/* adjust stack pointer back*/
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
