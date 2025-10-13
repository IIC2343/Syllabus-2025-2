.data
  N:       .word 17
.text
  main:
    lw a0, N				# a0 = N = parameter
    li s0, 1				# Constant s0 = 1
    li s1, 2				# Constant s1 = 2
    addi sp, sp, -4			# Save ra
    sw ra, 0(sp)
    jal ra, check_is_prime
    lw ra, 0(sp)				# Restore ra and stack
    addi sp, sp, 4
    addi a7, zero, 1				# print
    ecall
    addi a7, zero, 10			# exit
    ecall
  check_is_prime:
    bge s0, a0, is_not_prime			# a0 <= 1 -> is_not_prime
    beq a0, s1, is_prime			# a1 == 2 -> is_prime
    # Check divisors from 2 to sqrt_2(N).
    fcvt.s.w ft0, a0
    fsqrt.s ft0, ft0
    fcvt.w.s t1, ft0
    addi t0, zero, 2 				# Starting divisor. t0 = 2
    division_loop:
      rem t2, a0, t0			# If a0 % t0 == 0 -> Divisible, not prime.
      beq t2, zero, is_not_prime
      addi t0, t0, 1			# t0 += 1
      bge t1, t0, division_loop	# While t0 <= t1, keep looking for divisors.
    is_prime:
      addi a0, zero, 1
      jal zero, end
    is_not_prime:
      addi a0, zero, 0
    end:
      jalr zero, 0(ra)
