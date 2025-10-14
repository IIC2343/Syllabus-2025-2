.data
arr: .word 4, 2, 7,3,10
n:   .word 5

.text
main:
# Preparar argumentos para suma
la a0, arr      # a0 = dirección base del arreglo
lw a1, n        # a1 = tamaño del arreglo (n)
# Llamar a la subrutina suma
jal ra, suma # Similar a CALL

# Al retornar, a0 tiene la suma
# Llamar a imprimir(a0)

addi sp, sp, -4
sw ra, 0(sp)
jal ra, imprimir
lw ra, 0(sp)
addi sp, sp, 4

# Llamar a terminar()
jal ra, terminar # es un CALL

suma:
    beq   a1, zero, caso_base

    addi  sp, sp, -8     # espacio para ra y t2
    sw    ra, 4(sp)

    addi  a1, a1, -1     # n = n - 1
    slli  t0, a1, 2      # t0 = (n-1)*4
    add   t1, a0, t0     # t1 = Direccion de arr[n-1]
    lw    t2, 0(t1)      # t2 = arr[n-1]
    sw    t2, 0(sp)      # guardar t2 (caller-saved) antes del jal

    jal   ra, suma       # llamada recursiva

    lw    t2, 0(sp)      # recuperar t2 = arr[n-1]
    add   a0, a0, t2     # a0 = suma(arr, n-1) + arr[n-1]

    lw    ra, 4(sp)
    addi  sp, sp, 8
    jalr  zero, 0(ra)

caso_base:
    addi  a0, zero, 0
    jalr  zero, 0(ra)

    
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
