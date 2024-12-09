.MODEL small              ; Specifică modelul de memorie "small", în care codul și datele ocupă segmente diferite, fiecare de maxim 64 KB.
.STACK 100h               ; Alocă 256 octeți (100h în hexazecimal) pentru stiva, care este utilizată pentru stocarea temporară a datelor și a adreselor de retur.

.DATA
    mesaj1 db 13,10,'nr1=','$'  ; Șir de caractere pentru afișarea textului "nr1=", urmat de o linie nouă (13 = carriage return, 10 = line feed).
    mesaj2 db 13,10,'nr2=','$'  ; Șir de caractere pentru afișarea textului "nr2=", urmat de o linie nouă.
    suma db 13,10,'Suma=','$'   ; Șir de caractere pentru afișarea textului "Suma=", urmat de o linie nouă.
    nr1 db ?                    ; Variabilă de un octet pentru primul număr, inițializată cu `?`, ceea ce înseamnă că nu are o valoare atribuită la început.
    nr2 db ?                    ; Variabilă de un octet pentru al doilea număr, la fel fără valoare inițială.
    s dw ?                      ; Variabilă de 2 octeți (word - double byte) pentru suma celor două numere, neinițializată.

.CODE
start:
    MOV AX, @DATA           ; Încarcă adresa segmentului de date (@DATA) în registrul AX.
    MOV DS, AX              ; Setează registrul DS (Data Segment) pentru a accesa variabilele definite în secțiunea `.DATA`.

    ; Afișare mesaj "nr1="
    MOV ah, 09h             ; Setează registrul AH la 09h, care este funcția DOS pentru afișarea unui șir de caractere terminat cu `$`.
    MOV dx, offset mesaj1   ; Încărcăm adresa de început a șirului `mesaj1` în registrul DX.
    INT 21h                 ; Apel interrupt 21h pentru executarea funcției DOS 09h.

    ; Citire primul număr
    MOV ah, 01h             ; Setează registrul AH la 01h, funcția DOS pentru citirea unui caracter de la tastatură (cu afișare pe ecran).
    INT 21h                 ; Apel interrupt 21h. Caracterul introdus este returnat în registrul AL.
    SUB al, '0'             ; Scade valoarea ASCII a caracterului '0' din AL, convertind caracterul în valoarea numerică corespunzătoare.
                             ; De exemplu, dacă AL = '5' (ASCII 53), `AL - '0'` (53 - 48) va da valoarea 5.
    XOR ah, ah              ; Curăță registrul AH (partea superioară a registrului AX), punând toți biții săi la 0.
                             ; Acest lucru transformă AX într-un registru curat cu valoarea din AL (numărul citit).
    MOV nr1, al             ; Stochează valoarea numerică a primului număr în variabila `nr1`.

    ; Afișare mesaj "nr2="
    MOV ah, 09h             ; Funcția DOS 09h pentru afișarea unui șir.
    MOV dx, offset mesaj2   ; Încărcăm adresa șirului `mesaj2` în DX.
    INT 21h                 ; Apel interrupt 21h pentru afișarea mesajului.

    ; Citire al doilea număr
    MOV ah, 01h             ; Funcția DOS 01h pentru citirea unui caracter.
    INT 21h                 ; Apel interrupt 21h. Caracterul introdus este returnat în registrul AL.
    SUB al, '0'             ; Transformă caracterul ASCII într-un număr prin scăderea valorii ASCII a lui '0'.
                             ; De exemplu, '7' devine 7.
    XOR ah, ah              ; Curăță registrul AH, păstrând doar valoarea numerică din AL.
    MOV nr2, al             ; Salvează valoarea numerică a celui de-al doilea număr în variabila `nr2`.

    ; Calculul sumei
    MOV al, nr1             ; Încarcă valoarea lui `nr1` în AL.
    ADD al, nr2             ; Adaugă valoarea lui `nr2` la AL.
    MOV s, ax               ; Salvează rezultatul în variabila `s` (pe 16 biți, dar în acest caz folosim doar 8 biți).
    SUB s, '0'              ; (Aceasta instrucțiune pare greșită și inutilă, dar dacă ar fi păstrată: ajustează valoarea pentru afișare ASCII,
                             ; deși în acest caz nu este necesar, deoarece `s` ar trebui să fie deja numerică).

    ; Afișare mesaj "Suma="
    MOV ah, 09h             ; Funcția DOS 09h pentru afișarea unui șir.
    MOV dx, offset suma     ; Încărcăm adresa șirului `suma` în DX.
    INT 21h                 ; Apel interrupt 21h pentru afișarea mesajului.

    ; Afișare valoare sumă
    MOV dx, s               ; Încărcăm valoarea sumei (din `s`) în DX.
    MOV ah, 02h             ; Funcția DOS 02h pentru afișarea unui singur caracter.
    INT 21h                 ; Apel interrupt 21h pentru afișarea caracterului sumei.

    ; Terminare program
    MOV ah, 4Ch             ; Funcția DOS 4Ch pentru terminarea programului.
    INT 21h                 ; Apel interrupt 21h pentru a încheia execuția programului.
END start                   ; Marcaj de final al programului (eticheta `start` reprezintă punctul de intrare).
