
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
- db _(define byte)_ : alocă 1 byte per caracter. Folosită pentru numere întregi și caracter
- dw _(define word)_ : alocă 2 bytes. Folosită pentru numere întregi
- dd _(define doubleword)_: alocă 4 bytes. Folosită pentru numere întregi, lungi.
- df, dp _(define for pointer)_: aloca 6 bytes. Folosită pentru numere reale
- dq _(define quadword)_: alocă 8 bytes. Folosită pentru numere reale sau întregi.
- dt _(define tenbytes)_: alocă 10 bytes. Folosită pentru numere reale sau numere în BCD.

## Indicatori de stare (Status Flags)
&nbsp; Se găsesc în cadrul registrului indicatorilor de stare. Registrul indicatorilor de stare este un registru special care are ca și rol ilustrarea unor stări (rezultatul unor operații aritmetice execuate în programul nostru cu extensia .asm). Indicatorii de stare sunt:
- Overflow Flag (OF): apare în urma realizării unei operații aritmetice. Dacă este setat se subînțelege faptul că rezultatul operației nu încape în destinație
- Direction Flag (DF): ilustrează direcția de procesare a elementelor dintr-un șir. Dacă este setat pe valoarea 0, atunci procesarea se va realiza de la adresa mai mică la cea mai mare. În caz contrat, procesarea va avea loc invers
- Interrupt Flag (IF): permite procesorului să răspundă la apeluri externe (întreruperi)
- Trap (Trace) Flag (TF): util pentru debugger, permițând execuția programului instrucțiune cu instrucțiune atunci când este setat
- Sign Flag (SF): indică semnul rezultatului unei operații aritmetice
- Zero Flag (ZF): ne ilustrează faptul că rezultatul unei operații aritmetice este 0
- Auxiliary Carry Flag (AF): folosit rar, atunci când se realizeaza operații în BCD
- Parity Flag (PF): dacă rezultatul unei operații conține un număr par de biți cu valoarea 1, flagul este setat. În caz contrar (număr impar de valori de 1) flagul va fi setat cu valoarea 0.
- Carry Flag (CF): indică apariția transportului în cazul unei adunări sau scăderi
