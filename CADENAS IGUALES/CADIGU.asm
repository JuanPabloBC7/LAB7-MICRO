.MODEL SMALL
.STACK
.DATA
SMS     DB 'INGRESE 2 CADENAS SIN ESPACIOS INTERMEDIOS, SEGUIDAS DE UN ENTER $'
SMS1    DB 10,13,'CADENA 1: $'
SMS2    DB 'CADENA 2: $'

CADENA1 DB 05 DUP(' ')
CADENA2 DB 05 DUP(' ')

SMSIG   DB 10,13,'LAS CADENAS SON IGUALES $'
SMSNI   DB 10,13,'LAS CADENAS NO SON IGUALES $'
.CODE
PROGRAMA:
    MOV AX,@DATA
    MOV DS, AX
    
    LEA DX,SMS
    MOV AH,09H
    INT 21H
    
    LEA DX,SMS1
    MOV AH,09H
    INT 21H
    
    LEA SI,CADENA1
    MOV AH,01
    LEER:
        INT 21h
        CMP AL,0DH      ;SI ES ENTER SIGUIENTE CADENA
        JE NEXT
        MOV [SI], AL
        INC SI
        JMP LEER

    NEXT:
        LEA DX,SMS2
        MOV AH,09H
        INT 21H    
    
        LEA DI,CADENA2
        MOV AH,01
        LEER1:
            INT 21H
            CMP AL,0DH  ;SI ES ENTER COMPARA CADENAS
            JE COMPARAR
            MOV [DI], AL
            INC DI
            JMP LEER1
    
    COMPARAR: 
        XOR BX,BX
        XOR CX,CX
        MOV BL,[SI]
        MOV CL,[DI]
        CMP BL,[DI]
        JNZ SALIR
        INC SI
        INC DI
        CMP CADENA1[SI],24H
        JE RESULTADO
        JMP COMPARAR
                 
    RESULTADO:
        XOR DX,DX
        MOV DX,OFFSET SMSIG
        MOV AH,09H
        INT 21H
        MOV AH,4CH
        INT 21H

   SALIR:
        MOV DX,OFFSET SMSNI
        MOV AH,09H
        INT 21H
        MOV AH,4CH
        INT 21H

END PROGRAMA