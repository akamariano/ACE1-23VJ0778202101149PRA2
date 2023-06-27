include macros.asm
.MODEL SMALL
.RADIX 16
.STACK
;; PILA
.DATA
titulos_existencias_html			db	"<th>Codigo</th><th>Descripcion</th><th>Precio",0a,"$"
;;
nombre_conf db "PRAII.CON",00
clave_capturada        db     09  dup (0)
usuario_capturado      db     08  dup (0)
espacio_leido          db     00
estado                 db     00
buffer_linea           db     0ff dup (0)
tam_liena_leida        db     00
handle_conf            dw     0000
; separador db "------------------------------------",0a,"$"
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
prompt_generar_cat_alfa db "Generar catalogo alfabeticamente (A)",0a,"$"
prompt_generar_cat_sin_existencias db "Generar catalogo sin existencias (S)",0a,"$"
prompt_rep_ventas db "Generar reporte de ventas (v)",0a,"$"
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
; Variables de venta
    punteroItems    dw 0000h

    diaVenta        db 01 dup (0)
    mesVenta        db 01 dup (0)
    yearVenta       dw 00
    horaVenta       db 01 dup (0)
    minutoVenta     db 01 dup (0)
    
    codeVentatemp     db 05 dup (0)
    unidadesVenta           db 05 dup (0)    
    
    bytesItems db 46 dup (0)
    dir_item dw 0000h
    
    codeVenta             db 05 dup (0)
    descripcionVenta        db 21 dup (0)
    numeroPrecioVenta       dw 0000
    numeroCantidadVenta     dw 0000

    numUnitsVenta   dw 0000
    numeroMonto           dw 0000
    numeroMontoTotal      dw 0000

    contadorItemsVenta  db 0
    separadorVentas     db "$"
    finalizarVenta      db "fin"

; Variables de reporte de ventas
txtFecha db "Fecha: "
    txtfechasz equ $-txtFecha

    txtMonto db "Monto: "
    txtMontoSize equ $-txtMonto

    txtUltimasVentas     db  "Ultimas ventas: ", 0ah
    txtUltimasVentasSize equ $-txtUltimasVentas

    txtMayorMonto db "Venta con mayor monto: ", 0ah
    txtMayorMontoSize equ $-txtMayorMonto

    txtMenorMonto db "Venta con menor monto: ", 0ah
    txtMenorMontoSize equ $-txtMenorMonto

    fechaMayorVenta      db 06h dup (0)
    fechaMenorVenta      db 06h dup (0)

    montoMayorVenta      dw 0000
    montoMenorVenta      dw 0000

    cantidadVentas       dw 0000

    offsetReporteVentas   dw 0000

;; numéricos
num_price   dw    0000
num_units   dw    0000
;; archivo productos
archivo_prods    db   "PROD.BIN",00
handle_prods     dw   0000
;; archivo productos
archivoVentas    db   "VENT.BIN",00
handle_ventas     dw   0000
;;
nombre_rep1      db   "CATALG.HTM",00
handle_reps      dw   0000
handle_abc dw   0000
nombre_rep_alfa db "ABC.HTM",00
nombre_rep_sin_exis     db   "FALTA.HTM", 00
handle_rep_sinexis      dw   0000
handle_rep_ventas  dw   0000
pgReporteVentas         db "REP.TXT", 00
separador       db  "|=================================================|", 0d, 0a, "$"
separadorSize   equ $-separador
msgReporteVentas db "Reporte de ventas", 0d, 0a, "$"

separadorSimple     db  "|-------------------------------------------------|", 0d, 0a, "$"
separadorSimpleSize equ $-separadorSimple
espacioBlanco   db  " "
horaActual       db "00:00:00"
horaActualSize   equ $-horaActual
diaActual        db 01 dup (0)
mesActual        db 01 dup (0)
anioActual       dw 00
separadorFecha   db "/", 00
separadorHora    db ":", 00

;; tokens
tk_creds               db     0e, "[credenciales]"
tk_nombre              db     07, "usuario"
tk_clave               db     05, "clave"
tk_igual               db     01, "="
tk_comillas            db     01, '"'
;;
;;ALFABETICO
dia3        db 01 dup (0)
mes3       db 01 dup (0)
anio3       dw 00
hora3      db 01 dup (0)
minutos3     db 01 dup (0)
dos_puntos db ":",0a,"$"
diagonal db "/",0a,"$"
contador db 00
letra_actual db 61 
primeraLetra db 00

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

    ; Reestablecer el contador de items en 0.
    mov dl, 0000
    mov [contadorItemsVenta], dl

    ; Reestablecer el contador de monto total en 0.
    mov dx, 0000
    mov [numeroMontoTotal], dx
    
    ; Reestablecer el puntero de items
    mov dx, 0000
    mov [punteroItems], dx

    obtener_fecha:
        ; Obtener la fecha actual
        mov ah, 2ah
        int 21h

        ; Guardar la fecha
        mov [diaVenta], dl
        mov [mesVenta], dh
        mov [yearVenta], cx

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
        mov [handle_ventas], ax
        mov bx, [handle_ventas]

        ; Mover el puntero del archivo al final
        mov cx, 0000
        mov dx, 0000
        mov al, 02h
        mov ah, 42h
        int 21h

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

            
            mov si, offset codeVentatemp
            mov di, offset buffer_entrada
            inc di ; Saltar el primer byte
            mov ch, 00
            mov cl, [di] 
            inc di 
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
            mov dx, offset codeVenta
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
            cmp [codeVenta], al
            je ciclo_encontrar_producto_venta

            ; Verificar el codigo con el codigo solicitado
            mov si, offset codeVentatemp
            mov di, offset codeVenta
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

            ; Convertir las unidades a numero
            mov di, offset unidadesVenta
            call cadenaAnum
            mov [numUnitsVenta], ax

            ; Limpiar la variable unidadesProducto
            mov di, offset unidadesVenta
            mov cx, 0005
            call clean_mem_var

    verificar_existencias_disponibles:
        mov ax, [numeroCantidadVenta]
        cmp ax, [numUnitsVenta]
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
            mov dx, offset codeVenta
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
            cmp [codeVenta], al
            je ciclo_ubicar_producto

            ; Verificar el codigo con el codigo solicitado
            mov si, offset codeVentatemp
            mov di, offset codeVenta
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
        sub ax, [numUnitsVenta]
        mov [numeroCantidadVenta], ax

        ; Escribir el nuevo contenido con las unidades restadas
        mov cx, 2ah
        mov dx, offset codeVenta
        mov ah, 40h
        int 21h

        ; Cerrar el archivo para guardar cambios
        mov bx, [handle_prods]
        mov ah, 3eh
        int 21h

    calcular_nuevo_monto:
        ; Multiplicacion
        mov ax, [numeroPrecioVenta]
        mul numUnitsVenta         ; ax = ax * numUnitsVenta
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
        mov dx, offset numero
        mov ah, 40h
        int 21h
        mPrint nueva_lin

        jmp escribir_nuevo_item

    escribir_nuevo_item:

        
        mov ah, 0000h
        mov al, 7h
        mov bh, 0000h
        mov bl, [contadorItemsVenta]
        mul bx
        mov [punteroItems], ax
        
        ; 1. Obtener la direccion para escribir el item
        ; dir_item = offset bytesItems + punteroItems
        mov cx, offset bytesItems
        mov bx, [punteroItems]
        add cx, bx
        mov [dir_item], cx

        ; 2. Copiar el codigo del item 
        mov si, [dir_item]
        mov di, offset codeVentatemp
        mov ch, 00
        mov cl, 0005
        copiar_codigo_item:
            mov al, [di]
            mov [si], al
            inc si
            inc di
            loop copiar_codigo_item
        
        
        mov di, offset numUnitsVenta
        mov ch, 00
        mov cl, 0004
        copiar_unidades_item:
            mov al, [di]
            mov [si], al
            inc si
            inc di
            loop copiar_unidades_item
        

        ; Limpiar la variable codeVenta y descripcionVenta
        mov di, offset codeVenta
        mov cx, 0026h
        call clean_mem_var

        ; Limpiar la variable unidadesVenta
        mov di, offset unidadesVenta
        mov cx, 0005
        call clean_mem_var

        ; Limpiar la variable numUnitsVenta
        mov dx, 0000
        mov [numUnitsVenta], dx

        ; Limpiar la variable numeroMonto
        mov dx, 0000
        mov [numeroMonto], dx      

        
        
        mPrint nueva_lin
        mPrint nueva_lin
        
        mov dl, contadorItemsVenta
        cmp dl, 0009h
        je finalizar_venta

        inc dl
        mov [contadorItemsVenta], dl
        jmp solicitar_item

    finalizar_venta:
        ; Cerrar el archivo de productos
        mov bx, [handle_prods]
        mov ah, 3eh
        int 21h

        
        mov bx, [handle_ventas]
        mov cx, 06h
        mov dx, offset diaVenta
        mov ah, 40
        int 21h

        ; Escribir los items de la venta
        mov bx, [handle_ventas]
        mov cx, 46h
        mov dx, offset bytesItems
        mov ah, 40h
        int 21h

        ; Escribir el monto total de la venta
        mov bx, [handle_ventas]
        mov cx, 0002
        mov dx, offset numeroMontoTotal
        mov ah, 40h
        int 21h

        
        mov dx, 0000
        mov [dir_item], dx

       
        mov di, offset bytesItems
        mov cx, 0046h
        call clean_mem_var

        
        mov bx, [handle_ventas]
        mov ah, 3eh
        int 21h

    mPrint nueva_lin
    mPrint separador
    mPrint nueva_lin
    jmp menu_ventas

; REPORTE DE VENTAS
rep_ventas:
mPrint nueva_lin
    mPrint separador
    mPrint nueva_lin

    ; Crear el archivo de registro de ventas
    mov cx, 0000
    mov dx, offset pgReporteVentas
    mov ah, 3ch
    int 21h

    ; Guardar el handle del archivo
    mov [handle_rep_ventas], ax
    mov bx, [handle_rep_ventas]

    ; Escribir la fecha y hora del reporte
    call escribir_fecha_hora_reporte_txt

    ; Escribir el separador
    mov cx, separadorSize
    dec cx
    mov dx, offset separador
    mov ah, 40h
    int 21h

    ; Escribir apartado de ultimas 5 ventas
    mov cx, txtUltimasVentasSize
    mov dx, offset txtUltimasVentas
    mov ah, 40h
    int 21h

    ; Escribir nueva linea
    mov cx, 2h
    mov dx, offset nueva_lin
    mov ah, 40h
    int 21h

    ; Abrir el archivo de ventas
    mov cx, 0000
    mov dx, offset archivoVentas
    mov al, 02h
    mov ah, 3dh
    int 21h

    ; Guardar el handle del archivo
    mov [handle_ventas], ax
    mov bx, [handle_ventas]

    ; Reiniciar el contador de ventas
    mov ax, 0000
    mov [cantidadVentas], ax

    ; Leer el archivo de ventas
    ; 1. Contar la cantidad de ventas
    ; 2. Guardar los datos de la venta mayor y menor
    ciclo_1_ventas:
        ; Puntero en la fecha de la venta	
        mov bx, [handle_ventas]
        mov cx, 6h
        mov dx, offset diaVenta
        mov ah, 3fh
        int 21h

        ; Puntero en los items de la venta
        mov bx, [handle_ventas]
        mov cx, 46h
        mov dx, offset bytesItems
        mov ah, 3fh
        int 21h

        ; Puntero en el total de la venta
        mov bx, [handle_ventas]
        mov cx, 2h
        mov dx, offset numeroMontoTotal
        mov ah, 3fh
        int 21h

        ; Determinar si se terminó el archivo
        cmp ax, 0000
        je ciclo_1_ventas_fin

        ; Aumentar el contador de ventas
        mov ax, [cantidadVentas]
        inc ax
        mov [cantidadVentas], ax

        ; Determinar si es la primera venta
        cmp ax, 0001
        je primera_venta_obtenida

        ; Determinar si es la venta mayor
        comparacion_venta_mayor:
            mov ax, [numeroMontoTotal]
            cmp ax, [montoMayorVenta]
            jg venta_mayor_obtenida

        ; Determinar si es la venta menor
        comparacion_venta_menor:
            mov ax, [numeroMontoTotal]
            cmp ax, [montoMenorVenta]
            jl venta_menor_obtenida
        
        ; Continuar con el ciclo
        jmp ciclo_1_ventas_continuar

        primera_venta_obtenida:
            mov ax, [numeroMontoTotal]
            mov [montoMayorVenta], ax
            
            mov si, offset fechaMayorVenta
            mov di, offset diaVenta
            mov cx, 6h
            call copiar_variable

            mov si, offset fechaMenorVenta
            mov di, offset diaVenta
            mov cx, 6h
            call copiar_variable

            mov ax, [numeroMontoTotal]
            mov [montoMenorVenta], ax
            jmp ciclo_1_ventas_continuar
        
        ; Si es la venta mayor, guardar los datos
        venta_mayor_obtenida:
            mov si, offset fechaMayorVenta
            mov di, offset diaVenta
            mov cx, 6h
            call copiar_variable

            mov ax, [numeroMontoTotal]
            mov [montoMayorVenta], ax

            jmp comparacion_venta_menor

        ; Si es la venta menor, guardar los datos
        venta_menor_obtenida:
            mov si, offset fechaMenorVenta
            mov di, offset diaVenta
            mov cx, 6h
            call copiar_variable

            mov ax, [numeroMontoTotal]
            mov [montoMenorVenta], ax

            jmp ciclo_1_ventas_continuar
        
        ; Leer el siguiente registro
        ciclo_1_ventas_continuar:
            jmp ciclo_1_ventas
        
    ciclo_1_ventas_fin:

   ;5 ventas
    mov ax, [cantidadVentas]
    cmp ax, 0005
    jle offset_todas_las_ventas

    ; 2. Si hay mas de 5 ventas, mostrar las ultimas 5
    jmp offset_ultimas_ventas

    offset_todas_las_ventas:
        mov ax, 0000h
        mov [offsetReporteVentas], ax
        jmp mostrar_ventas

    offset_ultimas_ventas:
        ; Calculo de offset para mostrar las ultimas 5 ventas
        ; 1. CantidadDeVentas - 5
        mov ax, [cantidadVentas]
        sub ax, 0005
        mov [offsetReporteVentas], ax
        
        ; 2. Multiplicar por 4Eh (tamaño de cada venta)
        mov ax, [offsetReporteVentas]
        mov bx, 4Eh
        mul bx
        mov [offsetReporteVentas], ax

        jmp mostrar_ventas

    mostrar_ventas:
        ;puntero del archivo con el offset calculado
        mov al, 00h
        mov bx, [handle_ventas]
        mov cx, [offsetReporteVentas]
        mov dx, 0000h
        mov ah, 42h
        int 21h

        ciclo_mostrar_ventas:
            ; Puntero en la fecha de la venta	
            mov bx, [handle_ventas]
            mov cx, 6h
            mov dx, offset diaVenta
            mov ah, 3fh
            int 21h

            ; Puntero en los items de la venta
            mov bx, [handle_ventas]
            mov cx, 46h
            mov dx, offset bytesItems
            mov ah, 3fh
            int 21h

            ; Puntero en el total de la venta
            mov bx, [handle_ventas]
            mov cx, 2h
            mov dx, offset numeroMontoTotal
            mov ah, 3fh
            int 21h

            ; Determinar si se terminó el archivo
            cmp ax, 0000
            je ciclo_mostrar_ventas_fin

            ; ESCRIBIR VENTA

            
            mov bx, [handle_rep_ventas]
            mov cx, separadorSimpleSize
            mov dx, offset separadorSimple
            dec cx
            mov ah, 40h
            int 21h

            ; 1. Escribir la fecha de la venta
            reporte_ventas_escribir_fecha:
                call escribir_fecha_txt
            
            ; 2. Escribir el monto de la venta
            reporte_ventas_escribir_monto:
                ; Escribir apartado de monto
                mov cx, txtMontoSize
                mov dx, offset txtMonto
                mov ah, 40h
                int 21h

                
                mov ah, 00h
                mov ax, [numeroMontoTotal]
                call numAcadena

                
                mov bx, [handle_rep_ventas]
                mov cx, 05h
                mov dx, offset numero
                mov ah, 40h
                int 21h

                
                mov cx, 2h
                mov dx, offset nueva_lin
                mov ah, 40h
                int 21h
            
            
            jmp ciclo_mostrar_ventas

        ciclo_mostrar_ventas_fin:
            
            mov bx, [handle_rep_ventas]
            mov cx, separadorSize
            mov dx, offset separador
            dec cx
            mov ah, 40h
            int 21h

    escribir_venta_mayor:
        
        mov bx, [handle_rep_ventas]
        mov cx, txtMayorMontoSize
        mov dx, offset txtMayorMonto
        mov ah, 40h
        int 21h

       
        mov cx, txtMontoSize
        mov dx, offset txtMonto
        mov ah, 40h
        int 21h

        
        mov ah, 00h
        mov ax, [montoMayorVenta]
        call numAcadena

        
        mov bx, [handle_rep_ventas]
        mov cx, 05h
        mov dx, offset numero
        mov ah, 40h
        int 21h

        
        mov cx, 2h
        mov dx, offset nueva_lin
        mov ah, 40h
        int 21h

        mov si, offset diaVenta
        mov di, offset fechaMayorVenta
        mov cx, 06h
        call copiar_variable
        
        call escribir_fecha_txt
        
        
        mov cx, 2h
        mov dx, offset nueva_lin
        mov ah, 40h
        int 21h

        
        mov bx, [handle_rep_ventas]
        mov cx, separadorSize
        mov dx, offset separador
        dec cx
        mov ah, 40h
        int 21h

    escribir_venta_menor:
        
        mov bx, [handle_rep_ventas]
        mov cx, txtMenorMontoSize
        mov dx, offset txtMenorMonto
        mov ah, 40h
        int 21h

        
        mov cx, txtMontoSize
        mov dx, offset txtMonto
        mov ah, 40h
        int 21h

        
        mov ah, 00h
        mov ax, [montoMenorVenta]
        call numAcadena

        
        mov bx, [handle_rep_ventas]
        mov cx, 05h
        mov dx, offset numero
        mov ah, 40h
        int 21h

       
        mov cx, 2h
        mov dx, offset nueva_lin
        mov ah, 40h
        int 21h

        mov si, offset diaVenta
        mov di, offset fechaMenorVenta
        mov cx, 06h
        call copiar_variable
        
        call escribir_fecha_txt
        
        
        mov cx, 2h
        mov dx, offset nueva_lin
        mov ah, 40h
        int 21h

        
        mov bx, [handle_rep_ventas]
        mov cx, separadorSize
        mov dx, offset separador
        dec cx
        mov ah, 40h
        int 21h

    call reiniciar_variables_ventas

    
    mov bx, [handle_rep_ventas]
    mov ah, 3eh
    int 21h

    
    mov bx, [handle_ventas]
    mov ah, 3eh
    int 21

    mPrint msgReporteVentas
    jmp menu_herramientas
escribir_fecha_hora_reporte_txt:
    
    escribir_fecha_reporte_txt:
        
        mov bx, [handle_rep_ventas]
        mov cx, txtfechasz
        mov dx, offset txtFecha
        mov ah, 40h
        int 21h

        
        mov ah, 2ah
        int 21h

        
        mov [diaActual], dl
        mov [mesActual], dh
        mov [anioActual], cx

        
        mov ah, 00h
        mov al, [diaActual]
        call numAcadena
        
        
        mov bx, [handle_rep_ventas]
        mov cx, 02h
        mov dx, offset numero
        inc dx
        inc dx
        inc dx
        mov ah, 40h
        int 21

        
        mov bx, [handle_rep_ventas]
        mov cx, 01h
        mov dx, offset separadorFecha
        mov ah, 40h
        int 21

        
        mov ah, 00h
        mov al, [mesActual]
        call numAcadena

        
        mov bx, [handle_rep_ventas]
        mov cx, 02h
        mov dx, offset numero
        inc dx
        inc dx
        inc dx
        mov ah, 40h
        int 21

        
        mov bx, [handle_rep_ventas]
        mov cx, 01h
        mov dx, offset separadorFecha
        mov ah, 40h
        int 21

        
        mov ah, 00h
        mov ax, [anioActual]
        call numAcadena

        
        mov bx, [handle_rep_ventas]
        mov cx, 04h
        mov dx, offset numero
        inc dx
        mov ah, 40h
        int 21

        
        mov bx, [handle_rep_ventas]
        mov cx, 01h
        mov dx, offset espacioBlanco
        mov ah, 40h
        int 21

    
    escribir_hora_reporte_txt:
        call convertir_hora_ascii
        
       
        mov bx, [handle_rep_ventas]
        mov cx, 8
        mov dx, offset horaActual
        mov ah, 40h
        int 21

        
        mov bx, [handle_rep_ventas]
        mov cx, 02h
        mov dx, offset nueva_lin
        mov ah, 40h
        int 21

    ret



escribir_fecha_txt:
    ; Escribir apartado de fecha
    mov bx, [handle_rep_ventas]
    mov cx, txtfechasz
    mov dx, offset txtFecha
    mov ah, 40h
    int 21h

    ; Convertir el dia
    mov ah, 00h
    mov al, [diaVenta]
    call numAcadena
    
    ; Escribir el dia
    mov bx, [handle_rep_ventas]
    mov cx, 02h
    mov dx, offset numero
    inc dx
    inc dx
    inc dx
    mov ah, 40h
    int 21h

   
    mov bx, [handle_rep_ventas]
    mov cx, 01h
    mov dx, offset separadorFecha
    mov ah, 40h
    int 21h

    
    mov ah, 00h
    mov al, [mesVenta]
    call numAcadena

    
    mov bx, [handle_rep_ventas]
    mov cx, 02h
    mov dx, offset numero
    inc dx
    inc dx
    inc dx
    mov ah, 40h
    int 21h

    
    mov bx, [handle_rep_ventas]
    mov cx, 01h
    mov dx, offset separadorFecha
    mov ah, 40h
    int 21h

    
    mov ah, 00h
    mov ax, [yearVenta]
    call numAcadena

    
    mov bx, [handle_rep_ventas]
    mov cx, 04h
    mov dx, offset numero
    inc dx
    mov ah, 40h
    int 21h

    
    mov bx, [handle_rep_ventas]
    mov cx, 01h
    mov dx, offset espacioBlanco
    mov ah, 40h
    int 21h

    
    mov ah, 00h
    mov al, [horaVenta]
    call numAcadena

    
    mov bx, [handle_rep_ventas]
    mov cx, 02h
    mov dx, offset numero
    inc dx
    inc dx
    inc dx
    mov ah, 40h
    int 21h

  
    mov bx, [handle_rep_ventas]
    mov cx, 01h
    mov dx, offset separadorHora
    mov ah, 40h
    int 21h

   
    mov ah, 00h
    mov al, [minutoVenta]
    call numAcadena

    
    mov bx, [handle_rep_ventas]
    mov cx, 02h
    mov dx, offset numero
    inc dx
    inc dx
    inc dx
    mov ah, 40h
    int 21h
    
   
    mov cx, 2h
    mov dx, offset nueva_lin
    mov ah, 40h
    int 21h

    ret


reiniciar_variables_ventas:
    ; Limpiar las variables de fechas (Registro y Reporte)
    mov di, offset diaVenta
    mov cx, 0006
    call clean_mem_var

    mov di, offset fechaMayorVenta
    mov cx, 0006
    call clean_mem_var

    mov di, offset fechaMenorVenta
    mov cx, 0006
    call clean_mem_var

    mov di, offset codeVentatemp
    mov cx, 0005h
    call clean_mem_var

    
    mov di, offset unidadesVenta
    mov cx, 0005
    call clean_mem_var
    
    
    mov di, offset codeVenta
    mov cx, 0026h
    call clean_mem_var

    
    mov dx, 0000
    mov [numUnitsVenta], dx

    
    mov dx, 0000
    mov [numeroMonto], dx

    
    mov di, offset montoMayorVenta
    mov cx, 0002
    call clean_mem_var

    mov di, offset montoMenorVenta
    mov cx, 0002
    call clean_mem_var

    
    mov di, offset cantidadVentas
    mov cx, 0002
    call clean_mem_var

    ret

convertir_hora_ascii:
    mov ah, 2ch
    int 21h
    mov al, ch

    mov bh, 0
    mov bl, 0
    decenas:
        cmp al, 0ah
        jl unidades
        sub al, 0ah
        inc bh
        jmp decenas
    unidades:
        mov bl, al
        
    add bh, 30h
    add bl, 30h

    mov [horaActual], bh
    mov [horaActual + 1], bl

    mov [horaActual + 2], 3a 

    
    mov al, cl
    mov bh, 0
    mov bl, 0
    decenas_1:
        cmp al, 0ah
        jl unidades_1
        sub al, 0ah
        inc bh
        jmp decenas_1
    unidades_1:
        mov bl, al
        
    add bh, 30h
    add bl, 30h
    mov [horaActual + 3], bh
    mov [horaActual + 4], bl

    mov [horaActual + 5], 3a 
    mov al, dh
    mov bh, 0
    mov bl, 0
    decenas_2:
        cmp al, 0ah
        jl unidades_2
        sub al, 0ah
        inc bh
        jmp decenas_2
    unidades_2:
        mov bl, al
        
    add bh, 30h
    add bl, 30h
    mov [horaActual + 6], bh
    mov [horaActual + 7], bl

    ret
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
		mov DX, offset prompt_generar_cat_alfa
		mov AH, 09
		int 21
		mov DX, offset prompt_generar_cat_sin_existencias
		mov AH, 09
		int 21
		mov DX, offset prompt_rep_ventas
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
		cmp AL, 61 ;; Generar abc
		je generar_rep_abc
		cmp AL, 73 ;; Generar falta
		je generar_rep_sin_exis
		cmp AL, 76 ;; Generar ventas
		je rep_ventas
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
	;; OBTENER FECHA 
	mov ah, 2a
	int 21
	mov [dia3], dl
	mov [mes3], dh
	mov [anio3], cx
	;;OBTENER HORA 
	mov ah, 2ch
	int 21h
	mov [hora3], ch
	mov [minutos3], cl

	;; <p>Fecha:
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [tam_fecha_html]
	mov DX, offset fecha_html
	int 21
	;; ESCRIBIR DIA	
	mov AL, [dia3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_reps]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; /
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset diagonal
	int 21
	;; ESCRIBIR MES	
	mov AL, [mes3]
	mov AH, 00 
	call numAcadena
	mov BX, [handle_reps]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; /
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset diagonal
	int 21
	
	mov AX, [anio3]
	call numAcadena
	mov BX, [handle_reps]
	mov CX, 04
	mov DX, offset numero
	inc dx
	mov AH, 40
	int 21
	;; </p>
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [close_p_sz]
	mov DX, offset cierre_p
	int 21

	;; <p>Hora:
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, [tam_hora_html]
	mov DX, offset hora_html
	int 21
	;; ESCRIBIR HORA	
	mov AL, [hora3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_reps]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; : 
	mov BX, [handle_reps]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset dos_puntos
	int 21
	;; ESCRIBIR MINUTOS 	
	mov AL, [minutos3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_reps]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
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

	
	cmp AX, 00
	je fin_mostrar_catalogo

	
	mov AL, 00
	cmp [cod_prod], AL
	je ciclo_mostrar_catalogo

	
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
	
	cmp AL, 00
	je escribir_descripcion
	 
	cmp SI, 0006
	je escribir_descripcion

	
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
	
	cmp AL, 00
	je escribir_precio
	
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

	

	ret

;;
;;
;;REPORTE ALFABETICO
generar_rep_abc:
	; Crear el archivo
	mov AH, 3c
	mov CX, 0000
	mov DX, offset nombre_rep_alfa
	int 21

	; Almacenar el file handle
	mov [handle_abc], AX


	
	mov BX, AX  ;; bx es el handle 
	mov AH, 40
	mov CH, 00 ;; limpio CH 
	mov CL, [sz_header]
	mov DX, offset encabezado_html
	int 21
	;; <title>Reporte</title>"
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [tit_cat_sz]
	mov DX, offset tit_Catalogo_html
	int 21
	;;<style>table { width: 100%; border-collapse: collapse; }" 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [style_tb_sz]
	mov DX, offset style_Table_html
	int 21
	;;"th, td {border: 1px solid blue; padding: 8px; text-align: left;} </style>"
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [style_th_sz]
	mov DX, offset style_Th_html
	int 21
	;;cierre_style
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_sty_sz]
	mov DX, offset cierre_style
	int 21
	;;"</head>"
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_head_sz]
	mov DX, offset cierre_head
	int 21
	;; <h1>Reporte Alfabetico de Productos</h1>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [body_cat_sz]
	mov DX, offset body_Catalogo_html
	int 21
	
	;; OBTENER FECHA 
	mov ah, 2a
	int 21
	mov [dia3], dl
	mov [mes3], dh
	mov [anio3], cx
	;;OBTENER HORA 
	mov ah, 2ch
	int 21h
	mov [hora3], ch
	mov [minutos3], cl

	;; <p>Fecha:
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [tam_fecha_html]
	mov DX, offset fecha_html
	int 21
	;; ESCRIBIR DIA	
	mov AL, [dia3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_abc]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; /
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset diagonal
	int 21
	;; ESCRIBIR MES	
	mov AL, [mes3]
	mov AH, 00 
	call numAcadena
	mov BX, [handle_abc]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; /
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset diagonal
	int 21
	;; ESCRIBIR ANIO	
	mov AX, [anio3]
	call numAcadena
	mov BX, [handle_abc]
	mov CX, 04
	mov DX, offset numero
	inc dx
	mov AH, 40
	int 21
	;; </p>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_p_sz]
	mov DX, offset cierre_p
	int 21

	;; <p>Hora:
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [tam_hora_html]
	mov DX, offset hora_html
	int 21
	;; ESCRIBIR HORA	
	mov AL, [hora3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_abc]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; : 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset dos_puntos
	int 21
	;; ESCRIBIR MINUTOS 	
	mov AL, [minutos3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_abc]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;;abriendo <table>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [op_table_sz]
	mov DX, offset apertura_table
	int 21
	;; <tr> 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [open_tr_sz]
	mov DX, offset apertura_tr
	int 21
	;; <th>Letra</th><th>Cantidad de Productos
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [tit_af_sz]
	mov DX, offset titulos_html
	int 21
	;;</th>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, 05
	mov DX, offset cierre_th
	int 21
	;; </tr> 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_tr_sz]
	mov DX, offset cierre_tr
	int 21

	;; Abrir el archivo de productos
	mov AH, 3d
	mov AL, 02
	mov DX, offset archivo_prods
	int 21

	; Almacenar el file handle
	mov [handle_prods], AX


ciclo_mostrar_rep_alfabetico:
	
	mov BX, [handle_prods]
	mov CX, 26     ;; leer 26h bytes
	mov DX, offset cod_prod
	mov AH, 3f
	int 21

	
	mov BX, [handle_prods]
	mov CX, 0004
	mov DX, offset num_price
	mov AH, 3f
	int 21

	
	cmp AX, 00
	je escribir_letra_cantidad

	
	mov AL, 00
	cmp [cod_prod], AL
	je ciclo_mostrar_rep_alfabetico

	
	mov si, offset cod_name
	mov di, offset letra_actual
	mov cx, 01h
	call cadenas_iguales
	cmp dl, 0ffh
	je incrementar_contador

	
	jmp ciclo_mostrar_rep_alfabetico

	
	incrementar_contador:
		mov al, [contador]
		inc al
		mov [contador], al
		jmp ciclo_mostrar_rep_alfabetico

	jmp ciclo_mostrar_rep_alfabetico

fin_rep_alfabetico:
	;; </table>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_tb_sz]
	mov DX, offset cierre_table
	int 21

	;; </body>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_body_sz]
	mov DX, offset cierre_body
	int 21
	;; </html>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_html_sz]
	mov DX, offset cierre_html
	int 21

	;; CLOSE A FILE WITH HANDLE
	mov AH, 3e
	int 21

	jmp menu_herramientas

escribir_letra_cantidad:
	;;<tr> 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [open_tr_sz]
	mov DX, offset apertura_tr
	int 21
	
	;; <td> 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [open_td_sz]
	mov DX, offset apertura_td
	int 21

    ;; LETRA
    
	mov DX, offset letra_actual
	mov CX, 0001
	mov BX, [handle_abc]
	mov AH, 40
	int 21

	;; </td>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_td_sz]
	mov DX, offset cierre_td
	int 21h

	;; <td> 
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [open_td_sz]
	mov DX, offset apertura_td
	int 21

	
	; Verificar si no es 0
	mov AL, [contador] 
	cmp AL, 0000
	je escribir_variable_cero
	jmp convertir_variable

	escribir_variable_cero:
		mov al, 30h
		mov [numero], al
		mov al, 30h
		mov [numero + 1], al
		mov al, 30h
		mov [numero + 2], al
		mov al, 30h
		mov [numero + 3], al
		mov al, 30h
		mov [numero + 4], al
		jmp escribir_variable

	convertir_variable:
		; Convertir el precio
		mov AL, [contador]
		mov AH, 00
		call numAcadena

	escribir_variable:
		; Escribir el precio
		mov bx, [handle_abc]
		mov cx, 02
		mov dx, offset numero
		inc dx
		inc dx 
		inc dx
		mov ah, 40h
		int 21h

	;; </td>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_td_sz]
	mov DX, offset cierre_td
	int 21

	;; </tr>
	mov BX, [handle_abc]
	mov AH, 40
	mov CH, 00
	mov CL, [close_tr_sz]
	mov DX, offset cierre_tr
	int 21

    ;cmenor o igual a Z 
	cmp letra_actual, 7A ;z 
	jb menor_igual 

	jmp fin_rep_alfabetico

menor_igual:
	inc letra_actual 
    mov contador, 00 
	;apuntador de productos
	mov al, 00h
	mov bx, [handle_prods]
	mov cx, 00h
	mov dx, 00h
	mov ah, 42h
	int 21h
	;; cambiar de letra 
	jmp ciclo_mostrar_rep_alfabetico

;;SIN EXISTENCIAS

generar_rep_sin_exis:
	
	mov AH, 3c
	mov CX, 0000
	mov DX, offset nombre_rep_sin_exis
	int 21
	;; el file handle se almacena en Ax 
	mov [handle_rep_sinexis], AX

	
	;;<!DOCTYPE html><html><head>" 
	mov BX, AX  ;; bx es el handle 
	mov AH, 40
	mov CH, 00 ;; limpio CH 
	mov CL, [sz_header]
	mov DX, offset encabezado_html
	int 21

	;; <title>Catalogo</title>"
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [tit_cat_sz]
	mov DX, offset tit_Catalogo_html
	int 21

	;;<style>table { width: 100%; border-collapse: collapse; }" 
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [style_tb_sz]
	mov DX, offset style_Table_html
	int 21

	;;"th, td {border: 1px solid black; padding: 8px; text-align: left;} </style>"
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [style_th_sz]
	mov DX, offset style_Th_html
	int 21

	;;cierre_style
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [close_sty_sz]
	mov DX, offset cierre_style
	int 21

	;;"</head>"
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [close_head_sz]
	mov DX, offset cierre_head
	int 21

	;; "<body><h1>Catalogo Completo de Productos</h1>"
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [body_cat_sz]
	mov DX, offset body_Catalogo_html
	int 21
	;; OBTENER FECHA 
	mov ah, 2a
	int 21
	mov [dia3], dl
	mov [mes3], dh
	mov [anio3], cx
	;;OBTENER HORA 
	mov ah, 2ch
	int 21h
	mov [hora3], ch
	mov [minutos3], cl

	;; <p>Fecha:
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [tam_fecha_html]
	mov DX, offset fecha_html
	int 21
	;; ESCRIBIR DIA	
	mov AL, [dia3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_rep_sinexis]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; /
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset diagonal
	int 21
	;; ESCRIBIR MES	
	mov AL, [mes3]
	mov AH, 00 
	call numAcadena
	mov BX, [handle_rep_sinexis]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; /
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset diagonal
	int 21
	;; year	
	mov AX, [anio3]
	call numAcadena
	mov BX, [handle_rep_sinexis]
	mov CX, 04
	mov DX, offset numero
	inc dx
	mov AH, 40
	int 21
	;; </p>
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [close_p_sz]
	mov DX, offset cierre_p
	int 21

	;; <p>Hora:
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [tam_hora_html]
	mov DX, offset hora_html
	int 21
	;; hr	
	mov AL, [hora3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_rep_sinexis]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; : 
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, 01
	mov DX, offset dos_puntos
	int 21
	;; min	
	mov AL, [minutos3]
	mov AH, 00 
	call numAcadena 
	mov BX, [handle_rep_sinexis]
	mov CX, 02
	mov DX, offset numero
	inc dx
	inc dx 
	inc dx
	mov AH, 40
	int 21
	;; <table>
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [op_table_sz]
	mov DX, offset apertura_table
	int 21

	;; <tr> 
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [open_tr_sz]
	mov DX, offset apertura_tr
	int 21

	;; "<th>Descripción</th> <th>Código</th> <th>Precio</th> <th>Unidades"
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, [tit_ht_sz]
	mov DX, offset titulos_html
	int 21

	;;</th>
	mov BX, [handle_rep_sinexis]
	mov AH, 40
	mov CH, 00
	mov CL, 05
	mov DX, offset cierre_th
	int 21

	;; </tr> 
	mov BX, [handle_rep_sinexis]
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

		ciclo_mostrar_existentes:
			
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

			
			cmp AX, 0000
			je fin_mostrar_existentes

			
			mov AL, 00
			cmp [cod_prod], AL
			je ciclo_mostrar_existentes						

					
			mov DI, offset cod_name
			;; dx toma el valor de unidades
			mov ax, [num_units]
			cmp ax, 0000
			je ir_a_imprimir_esctructura_html			

			jmp ciclo_mostrar_existentes

		ir_a_imprimir_esctructura_html:
			;; llamar a la sub-rutina 
			call imprimir_estructura_html_existencias
			
		fin_mostrar_existentes:
			;; </table>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [close_tb_sz]
			mov DX, offset cierre_table
			int 21
			;; </body>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [close_body_sz]
			mov DX, offset cierre_body
			int 21
			;; </html>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [close_html_sz]
			mov DX, offset cierre_html
			int 21

			;; CLOSE A FILE WITH HANDLE
			mov AH, 3e
			int 21

			jmp menu_herramientas

		imprimir_estructura_html_existencias:
			;; <tr> 
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [open_tr_sz]
			mov DX, offset apertura_tr
			int 21

			;; <td> 
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [open_td_sz]
			mov DX, offset apertura_td
			int 21

			 
			mov DX, offset cod_prod
			
			mov SI, 0000

		ciclo_escribir_codigo_existencias:
			mov DI, DX
			mov AL, [DI]
			
			cmp AL, 00
			je escribir_descripcion_existencias
			
			cmp SI, 0006
			je escribir_descripcion_existencias

			
			mov CX, 0001
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			int 21

			inc DX  
			inc SI   

			jmp ciclo_escribir_codigo_existencias

		escribir_descripcion_existencias:
			;; </td>
			mov BX, [handle_reps]
			mov AH, 40
			mov CH, 00
			mov CL, [close_td_sz]
			mov DX, offset cierre_td
			int 21
			;; <td>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [open_td_sz]
			mov DX, offset apertura_td
			int 21

			;descripc
			mov DX, offset cod_name
			mov SI, 0000

		ciclo_escribir_descripcion_existencias:
			mov DI, DX
			mov AL, [DI]
			;nulo
			cmp AL, 00
			je escribir_precio_existencias
			;llena
			cmp SI, 0021
			je escribir_precio_existencias

			; 
			mov CX, 0001
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			int 21

			inc DX  ;; <-- para que se vaya la siguiente byte 
			inc SI  ;; <-- si se escribe algo en el arcribo, aumenta el contador 
			jmp ciclo_escribir_descripcion_existencias

		escribir_precio_existencias:
			;
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [close_td_sz]
			mov DX, offset cierre_td
			int 21
			;; <td>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [open_td_sz]
			mov DX, offset apertura_td
			int 21
			;
			mov AX, [num_price]
			call numAcadena

			mov DX, offset numero
			mov SI, 0000

		ciclo_escribir_precio_existencias:: 
			mov DI, DX
			mov AL, [DI]
			; nulo
			cmp AL, 00
			je cerrar_table
			;llena 
			cmp SI, 0006
			je cerrar_table

			;;write to fil
			mov CX, 0001
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			int 21

			inc DX  
			inc SI   
			jmp ciclo_escribir_precio_existencias

		cerrar_table_existencias:
			;; </td>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [close_td_sz]
			mov DX, offset cierre_td
			int 21
			;; </tr>
			mov BX, [handle_rep_sinexis]
			mov AH, 40
			mov CH, 00
			mov CL, [close_tr_sz]
			mov DX, offset cierre_tr
			int 21


			ret
					;	
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
