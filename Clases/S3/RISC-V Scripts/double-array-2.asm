.data
    len: .word 5
    arr: .word 198, 137, 42, 63, 175
.text
    start:
        addi t0, zero, 4	# s0 = 4 bytes por dirección
        lw t2, len 			# s1 = largo del arreglo
        addi s0, zero, 0 	# Contador (i)
        la s1, arr 			# t1 = dirección del arreglo (inicialmente arr[0])
        mul s2, t0, t2		# t2 = s0 * s1 = bytes que ocupa el arreglo de entrada
        add s2, s2, s1		# t2 += t1 = primera dirección que podemos usar de .data
        while:
            lw a0, 0(s1)		# a0 = arr[i] 	
            addi sp, sp, -4
            sw ra, 0(sp) 		# Respaldamos ra (caller-saved)
            jal ra, double_give_next_person
            lw ra, 0(sp) 		# Recuperamos ra y restauramos el stack
            addi sp, sp, 4
            sw a0, 0(s2)		# out[i] = a0
            addi s0, s0, 1		# s0 += 1
            beq s0, t2, end		# Termina cuando se recorre todo el arreglo
            add s1, s1, t0		# s1 += t0 = dirección arr[i+1]
            add s2, s2, t0    	# s2 += t0 = dirección out[i+1]
            beq zero, zero, while
    double_give_next_person:
        addi sp, sp, -4
        sw s0, 0(sp) 		# Respaldamos s0 (callee-saved)
        add s0, zero, a0
        add a0, a0, s0		# a0 = a0 + s0 = 2 * a0
        lw s0, 0(sp) 		# Recuperamos s0 y restauramos el stack
        addi sp, sp, 4
        jalr zero, 0(ra)
    end:
        addi a7, zero, 10
        ecall
