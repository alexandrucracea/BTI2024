.MODEL small            ; Specificăm modelul small
.STACK 200h             ; Dimensiunea stivei este 512 octeți

.DATA                   ; Secțiunea de date
    mesaj DB "Rezultatul este mai mare decat 10$", 0 ; Mesaj terminat cu '$' pentru funcția de afișare DOS

.CODE                   ; Secțiunea de cod
MAIN PROC               ; Începem procedura principală
    MOV AX, @DATA       ; Inițializăm segmentul de date
    MOV DS, AX          ; Mutăm segmentul în DS
    
    ; 1. Inițializăm registrele cu valori
    MOV AX, 5           ; Mută valoarea 5 în registrul AX
    MOV BX, 7           ; Mută valoarea 7 în registrul BX
    
    ; 2. Adunăm AX și BX, stocăm rezultatul în CX
    ADD AX, BX          ; AX = AX + BX (5 + 7)
    MOV CX, AX          ; Salvăm rezultatul în CX pentru utilizare ulterioară

    ; 3. Comparăm rezultatul cu o valoare
    MOV DX, 10          ; Mută valoarea 10 în registrul DX
    CMP CX, DX          ; Comparăm CX cu DX
    JG MaiMare          ; Sari la eticheta 'MaiMare' dacă CX > DX

    ; 4. Dacă nu este mai mare, ieșim
    JMP Final           ; Sari la final

MaiMare:
    ; 5. Dacă rezultatul este mai mare, afișăm mesajul
    LEA DX, mesaj       ; Mutăm adresa mesajului în DX
    MOV AH, 09h         ; Funcția DOS pentru afișarea unui șir terminat cu '$'
    INT 21h             ; Apelăm funcția de afișare

Final:
    ; 6. Ieșim din program
    MOV AH, 4Ch         ; Funcția DOS pentru terminarea programului
    INT 21h             ; Apelăm funcția pentru a ieși din program
MAIN ENDP               ; Sfârșitul procedurii principale

END MAIN                ; Punctul de intrare al programului
