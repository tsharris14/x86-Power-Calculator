# ----------------------------------------------------------------------------------------
# TaCoya S. Harris
# CSC220
# Prof. Nwanze
# 14 April 2020
# Assembly code that calculates a base to a power
#
#     gcc -no-pie sum.s && ./a.out
#
# ----------------------------------------------------------------------------------------
	.global main


format:
	.asciz  "%5ld\n"

	.text
main:

	push    %rbx			# we have to save this since we use it
	mov     $2, %rax		# base
	mov     $5, %rbx	    # exponent
	mov     $0, %rcx        # sum (don't change)
	mov     $0, %rdx        # count (don't change)
	add     %rax, %rcx		# Add base to sum

printandadd:

	cmp     $0, %rbx        # if exponent == 0
	jE      ELSE            # if yes, jump to ZERO
    
	
	push    %rbx			# push exponent
    push    %rdx		    # push count
	push    %rax			# push base 
	push    %rcx			# push sum

	lea format(%rip), %rdi	# set 1st parameter (format)
	
	mov %rcx, %rsi			# set 2nd parameter (current_number)
	xor %cl, %cl			# clear AL
	

	# Stack is already aligned because we pushed three 8 byte registers
	call    printf		  	# printf(format, current_number)

    pop     %rcx            # pop sum
	pop     %rax			# pop base

	
	imul    %rax, %rcx      # multiply base with sum

    pop     %rdx            # pop count
	inc     %rdx			# add one to count
	
	pop     %rbx            # pop exponent
	
	cmp     %rbx, %rdx      # compare count to exponent
	jL     printandadd	   	# if count < exponent, go to printandadd
	
	pop     %rbx			# restore rbx before returning
	 
	ret
	
	ELSE:                   # if exponent is 0
	mov     $1, %r8         # move value 1 into r8
	push    %r8			    # push r8
	
	lea format(%rip), %rdi	# set 1st parameter (format)
	pop  %rcx               # *not quite sure why this line is necessary, but the code won't run without it
	mov  %r8, %rsi			# set 2nd parameter (current_number)
	xor  %r8b, %r8b			# clear AL
	
	# Stack is already aligned because we pushed three 8 byte registers
	call    printf		  	# printf(format, current_number)
    pop     %rbx			# restore rbx before returning
  
    


