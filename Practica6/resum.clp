
## VARIABLES: Per definir dominis

X in -2..4          # [-2,4]
X in -2..4 \/ 5..8  # [-2,4] U [5,8]
[X,Y] in -2..4      # S'aplica a X i Y


## EXPRESSION ARITMETIQUES

- E           #  Negacion
E1 +  E2
E1 -  E2
E1 *  E2
E1 ** E2      # E1 elevado a E2
min(E1,E2)
max(E1,E2)
dist(E1,E2)   # |E1 - E2|
E1 // E2      # División entera E1/E2
E1 rem E2     # residuo de E1//E2

## RESTRICCIONS ARITMETIQUES

X #\= Y,        # forçar X i Y son diferents
X #\= Y + I,    # forçar X i (Y+I) son diferents
X #=  Y
X #<  Y
X #<  Y

## ALTRES RESTRICCIONS

all_differents(Lits)   # Forçar a que siguin diferents
elements_var(I,L,X)    # Forçar a que X sigui igual a Isim de la llista




##
