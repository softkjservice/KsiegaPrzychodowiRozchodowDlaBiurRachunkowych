*PROCEDURE ARCHK
*PROCEDURE:  ARCHIWK, ARCHI, ARCHIWUJ, DOKAD
local t[2]
local s:=0
local dyskready:=.t.
t[1]:="1.  W P I S Y  "
t[1]:="BIEZACY MIESAC "
t[2]:="  KONTRAHENT   "
@ 8,48 to 11,64 double 
s=achoice(9,49,10,63,t)
do case
  case s=1
    do dysktest with dyskready
    if.not.dyskready
	  return
	endif  
    do archwpis
  case s=2
    do dysktest with dyskready
    if.not.dyskready
	  return
	endif    
    if ksiegakon
	  do kskondef
    else
	  do kondefault
    endif	  	  
    do archkon
endcase     
keyboard chr(205)	
RETURN



PROCEDURE ARCHWPIS
local lmiesiac:=month(daf)
dys:=substr(dysk,1,2)
@ 12,27 say "  Archiwizuj miesiac      "
set cursor on
@ 12,49 get lmiesiac picture "99" range 1,12
read
set cursor off
if lastkey()=27
  return
endif
set default to
close databases
*if file("firdef.dbf")
*  copy file firdef.dbf to &dys\firdef.dbf
*endif  
*if file("pam.mem")
*  copy file pam.mem to &dys\pam.mem
*endif  
do pksdefault with lmiesiac
if file("ksiega.dbf")
  copy file ksiega.dbf to &dys\ksiega.dbf
else
  do tkom with "Uwaga !  Plik ksiega.dbf nie odnaleziony.     Nacisnij dowolny klawisz."
endif  
if file("rejestr.dbf")
  copy file rejestr.dbf to &dys\rejestr.dbf
else
  do tkom with "Uwaga !  Plik rejestr.dbf nie odnaleziony.     Nacisnij dowolny klawisz."
endif  
set default to
restore from pam additive
do ksdefault
RETURN	

PROCEDURE ARCHKON
dys:=substr(dysk,1,2)
close databases
if file("kontrah.dbf")
  copy file kontrah.dbf to &dys\kontrah.dbf
endif  
if file("kontrah.dbf")
  copy file kontrah.dbf to &dys\kontrah.dbf
else
  do tkom with "Uwaga !  Plik kontrah.dbf nie odnaleziony.     Nacisnij dowolny klawisz."
endif  
if file("trah.dbf")
  copy file trah.dbf to &dys\trah.dbf
else
  do tkom with "Uwaga !  Plik trah.dbf nie odnaleziony.     Nacisnij dowolny klawisz."
endif  
set default to
restore from pam additive
do ksdefault
RETURN


*******************************************************************************
* Procedura sprawdza istnienie dyskietki w napedzie roboczym                  *
*******************************************************************************
PROCEDURE DYSKTEST
parameters pdyskready
sciezka=dysk
do while .t.
  n_nazwa=SCIEZKA+"TESTOWY.$$$"   && testowa nazwa wykorzystywana 
                                      && wylacznie do sprawdzenia poprawnosci 
                                      && sciezki 
  x=fcreate("&n_nazwa")      && utworzenie testowego pliku 
    if ferror()#0              && jesli zaistnial blad 
     set color to  
	 zz=.t.
     do case
       case dysk="A:\"
         do gkom with "Brak dostepu do dyskietki w napedzie A: !  Ponowic probe ?  [Y/F]",zz
       case dysk="B:\"
         do gkom with "Brak dostepu do dyskietki w napedzie B: !  Ponowic probe ?  [Y/F]",zz
     endcase
     pdyskready=.f.
	 if lastkey()=27.or..not.zz
       delete file  &n_nazwa   	 
       return
	 endif
   else
   	 pdyskready=.t.
     delete file  &n_nazwa 
	 exit
   endif  
   delete file  &n_nazwa      && usuniecie pliku testowego 
 enddo
RETURN

PROCEDURE KSINDEX
select 2
if file("ksiega.dbf")
  use ksiega
  index on ksday to ksiega
else
  do tkom with "Uwaga!  Plik ksiega.dbf nie odnaleziony.    Nacisnij dowolny klawisz."
endif
if file("rejestr.dbf")
  use rejestr
  index on ksday to rejestr
else
  do tkom with "Uwaga!  Plik rejestr.dbf nie odnaleziony.    Nacisnij dowolny klawisz."
endif
if ksiegakon
  do kskondef
else
  do kondefault
endif
if file("kontrah.dbf")
  use kontrah
  index on naz1 to kont_naz   
  index on nr_kontr to kont_nr
  index on nskrot to kont_nsk
else
  do tkom with "Uwaga!  Plik kontrah.dbf nie odnaleziony.    Nacisnij dowolny klawisz."
endif
if file("trah.dbf")
  use trah
  index on naz1 to trah_naz   
  index on nr_kontr to trah_nr
  index on nskrot to trah_nsk      
else
  do tkom with "Uwaga!  Plik trah.dbf nie odnaleziony.    Nacisnij dowolny klawisz."
endif  
use
knum=0
rnum=0
for i=1 to 12
  do pksdefault with i
  select 1
  use ksiega index ksiega
  do while.not.eof()
    knum=knum+1
	replace kspoz with knum
	skip
  enddo
  use rejestr index rejestr
  do while.not.eof()
    rnum=rnum+1
	replace kspoz with rnum
	skip
  enddo  
  use
next
do ksdefault
RETURN