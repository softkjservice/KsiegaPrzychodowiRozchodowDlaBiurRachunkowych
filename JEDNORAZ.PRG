*p18=.t. - wprowadzanie z poziomu rubryki 18  .f. - wejscie ze spisu ogolnego
parameters p18
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
if.not.p18
  clear
  @ 0,0,24,79 box chr(176)
  set color to n/w
  @ 0,0 say "  EWIDENCJA WYPOSAZENIA   -  MIESIAC                                            "
  do skom with " dopisz_Wzor/Nowa    Popraw    Kasuj   Esc-rezygnacja "   
else
  do skom with " ENTER - zatwierdzenie     ESC - rezygnacja"

  @ 11,0,23,42 box chr(176)
  @ 11,0,23,43 box chr(176)
  @ 21,1 say "========================================="
  @ 22,1 say "                          |              "  
endif
if.not.file("jednoraz.dbf")
  use wypos new
  copy structure to jednoraz
  index on wdata to jednoraz
  use jednoraz index jednoraz
else
  use jednoraz index jednoraz new
endif
wkoniec=.f.
do while.t.
  if p18
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



*******************************************************************************
* Procedura nadaje pozycjom w bazie wyposazenia odpowiednie numery z ksiegi   *
*******************************************************************************
PROCEDURE JKSNUM
local lwlp:=0
local lwnr:=0
local lwdata:=daf
local lwnumer:=space(15)
local lwday:=0
local found:=.f.
select 2
use ksiega index ksiega
select 1
use jednoraz index jednoraz
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
	  if ksdow=lwnumer.and..not.kswypos=0
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