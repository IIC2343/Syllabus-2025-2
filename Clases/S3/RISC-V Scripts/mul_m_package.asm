.text
main:
  addi t0, zero, 10
  addi t1, zero, 200
  mul t2,t0,t1
  end:
    add a0, zero, t2
    addi a7, zero, 1
    ecall
    addi a7, zero, 10
    ecall
