; ADUNARE NUMERE NATURALE
.MODEL SMALL
.STACK 100H
.DATA
    NUM1 DW 1   ; Primul număr
    NUM2 DW 9   ; Al doilea număr
    RESULT DW ?   ; Rezultatul
    MSG DB 'Suma este: $'
    BUFFER DB 6 DUP(?), '$'
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; Adunarea numerelor
    MOV AX, NUM1
    ADD AX, NUM2
    MOV RESULT, AX

    ; Afișarea rezultatului
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Conversia rezultatului în string
    MOV AX, RESULT
    CALL CONVERT_TO_STRING

    ; Afișare string
    MOV AH, 09H
    LEA DX, BUFFER
    INT 21H

    MOV AH, 4CH
    INT 21H

CONVERT_TO_STRING PROC
    XOR CX, CX
    MOV BX, 10       ; Baza de conversie
CONVERT_LOOP:
    XOR DX, DX
    DIV BX           ; Împarte AX la 10, câtul în AX, restul în DX
    ADD DL, '0'      ; Conversia cifrei în ASCII
    PUSH DX          ; Stochează cifra pe stivă
    INC CX           ; Crește numărul de cifre
    TEST AX, AX
    JNZ CONVERT_LOOP ; Repetă până când AX devine 0

    ; Construirea stringului în buffer
    LEA DI, BUFFER
    BUFFER_END:
    POP AX
    MOV [DI], AL
    INC DI
    LOOP BUFFER_END

    MOV BYTE PTR [DI], '$' ; Terminatorul stringului
    RET
CONVERT_TO_STRING ENDP

END START
; PTR este utilizat pentru a specifica tipul de operand atunci când acesta nu este evident pentru asamblor.
;BYTE PTR: Specifică că operandul este de 1 byte.
;WORD PTR: Specifică că operandul este de 2 bytes.
;Este necesar în situații în care asamblorul nu poate deduce dimensiunea operandului.