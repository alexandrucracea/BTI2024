; IMPARTIREA A DOUA NUMERE INTREGI
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Introdu primul numar (de impartit, intreg):', 0DH, 0AH, '$'
    MSG2 DB 'Introdu al doilea numar (impartitor, intreg):', 0DH, 0AH, '$'
    MSG_QUOT DB 'Catul este:', 0DH, 0AH, '$'
    MSG_REM DB 'Restul este:', 0DH, 0AH, '$'
    MSG_DIV_ZERO DB 'Eroare: Nu se poate imparti la 0!', 0DH, 0AH, '$'
    INPUT_BUFFER DB 5, 0, 5 DUP(0)       ; Buffer pentru citirea numerelor
    NUM1 DW ?                            ; Primul număr (de împărțit)
    NUM2 DW ?                            ; Al doilea număr (împărțitor)
    QUOTIENT DW ?                        ; Câtul
    REMAINDER DW ?                       ; Restul
    BUFFER DB 8 DUP(?), '$'              ; Buffer pentru conversie în string
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; ---- Citirea primului număr ----
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    LEA DX, INPUT_BUFFER
    MOV AH, 0AH
    INT 21H
    CALL STRING_TO_SIGNED_NUMBER         ; Convertim string în număr semnat
    MOV NUM1, AX                         ; Salvăm primul număr în NUM1

    ; ---- Citirea celui de-al doilea număr ----
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    LEA DX, INPUT_BUFFER
    MOV AH, 0AH
    INT 21H
    CALL STRING_TO_SIGNED_NUMBER
    MOV NUM2, AX                         ; Salvăm al doilea număr în NUM2

    ; ---- Verificare împărțire la 0 ----
    CMP NUM2, 0                          ; Verificăm dacă al doilea număr este 0
    JE DIVIDE_BY_ZERO                    ; Sărim la mesaj de eroare dacă împărțitorul e 0

    ; ---- Împărțirea numerelor semnate ----
    MOV AX, NUM1                         ; Încărcăm primul număr în AX
    CWD                                  ; Extindem semnul din AX în DX
    IDIV NUM2                            ; Împărțim DX:AX la NUM2
    MOV QUOTIENT, AX                     ; Salvăm câtul în QUOTIENT
    MOV REMAINDER, DX                    ; Salvăm restul în REMAINDER

    ; ---- Afișarea câtului ----
    LEA DX, MSG_QUOT
    MOV AH, 09H
    INT 21H
    MOV AX, QUOTIENT
    CALL SIGNED_NUMBER_TO_STRING         ; Convertim câtul în string
    LEA DX, BUFFER
    MOV AH, 09H
    INT 21H

    ; ---- Afișarea restului ----
    LEA DX, MSG_REM
    MOV AH, 09H
    INT 21H
    MOV AX, REMAINDER
    CALL SIGNED_NUMBER_TO_STRING         ; Convertim restul în string
    LEA DX, BUFFER
    MOV AH, 09H
    INT 21H

    ; Terminarea programului
    MOV AH, 4CH
    INT 21H

DIVIDE_BY_ZERO:
    ; Afișăm mesaj de eroare pentru împărțire la 0
    LEA DX, MSG_DIV_ZERO
    MOV AH, 09H
    INT 21H

    ; Terminarea programului după eroare
    MOV AH, 4CH
    INT 21H

STRING_TO_SIGNED_NUMBER PROC
    XOR AX, AX                          ; Curățăm AX (rezultatul)
    XOR BX, BX                          ; BX = multiplicator pentru cifre (implicit 10)
    MOV BX, 10
    LEA SI, INPUT_BUFFER                ; Adresa bufferului
    ADD SI, 2                           ; Sărim primii 2 bytes (lungimea stringului)

    ; Conversie semn
    MOV CL, [SI]                        ; Citim primul caracter
    CMP CL, '-'                         ; Verificăm dacă este negativ
    JNE POSITIVE                        ; Dacă nu, trecem la conversie
    INC SI                              ; Sărim peste semnul "-"
    JMP CONTINUE

POSITIVE:
    CMP CL, '+'                         ; Verificăm dacă există semnul "+"
    JNE CONTINUE                        ; Dacă nu, continuăm conversia
    INC SI                              ; Sărim peste semnul "+"

CONTINUE:
    ; Conversie numerică
STRING_LOOP:
    MOV CL, [SI]                        ; Citim caracterul curent
    CMP CL, 0DH                         ; Verificăm dacă e Enter
    JE END_STRING_TO_SIGNED_NUMBER      ; Terminăm conversia
    SUB CL, '0'                         ; Convertim ASCII -> numeric
    MOV BX, 10
    IMUL BX                             ; Înmulțim rezultatul anterior cu 10
    ADD AX, CX                          ; Adăugăm cifra curentă
    INC SI                              ; Avansăm la următorul caracter
    JMP STRING_LOOP                     ; Repetăm

END_STRING_TO_SIGNED_NUMBER:
    CMP [INPUT_BUFFER + 2], '-'         ; Verificăm dacă numărul a fost negativ
    JNE RETURN_SIGNED_NUMBER            ; Dacă nu, returnăm
    NEG AX                              ; Transformăm rezultatul în negativ

RETURN_SIGNED_NUMBER:
    RET
STRING_TO_SIGNED_NUMBER ENDP

SIGNED_NUMBER_TO_STRING PROC
    CMP AX, 0                           ; Verificăm dacă numărul este negativ
    JGE CONVERT_POSITIVE                ; Dacă e pozitiv, continuăm
    NEG AX                              ; Transformăm în pozitiv pentru conversie
    MOV BYTE PTR [BUFFER], '-'          ; Adăugăm semnul minus
    LEA DI, BUFFER + 1                  ; Setăm poziția bufferului după '-'
    JMP CONVERT_NUMBER

CONVERT_POSITIVE:
    LEA DI, BUFFER                      ; Setăm adresa inițială a bufferului

CONVERT_NUMBER:
    XOR CX, CX                          ; CX = 0 (numără cifrele)
    MOV BX, 10                          ; Sistem zecimal

CONVERT_LOOP:
    XOR DX, DX                          ; DX = 0
    DIV BX                              ; AX = AX / 10; restul în DX
    ADD DL, '0'                         ; Convertim cifra în ASCII
    PUSH DX                             ; Salvăm cifra pe stivă
    INC CX                              ; Incrementăm contorul
    TEST AX, AX                         ; Verificăm dacă mai avem cifre
    JNZ CONVERT_LOOP                    ; Dacă da, continuăm

BUILD_STRING:
    POP AX                              ; Luăm o cifră din stivă
    MOV [DI], AL                        ; Salvăm cifra în buffer
    INC DI                              ; Mutăm în buffer
    LOOP BUILD_STRING                   ; Continuăm până golim stiva

    MOV BYTE PTR [DI], '$'              ; Terminatorul stringului
    RET
SIGNED_NUMBER_TO_STRING ENDP


END START
