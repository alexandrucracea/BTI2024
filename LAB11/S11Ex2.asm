.MODEL small             ; Specifică modelul de memorie "small", în care codul și datele sunt stocate în segmente separate, fiecare având o dimensiune maximă de 64KB.
.STACK 100h              ; Alocă 256 octeți (100h în hexazecimal) pentru stiva, care este utilizată pentru stocarea temporară a datelor și a adreselor de retur.

.DATA                    ; Secțiunea de date, unde sunt definite variabilele și șirurile ce vor fi folosite în program.
    mesaj1 db 13,10,'nr1=','$'  ; Definirea unui șir de caractere pentru afișarea mesajului "nr1=", urmat de o linie nouă (13 = carriage return, 10 = line feed).
    mesaj2 db 13,10,'nr2=','$'  ; Șirul pentru afișarea mesajului "nr2=", urmat de o linie nouă.
    suma db 13,10,'Suma=','$'   ; Șirul pentru afișarea mesajului "Suma=", urmat de o linie nouă.
    nr1 db ?                    ; Variabilă de tip byte (8 biți) pentru primul număr, inițializată cu `?`, ceea ce înseamnă că nu are o valoare atribuită la început.
    nr2 db ?                    ; Variabilă de tip byte (8 biți) pentru al doilea număr, fără valoare inițială.
    s db ?                      ; Variabilă de tip byte (8 biți) pentru stocarea sumei celor două numere, inițializată cu `?`.

.CODE                       ; Secțiunea de cod a programului.

start:                       ; Punctul de intrare al programului, eticheta `start`.
    MOV AX, @DATA           ; Încarcă adresa segmentului de date (care este definită de directiva `.DATA`) în registrul AX.
    MOV DS, AX              ; Setează registrul DS (Data Segment) cu valoarea din AX, astfel încât programul va accesa corect variabilele din segmentul de date.

    ; Afișare mesaj "nr1="
    MOV ah,09h              ; Setează registrul AH la valoarea 09h, care reprezintă funcția DOS pentru afișarea unui șir de caractere terminat cu semnul `$`.
    MOV dx, offset mesaj1   ; Încarcă adresa de început a șirului `mesaj1` în registrul DX.
    INT 21h                 ; Apelă întreruperea 21h pentru a afișa șirul pe ecran. Funcția 09h afișează șirul de caractere.

    ; Citire primul număr
    MOV ah,01h              ; Setează registrul AH la 01h, care este funcția DOS pentru citirea unui caracter de la tastatură.
    INT 21h                 ; Apelă întreruperea 21h pentru a citi un caracter de la tastatură. Caracterele citite sunt returnate în registrul AL.
    SUB al, '0'             ; Scade valoarea ASCII a caracterului '0' (48 în ASCII) din AL. Acest lucru transformă caracterul citit într-o valoare numerică.
                             ; De exemplu, dacă AL conține '5' (valoare ASCII 53), `AL - '0'` va deveni 5 (valoarea numerică a lui 5).
    MOV nr1, al             ; Stochează valoarea numerică obținută în variabila `nr1` (ceea ce înseamnă că `nr1` conține acum un număr între 0 și 9).

    ; Afișare mesaj "nr2="
    MOV ah,09h              ; Setează registrul AH la 09h pentru a afișa un șir de caractere terminat cu semnul `$`.
    MOV dx, offset mesaj2   ; Încarcă adresa șirului `mesaj2` în DX.
    INT 21h                 ; Apelă întreruperea 21h pentru a afișa mesajul pe ecran.

    ; Citire al doilea număr
    MOV ah,01h              ; Setează registrul AH la 01h pentru citirea unui caracter de la tastatură.
    INT 21h                 ; Apelă întreruperea 21h pentru a citi al doilea caracter.
    SUB al, '0'             ; Convertim caracterul citit într-o valoare numerică prin scăderea valorii ASCII a lui '0' din AL.
                             ; De exemplu, dacă AL conține '7', `AL - '0'` va deveni 7 (valoarea numerică a lui 7).
    MOV nr2, al             ; Stochează al doilea număr citit în variabila `nr2`.

    ; Calculul sumei
    MOV al, nr1             ; Încarcă valoarea lui `nr1` în registrul AL (valoare numerică).
    ADD al, nr2             ; Adaugă valoarea lui `nr2` la AL. Rezultatul (suma) este acum stocat în AL.
    MOV s, al               ; Salvează rezultatul sumei în variabila `s`.

    ; Afișare mesaj "Suma="
    MOV ah,09h              ; Setează AH la 09h pentru a afișa șirul "Suma=".
    MOV dx, offset suma     ; Încarcă adresa șirului `suma` în registrul DX.
    INT 21h                 ; Apelă întreruperea 21h pentru a afișa mesajul "Suma=".

    ; Conversie suma în caracter ASCII
    ADD s, '0'              ; Adaugă valoarea ASCII a caracterului '0' (48) la valoarea numerică stocată în `s`. 
                             ; Astfel, dacă `s` conține valoarea 5, atunci `s + '0'` va deveni valoarea ASCII corespunzătoare caracterului '5'.
                             ; De exemplu, dacă suma este 7, această instrucțiune transformă valoarea 7 în caracterul ASCII '7' (valoarea 55).
    MOV dl, s               ; Încarcă valoarea din `s` (acum un caracter ASCII) în registrul DL pentru a o pregăti pentru a fi afișată.
    MOV ah, 02h             ; Setează AH la 02h pentru a folosi funcția DOS care afișează un singur caracter din DL.
    INT 21h                 ; Apelă întreruperea 21h pentru a afișa caracterul din DL (adică suma).

    ; Terminare program
    MOV ah,4Ch             ; Setează AH la 4Ch, care este funcția DOS pentru terminarea programului.
    INT 21h                 ; Apelă întreruperea 21h pentru a încheia programul.

END start                   ; Eticheta `start` marchează sfâ