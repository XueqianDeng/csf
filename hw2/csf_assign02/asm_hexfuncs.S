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

/*
 * Format a byte value (in the range 0-255) as string consisting
 * of two hex digits.  The string is stored in sbuf.
 * Parameters:
 *  byteval (%rdi) - the byte value to be translated. 
 *  sbuf (%rsi) - the pointer to the string. 
 */
	.globl hex_format_byte_as_hex
hex_format_byte_as_hex:
	subq $8, %rsp	/* align stack pointer */
	movq %rdi, %r10 /* Move byteval in rdi register to r10 */
	andq $15, %r10  /* Perform bitwise operation &1111 on r10 register */
	/* increment rsi so that it now has the address of second element in array */
	inc %rsi 
	movq $hex_tablet, %r11 /* store the address of hex_tablet into r11 */
	/* put the char value at address (%r10 + %r11) into %cl register (getting hex char) */
	movb (%r11,%r10), %cl 
	movb %cl, (%rsi) /* set the second element of the array (rsi reference) to the char value */
	movq %rdi, %r10 /* Move byteval in rdi register to r10 */
	/* we move the rightmost 4 bits out and retain the leftmost 4 bits, by rightshifting by 4 */
	sarq $4, %r10 /* put the char value at address (%r10 + %r11) into %cl register */
	andq $15, %r10 /* Perform bitwise operation &1111 on r10 register */
	subq $1, %rsi /* decrement by 1 so that rsi has the address of the first element in array */
	movb (%r11,%r10), %cl /* put the char value at address (%r10 + %r11) into %cl register */
	movb %cl, (%rsi) /* set the first element of the array (rsi reference) to the char value */
	movb $0, 2(%rsi) /* set null terminator in array at index 2*/
	addq $8, %rsp /* align stack pointer */
	ret

/*
 * Convert a byte value (in the range 0-255) to a printable character
 * value.  If byteval is already a printable character, it is returned
 * unmodified.  If byteval is not a printable character, then the
 * ASCII code for '.' should be returned.
 *  byteval (%rdi) - the byte value to be translated. 
 */
	.globl hex_to_printable
hex_to_printable:
	subq $8, %rsp /* adjust stack pointer */
	/* check if byteval (passed in edi) is smaller than 0x20 (smallest printable ascii val) */
	cmpl $32, %edi 
	movl $46, %r10d /* put the ascii val of dot (46) to r10d */
	cmovl %r10d,  %edi /* conditionally (if byteval < 0x20), store 46 in edi */
	cmpl $126, %edi /* check if byteval is greater than 0x7E (largest printable ascii val)*/
	cmovg %r10d, %edi /* conditionally (if byteval > 0x7E), store 46 in edi */
	/* move the ascii val in edi to eax as return value (if byteval is within printable range, leave unchanged; otherwise, 46) */
	movl %edi, %eax 
	addq $8, %rsp /* adjust stack pointer back*/
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
