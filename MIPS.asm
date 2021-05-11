#181176 David Kirovski
.data
vektor_1: .space 80 #odvojuvanje mesto od 20 celi broevi
vektor_2: .space 80 #odvojuvanje mesto od 20 celi broevi
indeks: .word 181176 #pretstavuvanje na indeksot kako 32 biten broj so .word
.text
lw $t0,indeks #vcituvanje na 32 bitniot broj vo t0
sll $t0,$t0,16 #pomestuvanje za 16 bitovi vo levo
srl $t0,$t0,16 #pomestuvanje za 16 bitovi vo desno, so sto ostanuvaat samo poslednite 16 od prvicniot broj
move $s1,$t0 #premestuvanje na rezultatot vo s1
addi $t0,$zero,0 #dodavanje vrednost 0 na t0
li $v0,5 #povikuvanje na sistemot za vnesuvanje na cel broj vo v0
syscall
move $s0,$v0 #premestuvanje na vneseniot broj vo s0
li $v0,5 #povikuvanje na sistemot za vnesuvanje na cel broj vo v0
syscall
mul $t0,$v0,4 #mnozenje na vneseniot broj so 4 i premestuvanje na rezultatot vo t0
loop1: #ciklus za prviot vektor
bge $t1,$t0,exit #ako brojacot e ednakov ili pogolem od maximumot, togas ciklusot zavrsuva
li $v0,5 #povikuvanje na sistemot za vnesuvanje na cel broj vo v0
syscall
move $t2,$v0 #premestuvanje na vneseniot broj vo t2
sw $t2,vektor_1($t1) #zacuvuvanje na vneseniot broj vo nizata vektor_1 so index t1
addi $t1,$t1,4 #zgolemuvanje na brojacot za 4
j loop1 #povtorno zapocnuvanje na ciklusot
exit:
addi $t1,$zero,0 #dodavanje vrednost 0 na t1 - brojacot
loop2:
bge $t1,$t0,main #ako brojacot e ednakov ili pogolem od maximumot, togas ciklusot zavrsuva
li $v0,5 #povikuvanje na sistemot za vnesuvanje na cel broj vo v0
syscall
move $t2,$v0 #premestuvanje na vneseniot broj vo t2
sw $t2,vektor_2($t1) #zacuvuvanje na vneseniot broj vo nizata vektor_2 so index t1
addi $t1,$t1,4 #zgolemuvanje na brojacot za 4
j loop2 #povtorno zapocnuvanje na ciklusot
main:
bge $t3,$t0,end #ako brojacot e ednakov ili pogolem od maximumot, togas ciklusot zavrsuva
jal presmetka #povikuvanje na procedura koja ke vrati vrednost na proizvod na vektori i ke go smesti zbirot direktno vo memoriskata adresa
add $t9,$t9,$v1 #dodavanje na vratenata vrednost vo t9
addi $t3,$t3,4 #zgolemuvanje na brojacot za 4
j main #povtorno zapocnuvanje na ciklusot
end:
move $a0,$t9 #premestuvanje na vrednosta na skalarniot proizvod vo s2 i nejzino printanje
li $v0,1 #povikuvanje na sistemot za printanje na cel broj
syscall 
li $v0,10 #povikuvanje na sistemot za kraj na programata
syscall
presmetka:
lw $t1,vektor_1($t3) #vcituvanje na brojot od nizata vektor_1 so index t3 vo t1
lw $t2,vektor_2($t3) #vcituvanje na brojot od nizata vektor_2 so index t3 vo t2
add $t4,$t1,$t2 #sobiranje na dvete vrednosti i dodavanje vo v1
sw $t4,($s0) #zacuvuvanje na vrateniot rezultat vo zadadenata adresa
addi $s0,$s0,4 #zgolemuvanje na indeksot na memoriskata adresa
mult $t1,$t2 #mnozenje na dvete vrednosti
mflo $v1 #smestuvanje na rezultatot vo v1
jr $ra #vrakjanje na vrednosta vo v1 nazad vo main delot