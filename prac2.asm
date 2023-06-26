include macros.asm
.MODEL SMALL
.RADIX 16
.STACK
;; PILA
.DATA
;;
nombre_conf db "PRAII.CON",00
clave_capturada        db     09  dup (0)
usuario_capturado      db     08  dup (0)
espacio_leido          db     00
estado                 db     00
buffer_linea           db     0ff dup (0)
tam_liena_leida        db     00
handle_conf            dw     0000
separador db "------------------------------------",0a,"$"
fin_ejecucion_programa db " Credenciales erroneas, fin de ejecucion del programa",0a,"$"
usuario db "mnoguera","$"
clave db "202101149","$"
;;VARS HTMl
;;VARIABLES DE TAMAÑO HTML 
sz_header		db 	1b 
tit_cat_sz	db	17 
style_tb_sz	db	38 
style_th_sz		db	40 
close_sty_sz		db	8  
close_head_sz			db	7  
body_cat_sz	db  21 
tam_fecha_html			db	0a  
tam_hora_html			db	8  
close_p_sz			db  4  
op_table_sz		db  7  
close_tb_sz		db 	8  
open_tr_sz			db  4  
tit_ht_sz		db  3e  
close_tr_sz			db	5	
open_td_sz			db	4  
close_td_sz			db	5	
close_body_sz			db	7  
close_html_sz			db	7  
tit_af_sz	db  27 
body_rep_af_sz  db  2e 

;;VARIABLES DE ESTRUCTURA HTML
encabezado_html        	db	"<!DOCTYPE html><html><head>" 
tit_Catalogo_html 		db	"<title>Reporte</title>"	
style_Table_html		db	"<style>table { width: 100%; border-collapse: collapse; }" 
style_Th_html			db  "th, td {border: 3px solid blue; padding: 8px; text-align: left;}";;
cierre_style           	db  "</style>"
cierre_head            	db  "</head>"
body_Catalogo_html     db  "<body><h1>Catalogo Productos</h1>"
fecha_html				db	"<p>Fecha: "
hora_html 				db	"<p>Hora:"
cierre_p				db	"</p>"
apertura_table			db 	"<table>"
cierre_table			db	"</table>"
apertura_tr				db	"<tr>"
titulos_html			db	"<th>Código</th><th>Descripcion</th><th>Precio</th><th>Unidades"
cierre_tr				db	"</tr>"
apertura_td				db	"<td>"
cierre_td				db	"</td>"
cierre_body				db	"</body>"
cierre_html				db	"</html>"
cierre_th				db  "</th>"
;;

ceros          db     2b  dup (0)
;; VARIABLES | MEMORIA RAM
numero           db   05 dup (30)
;;
MensajeInicial db "Universidad de San Carlos de Guatemala",0a,"Facultad de Ingenieria",0a,"Arquitectura de Computadoras y Ensambladores 1",0a,"Nombre: Mariano Rac",0a,"Carnet: 202101149",0a,"$" 
products  db    "(P)roductos",0a,"$"
ventas     db    "(V)entas",0a,"$"
herramientas db  "(H)erramientas",0a,"$"
titulo_producto db  "PRODUCTOS",0a,"$"
sub_prod        db  "=========",0a,"$"
titulo_ventas   db  "VENTAS",0a,"$"
sub_vent        db  "======",0a,"$"
titulo_herras   db  "HERRAMIENTAS",0a,"$"
sub_herr        db  "============",0a,"$"
prompt     db    "Elija una opcion:",0a,"$"
prompt_code      db    "Codigo: ","$"
prompt_name      db    "Nombre: ","$"
prompt_price     db    "Precio: ","$"
prompt_units     db    "Unidades: ","$"
temp       db    00,"$"
nueva_lin  db    0a,"$"
numeroA    db    0ff
numeroB    db    50
numeros    db    20, 12, 24
buffer_entrada   db  20, 00
                 db  20 dup (0)
mostrar_prod     db  "(M)ostrar productos",0a,"$"
ingresar_prod    db  "(I)ngresar producto",0a,"$"
editar_prod      db  "(E)ditar producto",0a,"$"
borrar_prod      db  "(B)orrar producto",0a,"$"
prompt_generar_cat db	"Generar (C)atalogo",0a,"$"
regresar      db  "(R)egresar",0a,"$"
prods_registrados db "Productos registrados:",0a,"$"
prompt_ventas_codigo db "Ingrese codigo de producto a comprar: ","$"
prompt_ventas_unidades db "Ingrese unidades a comprar: ","$"
prompt_ingresar_venta db "(I)ngresar venta",0a,"$"
msgSinExistencias db "No hay existencias de este producto",0a,"$"
prompt_fin db "fin",0a,"$"
;;; temps
cod_prod_temp    db    05 dup (0)
puntero_temp     dw    0000
;; "ESTRUCTURA PRODUCTO"
cod_prod    db    05 dup (0)
cod_name    db    21 dup (0)
cod_price   db    05 dup (0)
cod_units   db    05 dup (0)
; ;; "ESTRUCTURA VENTA"
diaVenta        db 01 dup (0)
mesVenta        db 01 dup (0)
anioVenta       dw 00
horaVenta       db 01 dup (0)
minutoVenta     db 01 dup (0)

codigoVenta             db 05 dup (0)
descripcionVenta        db 21 dup (0)
numeroPrecioVenta       dw 0000
numeroCantidadVenta     dw 0000

codigoVentaTemporal     db 05 dup (0)
unidadesVenta           db 05 dup (0)    

numeroUnidadesVenta   dw 0000
numeroMonto           dw 0000
numeroMontoTotal      dw 0000

contadorItemsVenta  db 0
separadorVentas     db "$"
finalizarVenta      db "fin"
;; numéricos
num_price   dw    0000
num_units   dw    0000
;; archivo productos
archivo_prods    db   "PROD.BIN",00
handle_prods     dw   0000
;; archivo productos
archivoVentas    db   "VENT.BIN",00
handleVentas     dw   0000
;;
nombre_rep1      db   "CATALG.HTM",00
handle_reps      dw   0000
;; tokens
tk_creds               db     0e, "[credenciales]"
tk_nombre              db     07, "usuario"
tk_clave               db     05, "clave"
tk_igual               db     01, "="
tk_comillas            db     01, '"'
;;

;;
.CODE
.STARTUP
;; CODIGO
inicio:
		mPrint nueva_lin
		mPrint MensajeInicial
		mprint nueva_lin
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

menu_principal:
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		;; Menú
		mov DX, offset products
		mov AH, 09
		int 21
		mov DX, offset ventas
		mov AH, 09
		int 21
		mov DX, offset herramientas
		mov AH, 09
		int 21
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		mov DX, offset prompt
		mov AH, 09
		int 21
		;; LEER 1 caracter
		mov AH, 08
		int 21
		;; AL = CARACTER LEIDO
		cmp AL, 70 ;; p minúscula ascii
		je menu_productos
		cmp AL, 76 ;; v minúscula ascii
		je menu_ventas 
		cmp AL, 68 ;; h minúscula ascii
		je menu_herramientas
		; je generar_catalogo 
		jmp menu_principal
menu_productos:
		mov DX, offset nueva_lin
		mov AH, 09
		int 21
		mov DX, offset mostrar_prod
		mov AH, 09
		int 21
		mov DX, offset ingresar_prod
		mov AH, 09
		int 21
		; mov DX, offset editar_prod
		; mov AH, 09
		; int 21
		mov DX, offset borrar_prod
		mov AH, 09
		int 21
		mov DX, offset regresar
		mov AH, 09
		int 21
		mov AH, 08
		int 21
		;;
		mov DX, offset prompt
		mov AH, 09
		int 21
		;; AL = CARACTER LEIDO
		cmp AL, 62 ;; borrar
		je eliminar_producto_archivo
		cmp AL, 69 ;; insertar
		je ingresar_producto_archivo
		cmp AL, 6d ;; mostrar
		je mostrar_productos_archivo
		; je imprimir_producto_new
		cmp AL, 72 ;; regresar
		je menu_principal
		jmp menu_productos
		;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;VENTAAAAAS
menu_ventas:
		mov DX, offset titulo_ventas
		mov AH, 09
		int 21
		mov DX, offset sub_vent
		mov AH, 09
		int 21
		mov DX, offset regresar
		mov AH, 09
		int 21
		mov DX, offset prompt_ingresar_venta
		mov AH, 09
		int 21
		mov DX, offset prompt
		mov AH, 09
		int 21
		mov AH, 08
		int 21
		cmp AL, 72 ;; regresar
		je menu_principal
		cmp AL, 69 ;; insertar venta
		je ingresar_venta
		
ingresar_venta:
    mPrint nueva_lin
    mPrint separador
    mPrint nueva_lin

    ; Reestablecer el contador de items en 1.
    mov dl, 0001
    mov [contadorItemsVenta], dl

    ; Reestablecer el contador de monto total en 0.
    mov dx, 0000
    mov [numeroMontoTotal], dx

    obtener_fecha:
        ; Obtener la fecha actual
        mov ah, 2ah
        int 21h

        ; Guardar la fecha
        mov [diaVenta], dl
        mov [mesVenta], dh
        mov [anioVenta], cx

    obtener_hora:
        ; Obtener la hora actual
        mov ah, 2ch
        int 21h

        ; Guardar la hora actual
        mov [horaVenta], ch
        mov [minutoVenta], cl

    abrir_archivo_ventas:
        ; Intentar abrir el archivo de ventas
        mov al, 02
        mov ah, 3d
        mov dx, offset archivoVentas
        int 21

        ; Si no existe, crearlo
        jc  crear_archivo_ventas

        ; Si existe, guardar el handle
        jmp guardar_handle_ventas

    crear_archivo_ventas:
        ; Crear el archivo de ventas
        mov cx, 0000
        mov dx, offset archivoVentas
        mov ah, 3ch
        int 21h
    
    guardar_handle_ventas:
        ; Guardar el handle del archivo
        mov [handleVentas], ax
        mov bx, [handleVentas]

        ; Mover el puntero del archivo al final
        mov cx, 0000
        mov dx, 0000
        mov al, 02h
        mov ah, 42h
        int 21h

    escribir_fecha_hora:
        ; Escribir la fecha y hora en el archivo
        mov cx, 06h
        mov dx, offset diaVenta
        mov ah, 40
        int 21h

        jmp leer_codigo_venta

    solicitar_item:
        ; Reiniciar puntero temporal
        mov dx, 0000
        mov [puntero_temp], dx

        mPrint nueva_lin
        
        leer_codigo_venta:
            mPrint nueva_lin
            mPrint prompt_code

            mov dx, offset buffer_entrada
            mov ah, 0ah
            int 21h

            ; Verificar longitud del codigo (maximo 4 caracteres y minimo 1 caracter)
            mov di, offset buffer_entrada
            inc di
            mov al, [di]
            cmp al, 00
            je leer_codigo_venta
            cmp al, 04h
            ja leer_codigo_venta

            ; Verificar si es 'fin'
            mov si, offset finalizarVenta
            mov di, offset buffer_entrada
            inc di ; Saltar el primer byte
            mov cl, [di]
            inc di ; Saltar el segundo byte
            call cadenas_iguales
            cmp dl, 0ff
            je finalizar_venta

            ; Guardar el codigo del producto
            mov si, offset codigoVentaTemporal
            mov di, offset buffer_entrada
            inc di ; Saltar el primer byte
            mov ch, 00
            mov cl, [di] ; Cantidad de bytes leidos
            inc di ; Saltar el segundo byte: Bytes leidos
            call copiar_variable

            ; Abrir el archivo de productos
            mov al, 02              
            mov dx, offset archivo_prods
            mov ah, 3d
            int 21

            ; Si no existe
            jc menu_ventas

            ; Guardar el handle del archivo
            mov [handle_prods], ax

        ciclo_encontrar_producto_venta:
            ; Puntero en el código del producto
            mov bx, [handle_prods]
            mov cx, 26h
            mov dx, offset codigoVenta
            mov ah, 3f
            int 21h

            ; Puntero en el precio del producto
            mov bx, [handle_prods]
            mov cx, 04h
            mov dx, offset numeroPrecioVenta
            mov ah, 3f
            int 21h

            ; Determinar si se terminó el archivo
            cmp ax, 0000
            je finalizar_venta

            ; Verificar si es un producto válido
            mov al, 00
            cmp [codigoVenta], al
            je ciclo_encontrar_producto_venta

            ; Verificar el codigo con el codigo solicitado
            mov si, offset codigoVentaTemporal
            mov di, offset codigoVenta
            mov cx, 0005
            call cadenas_iguales
            cmp dl, 0ff

            ; Si son iguales, continuar
            je verificar_stock

            ; Si no son iguales, buscar el siguiente producto
            jmp ciclo_encontrar_producto_venta

        verificar_stock:
            mov ax, [numeroCantidadVenta]
            cmp ax, 0000
            jne leer_unidades_venta
            
            mPrint nueva_lin
            mPrint msgSinExistencias
            mPrint nueva_lin
            jmp solicitar_item

        leer_unidades_venta:
            mPrint nueva_lin
            mPrint prompt_units

            ; Leer las unidades del producto
            mov dx, offset buffer_entrada
            mov ah, 0a
            int 21h

            ; Verificar longitud de las unidades (maximo 5 caracteres y minimo 1 caracter)
            mov di, offset buffer_entrada
            inc di
            mov al, [di]
            cmp al, 00
            je leer_unidades_venta
            cmp al, 05h
            ja leer_unidades_venta

            ; Guardar las unidades del producto
            mov si, offset unidadesVenta
            mov di, offset buffer_entrada
            inc di ; Saltar el primer byte
            mov ch, 00
            mov cl, [di] ; Cantidad de bytes leidos
            inc di ; Saltar el segundo byte: Bytes leidos
            call copiar_variable

            ; Convertir el precio a numero
            mov di, offset unidadesVenta
            call cadenaAnum
            mov [numeroUnidadesVenta], ax

            ; Limpiar la variable unidadesProducto
            mov di, offset unidadesVenta
            mov cx, 0005
            call memset

    verificar_existencias_disponibles:
        mov ax, [numeroCantidadVenta]
        cmp ax, [numeroUnidadesVenta]
        jl sin_existencias_disponibles
        jmp ubicar_producto
    
    sin_existencias_disponibles:
        mPrint nueva_lin
        mPrint msgSinExistencias
        mPrint nueva_lin
        jmp solicitar_item

    ubicar_producto:
        mov al, 02
        mov dx, offset archivo_prods
        mov ah, 3dh
        int 21h
        mov [handle_prods], ax

    ciclo_ubicar_producto:
        mov bx, [handle_prods]
        mov cx, 26h
        mov dx, offset codigoVenta
        mov ah, 3f
        int 21h

        ; Puntero en el precio del producto
        mov bx, [handle_prods]
        mov cx, 04h
        mov dx, offset numeroPrecioVenta
        mov ah, 3f
        int 21h

        ; Determinar si se terminó el archivo
        cmp ax, 0000
        je finalizar_venta

        ; Operaciones de puntero
        mov dx, [puntero_temp]
        add dx, 2ah
        mov [puntero_temp], dx

        ; Verificar si es un producto válido
        mov al, 00
        cmp [codigoVenta], al
        je ciclo_ubicar_producto

        ; Verificar el codigo con el codigo solicitado
        mov si, offset codigoVentaTemporal
        mov di, offset codigoVenta
        mov cx, 0005
        call cadenas_iguales
        cmp dl, 0ff

        je restar_existencias_producto
        jmp ciclo_ubicar_producto
    
    restar_existencias_producto:
        ; Posicionar puntero para el offset de la interrupcion
        mov dx, [puntero_temp]
        sub dx, 2ah
        mov cx, 0000
        
        ; Mover el puntero
        mov bx, [handle_prods]
        mov al, 00
        mov ah, 42h
        int 21h

        ; Restar las unidades vendidas
        mov ax, [numeroCantidadVenta]
        sub ax, [numeroUnidadesVenta]
        mov [numeroCantidadVenta], ax

        ; Escribir el nuevo contenido con las unidades restadas
        mov cx, 2ah
        mov dx, offset codigoVenta
        mov ah, 40h
        int 21h

        ; Cerrar el archivo para guardar cambios
        mov bx, [handle_prods]
        mov ah, 3eh
        int 21h

    calcular_nuevo_monto:
        ; Multiplicacion
        mov ax, [numeroPrecioVenta]
        mul numeroUnidadesVenta         ; ax = ax * numeroUnidadesVenta
        mov [numeroMonto], ax

        ; Suma a monto total
        mPrint nueva_lin
        
        mov di, [numeroMonto]
        add [numeroMontoTotal], di

        mov ax, [numeroMontoTotal]
        call numAcadena
        
        ; Imprimir en consola el monto total actual
        mPrint nueva_lin
        mov bx, 0001
        mov cx, 0005
        mov dx, offset numAcadena
        mov ah, 40h
        int 21h
        mPrint nueva_lin

        jmp escribir_nuevo_item

    escribir_nuevo_item:
        ; 1. Escribir el codigo del producto
        mov bx, [handleVentas]
        mov cx, 0005
        mov dx, offset codigoVenta
        mov ah, 40h
        int 21h

        ; 2. Escribir las unidades del producto (Es un numero)
        mov bx, [handleVentas]
        mov cx, 0002
        mov dx, offset numeroUnidadesVenta
        mov ah, 40h
        int 21h
        
        ; Limpiar la variable codigoVenta y descripcionVenta
        mov di, offset codigoVenta
        mov cx, 0026h
        call memset

        ; Limpiar la variable unidadesVenta
        mov di, offset unidadesVenta
        mov cx, 0005
        call memset

        ; Limpiar la variable numeroUnidadesVenta
        mov dx, 0000
        mov [numeroUnidadesVenta], dx

        ; Limpiar la variable numeroMonto
        mov dx, 0000
        mov [numeroMonto], dx

        ; Incrementar y comparar el numero de items agregados actualmente
        ; Maximo de 10 items por venta
        
        mPrint nueva_lin
        mPrint nueva_lin
        
        mov dl, contadorItemsVenta
        cmp dl, 000ah
        je finalizar_venta

        inc dl
        mov [contadorItemsVenta], dl
        jmp solicitar_item

    finalizar_venta:
        ; Cerrar el archivo de productos
        mov bx, [handle_prods]
        mov ah, 3eh
        int 21h

        ; Escribir el monto total de la venta
        mov bx, [handleVentas]
        mov cx, 0002
        mov dx, offset numeroMontoTotal
        mov ah, 40h
        int 21h

        ; Escribir el separador de ventas
        mov bx, [handleVentas]
        mov cx, 0001
        mov dx, offset separadorVentas
        mov ah, 40h
        int 21h

        ; Cerrar el archivo de ventas
        mov bx, [handleVentas]
        mov ah, 3eh
        int 21h

    mPrint nueva_lin
    mPrint separador
    mPrint nueva_lin
    jmp menu_ventas


;;
;;;VENTAAAAS
menu_herramientas:
		mov DX, offset titulo_herras
		mov AH, 09
		int 21
		mov DX, offset sub_vent
		mov AH, 09
		int 21
		mov DX, offset regresar
		mov AH, 09
		int 21
		mov DX, offset prompt_generar_cat
		mov AH, 09
		int 21
		mov DX, offset prompt
		mov AH, 09
		int 21
		mov AH, 08
		int 21
		cmp AL, 72 ;; regresar
		je menu_principal
		cmp AL, 63 ;; Generar catálogo
		je generar_catalogo_completo
		jmp fin
;;CATALOGO

generar_catalogo_completo:
	;;interrumpcion create a file with a handle 
	mov AH, 3c
	mov CX, 0000
	mov DX, offset nombre_rep1
	int 21
	;; el file handle se almacena en Ax 
	mov [handle_reps], AX

	;;<!DOCTYPE html><html><head>" 
	mov BX, AX  ;; bx es el handle 
	mov AH, 40
	mov CH, 00 ;; limpio CH 
	mov CL, [sz_header]
	mov DX, offset encabezado_html
	int 21

	;; <title>Catalogo</title>"
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [tit_cat_sz]
	mov DX, offset tit_Catalogo_html
	int 21

	;;<style>table { width: 100%; border-collapse: collapse; }" 
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [style_tb_sz]
	mov DX, offset style_Table_html
	int 21

	;;"th, td {border: 1px solid black; padding: 8px; text-align: left;} </style>"
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [style_th_sz]
	mov DX, offset style_Th_html
	int 21

	;;cierre_style
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_sty_sz]
	mov DX, offset cierre_style
	int 21

	;;"</head>"
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_head_sz]
	mov DX, offset cierre_head
	int 21

	;; "<body><h1>Catalogo Completo de Productos</h1>"
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [body_cat_sz]
	mov DX, offset body_Catalogo_html
	int 21

	;;abriendo <table>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [op_table_sz]
	mov DX, offset apertura_table
	int 21

	;; <tr> 
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [open_tr_sz]
	mov DX, offset apertura_tr
	int 21

	;; "<th>Descripción</th> <th>Código</th> <th>Precio</th> <th>Unidades"
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [tit_ht_sz]
	mov DX, offset titulos_html
	int 21

	;;</th>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, 05
	mov DX, offset cierre_th
	int 21

	;; </tr> 
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_tr_sz]
	mov DX, offset cierre_tr
	int 21
	
	;; OPEN DISK FILE WITH HANDLE 
	mov AH, 3d
	mov AL, 02
	mov DX, offset archivo_prods
	int 21

	mov [handle_prods], AX

ciclo_mostrar_catalogo:
	;; READ FROM FILE WITH HANDLE
	mov BX, [handle_prods]
	mov CX, 26     ;; leer 26h bytes
	mov DX, offset cod_prod
	mov AH, 3f
	int 21
	;; puntero avanzó
	mov BX, [handle_prods]
	mov CX, 0004
	mov DX, offset num_price
	mov AH, 3f
	int 21

	;; verificar que no sea nulo, si es termina 
	cmp AX, 00
	je fin_mostrar_catalogo

	;; ver si es producto válido
	mov AL, 00
	cmp [cod_prod], AL
	je ciclo_mostrar_catalogo

	;; llamar a la sub-rutina 
	call imprimir_estructura_html

	jmp ciclo_mostrar_catalogo
	

fin_mostrar_catalogo:
	;; </table>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_tb_sz]
	mov DX, offset cierre_table
	int 21
	;; </body>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_body_sz]
	mov DX, offset cierre_body
	int 21
	;; </html>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_html_sz]
	mov DX, offset cierre_html
	int 21

	;; CLOSE A FILE WITH HANDLE
	mov AH, 3e
	int 21

	jmp menu_herramientas

imprimir_estructura_html:
	;; <tr> 
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [open_tr_sz]
	mov DX, offset apertura_tr
	int 21

	;; <td> 
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [open_td_sz]
	mov DX, offset apertura_td
	int 21

	;;dx toma el valor del codigo 
	mov DX, offset cod_prod
	;;contador que inicia en 0 
	mov SI, 0000

ciclo_escribir_codigo:
	mov DI, DX
	mov AL, [DI]
	;;valida si no es nulo, si lo es se va a 
	cmp AL, 00
	je escribir_descripcion
	;;valida que la cadena se encuentra llena 
	cmp SI, 0006
	je escribir_descripcion

	;;write to file with handle ---> escribir 
	mov CX, 0001
	mov BX, [handle_reps]
	mov AH, 40
	int 21

	inc DX  
	inc SI  

	jmp ciclo_escribir_codigo

escribir_descripcion:
	;; </td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_td_sz]
	mov DX, offset cierre_td
	int 21
	;; <td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [open_td_sz]
	mov DX, offset apertura_td
	int 21

	;; dx toma el valor de la descripcion 
	mov DX, offset cod_name
	mov SI, 0000

ciclo_escribir_descripcion:
	mov DI, DX
	mov AL, [DI]
	;;valida si no es nulo, si lo es se va a 
	cmp AL, 00
	je escribir_precio
	;;valida que la cadena se encuentra llena 
	cmp SI, 0021
	je escribir_precio

	;;write to file with handle
	mov CX, 0001
	mov BX, [handle_reps]
	mov AH, 40
	int 21

	inc DX  
	inc SI  
	jmp ciclo_escribir_descripcion

escribir_precio:
	;; </td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_td_sz]
	mov DX, offset cierre_td
	int 21
	;; <td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [open_td_sz]
	mov DX, offset apertura_td
	int 21
	;; dx toma el valor de precio
	mov AX, [num_price]
	call numAcadena

	mov DX, offset numero
	mov SI, 0000

ciclo_escribir_precio: 
	mov DI, DX
	mov AL, [DI]
	;;valida si no es nulo, si lo es se va a 
	cmp AL, 00
	je escribir_unidades
	;;valida que la cadena se encuentra llena 
	cmp SI, 0006
	je escribir_unidades

	;;write to file with handle 
	mov CX, 0001
	mov BX, [handle_reps]
	mov AH, 40
	int 21

	inc DX  
	inc SI  
	jmp ciclo_escribir_precio

escribir_unidades:
	;; </td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_td_sz]
	mov DX, offset cierre_td
	int 21
	;; <td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [open_td_sz]
	mov DX, offset apertura_td
	int 21
	;; dx toma el valor de unidades
	mov AX, [num_units]
	call numAcadena
	mov DX, offset numero
	mov SI, 0000

ciclo_escribir_unidades:
	mov DI, DX
	mov AL, [DI]
	;;valida si no es nulo, si lo es se va a 
	cmp AL, 00
	je cerrar_table
	;;valida que la cadena se encuentra llena 
	cmp SI, 0006
	je cerrar_table

	;;write to file with handle ---> esceribir 
	mov CX, 0001
	mov BX, [handle_reps]
	mov AH, 40
	int 21

	inc DX  
	inc SI  
	jmp ciclo_escribir_unidades

cerrar_table:
	;; </td>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_td_sz]
	mov DX, offset cierre_td
	int 21
	;; </tr>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_tr_sz]
	mov DX, offset cierre_tr
	int 21

	;;llamada de sub-rutina para hora 
	;;call retornar_fecha_hora

    ; mov dx, offset dia
	; mov ah, 9
    ; int 21h

	ret

;;
;;
;;REPORTE EXISTENCIAS


;;

;;

;; cadenaAnum
;; ENTRADA:
;;    DI -> dirección a una cadena numérica
;; SALIDA:
;;    AX -> número convertido
;
;
;
;;[31][32][33][00][00]
;;     ^
;;     |
;;     ----- DI
;;;;
;;AX = 0
;;10 * AX + *1*  = 1
;;;;
;;AX = 1
;;10 * AX + 2  = 12
;;;;
;;AX = 12
;;10 * AX + 3  = 123
;;;;
cadenaAnum:
		mov AX, 0000    ; inicializar la salida
		mov CX, 0005    ; inicializar contador
		;;
seguir_convirtiendo:
		mov BL, [DI]
		cmp BL, 00
		je retorno_cadenaAnum
		sub BL, 30      ; BL es el valor numérico del caracter
		mov DX, 000a
		mul DX          ; AX * DX -> DX:AX
		mov BH, 00
		add AX, BX 
		inc DI          ; puntero en la cadena
		loop seguir_convirtiendo
retorno_cadenaAnum:
		ret

;; numAcadena
;; ENTRADA:
;;     AX -> número a convertir    
;; SALIDA:
;;    [numero] -> numero convertido en cadena
;;AX = 1500
;;CX = AX  <<<<<<<<<<<
;;[31][30][30][30][30]
;;                  ^
numAcadena:
		mov CX, 0005
		mov DI, offset numero
ciclo_poner30s:
		mov BL, 30
		mov [DI], BL
		inc DI
		loop ciclo_poner30s
		;; tenemos '0' en toda la cadena
		mov CX, AX    ; inicializar contador
		mov DI, offset numero
		add DI, 0004
		;;
ciclo_convertirAcadena:
		mov BL, [DI]
		inc BL
		mov [DI], BL
		cmp BL, 3a
		je aumentar_siguiente_digito_primera_vez
		loop ciclo_convertirAcadena
		jmp retorno_convertirAcadena
aumentar_siguiente_digito_primera_vez:
		push DI
aumentar_siguiente_digito:
		mov BL, 30     ; poner en '0' el actual
		mov [DI], BL
		dec DI         ; puntero a la cadena
		mov BL, [DI]
		inc BL
		mov [DI], BL
		cmp BL, 3a
		je aumentar_siguiente_digito
		pop DI         ; se recupera DI
		loop ciclo_convertirAcadena
retorno_convertirAcadena:
		ret

;; memset
;; ENTRADA:
;;    DI -> dirección de la cadena
;;    CX -> tamaño de la cadena
memset:
ciclo_memset:
		mov AL, 00
		mov [DI], AL
		inc DI
		loop ciclo_memset
		ret

;; cadenas_iguales -
;; ENTRADA:
;;    SI -> dirección a cadena 1
;;    DI -> dirección a cadena 2
;;    CX -> tamaño máximo
;; SALIDA:
;;    DL -> 00 si no son iguales

;;         0ff si si lo son
cadenas_iguales:
ciclo_cadenas_iguales:
		mov AL, [SI]
		cmp [DI], AL
		jne no_son_iguales
		inc DI
		inc SI
		loop ciclo_cadenas_iguales
		;;;;; <<<
		mov DL, 0ff
		ret
no_son_iguales:	mov DL, 00
		ret
clean_mem_var:
	ciclo_clean_var:
		mov AL, 00
		mov [DI], AL
		inc DI
		loop ciclo_clean_var
	ret
copiar_variable:
	mov AL, [DI]
	mov [SI], AL
	inc SI
	inc DI
	loop copiar_variable
	ret
validar_acceso:
		;; abrir archivo de configuración
		mov AH, 3d
		mov AL, 00
		mov DX, offset nombre_conf
		int 21
		mov [handle_conf], AX
		;; analizarlo
ciclo_lineaXlinea:
		mov DI, offset buffer_linea
		mov AL, 00
		mov [tam_liena_leida], AL
ciclo_obtener_linea:
		mov AH, 3f
		mov BX, [handle_conf]
		mov CX, 0001
		mov DX, DI
		int 21
		cmp CX, 0000
		je fin_leer_linea
		mov AL, [DI]
		cmp AL, 0a
		je fin_leer_linea
		mov AL, [tam_liena_leida]
		inc AL
		mov [tam_liena_leida], AL
		inc DI
		jmp ciclo_obtener_linea
fin_leer_linea:
		mov AL, [tam_liena_leida]
		mov AL, 00
		cmp [estado], AL   ;; verificar la cadena credenciales
		je verificar_cadena_credenciales
		mov AL, 01
		cmp [estado], AL   ;; obtener campo
		je obtener_campo_conf
		mov AL, 02
		cmp [estado], AL   ;; obtener campo
		je obtener_campo_conf
		jmp retorno_exitoso
verificar_cadena_credenciales:
		cmp CX, 0000
		je retorno_fallido
		mov CH, 00
		mov CL, [tk_creds]
		mov SI, offset tk_creds
		inc SI
		mov DI, offset buffer_linea
		call cadenas_iguales
		cmp DL, 0ff
		je si_hay_creds
		jmp retorno_fallido
si_hay_creds:
		mov AL, [estado]
		inc AL
		mov [estado], AL
		jmp ciclo_lineaXlinea
		;;
obtener_campo_conf:
		cmp CX, 0000
		je retorno_fallido
		mov CH, 00
		mov CL, [tk_nombre]
		mov SI, offset tk_nombre
		inc SI
		mov DI, offset buffer_linea
		call cadenas_iguales
		cmp DL, 0ff
		je obtener_valor_usuario
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov CH, 00
		mov CL, [tk_clave]
		mov SI, offset tk_clave
		inc SI
		mov DI, offset buffer_linea
		call cadenas_iguales
		cmp DL, 0ff
		je obtener_valor_clave
		jmp retorno_fallido
obtener_valor_usuario:
ciclo_espacios1:
		inc DI
		mov AL, [DI]
		cmp AL, 20    ;; ver si es espacio
		jne ver_si_es_igual
		inc DI
		jmp ciclo_espacios1
ver_si_es_igual:
		mov CH, 00
		mov CL, [tk_igual]
		mov SI, offset tk_igual
		inc SI
		call cadenas_iguales
		cmp DL, 0ff
		je obtener_valor_cadena_usuario
		jmp retorno_fallido
obtener_valor_cadena_usuario:
ciclo_espacios2:
		inc DI
		mov AL, [DI]
		cmp AL, 20    ;; ver si es espacio
		jne capturar_usuario
		inc DI
		jmp ciclo_espacios2
capturar_usuario:
		mov CX, 0008    ;; TAMAÑO DEL USUARIO: 6 caracteres
		mov SI, offset usuario_capturado
ciclo_cap_usuario:
		inc DI
		inc SI
		mov AL, [DI]
		mov [SI], AL
		loop ciclo_cap_usuario
		mov AL, [estado]
		inc AL
		mov [estado], AL
		jmp ciclo_lineaXlinea
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
obtener_valor_clave:
ciclo_espacios3:
		inc DI
		mov AL, [DI]
		cmp AL, 20    ;; ver si es espacio
		jne ver_si_es_igual2
		inc DI
		jmp ciclo_espacios3
ver_si_es_igual2:
		mov CH, 00
		mov CL, [tk_igual]
		mov SI, offset tk_igual
		inc SI
		call cadenas_iguales
		cmp DL, 0ff
		je obtener_valor_cadena_clave
		jmp retorno_fallido
obtener_valor_cadena_clave:
ciclo_espacios4:
		inc DI
		mov AL, [DI]
		cmp AL, 20    ;; ver si es espacio
		jne capturar_clave
		inc DI
		jmp ciclo_espacios4
capturar_clave:
		mov CX, 0009    ;; TAMAÑO DE LA CLAVE: 9 caracteres
		mov SI, offset clave_capturada
ciclo_cap_clave:
		inc DI
		inc SI
		mov AL, [DI]
		mov [SI], AL
		loop ciclo_cap_clave
		mov AL, [estado]
		inc AL
		mov [estado], AL
		jmp ciclo_lineaXlinea
		;; ver si el nombre de campo es "usuario"
		;;      trabajo con la línea
		;; comparar nombre
		;; comparar clave
		;; si son correctos devolver en DL = 0ff
		;; si no son correctos devolver en DL = 00
retorno_fallido:
		mov DL, 00
		ret
retorno_exitoso:
		mov DL, 0ff
		ret
acabar_ejecucion:
	mov AL,0
	mov AH, 4CH
	int 21
fin:
.EXIT
END
