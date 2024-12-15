
# BTI 2024

Salutare, în cadrul acestui repo veți găsi explicații referitoare la instrucțiunile de Assembly, precum și câteva exemple de utilizare a mnemonicelor și a directivelor pe care le putem folosi în cadrul **DOS** în contextul **MASM/TASM**.

#

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
imul ax, bx, 4      ; AX = BX * 4 (rezultat care ține cont de semn)
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
