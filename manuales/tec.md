# Manual Técnico Práctica 2
#
| Carnet            | Nombre      | Auxiliar | Sección|
|-------------------|-------------|------------|--------|
|202101149| Mariano Roberto Rac Noguera | Mynor Ruíz|ACYE N|
#
## Introducción

Este manual técnico es una guía para los desarrolladores y técnicos encargados del mantenimiento de la aplicación o bien interesados en el código y desarrollo de la app. Proporciona información detallada sobre la arquitectura, el diseño y las tecnologías utilizadas en el desarrollo de Exregan
## Requerimientos de Software
- Arquitectura: x86 de 16 bits.Esto significa que el procesador debe ser compatible con la arquitectura x86 de 16 bits. La mayoría de los procesadores modernos son compatibles con esta arquitectura, pero se debe tener cuenta que algunos procesadores más nuevos solo admiten la arquitectura x86 de 32 o 64 bits
- Sistema operativo: MS-DOS o algún otro sistema operativo compatible con x86 de 16 bits.Asm6 es un ensamblador diseñado para sistemas operativos de 16 bits, como MS-DOS. Si se desea ejecutar programas asm6, se necesitará un sistema operativo compatible con esta arquitectura. 
- Herramienta de ensamblaje: asm6.El programa asm6 es un ensamblador específico para el lenguaje de ensamblaje de 6502 utilizado en algunos sistemas de 8 bits  o 16 bits. Aunque asm6 está diseñado para el ensamblaje de código de 8 bits, aún es posible utilizarlo para ensamblar código x86 de 16 bits. 


# Arquitectura
Este código está escrito en ensamblador x86 y sigue una estructura básica de un programa en ensamblador para el procesador Intel 8086.
- Incluye un archivo de macros que contiene funciones útiles para simplificar la escritura del código ensamblador..
- Es un programa interactivo que muestra un menú al usuario y le permite realizar varias operaciones relacionadas con productos, ventas y herramientas. También hay código relacionado con la manipulación de archivos y la generación de un archivo HTML como resultado.

## Tecnologías utilizadas

Exregan utiliza las siguientes tecnologías:

* ASM- para el desarrollo del programa
* DOSBOX - como entorno virtual

## Introducción
# Estructura del Código

- UI: La interfaz gráfica consiste en una aplicación directamente en la que el usuario puede interactuar por consola, es decir con el teclado,
- Productos: Consiste en la elaboración del apartado que permite al usuario ingresar productos en el sistema, poder visualizarlos y generar sus reportes, así también su eliminación 
- Ventas: permite al usuario registrar ventas, asociando código de producto con su precio para poder ir determinando el monto a total



## Funcionamiento Interno de la Aplicación
Validación Credenciales
```
call validar_acceso
		mov SI, offset usuario
		mov DI, offset usuario_capturado
		inc DI
		mov CX, 08
		call cadenas_iguales
		cmp DL, 0ff
		je validar_clave_usuario
		
		jmp credenciales_inc_fin
		
validar_clave_usuario:
	mov SI, offset clave
	mov DI, offset clave_capturada
	inc DI
	mov CX, 09
	call cadenas_iguales
	cmp DL, 0ff
	je menu_principal
	jmp credenciales_inc_fin
credenciales_inc_fin:
	mPrint nueva_lin
	mPrint fin_ejecucion_programa
	call acabar_ejecucion
	validar_acceso:
		;; abrir archivo de configuración
		mov AH, 3d
		mov AL, 00
		mov DX, offset nombre_conf
		int 21
		mov [handle_conf], AX
		;; analizarlo
```
Primero, se llama a la función validar_acceso. Esta función se encargará de realizar la validación del acceso al programa.
A continuación, se mueve la dirección de memoria del string usuario al registro SI y la dirección de memoria del string usuario_capturado al registro DI.
Se incrementa DI en 1 para omitir el primer carácter del string usuario_capturado.
Se mueve el valor 08 al registro CX, indicando la longitud de la comparación.
Se llama a la función cadenas_iguales, que compara los caracteres de los dos strings. El resultado de la comparación se almacena en el registro DL.
Se compara DL con 0ff y, si son iguales, salta a la etiqueta validar_clave_usuario. Esto implica que la comparación de los strings usuario y usuario_capturado fue exitosa.
Si la comparación anterior no fue exitosa, se salta a la etiqueta credenciales_inc_fin. Esto indica que el acceso no fue válido y el programa finaliza.
Si la comparación fue exitosa, se ejecutan las instrucciones dentro de la etiqueta validar_clave_usuario.
Se mueven las direcciones de memoria del string clave y del string clave_capturada a los registros SI y DI, respectivamente.
Se incrementa DI en 1 para omitir el primer carácter del string clave_capturada.
Se mueve el valor 09 al registro CX, indicando la longitud de la comparación.
Se llama a la función cadenas_iguales para comparar los caracteres de los dos strings. El resultado de la comparación se almacena en el registro DL.
Se compara DL con 0ff y, si son iguales, salta a la etiqueta menu_principal. Esto implica que la comparación de los strings clave y clave_capturada fue exitosa.
Si la comparación anterior no fue exitosa, se salta a la etiqueta credenciales_inc_fin. Esto indica que las credenciales no son válidas y el programa finaliza.
Se ejecutan las instrucciones dentro de la etiqueta credenciales_inc_fin. En este caso, se muestra un mensaje en pantalla, se imprime una nueva línea y se llama a la función acabar_ejecucion para finalizar la ejecución del programa.
Ingreso Productos/Ventas
```
ingresar_producto_archivo:
		mov DX, offset titulo_producto
		mov AH, 09
		int 21
		mov DX, offset sub_prod
		mov AH, 09
		int 21
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;;; PEDIR CODIGO
pedir_de_nuevo_codigo:
		mov DX, offset prompt_code
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		;;; verificar que el tamaño del codigo no sea mayor a 5
		mov DI, offset buffer_entrada
		inc DI
		mov AL, [DI]
		cmp AL, 00
		je  pedir_de_nuevo_codigo
		cmp AL, 05
		jb  aceptar_tam_cod  ;; jb --> jump if below
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		jmp pedir_de_nuevo_codigo
		;;; mover al campo codigo en la estructura producto
aceptar_tam_cod:
		mov SI, offset cod_prod
		mov DI, offset buffer_entrada
		inc DI
		mov CH, 00
		mov CL, [DI]
		inc DI  ;; me posiciono en el contenido del buffer
copiar_codigo:	mov AL, [DI]
		mov [SI], AL
		inc SI
		inc DI
		loop copiar_codigo  ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
		;;; la cadena ingresada en la estructura
		;;;
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;;; PEDIR NOMBRE
pedir_de_nuevo_nombre:
		mov DX, offset prompt_name
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		;;; verificar que el tamaño del codigo no sea mayor a 5
		mov DI, offset buffer_entrada
		inc DI
		mov AL, [DI]
		cmp AL, 00
		je  pedir_de_nuevo_nombre
		cmp AL, 20
		jb  aceptar_tam_nom
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		jmp pedir_de_nuevo_nombre
		;;; mover al campo codigo en la estructura producto
aceptar_tam_nom:
		mov SI, offset cod_name
		mov DI, offset buffer_entrada
		inc DI
		mov CH, 00
		mov CL, [DI]
		inc DI  ;; me posiciono en el contenido del buffer
copiar_nombre:	
		mov AL, [DI]
		mov [SI], AL
		inc SI
		inc DI
		loop copiar_nombre  ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
		;;; la cadena ingresada en la estructura
		;;;
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;;
pedir_de_nuevo_precio:
		mov DX, offset prompt_price
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		;;; verificar que el tamaño del codigo no sea mayor a 5
		mov DI, offset buffer_entrada
		inc DI
		mov AL, [DI]
		cmp AL, 00
		je  pedir_de_nuevo_precio
		cmp AL, 06  ;; tamaño máximo del campo
		jb  aceptar_tam_precio ;; jb --> jump if below
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		jmp pedir_de_nuevo_precio
		;;; mover al campo codigo en la estructura producto
aceptar_tam_precio:
		mov SI, offset cod_price
		mov DI, offset buffer_entrada
		inc DI
		mov CH, 00
		mov CL, [DI]
		inc DI  ;; me posiciono en el contenido del buffer
copiar_precio:	mov AL, [DI]
		mov [SI], AL
		inc SI
		inc DI
		loop copiar_precio  ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
		;;
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;;
		mov DI, offset cod_price
		call cadenaAnum
		;; AX -> numero convertido
		mov [num_price], AX
		;;
		mov DI, offset cod_price
		mov CX, 0005
		call memset
		;;
pedir_de_nuevo_unidades:
		mov DX, offset prompt_units
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		;;; verificar que el tamaño del codigo no sea mayor a 5
		mov DI, offset buffer_entrada
		inc DI
		mov AL, [DI]
		cmp AL, 00
		je  pedir_de_nuevo_unidades
		cmp AL, 06  ;; tamaño máximo del campo
		jb  aceptar_tam_unidades ;; jb --> jump if below
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		jmp pedir_de_nuevo_unidades
		;;; mover al campo codigo en la estructura producto
aceptar_tam_unidades:
		mov SI, offset cod_units
		mov DI, offset buffer_entrada
		inc DI
		mov CH, 00
		mov CL, [DI]
		inc DI  ;; me posiciono en el contenido del buffer
copiar_unidades:
		mov AL, [DI]
		mov [SI], AL
		inc SI
		inc DI
		loop copiar_unidades  ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
		;;
		mov DI, offset cod_units
		call cadenaAnum
		;; AX -> numero convertido
		mov [num_units], AX
		;;
		mov DI, offset cod_units
		mov CX, 0005
		call memset
		;; finalizó pedir datos de producto
		;;
		;;
		;;
		;;
		;; GUARDAR EN ARCHIVO
		;; probar abrirlo normal
		mov AL, 02
		mov AH, 3d
		mov DX, offset archivo_prods
		int 21
		;; si no lo cremos
		jc  crear_archivo_prod
		;; si abre escribimos
		jmp guardar_handle_prod
crear_archivo_prod:
		mov CX, 0000
		mov DX, offset archivo_prods
		mov AH, 3c
		int 21
		;; archivo abierto
guardar_handle_prod:
		;; guardamos handle
		mov [handle_prods], AX
		;; obtener handle
		mov BX, [handle_prods]
		;; vamos al final del archivo
		mov CX, 00
		mov DX, 00
		mov AL, 02
		mov AH, 42
		int 21
		;; escribir el producto en el archivo
		;; escribí los dos primeros campos
		mov CX, 26
		mov DX, offset cod_prod
		mov AH, 40
		int 21
		;; escribo los otros dos
		mov CX, 0004
		mov DX, offset num_price
		mov AH, 40
		int 21
		;;limpiar
		mov DI, offset cod_prod
		mov CX, 0005
		call clean_mem_var
		mov DI, offset cod_name
		mov CX, 0021
		call clean_mem_var
		mov DI, offset cod_price
		mov CX, 0005
		call clean_mem_var
		mov DI, offset cod_units
		mov CX, 0005
		call clean_mem_var
		;; cerrar archivo
		mov AH, 3e
		int 21
		;;
		jmp menu_productos
mostrar_productos_archivo:
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;;
		mov AL, 02
		mov AH, 3d
		mov DX, offset archivo_prods
		int 21
		;;
		mov [handle_prods], AX
		;; leemos
ciclo_mostrar:
		;; puntero cierta posición
		mov BX, [handle_prods]
		mov CX, 0026     ;; leer 26h bytes
		mov DX, offset cod_prod
		;;
		mov AH, 3f
		int 21
		;; puntero avanzó
		mov BX, [handle_prods]
		mov CX, 0004
		mov DX, offset num_price
		mov AH, 3f
		int 21
		;; ¿cuántos bytes leímos?
		;; si se leyeron 0 bytes entonces se terminó el archivo...
		cmp AX, 0000
		je fin_mostrar
		;; ver si es producto válido
		mov AL, 00
		cmp [cod_prod], AL
		je ciclo_mostrar
		;; producto en estructura
		call imprimir_producto_new
		jmp ciclo_mostrar
		;;
fin_mostrar:
		jmp menu_productos
;;IMPRIMIR NUEVOS PRODS
; Salida: Impresion de estructura producto
imprimir_producto_new:
    mov DI, offset cod_prod
    
    ciclo_agregar_dolar_final_1:
        mov AL, [DI]
        cmp AL, 00
        je agregar_dolar_final_1
        inc DI
        jmp ciclo_agregar_dolar_final_1
    agregar_dolar_final_1:
        mov AL, 24
        mov [DI], AL

        mPrint prompt_code
        mPrint cod_prod
        mPrint nueva_lin
    
    mov DI, offset cod_name

    ciclo_agregar_dolar_final_2:
        mov AL, [DI]
        cmp AL, 00
        je agregar_dolar_final_2
        inc DI
        jmp ciclo_agregar_dolar_final_2
    agregar_dolar_final_2:
        mov AL, 24
        mov [DI], AL

        mPrint prompt_name
        mPrint cod_name
        mPrint nueva_lin

    ret
;;
eliminar_producto_archivo:
		mov DX, 0000
		mov [puntero_temp], DX
pedir_de_nuevo_codigo_borrar_producto:
		mov DX, offset prompt_code
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		;;
		mov DI, offset buffer_entrada
		inc DI
		mov AL, [DI]
		cmp AL, 00
		je  pedir_de_nuevo_codigo_borrar_producto
		cmp AL, 05
		jb  aceptar_tam_cod_borrar_producto  ;; jb --> jump if below
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		jmp pedir_de_nuevo_codigo_borrar_producto
		;;; mover al campo codigo en la estructura producto
aceptar_tam_cod_borrar_producto:
		mov SI, offset cod_prod_temp
		mov DI, offset buffer_entrada
		inc DI
		mov CH, 00
		mov CL, [DI]
		inc DI  ;; me posiciono en el contenido del buffer
copiar_codigo_borrar_producto:	mov AL, [DI]
		mov [SI], AL
		inc SI
		inc DI
		loop copiar_codigo_borrar_producto ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
		;;; la cadena ingresada en la estructura
		;;;
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;;
		mov AL, 02              ;;;<<<<<  lectura/escritura
		mov DX, offset archivo_prods
		mov AH, 3d
		int 21
		mov [handle_prods], AX
		;;; TODO: revisar si existe
ciclo_encontrar:
		int 03
		mov BX, [handle_prods]
		mov CX, 26
		mov DX, offset cod_prod
		moV AH, 3f
		int 21
		mov BX, [handle_prods]
		mov CX, 4
		mov DX, offset num_price
		moV AH, 3f
		int 21
		cmp AX, 0000   ;; se acaba cuando el archivo se termina
		je finalizar_borrar
		mov DX, [puntero_temp]
		add DX, 2a
		mov [puntero_temp], DX
		;;; verificar si es producto válido
		mov AL, 00
		cmp [cod_prod], AL
		je ciclo_encontrar
		;;; verificar el código
		mov SI, offset cod_prod_temp
		mov DI, offset cod_prod
		mov CX, 0005
		call cadenas_iguales
		;;;; <<
		cmp DL, 0ff
		je borrar_encontrado
		jmp ciclo_encontrar
borrar_encontrado:
		mov DX, [puntero_temp]
		sub DX, 2a
		mov CX, 0000
		mov BX, [handle_prods]
		mov AL, 00
		mov AH, 42
		int 21
		;;; puntero posicionado
		mov CX, 2a
		mov DX, offset ceros
		mov AH, 40
		int 21
finalizar_borrar:
		mov BX, [handle_prods]
		mov AH, 3e
		int 21
		jmp menu_productos
```
Muestra el título del producto en pantalla utilizando la función de servicio de DOS INT 21h con la función 09h.
Pide al usuario que ingrese el código del producto y lo almacena en el buffer de entrada.
Verifica que el tamaño del código no sea mayor a 5 caracteres.
Si el tamaño del código es mayor a 5 caracteres, muestra un mensaje de nueva línea y vuelve al paso 2 para pedir el código nuevamente.
Si el tamaño del código es válido, copia el código del buffer de entrada al campo de código en la estructura del producto.
Pide al usuario que ingrese el nombre del producto y lo almacena en el buffer de entrada.
Verifica que el tamaño del nombre no sea mayor a 20 caracteres.
Si el tamaño del nombre es mayor a 20 caracteres, muestra un mensaje de nueva línea y vuelve al paso 6 para pedir el nombre nuevamente.
Si el tamaño del nombre es válido, copia el nombre del buffer de entrada al campo de nombre en la estructura del producto.
Pide al usuario que ingrese el precio del producto y lo almacena en el buffer de entrada.
Verifica que el tamaño del precio no sea mayor a 6 caracteres.
Si el tamaño del precio es mayor a 6 caracteres, muestra un mensaje de nueva línea y vuelve al paso 10 para pedir el precio nuevamente.
Si el tamaño del precio es válido, copia el precio del buffer de entrada al campo de precio en la estructura del producto.
Convierte el precio de cadena de caracteres a un número entero utilizando la función cadenaAnum.
Limpia el campo de precio en la estructura del producto y lo guarda como un número entero en la variable num_price.
Pide al usuario que ingrese la cantidad de unidades del producto y lo almacena en el buffer de entrada.
Verifica que el tamaño de las unidades no sea mayor a 6 caracteres.
Si el tamaño de las unidades es mayor a 6 caracteres, muestra un mensaje de nueva línea y vuelve al paso 16 para pedir las unidades nuevamente.
Si el tamaño de las unidades es válido, copia las unidades del buffer de entrada al campo de unidades en la estructura del producto.
Convierte las unidades de cadena de caracteres a un número entero utilizando la función cadenaAnum.
Limpia el campo de unidades en la estructura del producto y lo guarda como un número entero en la variable num_units.
Guarda el producto en un archivo utilizando la función de servicio de DOS INT 21h con la función 3Dh para abrir el archivo en modo de escritura.
Si el archivo existe, se salta a la etiqueta guardar_handle_prod. De lo contrario, se crea el archivo utilizando la función 3Ch de INT 21h.
Guarda el handle del archivo abierto en la variable handle_prods.
Se mueve al final del archivo utilizando la función INT 21h con la función 42h para establecer el puntero de archivo al final.
Escribe los campos de código y precio del producto en el archivo utilizando la función `INT.
Generación de HTML
Se usó la misma lógica para recorrer los archivos BIN con punteros para poder ir escribiendo un archivo nuevo.
#Algunos Registros utilizados
| Nombre       | Descripción                                                                                                     |
|--------------|-----------------------------------------------------------------------------------------------------------------|
| CF           | Carry Flag: Indica si hubo un acarreo o préstamo en una operación aritmética o lógica.                           |
| ZF           | Zero Flag: Indica si el resultado de una operación aritmética o lógica es cero.                                   |
| SF           | Sign Flag: Indica el signo del resultado de una operación aritmética o lógica.                                    |
| AH           | Registro AH: Parte alta del registro AX.                                                                        |
| AL           | Registro AL: Parte baja del registro AX.                                                                        |
| AX           | Registro AX: Registro de propósito general de 16 bits.                                                          |
| BX           | Registro BX: Registro de propósito general de 16 bits.                                                          |
| CX           | Registro CX: Registro de propósito general de 16 bits.                                                          |
| DX           | Registro DX: Registro de propósito general de 16 bits.                                                          |
| DS           | Registro DS: Segmento de datos utilizado para acceder a los datos en memoria.                                    |
| ES           | Registro ES: Segmento extra utilizado para acceder a los datos en memoria.                                      |
| INT 21h      | Interrupción 21h: Servicio de interrupción de DOS utilizado para invocar funciones del sistema operativo.        |
| INT 10h      | Interrupción 10h: Servicio de interrupción de video utilizado para realizar operaciones relacionadas con la pantalla. |
| cadenaAnum   | Función que convierte una cadena de caracteres en un número entero.                                              |
| 09h          | Función del servicio de DOS para mostrar una cadena en pantalla.                                                 |
| 3Dh          | Función del servicio de DOS para abrir un archivo en modo de escritura.                                          |
| 3Ch          | Función del servicio de DOS para crear un archivo.                                                               |
| 42h          | Función del servicio de DOS para mover el puntero de archivo al final.                                           |
