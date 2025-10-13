.data
    N: .word 4		# N = Argumento de factorial. Calcularemos N! = 4
.text
    main:
        addi sp, sp, -4         	# Reservamos 4 bytes en el stack
        sw   ra, 0(sp)       		# Respaldamos ra
        la   t0, N              	# Dirección de memoria de N
        lw   t0, 0(t0)         		# Valor de N
        add  a0, zero, t0    		# Argumento 0 = valor de N
        jal ra, factorial       	# factorial(N)
        addi a7, zero, 1        	# Llamada de sistema: print int   
        ecall						# Valor en consola: 24 (a0, valor de retorno)
        lw   ra, 0(sp)         		# Restauramos ra
        addi sp, sp, 4          	# Restauramos el stack
        addi a7, zero, 10       	# Llamada de sistema: exit
        ecall
    factorial:
        addi sp, sp, -8         	# Reservamos 8 bytes en el stack
        sw   ra, 0(sp)       		# Respaldamos ra
        sw   a0, 4(sp)          	# Respaldamos N
        bge zero, a0, fact_zero		# if (N > 0){
        addi a0, a0, -1				#   N -= 1
        jal  ra, factorial			#   (N-1)! = factorial(N-1)
        lw   t0, 4(sp)				#   Recuperamos N
        mul  a0, a0, t0				#   N! = N * (N-1)! = N * factorial(N-1)
        beq  zero,zero, fact_end	# }
        fact_zero:					# else {
            addi  a0, zero, 1 		#   N! = 1
        fact_end:					# }
            lw   ra, 0(sp)      	# Restauramos solo ra, a0 ahora posee el retorno
            addi sp, sp, 8			# Restauramos el stack
        jalr zero, 0(ra)
