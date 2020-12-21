*******************************************************************************
* Program drukuje ksiege p.ir.{P=1} , rejestr  sprz.{P=2}, rej.zak (p=3)      *
* Umozliwia wspolprace z drukarka 15'{lpt15=.t.} oraz 10-12'{lpt15=.f.        *
*******************************************************************************
PARAMETERS P
local lms:=0
local ilosc:=1
local em:=savescreen(0,0,24,79)
local drukuj:=.t.
local bat:=.f.
public strona:=1
public w:=0
tytul=space(30)
plik:="\kjdruk.prn"
dl=52
dziel=0       &&0-wydr jednoczesciowy, 1-strona A  1-strona B
wek=""
save screen to em
do startdruk with ilosc,drukuj,wek
if.not.drukuj
  restore screen from em
  return
endif  
set device to printer
if p#102.and.p#103
  @ prow(),pcol() say &zdr_kond
else
  @ prow(),pcol() say &zdr_kkond
endif  
set margin to margines
* * *
if file("ksiega.dbf").and.p#101.and.p#102.and.p#103       &&p=101 - wydruk rap przy otwartej bazie
  ms=month(daf)
  set device to screen
  @ 21,1 clear to 23,78
  @ 22,26 say"  Wydruk  za miesiac       "
  set cursor on
  @ 22,48 get ms picture "99" range 1,12
  read
  set cursor off
  if lastkey()=27
    return
  endif  
  lms=ms
  do pksdefault with lms
  select 2
  use ksiega index ksiega
endif
set device to printer


if (p=1.or.p=101).and..not.lpt15
   dziel=1
   do rap
   if lastkey()#27
     eject
     w=0
     dziel=2
     go top
     do rap
   endif  && konczy warunek drukowania strony  B   
else
  dziel=0
  do case
    case p=1.or.p=101
      do rap
	case p=2.or.p=8
	  do wyposazenie  
    case p=4
	  do ewidencja
    case p=5        &&rej spraedazy
	  do ksdruk with 2
    case p=55        &&rej sprzedazy / tylko faktury dla osob (RN)
	  do ksdruk with 55	  
	case p=6        &&rej zakupow
	  do ksdruk with 3  
	case p=7        &&srodki trwale
	  do ksdruk with 6  
    case p=9        &&raport
	  do ksprotokol
    case p=102
	  k_export_dr()
    case p=103
	  r_export_dr()	  
  endcase
endif   
* * *
@ prow(),pcol() say &zdr_kkond
if.not.plikdruk.and.p#5.and.p#6.and.p#7
  eject
endif  
set device to screen

if p#102.and.p#103
  use
endif  
set device to screen

if plikdruk.and.p#5.and.p#6.and.p#7
  set printer to
  zz=.t.
  do gkom with "Edycja na ekranie ?  [T/N] ",zz
  if zz.and.lastkey()#27
    run ne \kjdruk.prn    
  endif	
endif
restore screen from em
RETURN

***************************************************** KSIEGA  RAPORT MIESIECZNY
PROCEDURE RAP
local str:=1
local sep:='|----|--|--------|---------------|---------------|----------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|---------|'
declare suma[13],folio[13]
for i=1 to 13
 suma[i]:=0
 folio[i]:=0
next
do tytrap with str
do while.not.eof()
  
  if w>dl
    do ksstopa
    eject
	w=0
	str=str+1
	for i=1 to 13
	  folio[i]=folio[i]+suma[i]
	  suma[i]=0
	next
	do tytrap with str
  endif

  for k=1 to 13
    suma[k]=suma[k]+fieldget(k+6)
  next
     suma[11]=suma[11]+kswypos       &&dolozenie amortyzacji jednorazowej
  do wiersz
  w=w+1  
  do case
    case dziel=0
      @ w,0 say sep
    case dziel=1
      @ w,0 say substr(sep,1,115)
    case dziel=2
      @ w,0 say substr(sep,115)
  endcase
  w=w+1
  skip
enddo
do ksstopa
RETURN


PROCEDURE TYTRAP
parameters stron
local lmiesiac:=space(15)
local lms:=ms
@ w,0 say &zdr_kkond+firnazwa+&zdr_kond
w=w+1
@ w,0 say fwl
do miesiac with lms,lmiesiac
@ w,40 say "Miesiac :"
@ w,50 say lmiesiac
@ w,pcol()+3 say year(daf)
@ w,pcol()+1 say "r."
@ w,80 say "TABULOGRAM KOMPUTEROWY NR"
@ w,106 say lms picture "99"
@ w,108 say "/"
@ w,109 say year(daf)
w=w+1
do case
  case dziel=0
    @ w,100 say "Strona :"
    @ w,108 say stron picture "999"
    @ prow()+1,0 say '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '|    |  |  Nr    |          kontrahent           |     opis       |              przychod             |zak. mater.|  koszty   |                    wydatki (koszty)                       |         |'
    @ prow()+1,0 say '| Lp.|Dz| dowodu |-------------------------------|   zdarzenia    |-----------------------------------|podstawow. |  uboczne  |----------------------------------------------------------------------'
    @ prow()+1,0 say '|    |  | ksiego-|imie i nazwisko|     adres     |  gospodarczego |obr.ze sprz| pozostale |   RAZEM   | i towarow |  zakupu   |reprezenta-|wynagrodze-| pozostale |   razem   |           |  uwagi  |'
    @ prow()+1,0 say '|    |  |  wego  |    (firma)    |               |                |tow.  i usl| przychody | przychod  |handlowych |           |cji i rekl.|nie got/nat|  wydatki  |  wydatki  |           |         |'
    @ prow()+1,0 say '|----|--|--------|---------------|---------------|----------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|---------|'
	@ prow()+1,0 say '| 1  |2 |   3    |       4       |        5      |        6       |     7     |      8    |     9     |    10     |     11    |   12      |     13    |     14    |     15    |     16    |    17   |'
    @ prow()+1,0 say '|----|--|--------|---------------|---------------|----------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|---------|'
  case dziel=1
    @ w,100 say "Strona A"
	@ w,108 say stron picture "999"
    @ prow()+1,0 say '-------------------------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '|    |  |  Nr    |          kontrahent           |     opis       |              przychod             |zak. mater.|'
    @ prow()+1,0 say '| Lp.|Dz| dowodu |-------------------------------|   zdarzenia    |-----------------------------------|podstawow. |'
    @ prow()+1,0 say '|    |  | ksiego-|imie i nazwisko|     adres     |  gospodarczego |obr.ze sprz| pozostale |   RAZEM   | i towarow |'
    @ prow()+1,0 say '|    |  |  wego  |    (firma)    |               |                |tow.  i usl| przychody | przychod  |handlowych |'
    @ prow()+1,0 say '|----|--|--------|---------------|---------------|----------------|-----------|-----------|-----------|-----------|'
    @ prow()+1,0 say '| 1  |2 |   3    |       4       |        5      |        6       |     7     |      8    |     9     |    10     |'
    @ prow()+1,0 say '|----|--|--------|---------------|---------------|----------------|-----------|-----------|-----------|-----------|'
  case dziel=2
    @ w,100 say "Strona B"		
	@ w,108 say stron picture "999"
    @ prow()+1,0 say '-----------------------------------------------------------------------------------'
    @ prow()+1,0 say '|  koszty   |                    wydatki (koszty)                       |         |'
    @ prow()+1,0 say '|  uboczne  |----------------------------------------------------------------------'
    @ prow()+1,0 say '|  zakupu   |reprezenta-|wynagrodze-| pozostale |   razem   |           |  uwagi  |'
    @ prow()+1,0 say '|           |cji i rekl.|nie got/nat|  wydatki  |  wydatki  |           |         |'
    @ prow()+1,0 say '|-----------|-----------|-----------|-----------|-----------|-----------|---------|'
	@ prow()+1,0 say '|     11    |   12      |     13    |     14    |     15    |     16    |    17   |'
    @ prow()+1,0 say '|-----------|-----------|-----------|-----------|-----------|-----------|---------|'
endcase
w=prow()+1
RETURN


PROCEDURE WIERSZ
local wtxt:= '|    |  |        |               |               |                |           |           |           |           |           |           |           |           |           |           |         |'
local wtxt1:='|    |  |        |               |               |                |           |           |           |           |           |           |           |           |           |           |         |'
local lksdow:=ksdow
if .not. kszak
  lksdow=ndok_druk(lksdow)
endif
if kspoz>9999
  wtxt=stuff(wtxt,1,5,str(kspoz))
else
  wtxt=stuff(wtxt,2,4,str(kspoz))
endif
wtxt=stuff(wtxt,7,2,str(ksday))
wtxt=stuff(wtxt,10,8,substr(lksdow,1,8))
wtxt=stuff(wtxt,19,15,substr(ksnaz,1,15))
wtxt=stuff(wtxt,35,15,substr(ksadr,1,15))
wtxt=stuff(wtxt,51,16,ksopis)
wtxt=stuff(wtxt,188,9,substr(ksuwag,1,9))

if kstow#0
  wtxt=stuff(wtxt,68,11,str(kstow,11,2))
endif
if ksusl#0
  wtxt=stuff(wtxt,80,11,str(ksusl,11,2))
endif
if kssum#0
  wtxt=stuff(wtxt,92,11,str(kssum,11,2))
endif
if kszakup#0
  wtxt=stuff(wtxt,104,11,str(kszakup,11,2))
endif
if ksubocz#0
  wtxt=stuff(wtxt,116,11,str(ksubocz,11,2))
endif
*if ksobrot#0
*  wtxt=stuff(wtxt,128,11,str(ksobrot,11,2))
*endif
*if ksobc>0
*  wtxt=stuff(wtxt,140,11,str(ksobc,11,2))
*endif
if ksrep#0
  wtxt=stuff(wtxt,128,11,str(ksrep,11,2))
endif
if ksgot#0
  wtxt=stuff(wtxt,140,11,str(ksgot,11,2))
endif
*If ksnat>0
*  wtxt=stuff(wtxt,175,11,str(ksnat,11,2))
*endif
if kswyd#0
  wtxt=stuff(wtxt,152,11,str(kswyd,11,2))
endif
if kswypos#0
  wtxt=stuff(wtxt,152,11,str(kswypos,11,2))
endif
*if kswypos>0
*  wtxt=stuff(wtxt,199,11,str(kswypos,11,2))
*endif
if kswydsum#0
  wtxt=stuff(wtxt,164,11,str(kswydsum,11,2))
endif

do case
  case dziel=0
    @ w,0 say wtxt
  case dziel=1
    @ w,0 say substr(wtxt,1,115)
  case dziel=2
    @ w,0 say substr(wtxt,115)		
endcase
if substr(ksnaz,16,15)#space(15).or.substr(ksadr,16,15)#space(15).or.substr(ksdow,9,7)#space(7).or.substr(ksuwag,6,5)#space(5)
  wtxt1=stuff(wtxt1,10,7,substr(ksdow,9,7))
  wtxt1=stuff(wtxt1,19,15,substr(ksnaz,16,15))
  wtxt1=stuff(wtxt1,35,15,substr(ksadr,16,15))
  wtxt1=stuff(wtxt1,188,8,substr(ksuwag,10,8))
  w=w+1
  do case
    case dziel=0
      @ w,0 say wtxt1
    case dziel=1
      @ w,0 say substr(wtxt1,1,115)
    case dziel=2
      @ w,0 say substr(wtxt1,115)		
  endcase  
endif
RETURN


PROCEDURE KSSTOPA
local t[13]
local sum:= '                                                 |                |           |           |           |           |           |           |           |           |           |           |         |'
local lin1:='|------------------------------------------------|----------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|---------|'
local lin2:='                                                 ----------------------------------------------------------------------------------------------------------------------------------------------------'
for k=1 to 13
   t[k]=0
next
do case
  case dziel=0
    @ w,0 say lin1
  case dziel=1
    @ w,0 say substr(lin1,1,115)
  case dziel=2
	@ w,0 say substr(lin1,115) 
endcase
for i=1 to 3
  sum:='                                                 |                |           |           |           |           |           |           |           |           |           |           |         |'

  do case
    case i=1
	  for k=1 to 13
	    t[k]=suma[k]
	  next
      sum=stuff(sum,51,16," Suma folio     ")
    case i=2
	  for k=1 to 13
	    t[k]=folio[k]
	  next
	  sum=stuff(sum,51,16," Przen. z folio ")
    case i=3
	  for k=1 to 13
	    t[k]=suma[k]+folio[k]
	  next	
	  sum=stuff(sum,51,16," Razem          ")  
  endcase
  
  if t[1]#0
    sum=stuff(sum,68,11,str(t[1],11,2))
  endif
  if t[2]#0
    sum=stuff(sum,80,11,str(t[2],11,2))
  endif
  if t[3]#0
    sum=stuff(sum,92,11,str(t[3],11,2))
  endif
  if t[4]#0
    sum=stuff(sum,104,11,str(t[4],11,2))
  endif
  if t[5]#0
    sum=stuff(sum,116,11,str(t[5],11,2))
  endif
* if t[6]>0
*   sum=stuff(sum,128,11,str(t[4],11,2))
* endif
* if t[7]>0
*   sum=stuff(sum,140,11,str(t[7],11,2))
* endif
  if t[8]#0
    sum=stuff(sum,128,11,str(t[8],11,2))
  endif
  if t[9]#0
    sum=stuff(sum,140,11,str(t[9],11,2))
  endif
 * if t[10]>0
 *   sum=stuff(sum,175,11,str(t[10],11,2))
 * endif
  if t[11]#0
    sum=stuff(sum,152,11,str(t[11],11,2))
  endif
* if t[12]>0
*   sum=stuff(sum,199,11,str(t[12],11,2))
* endif
  if t[13]#0
    sum=stuff(sum,164,11,str(t[13],11,2))
  endif
  w=w+1
  do case
    case dziel=0
      @ w,0 say sum
      w=w+1
      @ w,0 say lin2
    case dziel=1
      @ w,0 say substr(sum,1,115)
      w=w+1
      @ w,0 say substr(lin2,1,115)
    case dziel=2
      @ w,0 say substr(sum,115)
      w=w+1
      @ w,0 say substr(lin2,115)
  endcase
next
RETURN




***********************************************************  EWIDENCJA
PROCEDURE EWIDENCJA
local cykl:=0
local str:=1
*local sep:="|---|--------|---------------|------------|------------|------------|------------|--------|---------------|------------|-----------|"
local sep:="|---|----------|---------------|------------|------------|------------|------------|----------|---------------|"
declare suma[5],folio[5]
pozycja=0        && kolejny numer na wydruku
for i=1 to 5
 suma[i]:=0
 folio[i]:=0
next

do tytew with str

do while.not.eof()
*  if (kstow#0.or.kszakup#0)
  if kstow#0
     pozycja=pozycja+1
      if w>dl
        do stopaew
        eject
        w=0
	    str=str+1
	    for i=1 to 5
	      folio[i]=folio[i]+suma[i]
	      suma[i]=0
	    next
	    do tytew with str
      endif
      
	  do case
	    case ksprocp=rycz_u
		  suma[1]=suma[1]+kstow
	    case ksprocp=rycz_p
		  suma[2]=suma[2]+kstow
	    case ksprocp=rycz_h
		  suma[3]=suma[3]+kstow		  		  
	  endcase
	  suma[4]=suma[4]+kstow
	  suma[5]=suma[5]+kszakup
	  if kssprzed
        do wierszew
        w=w+1  
        @ w,0 say sep
        w=w+1
	  endif	
	skip
  else
    skip
  endif
enddo
do stopaew
RETURN


PROCEDURE TYTEW
parameters stron
local t[8]
local lmiesiac:=space(15)
local lms:=ms
t[1]:="---------------------------------------------------------------------------------------------------------------"
t[2]:="|   |  Data    | Numer dowodu, |   Kwota przychodu opodatkowanego     |  Ogolem    | Data uzy |               |"
t[3]:="|Lp.| wpisu    | na podstawie  |           wedlug stawki              | przychod   | skania   |   U W A G I   |"
t[4]:="|   |          | ktorego doko- |------------|------------|------------| w zlotych  | przycho- |               |"
t[5]:="|   |          | nano wpisu    |        %   |        %   |        %   |  (4+5+6)   | du       |               |"
t[6]:="|---|----------|---------------|------------|------------|------------|------------|----------|---------------|"
t[7]:="| 1 |   2      |       3       |      4     |      5     |     6      |      7     |    8     |       9       |"
t[8]:="|=============================================================================================================="
t[5]=stuff(t[5],34,4,str(rycz_u,4,1))
t[5]=stuff(t[5],47,4,str(rycz_p,4,1))
t[5]=stuff(t[5],60,4,str(rycz_h,4,1))
@ w,0 say &zdr_kkond+firnazwa+&zdr_kond
w=w+1
@ w,5 say "E W I D E N C J A   P R Z Y C H O D O W    ZA MIESIAC : "
do miesiac with lms,lmiesiac
@ w,62 say lmiesiac
@ w,pcol()+3 say year(daf)
@ w,pcol()+1 say "r."
@ w,90 say "Strona :"
@ w,98 say stron picture "999"
 *@ w,141 say fwl
for i=1 to 8
  w=w+1
  @ w,0 say t[i]
next
w=w+1
RETURN



PROCEDURE WIERSZEW
local wtxt:="|   |          |               |            |            |            |            |          |               |"
local lz:=0
local kstxt:=space(12)
local kztxt:=space(12)

if kstow<1000000.00
  kstxt=stuff(kstxt,13-len(alltrim(strj(kstow))),len(alltrim(strj(kstow))),alltrim(strj(kstow))) 
else
  kstxt=stuff(kstxt,13-len(alltrim(str(kstow,11,2))),len(alltrim(str(kstow,11,2))),alltrim(str(kstow,11,2))) 
endif

wtxt=stuff(wtxt,2,3,str(pozycja,3,0))
wtxt=stuff(wtxt,6,10,dtoc(ksdata))
wtxt=stuff(wtxt,85,10,dtoc(ksdata))
wtxt=stuff(wtxt,96,15,substr(ksuwag,1,15))
*if kssprzed
  wtxt=stuff(wtxt,17,15,ksdow)
  do case
    case ksprocp=rycz_u
      wtxt=stuff(wtxt,33,12,kstxt)
    case ksprocp=rycz_p
      wtxt=stuff(wtxt,46,12,kstxt)
    case ksprocp=rycz_h
      wtxt=stuff(wtxt,59,12,kstxt)		
  endcase	
  wtxt=stuff(wtxt,72,12,kstxt)		
*else
*    wtxt=stuff(wtxt,83,8,dtoc(ksdata))
*	wtxt=stuff(wtxt,92,15,ksdow)
*	wtxt=stuff(wtxt,108,12,kztxt)		
*endif

@ w,0 say wtxt
RETURN



PROCEDURE STOPAEW
local stxt1:=space(12)
local stxt2:=space(12)
local stxt3:=space(12)
local stxt4:=space(12)
local stxt5:=space(12)
local lz:=0
local t[5] 
local  sum:="                               |            |            |            |            |          |               |"
local lin1:="|------------------------------|------------|------------|------------|------------|----------|---------------|"
local lin2:="                               |-------------------------------------------------------------------------------"
for k=1 to 5
   t[k]=0
next
    @ w,0 say lin1
for i=1 to 3
  sum:="                               |            |            |            |            |          |               |"

  do case
    case i=1
	  for k=1 to 5
	    t[k]=suma[k]
	  next
      sum=stuff(sum,16,13,"Suma folio   ")
    case i=2
	  for k=1 to 5
	    t[k]=folio[k]
	  next
	  sum=stuff(sum,16,13,"Przen.z folio")
    case i=3
	  for k=1 to 5
	    t[k]=suma[k]+folio[k]
	  next	
	  sum=stuff(sum,16,13," Razem       ")  
  endcase
  
  
if t[1]<1000000.00
  stxt1=stuff(space(12),13-len(alltrim(strj(t[1]))),len(alltrim(strj(t[1]))),alltrim(strj(t[1]))) 
else
  stxt1=stuff(space(12),13-len(alltrim(str(t[1],11,2))),len(alltrim(str(t[1],11,2))),alltrim(str(t[1],11,2))) 
endif

if t[2]<1000000.00
  stxt2=stuff(space(12),13-len(alltrim(strj(t[2]))),len(alltrim(strj(t[2]))),alltrim(strj(t[2]))) 
else
  stxt2=stuff(space(12),13-len(alltrim(str(t[2],11,2))),len(alltrim(str(t[2],11,2))),alltrim(str(t[2],11,2))) 
endif

if t[3]<1000000.00
  stxt3=stuff(space(12),13-len(alltrim(strj(t[3]))),len(alltrim(strj(t[3]))),alltrim(strj(t[3]))) 
else
  stxt3=stuff(space(12),13-len(alltrim(str(t[3],11,2))),len(alltrim(str(t[3],11,2))),alltrim(str(t[3],11,2))) 
endif

if t[4]<1000000.00
  stxt4=stuff(space(12),13-len(alltrim(strj(t[4]))),len(alltrim(strj(t[4]))),alltrim(strj(t[4]))) 
else
  stxt4=stuff(space(12),13-len(alltrim(str(t[4],11,2))),len(alltrim(str(t[4],11,2))),alltrim(str(t[4],11,2))) 
endif

if t[5]<1000000.00
  stxt5=stuff(space(12),13-len(alltrim(strj(t[5]))),len(alltrim(strj(t[5]))),alltrim(strj(t[5]))) 
else
  stxt5=stuff(space(12),13-len(alltrim(str(t[5],11,2))),len(alltrim(str(t[5],11,2))),alltrim(str(t[5],11,2))) 
endif  
  sum=stuff(sum,33,12,stxt1)
  sum=stuff(sum,46,12,stxt2)  
  sum=stuff(sum,59,12,stxt3)      
  sum=stuff(sum,72,12,stxt4)    
  w=w+1
      @ w,0 say sum
      w=w+1
      @ w,0 say lin2
next
RETURN



***********************************************************  EWIDENCJA
PROCEDURE WYPOSAZENIE
local cykl:=0
local str:=1
local sep:="|----|--------|---------------|-------------------------|------------|----|--------|-------------------------|---------------|"
declare suma[5],folio[5]
pozycja=0        && kolejny numer na wydruku
for i=1 to 5
 suma[i]:=0
 folio[i]:=0
next

do tytwyp with str
if p=8
  use jednoraz index jednoraz
else  
  use wypos index wypos
endif  
do while.not.eof()
     pozycja=pozycja+1
      if w>dl
        do stopawyp
        eject
        w=0
	    str=str+1
	    do tytwyp with str
      endif
      
        do wierszwyp
        w=w+1  
        @ w,0 say sep
        w=w+1
	skip
enddo
do stopawyp
use
select 2
RETURN


PROCEDURE TYTWYP
parameters stron
local lmiesiac:=space(15)
local lms:=ms
  @ w,0 say &zdr_kkond+firnazwa+&zdr_kond
  w=w+1
  if p=8
    @ w,5 say "  SRODKI TRWALE AMORTYZOWANE JEDNORAZOWO                 ZA MIESIAC : "
  else
    @ w,5 say "    E W I D E N C J A   W Y P O S A Z E N I A            ZA MIESIAC : "
  endif
  do miesiac with lms,lmiesiac
  @ w,76 say lmiesiac
  @ w,pcol()+3 say year(daf)
  @ w,pcol()+1 say "r."
    @ w,104 say "Strona :"
    @ w,112 say stron picture "999"
    @ w,141 say fwl 
    @ prow()+1,0 say "-----------------------------------------------------------------------------------------------------------------------------"
    if p=8
	  @ prow()+1,0 say "|    |  Data  |     Numer     |  Nazwa srodka trwalego  |    Cena    |Nr  |Data li-|  Przyczyna  likwidacji  |      Uwagi    |"
	else
      @ prow()+1,0 say "|    |  Data  |     Numer     |    Nazwa wyposazenia    |    Cena    |Nr  |Data li-|  Przyczyna  likwidacji  |      Uwagi    |"
    endif
	@ prow()+1,0 say "| Lp.| nabycia|   dokumentu   |                         |  nabycia   |poz.|kwidacji|                         |               |"
    @ prow()+1,0 say "|----|--------|---------------|-------------------------|------------|----|--------|-------------------------|---------------|"
	@ prow()+1,0 say "| 1  |   2    |       3       |            4            |      5     |  6 |    7   |             8           |        9      |"
    @ prow()+1,0 say "|============================================================================================================================|"

w=prow()+1
RETURN



PROCEDURE WIERSZWYP
local wtxt:="|    |        |               |                         |            |    |        |                         |               |"
wtxt=stuff(wtxt,2,4,str(pozycja,4,0))
wtxt=stuff(wtxt,7,8,dtoc(wdata))
wtxt=stuff(wtxt,16,15,wnumer)
wtxt=stuff(wtxt,32,25,wnazwa)
wtxt=stuff(wtxt,58,12,STR(wcena,12,2))		
wtxt=stuff(wtxt,71,4,STR(wnr,4,0))		
wtxt=stuff(wtxt,76,8,dtoc(wdatlik))		
wtxt=stuff(wtxt,85,25,wprzyczyna)		
wtxt=stuff(wtxt,111,15,wuwagi)		

@ w,0 say wtxt
RETURN



PROCEDURE STOPAWYP
local lin1:="------------------------------------------------------------------------------------------------------------------------------"
@ w,0 say lin1
RETURN

PROCEDURE KSPROTOKOL
local ltyt:="P R O T O K O L    NR   /    /                 "
local lrazem:=0,k:=0
*w=0
*index on ksdow+str(len(alltrim(ksdow))) to ks_dow
do pliksum1
index on str(len(alltrim(ksdow)))+ksdow to ks_dow
use rejsum index ks_dow
@ w,60 say  pammiasto
@ w,pcol()+3 say "Dnia:"+&zdr_kkond
if grafik
  @ prow(),pcol() say &zdr_grubo
endif
@ w,pcol()+3 say date()
w=w+1
@ w,0 say flic1
w=w+1
@ w,0 say flic2
w=w+1
@ w,0 say flic3
w=w+1
@ w,0 say flic4
w=w+1
@ w,0 say flic5
w=w+3
ltyt=stuff(ltyt,23,2,str(ms,2))
ltyt=stuff(ltyt,27,2,substr(str(year(daf)),4,2))
ltyt=stuff(ltyt,32,15,firnazwa)
@ w,17 say ltyt
w=w+3

* wydruk spisu dokumentow sprzedazy
@ w,0 say "1. DOKUMENTY SPRZEDAZY :" 
w=w+2
if grafik
  @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
else
  @ prow(),pcol() say &zdr_kond
endif  
set filter to kssum#0
go top
do while.not.eof()
  if.not. substr(ksnic,4,1)="*"   &&Jesli nie jest wylaczony z protokolu
    lrazem=lrazem+1
    @ w,k*20 say ksdow
    k=k+1
    if k>5
      k=0
	  w=w+1
    endif
  endif
  skip
enddo  
if grafik
  @ prow(),pcol() say &zdr_grubo+&zdr_kkond
else  
  @ prow(),pcol() say &zdr_kkond
endif  

*w=w+1
*@ w,0 say lrazem

w=w+2
@ w,0 say "2. DOKUMENTY ZAKUPU :" 
w=w+2
if grafik
  @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
else
  @ prow(),pcol() say &zdr_kond
endif  
set filter to kszakup#0
go top
k=0
do while.not.eof()
  if.not. substr(ksnic,4,1)="*"   &&Jesli nie jest wylaczony z protokolu
    lrazem=lrazem+1
    @ w,k*20 say ksdow
    k=k+1
    if k>5
      k=0
	  w=w+1
    endif
  endif 
  skip
enddo  
if grafik
  @ prow(),pcol() say &zdr_grubo+&zdr_kkond
else  
  @ prow(),pcol() say &zdr_kkond
endif  

*w=w+1
*@ w,0 say lrazem

w=w+2
@ w,0 say "3. KOSZTY :" 
w=w+2
if grafik
  @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
else
  @ prow(),pcol() say &zdr_kond
endif  
set filter to kswyd#0.or.ksubocz#0.or.ksrep#0.or.ksgot#0
go top
k=0
do while.not.eof()
  if.not. substr(ksnic,4,1)="*"   &&Jesli nie jest wylaczony z protokolu
    lrazem=lrazem+1
    @ w,k*20 say ksdow
    k=k+1
    if k>5
      k=0
	  w=w+1
    endif
  endif 
  skip
enddo  
if grafik
  @ prow(),pcol() say &zdr_grubo+&zdr_kkond
else  
  @ prow(),pcol() say &zdr_kkond
endif  
set filter to
go top
w=w+3
@ w,0 say "LICZBA PRZEKAZANYCH DOKUMENTOW :"
@ W,34 say lrazem picture "9999"
w=w+7
if grafik
  @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
else
  @ prow(),pcol() say &zdr_kond
endif  
@ w,0 say ".............................................                    ............................................."
w=w+1
@ w,0 say "     podpis i pieczec osoby przekazujacej                             podpis i pieczec osoby odbierajacej     "
w=w+1
@ w,0 say "     dokumenty ksiegowe                                               dokumenty ksiegowe                      "
close
RETURN


FUNCTION K_EXPORT_DR()
w=prow()
k=7
@ w,k say " R O Z L I C Z E N I E    F A K T U R Y    E K S P O R T O W E J    "
w=w+1
@ w,k say "---------------------------------------------------------------    "
w=w+4
@ w,k say "S P R Z E D A W C A  :"
@ w,k+38 say "N A B Y W C A  :"
w=w+2
@ w,k say firnazwa
@ w,k+38 say znaz1
w=w+1
@ w,k say zfirmiasto
@ w,k+38 say zmiasto
w=w+1
@ w,k say substr(zfirulica,1,14)	
w=w+7
@ w,k+10 say "DOTYCZY FAKTURY NR ....."
@ w,k+35 say zksdow
w=w+2
@ w,k+10 say "DATA KSIEGOWANIA ......."
@ w,k+35 say zksdata        
w=w+7
@ w,k say "TABELA KURSOW SREDNICH NBP  NR ........"
@ w,k+40 say zsad_numer
w=w+2
@ w,k say "WALUTA ................................"
@ w,k+40 say zwaluta+" ("+zwal_skrot+")"
w=w+2
@ w,k say "KURS SREDNI ..........................."
w=w+2
k=k-18
@ w,k+40 say zile_jednostek picture "999"
@ w,k+44 say zwal_skrot
@ w,k+49 say "=" 
@ w,k+51 say zkurs picture "999.9999"
@ w,k+61 say "zl" 
w=w+2
k=k+18
@ w,k say "WARTOSC FAKTURY WG KURSU SREDNIEGO ...."
w=w+2
k=k-30
@ w,k+40 say zdewiz_kwot picture "999999.99"
@ w,k+50 say "x"
@ w,k+52 say zkurs picture "999.9999"
@ w,k+61 say "="
@ w,k+63 say zks00 picture "99999999.99"
@ w,k+76 say "zl"+ &zdr_kond   
k=k+30
w=w+2
ks_pslownie(w,k,zks00)
@ prow(),pcol() say &zdr_kkond
w=w+11
@ w,40 say "----------------------------------"
w=w+1
@ w,40 say "podpis sporzadzajacego rozliczenie"

*eject
RETURN 

FUNCTION R_EXPORT_DR()
w=prow()
k=7
@ w,k say " R O Z L I C Z E N I E    F A K T U R Y    E K S P O R T O W E J    "
w=w+1
@ w,k say "---------------------------------------------------------------    "
w=w+4
@ w,k say "S P R Z E D A W C A  :"
@ w,k+38 say "N A B Y W C A  :"
w=w+2
@ w,k say firnazwa
@ w,k+38 say znaz1
w=w+1
@ w,k say zfirmiasto
@ w,k+38 say zmiasto
w=w+1
@ w,k say substr(zfirulica,1,14)	
w=w+7
@ w,k+10 say "DOTYCZY FAKTURY NR ....."
@ w,k+35 say zksdow
w=w+2
@ w,k+10 say "DATA KSIEGOWANIA ......."
@ w,k+35 say zksdata        
w=w+7
@ w,k say "SAD NR "
@ w,k+9 say zsad_numer
*@ w,k+30 say "Z DNIA ..."
*@ w,k+40 say zsad_dat
w=w+2
@ w,k say "WALUTA ................."
@ w,k+25 say zwaluta+" ("+zwal_skrot+")"
w=w+2
@ w,k say "KURS SREDNI ............"
w=w+2
k=k-18
@ w,k+40 say zile_jednostek picture "999"
@ w,k+44 say zwal_skrot
@ w,k+49 say "=" 
@ w,k+51 say zkurs picture "999.9999"
@ w,k+61 say "zl" 
w=w+2
k=k+18
@ w,k say "WARTOSC FAKTURY WG KURSU SREDNIEGO ...."
w=w+2
k=k-30
@ w,k+40 say zdewiz_kwot picture "999999.99"
@ w,k+50 say "x"
@ w,k+52 say zkurs picture "999.9999"
@ w,k+61 say "="
@ w,k+63 say zks00 picture "99999999.99"
@ w,k+76 say "zl"+ &zdr_kond   
k=k+30
w=w+2
ks_pslownie(w,k,zks00)
@ prow(),pcol() say &zdr_kkond
w=w+11
@ w,40 say "----------------------------------"
w=w+1
@ w,40 say "podpis sporzadzajacego rozliczenie"   
*eject
RETURN 


FUNCTION KS_PSLOWNIE(prow,pcol,pkwota)
local kwota:=ALLTRIM(str(pkwota))
local cyfra:=" ",ltxt:=""
@ prow,pcol say "SLOWNIE : "
for i=1 to len(kwota)
  do case
    case substr(kwota,i,1)="0"
	  cyfra="*zero"
    case substr(kwota,i,1)="1"
	  cyfra="*jeden"
    case substr(kwota,i,1)="2"
	  cyfra="*dwa"
    case substr(kwota,i,1)="3"
      cyfra="*trzy"
    case substr(kwota,i,1)="4"
	  cyfra="*cztery"
    case substr(kwota,i,1)="5"
      cyfra="*piec"
    case substr(kwota,i,1)="6"
	  cyfra="*szesc"
    case substr(kwota,i,1)="7"
	  cyfra="*siedem"
    case substr(kwota,i,1)="8"
	  cyfra="*osiem"
    case substr(kwota,i,1)="9"
	  cyfra="*dziewiec"
    case substr(kwota,i,1)="."
	  cyfra="*Zl "	  
  endcase
  @ prow(),pcol() say cyfra
next
  @ prow(),pcol() say " GR "
RETURN ltxt