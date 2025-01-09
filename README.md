
# BTI 2024

Salutare, în cadrul acestui repo veți găsi explicații referitoare la instrucțiunile de Assembly, precum și câteva exemple de utilizare a mnemonicelor și a directivelor pe care le putem folosi în cadrul **DOS** în contextul **MASM/TASM**.

#

# Ce este Assembly?
__Assembly__ este un limbaj de programare de tip low level, având o legătura directă cu procesul. Codul scris în Assembly este transformat în cod mașină și este executat direct de UCP(CPU).

> [!IMPORTANT]
>  __Avantaje:__
> - Performanță ridicată, deoarece codul este executat direct de procesor.
> - Control precis asupra hardware-ului.
> - Ocupă mai puțin spațiu în memorie.
>   
> __Dezavantaje:__
> - Dificultate ridicată în învățare și scriere.
> - Lipsa portabilității (codul depinde de arhitectura procesorului).


# Care este structura unui program in Assembly?
Un program Assembly este împărțit în următoarele segmente:

1. Segmentul __.MODEL:__ Definește modelul de memorie (ex.: small, medium, large).
2. Segmentul __.STACK:__ Definește stiva programului.
3. Segmentul __.DATA:__ Pentru date, variabile și constante.
4. Segmentul __.CODE:__ Conține instrucțiunile programului.
<br/> 

# DIRECTIVE
__*.MODEL (.model)*__\
&nbsp; Directiva utilizată pentru inițializarea modelului de memorie definește modul în care segmentele unui program sunt organizate și dispuse în memoria RAM.\
&nbsp; Directiva model poate lua următoarele valori:\
&ensp; - tiny\
&ensp; - small\
&ensp; - medium\
&ensp; - compact\
&ensp; - large\
&ensp; - huge


__*.STACK (.stack)*__\
&nbsp; Directiva folosită pentru declararea unei zone de stivă, cod și date pe care o vom utiliza în cadrul programului nostru.

__*.DATA (.data)*__\
&nbsp; Directiva marchează începutul segmentului de date.

## Directive pentru definirea datelor
- **db _(define byte)_** : alocă 1 byte per caracter. Folosită pentru numere întregi și caracter
- **dw _(define word)_** : alocă 2 bytes. Folosită pentru numere întregi
- **dd _(define doubleword)_**: alocă 4 bytes. Folosită pentru numere întregi, lungi.
- **df, dp _(define for pointer)_**: aloca 6 bytes. Folosită pentru numere reale
- **dq _(define quadword)_**: alocă 8 bytes. Folosită pentru numere reale sau întregi.
- **dt _(define tenbytes)_**: alocă 10 bytes. Folosită pentru numere reale sau numere în BCD.
## Regiștri de uz general
- __AX__: denumit şi _registrul acumulator_: principalul registru de uz general utilizat pentru operaţii aritmetice, logice şi de deplasare de date. Operațiile de înmulțire și împărțire implică registrul AX. Este folosit şi pentru toate transferurile de date de la/către porturile de Intrare/Ieşire.
- __BX__: _registrul de bază_ poate stoca adrese pentru a face referire la diverse structuri de date, cum ar fi vectorii stocaţi în memorie. 
- __CX__: _registrul counter_, sau registrul contor se ocupă cu procesul de numărare 
- __DX__: _registrul de uz general (Data register)_ utilizat pentru a stoca date temporare sau intermediare în timpul execuției instrucțiunilor, utilizat în înmulțiri și împărțiri sau pentru  accesarea porturilor de intrare și de ieșire
- __SI__: _registrul Source Index_, poate fi folosit pentru a stoca adrese de memorie (asemenea lui BX). Extrem de util în instrucțiunile care lucrează cu date de tip string
- __DI__: _registrul Destination Index_ este utilizat automat de instrucțiunile de procesare a șirurilor, precum:
    - MOVS – Copiază date între șiruri.
    - STOS – Stochează date dintr-un registru într-un șir.
    - SCAS – Compară un șir cu o valoare.
    - CMPS – Compară două șiruri.
- __SP__: _registrul Stack Pointer_ reţine adresa de deplasament a următorului element disponibil în cadrul segmentului de stivă 
- __BP__: _registrul pointer de bază_, utilizat ca pointer de memorie precum regiştrii BX, SI şi DI, făcând referire relativ la segmentul de stivă SS.
<br/>

#
## Exemple de instrucțiuni
### Instrucțiuni de mutare a datelor
#### MOV - move (mutare date)
```assembly
mov ax, 10          ; Mută valoarea 10 în registrul AX
mov bx, ax          ; Copiază valoarea din AX în BX
```

#### PUSH/POP (stocare/preluare date din stivă)
```assembly
push ax             ; Salvare AX pe stivă
pop bx              ; Preluare din stivă direct în BX
```

#### LEA (Load effective address)
```assembly
lea si, myVar       ; Încarcă adresa variabilei myVar în SI
```
<br/> 

### Instrucțiuni pentru efectuarea de operații aritmetice și logice
#### ADD/SUB (Adunare/Scădere)
```assembly
add ax, bx          ; Adună valoarea din BX la AX
sub ax, 10          ; Scade 10 din AX
```
#### INC/DEC (Incrementare/Decrementare)
```assembly
inc ax              ; Incrementare AX cu 1
dec bx              ; Decrementare BX cu 1
```
#### MUL/IMUL (Înmulțire)
```assembly
mov al, 5
mul bl              ; AL = AL * BL (rezultat care nu ține cont de semn)
imul bx             ; AX = AX * BX (rezultat care ține cont de semn)
```
#### DIV/IDIV (Împărțire)
```assembly
mov ax, 10
mov bl, 2
div bl              ; AX = AX / BL (AX conține catul, restul în AH)
```
#### NEG (Negate - complement aritmetic)
```assembly
mov ax, 5
neg ax              ; AX = -AX (negare)
```

#### CMP (Compare)
```assembly
cmp ax, bx          ; Compară AX cu BX (setează flaguri)
```
<br/> 

### Instrucțiuni logice și bitwise
#### AND/OR/XOR (Operații logice)
```assembly
and ax, 0FFh        ; AND bitwise între AX și 0FFh
or bx, 80h          ; OR între BX și 80h
xor cx, cx          ; XOR între CX și CX (CX devine 0)
```
#### NOT (Negare)
```assembly
not ax              ; Inversează toți biții din AX
```
#### SHL/SHR (Shift logic la stânga/dreapta)
```assembly
shl ax, 1           ; Shift la stânga cu 1 bit
shr bx, 2           ; Shift la dreapta cu 2 biți
```
<br/> 

### Instrucțiuni de control al fluxului
#### JMP (Salt necondiționat)
```assembly
jmp myLabel         ; Sari la eticheta `myLabel`
```

#### JE/JZ (Salt condiționat - Jump Equal/ Jump Zero)
```assembly
JE equal_label   ; Sare la 'equal_label' dacă flag-ul zero este setat (Realizează un salt la eticheta specificată dacă rezultatul ultimei comparații a fost egal)
```

#### JNE/JNZ (Salt condiționat - Jump Not Equal/ Jump Not Zero)
```assembly
JNE notequal_label ; Sare la 'notequal_label' dacă flag-ul zero nu este setat (Realizează un salt la eticheta specificată dacă rezultatul ultimei comparații nu a fost egal (flag-ul zero nu este setat)
```

#### JG/JNLE
```assembly
JG greater_label ; Sare la 'greater_label' dacă EAX > EBX (Realizează un salt la eticheta specificată dacă operandul din stânga este mai mare decât cel din dreapta (pentru numere cu semn))
```

#### JL/JNGE
```assembly
JL less_label    ; Sare la 'less_label' dacă EAX < EBX (Realizează un salt la eticheta specificată dacă operandul din stânga este mai mic decât cel din dreapta (pentru numere cu semn))
```

#### CALL
```assembly
CALL subroutine  ; Apelează procedura 'subroutine' (Apelează o procedură la eticheta specificată; adresa de retur este stocată pe stivă)
```

#### RET
```assembly
RET              ; Revine la adresa de retur (Revine dintr-o subrutină la adresa stocată pe stivă)
```

#### RET
```assembly
RET              ; Revine la adresa de retur (Revine dintr-o subrutină la adresa stocată pe stivă)
```
<br/> 

#
## Funcții BIOS/DOS
### Afișare mesaj pe ecran:
```assembly
MOV AH, 09H         ; Funcția pentru afișare string
LEA DX, MSG         ; Adresa mesajului (definit în secțiunea DATA)
INT 21H

.DATA
MSG DB 'Hello, World!$', 0
```

### Citire caracter de la tastatură:
```assembly
MOV AH, 01H         ; Funcția pentru citire caracter
INT 21H
MOV CHAR, AL        ; Stochează caracterul citit în variabila CHAR

.DATA
CHAR DB ?
```

### Scriere caracter pe ecran:
```assembly
MOV AH, 02H         ; Funcția pentru afișare caracter
MOV DL, 'A'         ; Caracterul de afișat
INT 21H
```

###  Terminarea unui program:
```assembly
MOV AH, 4CH         ; Funcția pentru terminare program
MOV AL, 00H         ; Codul de ieșire
INT 21H
```

###  Citire string de la tastatură:
```assembly
MOV AH, 0AH         ; Funcția pentru citire string
LEA DX, BUFFER      ; Adresa bufferului pentru stocarea stringului
INT 21H

.DATA
BUFFER DB 10, 0, 10 DUP(0) ; Primul byte este lungimea maximă, al doilea este numărul de caractere citite
```

###  Deschidere fișier:
```assembly
MOV AH, 3DH         ; Funcția pentru deschidere fișier
MOV AL, 00H         ; Mod de acces: citire (00H)
LEA DX, FILENAME    ; Adresa numelui fișierului
INT 21H
MOV HANDLE, AX      ; Salvează handle-ul fișierului

.DATA
FILENAME DB 'example.txt', 0
HANDLE DW ?
```

###  Citire din fișier:
```assembly
MOV AH, 3FH         ; Funcția pentru citire din fișier
MOV BX, HANDLE      ; Handle-ul fișierului
LEA DX, BUFFER      ; Adresa bufferului de citire
MOV CX, 10          ; Numărul de octeți de citit
INT 21H

.DATA
BUFFER DB 10 DUP(0)
HANDLE DW ?
```

###  Scriere în fișier:
```assembly
MOV AH, 40H         ; Funcția pentru scriere în fișier
MOV BX, HANDLE      ; Handle-ul fișierului
LEA DX, BUFFER      ; Adresa datelor de scris
MOV CX, 10          ; Numărul de octeți de scris
INT 21H

.DATA
BUFFER DB 'Hello!', 0
HANDLE DW ?
```

###  Închidere fișier:
```assembly
MOV AH, 3EH         ; Funcția pentru închidere fișier
MOV BX, HANDLE      ; Handle-ul fișierului
INT 21H
```
<br/> 

## Indicatori de stare (Status Flags)
&nbsp; Se găsesc în cadrul registrului indicatorilor de stare. Registrul indicatorilor de stare este un registru special care are ca și rol ilustrarea unor stări (rezultatul unor operații aritmetice execuate în programul nostru cu extensia .asm). Indicatorii de stare sunt:
- __Overflow Flag (OF)__: apare în urma realizării unei operații aritmetice. Dacă este setat se subînțelege faptul că rezultatul operației nu încape în destinație
- __Direction Flag (DF)__: ilustrează direcția de procesare a elementelor dintr-un șir. Dacă este setat pe valoarea 0, atunci procesarea se va realiza de la adresa mai mică la cea mai mare. În caz contrat, procesarea va avea loc invers
- __Interrupt Flag (IF)__: permite procesorului să răspundă la apeluri externe (întreruperi)
- __Trap (Trace) Flag (TF)__: util pentru debugger, permițând execuția programului instrucțiune cu instrucțiune atunci când este setat
- __Sign Flag (SF)__: indică semnul rezultatului unei operații aritmetice
- __Zero Flag (ZF)__: ne ilustrează faptul că rezultatul unei operații aritmetice este 0
- __Auxiliary Carry Flag (AF)__: folosit rar, atunci când se realizeaza operații în BCD
- __Parity Flag (PF)__: dacă rezultatul unei operații conține un număr par de biți cu valoarea 1, flagul este setat. În caz contrar (număr impar de valori de 1) flagul va fi setat cu valoarea 0.
- __Carry Flag (CF)__: indică apariția transportului în cazul unei adunări sau scăderi

<br/> 

[Exemple pentru WHILE, DO WHILE și FOR](https://stackoverflow.com/questions/28665528/while-do-while-for-loops-in-assembly-language-emu8086)

## Tips and Tricks
> [!TIP]
> - Denumiți etichetele și variabilele într-un mod sugestiv.
> - Gestionați stiva corect: toate valorile introduse trebuie să fie scoase.
> - Familiarizați-vă cu flag-urile pentru a putea folosi mai ușor instrucțiunile de salt condiționat
> - Evitați utilizarea excesivă a memoriei, păstrând valorile temporare în registri.
> - Folosiți instrucțiuni mai eficiente. Exemplu: XOR AX, AX pentru a seta un registru la 0, în loc de MOV AX, 0.
> - Folosiți macro-uri pentru cod repetitiv.
> - Inițializați toate variabilele si toți regiștrii.
> - Aveți grijă să nu depășiți valoarea stivei. Dacă este necesar puteți mări dimensiunea acesteia.
> - Evitați conflictele de segment: registrele de segment (DS, ES, SS, CS) trebuie să fie corect configurate.
