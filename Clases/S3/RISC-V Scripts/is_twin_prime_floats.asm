.data
  N:       .word 17
.text
  main:
    lw a0, N			# a0 = N = parameter
    addi s0, zero, 1			# Constant s0 = 1
    addi s1, zero, 2			# Constant s1 = 1
    addi sp, sp, -4			# Save ra
    sw ra, 0(sp)
    jal ra, check_is_twin_prime
    lw ra, 0(sp)			# Restore ra and stack
    addi sp, sp, 4
    addi a7, zero, 1			# print
    ecall
    addi a7, zero, 10			# exit
    ecall
  check_is_twin_prime:
    addi sp, sp, -8			# Save ra and a0
    sw ra, 0(sp)
    sw a0, 4(sp)
    jal ra, check_is_prime		# Check if N is prime
    bne a0, s0, is_not_twin_prime	# a0 != 1 -> is not twin prime
    lw a0, 4(sp)			# Restore a0
    addi a0, a0, -2
    jal ra, check_is_prime		# Check if N - 2 is prime
    beq a0, s0, is_twin_prime		# If N - 2 is prime -> N is twin prime
    lw a0, 4(sp)			# Restore a0
    addi a0, a0, 2
    call check_is_prime		# Check if N + 2 is prime
    beq a0, s0, is_twin_prime		# If N + 2 is prime -> N is twin prime
    # Else: N is not twin prime
    is_not_twin_prime:
      addi a0, zero, 0
      jal zero, end
    is_twin_prime:
      addi a0, zero, 1
    end:
      lw ra, 0(sp)			# Restore ra and stack
      addi sp, sp, 8
      jalr zero, 0(ra) 
  check_is_prime:
    bge s0, a0, is_not_prime		# a0 <= 1 -> is_not_prime
    beq a0, s1, is_prime		# a0 == 2 -> is_prime
    # Check divisors from 2 to sqrt_2(N).
    fcvt.s.w ft0, a0
    fsqrt.s ft0, ft0
    fcvt.w.s t1, ft0
    addi t0, zero, 2 			# Starting divisor. t0 = 2
    division_loop:
      rem t2, a0, t0			# If a0 % t0 == 0 -> Divisible, not prime.
      beq t2, zero, is_not_prime
      addi t0, t0, 1			# t0 += 1
      bge t1, t0, division_loop		# While t0 <= t1, keep looking for divisors.
    is_prime:
      addi a0, zero, 1
      jal zero, end_check_is_prime
    is_not_prime:
      addi a0, zero, 0
    end_check_is_prime:
      jalr zero, 0(ra) 
