.data
    len: .word 5
    arr: .word 198, 137, 42, 63, 175
.text
    start:
        addi s0, zero, 4	# s0 = 4 bytes por dirección
        lw s1, len 			# s1 = largo del arreglo
        addi t0, zero, 0 	# Contador (i)
        la t1, arr 			# t1 = dirección del arreglo (inicialmente arr[0])
        mul t2, s0, s1		# t2 = s0 * s1 = bytes que ocupa el arreglo de entrada
        add t2, t2, t1		# t2 += t1 = primera dirección que podemos usar de .data
        while:
            lw a0, 0(t1)		# a0 = arr[i] 	
            addi sp, sp, -8
            sw t0, 0(sp) 		# Respaldamos t0 y ra (caller-saved).
            sw ra, 4(sp)		
            jal ra, double_give_next_person
            lw t0, 0(sp) 		# Recuperamos t0 y ra y restauramos el stack
            lw ra, 4(sp)
            addi sp, sp, 8
            sw a0, 0(t2)		# out[i] = a0
            addi t0, t0, 1		# t0 += 1
            beq t0, s1, end		# Termina cuando se recorre todo el arreglo
            add t1, t1, s0		# t1 += s0 = dirección arr[i+1]
            add t2, t2, s0    	# t2 += s0 = dirección out[i+1]
            beq zero, zero, while
    double_give_next_person:
        add t0, zero, a0
        add a0, a0, t0		# a0 = a0 + t0 = 2 * a0
        jalr zero, 0(ra)
    end:
        addi a7, zero, 10
        ecall
