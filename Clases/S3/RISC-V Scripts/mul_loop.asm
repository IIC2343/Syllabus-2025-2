.text
main:
  addi t0, zero, 10
  addi t1, zero, 200
  addi t2, zero, 0
  mul_loop:
    beq t0,zero,end
    add t2,t2,t1
    addi t0,t0,-1
    beq zero, zero, mul_loop
  end:
    add a0, zero, t2
    addi a7, zero, 1
    ecall
    addi a7, zero, 10
    ecall
