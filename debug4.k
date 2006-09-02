/ ----------------------------------------------------------------------
/ 2002-01-29 el 2003-04-25    debug helpers
/ Copyright: (C)2001 by Eberhard Lutz (eberhard-lutz@t-online.de). All rights reserved.
/ Use it at your own risk.
/ ----------------------------------------------------------------------
/ 2004-06-20 ported to kdb+; simon@kx.com

/ show definition of nouns like: `var `fn `ss as it would have been entered in a session
def:{-3!. x}
DEF:{($x),":",def x}

/ a poor man's tracer functions

A:{if[0<DEBUG;exit["i"$x]]}						/ *A*bort here if debug level > 0
H:{if[x&0<DEBUG;'`halt]}						/ *H*alt here if x true
X:{if[0<DEBUG;-2(-3!"x"$x)]}						/ he*X*adecimal representation
L:{if[0<DEBUG;-2(x#"-")]}						/ separator *L*ine length x
S:{if[0<DEBUG;-2("[",$[10h=@x;x;$x],"]")]}					/ level 1 emit a text *S*tring
B:{if[(x>1)&0<DEBUG;-2(1_x#"\n")]}				/ x line *B*reaks

V:{if[1<DEBUG;t:@x;-2(-3#"  ",$t),(-5#"    ",$[100h=t;$#(. x)[1];$[t<0;"*";$#x]])," | ",-3!x]} / level 2 show (type) *V*alue
E:{$[@x;V x;{i:0;do[#x;$[@x;V;E]x@i;i+:1]}x]}	/ level 2   show *E*numeration of items
R:{if[1<DEBUG;-2(x#,/"....",/:":!")]}			/ level 2   *R*uler line of len x
Z:{if[1<DEBUG;-2(x#,/"!:",\:"....")]}			/ level 2   ruler line, *Z*ero origin

D:{if[2<DEBUG;-2(DEF x)]}						/ level 3   show *D*ata definition

T:{x y;y}										/ T bar: T[E]x show and return a value

DEBUG:0											/ default: off

\
DEBUG:3

S "hello"
V `def
V (2*3)
  x:2+3
R 80
D `def
D `DEF
D `x
V x
L 80
E (1 2 3;("222";("234234";`sdfasdf);(0;"X");()))
V "SDFGHJKLdfghfdsdfg5rfvbnji876trfvbnmkiuzt"
X "abcdef"
A 0
