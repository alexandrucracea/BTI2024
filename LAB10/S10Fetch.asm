.MODEL SMALL          ; Setăm modelul de memorie SMALL (64KB cod + 64KB date)
.STACK 100h           ; Configurăm o stivă de 256 bytes

.DATA
    value DW 5                     ; Variabilă în memorie, inițializată cu valoarea 5
                                   ; `DW` (Define Word) alocă 2 bytes pentru stocarea unei valori de tip `WORD`.
                                   ; În acest caz, valoarea `5` este plasată în memoria segmentului de date.

    msgFetch DB 'Fetch: Citire valoare din memorie.$'   ; Mesaj pentru pasul Fetch
                                   ; `DB` (Define Byte) alocă o secvență de bytes în memorie pentru stocarea unui string.
                                   ; `msgFetch` este numele variabilei, iar restul sunt caracterele stringului terminat cu `$`.
                                   ; Caracterul `$` este necesar pentru funcția `INT 21h, AH=09h`, care identifică sfârșitul stringului.

    msgExecute DB 'Execute: Incrementeaza valoarea.$'  ; Mesaj pentru pasul Execute
    msgStore DB 'Store: Scrie valoarea actualizata in memorie.$' ; Mesaj pentru pasul Store

.CODE
MAIN PROC
    ; Inițializare segment de date
    MOV AX, @DATA       ; Încarcă adresa segmentului de date în AX
                                   ; `@DATA` este simbolul folosit de assembler pentru a marca începutul segmentului de date.
    MOV DS, AX          ; Setăm registrul DS (Data Segment) pentru acces la variabilele definite în `.DATA`.

    ; --------------- FETCH STEP ---------------
    ; Citește valoarea din memoria asociată variabilei "value"
    MOV AX, value       ; Încarcă valoarea de la adresa variabilei "value" în registrul AX
                                   ; Instrucțiunea accesează memoria la adresa specificată (în DS) și copiază conținutul în AX.

    ; Afișează mesajul pentru FETCH
    LEA DX, msgFetch    ; Încarcă adresa mesajului "msgFetch" în registrul DX
                                   ; `LEA` (Load Effective Address) calculează adresa efectivă a unei variabile și o încarcă în registru.
                                   ; Este util pentru a transmite pointeri către funcții sau instrucțiuni care necesită adrese.
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa stringul terminat cu `$`.

    ; --------------- EXECUTE STEP ---------------
    ; Incrementare a valorii din registrul AX
    ADD AX, 1           ; Adaugă 1 la valoarea curentă din AX
                                   ; `ADD` efectuează operația aritmetică și stochează rezultatul în registrul specificat.

    ; Afișează mesajul pentru EXECUTE
    LEA DX, msgExecute  ; Încarcă adresa mesajului "msgExecute" în registrul DX
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa stringul terminat cu `$`.

    ; --------------- STORE STEP ---------------
    ; Scrie valoarea actualizată înapoi în memoria asociată variabilei "value"
    MOV value, AX       ; Mută valoarea din AX în adresa variabilei "value"
                                   ; Instrucțiunea copiază conținutul din registrul AX în locația de memorie `value`.

    ; Afișează mesajul pentru STORE
    LEA DX, msgStore    ; Încarcă adresa mesajului "msgStore" în registrul DX
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa stringul terminat cu `$`.

    ; Terminare program
    MOV AH, 4Ch         ; Funcție DOS: Terminare program
                                   ; Codul 4Ch indică DOS-ului că programul s-a încheiat.
    INT 21h             ; Apel interrupt pentru terminarea programului

MAIN ENDP
END MAIN
