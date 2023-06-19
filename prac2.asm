.MODEL SMALL
.RADIX 16
.STACK
.DATA
cadena1 db "Universidad de San Carlos de Guatemala","$"
cadena2 db "Facultad de Ingeniería","$"
cadena3 db "Escuela de Vacaciones","$"
cadena4 db "Arquitectura de Computadoras y ensambladores 1","$"
cadena5 db "Nombre: Mariano Rac","$"
cadena6 db "Carnet: 202101149","$"
nA db 0ff
nB db 50
.CODE
.STARTUP

;; Imprimir cadena1
mov DX, OFFSET cadena1
mov AH, 09h
int 21h

;; Imprimir cadena2
mov DX, OFFSET cadena2
mov AH, 09h
int 21h

;; Imprimir cadena3
mov DX, OFFSET cadena3
mov AH, 09h
int 21h

;; Imprimir cadena4
mov DX, OFFSET cadena4
mov AH, 09h
int 21h

;; Imprimir cadena5
mov DX, OFFSET cadena5
mov AH, 09h
int 21h

;; Imprimir cadena6
mov DX, OFFSET cadena6
mov AH, 09h
int 21h

fin:
.EXIT
END
