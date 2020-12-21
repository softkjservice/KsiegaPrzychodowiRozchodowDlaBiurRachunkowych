*p14=.t. - wprowadzanie z poziomu rubryki 14  .f. - wejscie ze spisu ogolnego
parameters p14
local t[9],q[9],t1[2],q1[2]
local ek:=savescreen(0,0,24,79)
t[1]:="wlp"
t[2]:="wdata"
t[3]:="wnumer"
t[4]:="wnazwa"
t[5]:="wcena"
t[6]:="wnr"
t[7]:="wdatlik"
t[8]:="wprzyczyna"
t[9]:="wuwagi"
q[1]:=" Lp."
q[2]:="DataNab."
q[3]:="Nr dokumentu"
q[4]:="N a z w a        "
q[5]:="Cena nabycia"
q[6]:="Nr/K"
q[7]:="Data likwidacji"
q[8]:="Przyczyna likwidacji"
q[9]:="Uwagi"
t1[1]:="wnazwa"
t1[2]:="wcena"
q1[1]:="N a z w a        "
q1[2]:="Cena nabycia"
public zwlp:=0
public zwdata:=zksdata
public zwnumer:=zksdow
public zwnazwa:=space(25)
public zwcena:=0
public zwnr:=0
public zwdatlik:=ctod("        ") 
public zwprzyczyna:=space(25)
public zwuwagi:=space(15)
if.not.p14
  clear
  @ 0,0,24,79 box chr(176)
  set color to n/w
  @ 0,0 say "  EWIDENCJA                                                                     "
  do skom with " dopisz_Wzor/Nowa    Popraw    Kasuj   Esc-rezygnacja "   
else
  do skom with " ENTER - zatwierdzenie     ESC - rezygnacja"

  @ 11,0,23,42 box chr(176)
  @ 11,0,23,43 box chr(176)
  @ 21,1 say "========================================="
  @ 22,1 say "                          |              "  
endif
use wypos index wypos new
wkoniec=.f.
do while.t.
  if p14
    set color to n/w,w/n
    set filter to wdata=zksdata.and.wnumer=zksdow
	go top
    dbedit(12,1,20,41,t1,"w2","",q1)
  else
    dbedit(1,1,23,78,t,"w1","",q)
  endif	
  if wkoniec
    exit
  endif
enddo
close
set cursor off
restore screen from ek
select 2
return

FUNCTION W1(tryb,numer)
local last:=lastkey()
local ek:=savescreen(0,0,24,79)

do case
  case last=87.or.last=119
    restore screen from ek
	do wtlo
    do wget
    if lastkey()#27     
      append blank
   	  do wreplac 
	endif  
  case last=78.or.last=110    &&Nowy
    restore screen from ek
    do zwzer
	do wtlo
	do wget
    if lastkey()#27     
      append blank
   	  do wreplac 
	endif  
  case last=80.or.last=112   &&Popraw
    restore screen from ek
    do zwlad
	do wtlo
	do wget
    if lastkey()#27     
   	  do wreplac 
	endif  		
  case last=75.or.last=107   &&Koncz
    do zwlad
	do wtlo
	do wsay
	zz=.t.
	do gkom with "Kasowac ?  [T/N] ",zz
	if zz.and.lastkey()#27
	  delete
	  pack
	endif    
  case last=27
    zz=.t.
	do gkom with "Koniec  [T/N]  ? ",zz
	if lastkey()#27.and.zz
	  wkoniec=.t.
	  return 0
	endif 
    return 2
endcase
restore screen from ek
RETURN 1

PROCEDURE ZWZER
zwlp=0
zwdata=daf
zwnumer=space(15)
zwnazwa=space(25)
zwcena=0
zwnr=0
zwdatlik=ctod("        ") 
zwprzyczyna=space(25)
zwuwagi=space(15)
RETURN

PROCEDURE ZWLAD
zwlp=wlp
zwdata=wdata
zwnumer=wnumer
zwnazwa=wnazwa
zwcena=wcena
zwnr=wnr
zwdatlik=wdatlik
zwprzyczyna=wprzyczyna
zwuwagi=wuwagi
RETURN


PROCEDURE WGET
set cursor on
@ 14,16 get zwnazwa
@ 15,29 get zwcena picture "999999999.99"
@ 16,26 get zwnumer
@ 17,33 get zwdata
@ 18,33 get zwdatlik
@ 19,16 get zwprzyczyna
@ 20,26 get zwuwagi
@ 21,37 get zwnr picture "9999"
read
set cursor off
RETURN

PROCEDURE WSAY
set cursor on
set color to n/w
@ 14,16 say zwnazwa
@ 15,29 say zwcena picture "999999999.99"
@ 16,26 say zwnumer
@ 17,33 say zwdata
@ 18,33 say zwdatlik
@ 19,16 say zwprzyczyna
@ 20,26 say zwuwagi
@ 21,37 say zwnr picture "9999"
read
set cursor off
RETURN

PROCEDURE WTLO
set color to n/w

for i=14 to 22
  @ i,1 say space(40)
next
@ 11,0 say "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
set color to
@ 12,0 say "°         P  O  Z  Y  C  J  A            °"
@ 13,0 say "°========================================°"
set color to n/w
@ 14,0 say "° NAZWA.........                         °"
@ 15,0 say "° CENA NABYCIA  /ZL./ .......            °"
@ 16,0 say "° NUMER DOKUMENTY ZAKUPU..               °"
@ 17,0 say "° DATA NABYCIA...................        °"
@ 18,0 say "° DATA LIKWIDACJI................        °"
@ 19,0 say "° PRZYCZYNA.....                         °"
@ 20,0 say "° UWAGI...................               °"
@ 21,0 say "° NUMER POZYCJI KSIEGOWEJ............    °"
@ 22,0 say "°                                        °"
@ 23,0 say "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
set color to
@ 11,0,23,41 box chr(176)
RETURN

PROCEDURE WREPLAC
replace wlp with zwlp,wdata with zwdata,wnumer with zwnumer,wnazwa with zwnazwa
replace wcena with zwcena,wnr with zwnr,wdatlik with zwdatlik,wprzyczyna with zwprzyczyna
replace wuwagi with zwuwagi 
RETURN

FUNCTION W2(tryb,numer)
local last:=lastkey()
local ek:=savescreen(0,0,24,79)

do case
  case last=68.or.last=100          &&Dopisz
    zwnazwa=space(25)
	zwcena=0.00
    set cursor on
    @ 22,2 get zwnazwa picture "@!"
	@ 22,28 get zwcena picture "999999999.99"
	read
    if lastkey()#27     
      append blank
   	  do wreplac 
      keyboard chr(68)
	endif  
	set cursor off
    return 0
  case last=80.or.last=112   &&Popraw
    do zwlad
    set cursor on
    @ 22,2 get zwnazwa picture "@!"
	@ 22,28 get zwcena picture "999999999.99"
	read
    if lastkey()#27     
   	  do wreplac 
	endif  
	set cursor off
	return 0
  case last=75.or.last=107   &&Kasuj
	zz=.t.
	do gkom with "Kasowac ?  [T/N] ",zz
	if zz.and.lastkey()#27
	  delete
	  pack
	endif   
	return 0 
  case last=27
    zz=.t.
	do gkom with "Koniec  [T/N]  ? ",zz
	if lastkey()#27.and.zz
	  wkoniec=.t.
	  return 0
	endif
    do skom with " Dopisz    Popraw    Kasuj   Esc-rezygnacja "    
    return 2
endcase
RETURN 1


*******************************************************************************
* Procedura nadaje pozycjom w bazie wyposazenia odpowiednie numery z ksiegi   *
*******************************************************************************
PROCEDURE WKSNUM
local lwlp:=0
local lwnr:=0
local lwdata:=daf
local lwnumer:=space(15)
local lwday:=0
local found:=.f.
select 2
use ksiega index ksiega
select 1
use wypos index wypos 
do while.not.eof()
  found=.f.
  lwlp=lwlp+1
  lwdata=wdata
  lwday=day(lwdata)
  lwnumer=wnumer
  select 2
  seek lwday
  if found()
    do while ksday=lwday
	  if ksdow=lwnumer.and.kswyd>=200
	    lwnr=kspoz
		found=.t.
		exit
	  endif
	  skip
	enddo
  endif
  select 1
  replace wlp with lwlp
  if found
    replace wnr with lwnr
  endif
  skip
enddo
close
select 2
close
RETURN