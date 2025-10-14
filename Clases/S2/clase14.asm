.data
arr: .word 4, 2, 7, 3
n:   .word 4

.text
main:
    # Preparar argumentos para suma
    la a0, arr      # a0 = dirección base del arreglo
    lw a1, n        # a1 = tamaño del arreglo (n)

    # Llamar a la subrutina suma
    jal ra, suma

    # Al retornar, a0 tiene la suma
    # Llamar a imprimir(a0)
    addi sp, sp, -4
    sw ra, 0(sp)
    jal ra, imprimir
    lw ra, 0(sp)
    addi sp, sp, 4

    # Llamar a terminar()
    jal ra, terminar


# -------------------------------------------------
# Subrutina: suma(a0=base, a1=n)
# Retorna en a0 la suma de los n elementos del arreglo
# -------------------------------------------------
suma:
    # Caso base: si n == 0, retornar 0
    beq a1, zero, caso_base

    # Guardar ra en el stack (por llamada recursiva)
    addi sp, sp, -4
    sw ra, 0(sp)

    # Calcular dirección del elemento arr[n-1]
    addi a1, a1, -1       # n = n - 1
    slli t0, a1, 2        # t0 = (n-1)*4
    add t1, a0, t0        # t1 = dirección de arr[n-1]
    lw t2, 0(t1)          # t2 = arr[n-1]

    # Llamada recursiva: suma(base, n-1)
    jal ra, suma

    # Al retornar, a0 contiene suma(arr, n-1)
    add a0, a0, t2        # a0 = arr[n-1] + suma(arr, n-1)

    # Restaurar ra y volver
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr zero, 0(ra)

caso_base:
    addi a0, zero, 0
    jalr zero, 0(ra)


# -------------------------------------------------
# Subrutina: imprimir(a0 = valor)
# Imprime un número entero en consola
# -------------------------------------------------
imprimir:
    addi a7, zero, 1      # código de PrintInt
    ecall
    # Salto de línea (opcional, mejora legibilidad)
    addi a0, zero, 10
    addi a7, zero, 11
    ecall
    jalr zero, 0(ra)


# -------------------------------------------------
# Subrutina: terminar()
# Finaliza el programa limpiamente
# -------------------------------------------------
terminar:
    addi a0, zero, 0
    addi a7, zero, 10
    ecall
