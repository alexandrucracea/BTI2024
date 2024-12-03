.MODEL SMALL          ; Setăm modelul de memorie SMALL (64KB cod + 64KB date)
.STACK 100h           ; Configurăm o stivă de 256 bytes

.DATA
    value DW 7                     ; Variabilă în memorie, inițializată cu valoarea 7
                                   ; `DW` alocă 2 bytes pentru stocarea unei valori întregi (word, 16 biți).
    msgFetch DB 'Fetch: Citeste valoare din memorie.$'   ; Mesaj pentru FETCH
    msgExecute DB 'Execute: Inmulteste valoarea cu 2.$'  ; Mesaj pentru EXECUTE
    msgStore DB 'Store: Scrie valoarea actualizata in memorie.$' ; Mesaj pentru STORE
    msgResult DB 'Result: ', 0    ; Mesaj pentru afișarea rezultatului (se va completa ulterior)

.CODE
MAIN PROC
    ; Inițializare segment de date
    MOV AX, @DATA       ; Încarcă adresa segmentului de date în AX
    MOV DS, AX          ; Setăm registrul DS pentru acces la variabilele din `.DATA`

    ; --------------- FETCH STEP ---------------
    ; Citește valoarea din memoria asociată variabilei "value"
    MOV AX, value       ; Încarcă valoarea de la adresa variabilei "value" în registrul AX
    
    ; Afișează mesajul pentru FETCH
    LEA DX, msgFetch    ; Încarcă adresa mesajului "msgFetch" în registrul DX
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa mesajul

    ; --------------- EXECUTE STEP ---------------
    ; Înmulțire a valorii din registrul AX cu 2
    SHL AX, 1           ; Înmulțește valoarea din AX cu 2 printr-un shift la stânga
                                   ; `SHL` (Shift Logical Left) este o operație bit-shifting care deplasează biții spre stânga,
                                   ; echivalentă cu înmulțirea cu 2.

    ; Afișează mesajul pentru EXECUTE
    LEA DX, msgExecute  ; Încarcă adresa mesajului "msgExecute" în registrul DX
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa mesajul

    ; --------------- STORE STEP ---------------
    ; Scrie valoarea actualizată înapoi în memoria asociată variabilei "value"
    MOV value, AX       ; Mută valoarea din AX în adresa variabilei "value"

    ; Afișează mesajul pentru STORE
    LEA DX, msgStore    ; Încarcă adresa mesajului "msgStore" în registrul DX
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa mesajul

    ; --------------- DISPLAY RESULT ---------------
    ; Afișează rezultatul actualizat
    LEA DX, msgResult   ; Încarcă adresa mesajului "msgResult" în registrul DX
    MOV AH, 09h         ; Funcție DOS: Afișare string
    INT 21h             ; Apel interrupt pentru a afișa mesajul

    ; Conversie din valoare numerică în string și afișare
    CALL DisplayNumber  ; Apelăm funcția pentru afișarea rezultatului numeric

    ; Terminare program
    MOV AH, 4Ch         ; Funcție DOS: Terminare program
    INT 21h             ; Apel interrupt pentru ieșirea la DOS

MAIN ENDP

; --------------------------------------------------------
; Funcție pentru afișarea unui număr (AX -> string -> afișare)
DisplayNumber PROC
    PUSH AX             ; Salvăm valoarea din AX pe stivă
    PUSH DX             ; Salvăm registrul DX

    ; Pregătire pentru conversie
    XOR CX, CX          ; Setăm contorul CX (număr de cifre) la 0
    MOV BX, 10          ; Baza numerică 10 (pentru conversie în decimal)

ConvertLoop:
    XOR DX, DX          ; DX=0 pentru diviziune
    DIV BX              ; Împarte AX la 10 (AX = AX / BX, DX = restul)
    PUSH DX             ; Salvăm restul (cifra curentă) pe stivă
    INC CX              ; Incrementăm contorul CX
    TEST AX, AX         ; Testăm dacă AX este 0
    JNZ ConvertLoop     ; Dacă nu, continuăm

    ; Afișăm cifrele în ordine
    MOV AH, 02h         ; Funcție DOS: Afișare caracter
DisplayDigits:
    POP DX              ; Scoatem următoarea cifră de pe stivă
    ADD DL, '0'         ; Convertim cifra în ASCII
    INT 21h             ; Afișăm caracterul
    LOOP DisplayDigits  ; Repetăm pentru toate cifrele

    ; Restaurăm registrele
    POP DX              ; Restaurăm DX
    POP AX              ; Restaurăm AX
    RET
DisplayNumber ENDP
END MAIN
