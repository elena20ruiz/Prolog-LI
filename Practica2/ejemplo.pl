padre(juan,pedro).
padre(maria,pedro).
hermano(pedro, vicente).
hermano(pedro, alberto).
tio(x,y) :- padre(x,z) , hermano(z,y). 
