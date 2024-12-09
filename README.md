
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
