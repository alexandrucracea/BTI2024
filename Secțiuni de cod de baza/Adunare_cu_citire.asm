; ADUNARE NUMERE NATURALE
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Introdu primul numar:', 0DH, 0AH, '$'   ; Mesaj pentru primul număr, urmat de newline
    MSG2 DB 'Introdu al doilea numar:', 0DH, 0AH, '$' ; Mesaj pentru al doilea număr, urmat de newline
    MSG_RESULT DB 'Suma este:', 0DH, 0AH, '$'        ; Mesaj pentru rezultat, urmat de newline
    INPUT_BUFFER DB 5, 0, 5 DUP(0)                   ; Buffer pentru citirea numerelor
    NUM1 DW ?                                        ; Primul număr citit
    NUM2 DW ?                                        ; Al doilea număr citit
    RESULT DW ?                                      ; Rezultatul adunării
    BUFFER DB 6 DUP(?), '$'                          ; Buffer pentru convertirea rezultatului în string
.CODE
START:
    ; Setăm segmentul de date
    MOV AX, @DATA
    MOV DS, AX

    ; ---- Citirea primului număr ----
    LEA DX, MSG1                         ; Adresa mesajului "Introdu primul numar:"
    MOV AH, 09H                          ; Funcția DOS pentru afișare string
    INT 21H                              ; Afișăm mesajul pe consolă

    LEA DX, INPUT_BUFFER                 ; Adresa bufferului de citire
    MOV AH, 0AH                          ; Funcția DOS pentru citire string
    INT 21H                              ; Citim inputul utilizatorului
    CALL STRING_TO_NUMBER                ; Convertim stringul în număr
    MOV NUM1, AX                         ; Salvăm primul număr în variabila NUM1

    ; ---- Citirea celui de-al doilea număr ----
    LEA DX, MSG2                         ; Adresa mesajului "Introdu al doilea numar:"
    MOV AH, 09H
    INT 21H

    LEA DX, INPUT_BUFFER                 ; Adresa bufferului de citire
    MOV AH, 0AH
    INT 21H
    CALL STRING_TO_NUMBER
    MOV NUM2, AX                         ; Salvăm al doilea număr în variabila NUM2

    ; ---- Adunarea numerelor ----
    MOV AX, NUM1                         ; Încărcăm primul număr în AX
    ADD AX, NUM2                         ; Adunăm al doilea număr la AX
    MOV RESULT, AX                       ; Salvăm rezultatul în variabila RESULT

    ; ---- Afișarea rezultatului ----
    LEA DX, MSG_RESULT                   ; Adresa mesajului "Suma este:"
    MOV AH, 09H
    INT 21H                              ; Afișăm mesajul rezultatului

    MOV AX, RESULT                       ; Încărcăm rezultatul în AX
    CALL NUMBER_TO_STRING                ; Convertim rezultatul în string
    LEA DX, BUFFER                       ; Adresa stringului rezultat
    MOV AH, 09H
    INT 21H                              ; Afișăm stringul rezultatului pe consolă

    ; Terminarea programului
    MOV AH, 4CH                          ; Funcția DOS pentru terminare program
    INT 21H

; ---- Procedură pentru conversia unui string în număr ----
STRING_TO_NUMBER PROC
    XOR AX, AX                           ; Curățăm registrul AX (va stoca rezultatul)
    XOR BX, BX                           ; Curățăm registrul BX
    LEA SI, INPUT_BUFFER + 2             ; Adresa primului caracter (sărim peste primii 2 bytes din buffer)

STRING_LOOP:
    MOV CL, [SI]                         ; Citim un caracter din buffer
    CMP CL, 0DH                          ; Verificăm dacă este Enter (terminatorul de linie)
    JE END_STRING_CONVERSION             ; Dacă da, terminăm conversia
    SUB CL, '0'                          ; Convertim caracterul ASCII în valoare numerică
    MOV BX, 10                           ; Înmulțim cu 10
    IMUL BX                              ; Înmulțește AX cu BX (AX = AX * BX)
    ADD AX, CX                           ; Adăugăm cifra curentă la rezultat
    INC SI                               ; Avansăm la următorul caracter
    JMP STRING_LOOP                      ; Repetăm bucla

END_STRING_CONVERSION:
    RET                                  ; Returnăm rezultatul în AX
STRING_TO_NUMBER ENDP

; ---- Procedură pentru conversia unui număr în string ----
NUMBER_TO_STRING PROC
    XOR CX, CX                           ; Curățăm CX (numără cifrele)
    MOV BX, 10                           ; Baza pentru conversie (sistem zecimal)

CONVERT_LOOP:
    XOR DX, DX                           ; Curățăm DX (va stoca restul)
    DIV BX                               ; Împărțim AX la 10 (cât în AX, rest în DX)
    ADD DL, '0'                          ; Convertim cifra în ASCII
    PUSH DX                              ; Stocăm cifra pe stivă
    INC CX                               ; Creștem numărul de cifre
    TEST AX, AX                          ; Verificăm dacă mai avem cifre de procesat
    JNZ CONVERT_LOOP                     ; Dacă da, continuăm bucla

    ; Construim stringul din stivă
    LEA DI, BUFFER                       ; Adresa bufferului unde vom stoca stringul
BUILD_STRING:
    POP AX                               ; Luăm o cifră din stivă
    MOV [DI], AL                         ; Salvăm cifra în buffer
    INC DI                               ; Avansăm în buffer
    LOOP BUILD_STRING                    ; Continuăm până golim stiva

    MOV BYTE PTR [DI], '$'               ; Terminatorul stringului
    RET
NUMBER_TO_STRING ENDP

END START
