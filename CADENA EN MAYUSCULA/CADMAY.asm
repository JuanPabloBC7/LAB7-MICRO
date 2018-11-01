.MODEL SMALL
.STACK
.DATA 
CADENA  DB 100 DUP('$')

SMS     DB       'INGRESE UNA CADENA EN MINUSCULAS: $'
SMS2    DB 10,13,'LA CADENA EN MAYUSCULAS ES:       $'

.386
.CODE
PROGRAMA:
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DX,OFFSET SMS
    MOV AH,09H
    INT 21H
    
    LEA DI,CADENA
    MOV AH,01
    
    LEER:
        INT 21h
        CMP AL,0DH ; si fue enter
        JE NEXT
        MOV [DI],AL
        INC DI
        JMP LEER
        
    NEXT:
        LEA DI,CADENA
    
    CONVERTIR:
        MOV AH,CADENA[DI]       
        SUB AH,20H                      
        MOV CADENA[DI],AH
        INC DI
        CMP CADENA[DI],24H      
        JE IMPRIMIR
        JMP CONVERTIR
        
    IMPRIMIR:
        MOV DX,OFFSET SMS2
        MOV AH,09H
        INT 21H 
        MOV DL,OFFSET CADENA
        MOV AH,09
        INT 21H
    
    FINALIZAR:    
    MOV AH,4CH                     
    INT 21H
END PROGRAMA