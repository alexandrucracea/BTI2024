.MODEL small
.stack 256

.DATA
    intrebare db 'A trecut ora pranzului? (Y/N).$'  ; Textul întrebării care va fi afișat pe ecran.
                                                    ; Șirul se termină cu caracterul '$', folosit de funcția 09h a interrupt-ului 21h (DOS),
                                                    ; pentru a indica sfârșitul șirului de afișat.
    mesajCafeluta db 13,10, 'Spor la cafeluta!',13,10, '$' ; Mesajul afișat dacă utilizatorul introduce răspunsul corespunzător.
                                                            ; 13 reprezintă "Carriage Return" (mutarea cursorului la începutul liniei),
                                                            ; iar 10 reprezintă "Line Feed" (trecerea la linia următoare).
                                                            ; Combinația CR+LF este necesară pe sistemele DOS/Windows pentru a realiza o nouă linie.
                                                            ; Șirul se termină cu caracterul '$' pentru funcția 09h.
    mesajBrunch db 13,10, 'Hai la brunch!',13,10, '$'   ; Un alt mesaj afișat în funcție de răspunsul utilizatorului.
                                                        ; La fel ca mai sus, 13 și 10 asigură formatarea corectă a liniei.
                                                        ; '$' marchează sfârșitul șirului pentru funcția 09h.


.CODE
START:
    MOV AX, @DATA          ; Încarcă segmentul de date (@DATA) în registrul AX.
    MOV DS, AX             ; Setează registrul de segment DS la adresa segmentului de date.
                           ; Acest pas este necesar pentru a accesa datele definite în secțiunea `.DATA`.

    MOV DX, offset intrebare ; Încarcă adresa de început a șirului 'intrebare' în DX.
    MOV ah, 09h            ; Setează funcția DOS 09h (afișare șir de caractere terminat cu `$`).
    INT 21h                ; Apel interrupt 21h pentru a afișa mesajul de la adresa din DX.

    MOV AH, 01H            ; Setează funcția DOS 01h (citire caracter de la tastatură, cu eco).
    INT 21h                ; Apel interrupt 21h pentru a citi un caracter introdus de utilizator.
                           ; Rezultatul este returnat în registrul AL.

    OR AL, 20h             ; Convertește caracterul din AL la literă mică.
                           ; `OR` cu 20h transformă orice literă majusculă (A-Z) în literă mică (a-z),
                           ; fără a afecta alte caractere.

    CMP AL, 'y'            ; Compară caracterul din AL cu 'y' (da).
    JE dupaPranz           ; Dacă este egal cu 'y', sare la eticheta `dupaPranz`.
    JNE inainteDePranz     ; Dacă nu este egal cu 'y', sare la eticheta `inainteDePranz`.

dupaPranz:
    MOV DX, offset mesajBrunch ; Încarcă adresa mesajului `mesajBrunch` în DX.
    JMP afisareMesaj           ; Sare la eticheta `afisareMesaj`.

inainteDePranz:
    MOV DX, offset mesajCafeluta ; Încarcă adresa mesajului `mesajCafeluta` în DX.
    JMP afisareMesaj             ; Sare la eticheta `afisareMesaj`.

afisareMesaj:
    MOV ah, 09h            ; Setează funcția DOS 09h (afișare șir de caractere terminat cu `$`).
    INT 21h                ; Apel interrupt 21h pentru a afișa mesajul de la adresa din DX.

    MOV AX, 4C00h          ; Setează funcția DOS 4Ch (terminare program).
                           ; În AX, `4C00h` indică terminarea cu codul de ieșire 0.
    INT 21h                ; Apel interrupt 21h pentru a închide programul.
END START                  ; Marcajul de sfârșit al programului (START este punctul de intrare).

