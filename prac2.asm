.MODEL SMALL
.RADIX 16
.STACK
.DATA
usac db "Universidad de San Carlos de Guatemala",0a,"$"
fiusac db "Facultad de Ingenieria",0a,"$"
chain3 db "Escuela de Vacaciones",0a,"$"
chain4 db "Arquitectura de Computadoras y ensambladores 1" ,0a,"$"
nam db "Nombre: Mariano Rac",0a,"$"
carnet db "Carnet: 202101149" ,0a,"$"
products db "(P)roductos",0a,"$"
sales db "(V)entas",0a,"$"
tools db "(H)erramientas",0a,"$"
newline db 0ah,0dh,"$"
prompt db "Ingrese una opcion: ",0a,"$"
products_header db "PRODUCTOS",0a,"$"
sales_header db "VENTAS",0a,"$"
tools_header db "HERRAMIENTAS",0a,"$"
sub_menus db "-----------------------------",0a,"$"
products_create db"(C)rear",0a,"$"
products_delete db"(E)liminar",0a,"$"
products_show db"(M)ostrar",0a,"$"
products_create_header db "CREAR PRODUCTO",0a,"$"
products_delete_header db "ELIMINAR PRODUCTO",0a,"$"
products_show_header db "MOSTRAR PRODUCTO",0a,"$"

;;BUFFERED KEYBOARD INPUT
;;2nd Byte reads lenght of string
;;3rd byte reads entry
input_buffer db 20,00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
nA db 0ff
nB db 50
.CODE
.STARTUP
;;ENCABEZADO
;; Imprimir cadena1
mov DX, offset usac
mov AH, 09
int 21

;; Imprimir cadena2
mov DX, offset fiusac
mov AH, 09
int 21

;; Imprimir cadena3
mov DX, offset chain3
mov AH, 09
int 21

;; Imprimir cadena4
mov DX, offset chain4
mov AH, 09
int 21

;; Imprimir cadena5
mov DX, offset nam
mov AH, 09
int 21

;; Imprimir cadena6
mov DX, offset carnet
mov AH, 09
int 21
;;NuevaLinea
mov DX, offset newline
mov AH, 09
int 21
;;NuevaLinea
mov DX, offset newline
mov AH, 09
int 21

;;MENU
mov DX, offset products
mov AH, 09
int 21
mov DX, offset sales
mov AH, 09
int 21
mov DX, offset tools
mov AH, 09
int 21
mov DX, offset newline
mov AH, 09
int 21
mov DX, offset prompt
mov AH, 09
int 21
mov AH, 08;;LEER ENTRADA
int 21
;;AL=CARACTER LEÍDO
cmp AL,70;;COMPARAR SI ES P
;;HACER SALTO CONDICIONAL
je products_menu;;jump if equal
cmp AL, 76;;COMPARAR SI ES V
je sales_menu;;jump if equal
cmp AL,68;;COMPARAR SI ES H
je tools_menu;;jump if equal
; jmp inicio;Jump contyrol structures
;Products Menu
products_menu:
mov DX, offset products_header
mov AH, 09
int 21
mov DX, offset sub_menus
mov AH, 09
int 21
mov DX, offset products_create
mov AH, 09
int 21
mov DX, offset products_delete
mov AH, 09
int 21
mov DX, offset products_show
mov AH, 09
int 21

mov AH, 08;;LEER ENTRADA
int 21
;;AL=CARACTER LEÍDO
cmp AL,63;;COMPARAR SI ES c
;;HACER SALTO CONDICIONAL
je products_create_menu;;jump if equal
cmp AL,65;;COMPARAR SI ES e
;;HACER SALTO CONDICIONAL
je products_delete_menu;;jump if equal
cmp AL,6D;;COMPARAR SI ES m
;;HACER SALTO CONDICIONAL
je products_show_menu;;jump if equal
;sub create products
products_create_menu:
mov DX, offset products_create_header
mov AH, 09
int 21
mov DX, offset sub_menus
mov AH, 09
int 21
;Ask Code
mov DX, offset input_buffer
mov AH, 0ah
int 21
jmp fin

;sub delete products
products_delete_menu:
mov DX, offset products_delete_header
mov AH, 09
int 21
mov DX, offset sub_menus
mov AH, 09
int 21
;Ask Code
mov DX, offset input_buffer
mov AH, 0ah
int 21
jmp fin

;sub show products
products_show_menu:
mov DX, offset products_show_header
mov AH, 09
int 21
mov DX, offset sub_menus
mov AH, 09
int 21
;Ask Code
mov DX, offset input_buffer
mov AH, 0ah
int 21
jmp fin
;Sales Menu
sales_menu:
mov DX, offset sales_header
mov AH, 09
int 21
mov DX, offset sub_menus
mov AH, 09
int 21
jmp fin
;Tools Menu
tools_menu:
mov DX, offset tools_header
mov AH, 09
int 21
mov DX, offset sub_menus
mov AH, 09
int 21
jmp fin
fin:
.EXIT
END
