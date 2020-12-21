 *******************************************************************************
* Dostosowanie dokumentow do postaci zgodnej z formatem rejestrow w ksiedze   *
* Znaczenie parametrow : pdok=-1 Rej.zakupu, pdok=4 Rej.sprzedazy (wszystko)  *
* pdok=1 Rej.sp. faktury, pdok=2 Rej.sp.rachunki, pdok=3 Rej.sp. paragony     *
*******************************************************************************
parameters pdok
local t[3]
local ef:=savescreen(0,0,24,79)
local ldok:=pdok
local war1:=""
local war2:=""
local war3:=""
public warunek:=".t."
t[1]:="  ZA MIESIAC  "
t[2]:="   ZA DZIEN   "
t[3]:="   ZA OKRES   "
save screen to ek
ms=0
miesiac=1
dzien=daf
dat1=daf
dat2=daf+1
set color to
@ 10,31 TO 14,47 double   
d=achoice(11,32,13,46,t)   
@ 21,1 clear to 23,78
do case
  case pdok=-1
    war1="month(datdok)=miesiac.and..not.ksiegowy"
    war2="datdok=dzien.and..not.ksiegowy"
    war3="max(dat1,datdok)=datdok.and.min(dat2,datdok)=datdok.and..not.ksiegowy"		
  case pdok=0
    war1="month(datdok)=miesiac.and..not.substr(ndok,12,1)$'fru'"
    war2="datdok=dzien.and..not.substr(ndok,12,1)$'fru'"
    war3="max(dat1,datdok)=datdok.and.min(dat2,datdok)=datdok.and..not.substr(ndok,12,1)$'fru'"		  
  otherwise
    war1="month(datdok)=miesiac"
    war2="datdok=dzien"
*    war3="max(dat1-1,datdok)=datdok.and.min(dat2,datdok)=datdok"		  
    war3="max(dat1,datdok)=datdok.and.min(dat2,datdok)=datdok"		  
endcase


do case 
  case d=1
    ms=miesiac               &&informacja dla modulu ksdruk
    warunek=war1
    @ 22,25 say "     Zatwierdz miesiac         "
    set cursor on
    @ 22,52 get miesiac picture "99" range 1,12	  
    read
	ms=miesiac
  case d=2
    ms=month(dzien)	
	warunek=war2
    @ 22,23 say "    Zatwierdz dzien                "
    set cursor on
    @ 22,47 get dzien	
	read
    ms=month(dzien)		
  case d=3
    ms=month(dat1)		
	warunek=war3
    @ 22,16 say " Zatwierdz  od dnia           do dnia           "
    set cursor on
    @ 22,36 get dat1
	@ 22,54 get dat2	 
	read
    ms=month(dat1)		 
endcase
set cursor off
if lastkey()=27
  restore screen from ek
  return
endif
do skom with "Czekaj! Trwaja operacje dyskowe."
zdok=pdok

select 2
if file("rejsum.dbf")
  use rejsum index rejsum
  zap
*  append blank 
else
  do tkom with "Brak pliku REJSUM.DBF i REJSUM.NTX - doinstaluj z dyskietki i ponow probe. Ok!"
  return
endif  
select 1
if pdok=0.or.pdok=-1
  for i=1 to 4
    do expodok with i
  next	
  if pdok=-1
    select 2
    return
  endif	
else
  do expodok with ldok
endif  

close databases
restore screen from ek
RETURN

*******************************************************************************
* Procedura przepisuje dokument do pliku rejsum.dbf (sel.2) z plikow z sel.1  *
* ppdok=1 - faktury, 2 - rachunki, 3 - utargi z paragonow, 4 - zakupy         *
*******************************************************************************
PROCEDURE EXPODOK
parameters ppdok
if ppdok=4
  zak=.t.
else
  zak=.f.
endif  
do case
  case ppdok=1
    use dokument index dok_num	
  case ppdok=2
    use rachunek index rach_num		
  case ppdok=3
    use paragon
	index on datdok to par_dat
	use paragon index par_dat
  case ppdok=4
    use pzdok index pz_num
endcase
set filter to &warunek
go top
do while.not.eof()
  do dokrej
  skip
enddo
RETURN


*******************************************************************************
* Procedura wpisuje dane z pliku typu "dokument.dbf" oraz typu "sprzedaz.dbf" *
* do pliku "rejsum.dbf" o strukturze identycznej ze struktura pliku "ksiega.db*
* Wymaga otwartego pliku rejsum w sel. 2 oraz otwartego pliku z dokumentami w *
* sel 1  Odtwarza strukture vatowska dokumentu oraz przywoluje dane kontrahent*
*******************************************************************************
PROCEDURE DOKREJ
local lksday:=day(datdok)
local lksdow:=ndok  
local lksnaz:=space(30)
local lksadr:=space(30)
local lksnip:=space(13)
local lksopis:=opis  
local lkstow:=0
local lkszakup:=0
local lksdata:=datdok
local lksmod:=space(3)
local lks22:=0
local lks07:=0
local lks00:=dnet_00
local lkszw:=dnet_zw
local lksvat22:=0
local lksvat07:=0
local lkszak:=zak
local lkssprzed:=.not.zak
local lksprocp:=0
local lnplat:=nplat
local lzewndok:=zewndok
local found:=.t.

if ppdok#3           &&jesli nie paragon
  do kondefault
  select 3
  use kontrah index kont_nr
  seek lnplat
  if.not.found()
    use trah index trah_nr
    seek lnplat
    if.not.found()
      use
	  do tkom with "PROBLEM! 30 Kontrahent nie odnaleziony. Ok!"
	  found=.f.
    endif
  endif 
  if found
    lksnaz=naz1
    lksnaz=stuff(space(30),1,len(alltrim(naz1)),alltrim(naz1))
    lksnaz=stuff(lksnaz,len(alltrim(naz1))+2,30-len(alltrim(naz1))-2,substr(naz2,1,30-len(alltrim(naz1))-2))   
    lksnip=nip
    lksadr=stuff(space(30),1,len(alltrim(miasto)),alltrim(miasto))
    lksadr=stuff(lksadr,len(alltrim(miasto))+2,30-len(alltrim(miasto))-2,substr(ulica,1,30-len(alltrim(miasto))-2))   
    if len(alltrim(naz1))+len(alltrim(naz2))>27
	  lksnaz=stuff(lksnaz,30,1,"-")
	endif	
    if len(alltrim(miasto))+len(alltrim(ulica))>27
	  lksadr=stuff(lksadr,30,1,"-")
	endif
  endif
  use
  do dokdefault
endif  

select 1
do doklicz with lks22,lks07,lksvat22,lksvat07
if.not.vvt
  lks22=lks22+lksvat22
  lks07=lks07+lksvat07
endif



if ppdok=3
  lksopis="UTARG DZIENNY"
endif  

select 2
if ppdok=3.and.ksdata=lksdata.and.substr(ksmod,1,1)$"PT"
  lks22=lks22+ks22
  lks07=lks07+ks07
  lks00=lks00+ks00
  lkszw=lkszw+kszw
  lksvat22=lksvat22+ksvat22
  lksvat07=lksvat07+ksvat07
else
  append blank
endif  
replace ksmod with stuff(space(3),1,1,substr(lksdow,12,1))
if lkssprzed.and.substr(lksdow,14,1)="K"
  replace ksmod with stuff(ksmod,2,1,"k")
endif
do case
  case substr(lksdow,12,1)="N".and..not.zak
    lksdow=stuff(lksdow,12,1,"R")
  case substr(lksdow,12,1)="U".and..not.zak
    lksdow=stuff(lksdow,12,1,"F")	
endcase
replace ksday with lksday,ksdow with alltrim(lksdow),ksnaz with lksnaz,ksadr with lksadr
replace ksnip with lksnip,ksopis with lksopis,ksdata with lksdata
replace kszak with lkszak,kssprzed with lkssprzed
replace ks22 with lks22,ks07 with lks07,ks00 with lks00,kszw with lkszw
replace ksexport with .t.


if substr(lksdow,12,1)#"r".and.vvt
  replace ksvat22 with lksvat22,ksvat07 with lksvat07
endif
if zak
  replace kszakup with lks22+lks07+lks00+lkszw
  replace ksdow with alltrim(lzewndok)
  replace ksuwag with alltrim(lksdow)  
else
  replace kstow with lks22+lks07+lks00+lkszw 
  replace kssum with lks22+lks07+lks00+lkszw   
endif  
if zryczalt
  lksprocp=zksprocp
  replace ksprocp with lksprocp
  replace ksobrot with kstow*(lksprocp/100)
endif

if ppdok=3
  replace ksdow with "UTARG DZIENNY  "
endif  


select 1
RETURN



PROCEDURE ZAPISZIMP
local t[50]
local miesiac:=0
close databases
select 1
use rejsum index rejsum
do while.not.eof()
  do imp_zkslad
  miesiac=month(ksdata)
  do pksdefault with miesiac
  select 2
  use ksiega index ksiega
  append blank
  do imp_ksreplac
  replace ksexport with .f.,ksuwag with space(17)
  if zryczalt.and.kssprzed
    replace ksobrot with kstow*zksprocp/100,ksprocp with zksprocp
  endif
  select 1
  skip
enddo
close databases
RETURN

PROCEDURE ZAPISZLOK
local t[50]
local miesiac:=0
  do imp_zkslad
miesiac=month(ksdata)
do pksdefault with miesiac
select 3
use ksiega index ksiega
append blank
  do imp_ksreplac
  replace ksexport with .f.,ksuwag with space(17)
use
do dokdefault
select 2
RETURN


PROCEDURE RSUM
parameters plocal
local t[4],q[4]
t[1]:="ksexport"
t[2]:="ksdow"
t[3]:="ksdata"
t[4]:="SUBSTR(ksopis,1,6)"
q[1]:="K"
q[2]:="NUMER DOKUMENTU"
q[3]:="DATA"
q[4]:="OPIS "
do rsumtlo
do skom with "zaKsiegowac ? [T/N]    ENTER-zatwierdzenie     Esc-rezygnacja" 
set color to n/w,w/n
keyboard chr(205)
go top
dbedit(2,1,22,43,t,"RS","",q)
set color to (coldef)
RETURN


FUNCTION RS(tryb,numer)
local last:=lastkey()
do case
  case last=75.or.last=107
    set cursor on
    @ row(),3 get ksexport
	read
	set cursor off
  case last=13
    do skom with "Czekaj !  Trwa ksiegowanie dokumentow !    Esc - Przerwanie." 
    go top
    do while.not.eof()
      if ksexport
		do fajkuj
	    if plocal
		  do zapiszlok
		endif
	  else
	     delete
	  endif
      if inkey()=27
	    zz=.t.
		do gkom with "Przerwac ksiegowanie ?  [T/N] ",zz
		if zz.and.lastkey()#27
		  exit
		endif
	  endif
	  skip
	enddo
    pack
    go top
	return 0
  case last=27
    return 0
endcase
@ 3,61 say substr(ksnaz,1,15)
@ 4,61 say substr(ksnaz,16)
@ 5,61 say substr(ksadr,1,15)
@ 6,61 say substr(ksadr,16)
@ 7,61 say ksnip
@ 11,56 say ROUND(ks22,2)+ROUND(ks07,2)+ks00+kszw+ROUND(ksvat22,2)+ROUND(ksvat07,2) picture "999 999 999.99"
@ 14,50 say ks22 picture "999 999 999.99"
@ 15,50 say ks07 picture "999 999 999.99"
@ 16,50 say ks00 picture "999 999 999.99"
@ 17,50 say kszw picture "999 999 999.99"

@ 14,65 say ksvat22 picture "999 999 999.99"
@ 15,65 say ksvat07 picture "999 999 999.99"
@ 16,65 say 0 picture "999 999 999.99"
@ 17,65 say 0 picture "999 999 999.99"

@ 19,50 say ROUND(ks22,2)+ROUND(ks07,2)+ks00+kszw picture "999 999 999.99"
@ 19,65 say ROUND(ksvat22,2)+ROUND(ksvat07,2) picture "999 999 999.99"

if ksexport
  @ 22,46 say " DOKUMENT DO ZAKSIEGOWANIA       "
else
  @ 22,46 say " DOKUMENT NIE BEDZIE KSIEGOWANY  "
endif  
RETURN 1


PROCEDURE RSUMTLO
clear
@ 1,0 say replicate(chr(176),80)
@ 23,0 say replicate(chr(176),80)
for i=2 to 22
  @ i,0 say chr(176)
  @ I,78 say chr(176)
  @ i,79 say chr(176)
  @ i,44 say chr(176)
  @ i,45 say chr(176)
  @ i,46 say chr(176)   
  @ i,47 say space(31)
next
set color to n/w
@ 0,0 say  "                        WYKAZ DOKUMENTOW DO ZAKSIEGOWANIA                       "
set color to (coldef)

@ 2,46 say "  KONTRAHENT:                    "
@ 3,46 say "    NAZWA......               ..."
@ 4,46 say "    CD NAZWY...               ..."
@ 5,46 say "    ADRES......               ..."
@ 6,46 say "    CD ADRESU..               ..."
@ 7,46 say "    NIP........               ..."
@ 8,46 say "================================="
@ 10,46 say " WARTOSC DOKUMENTU :             "
@ 11,46 say " BRUTTO :                        "
@ 13,46 say "             NETTO            VAT"
@ 14,46 say "22%                              "
@ 15,46 say " 7%                              "
@ 16,46 say " 0%                              "
@ 17,46 say "zw.                              "
@ 18,46 say "    ============== =============="
@ 19,46 say "SUM:                             "
@ 20,46 say "================================="
@ 22,46 say " DOKUMENT DO ZAKSIEGOWANIA       "

RETURN

*******************************************************************************
*Procedura zaznacza dokumenty zaimportowane przez ksiege (ksiegowy=.t.)       *
*******************************************************************************
PROCEDURE FAJKUJ
local lndok:=space(15)
local ldata:=ksdata
local lksdow:=ksdow
local lksmod:=ksmod
local lksuwag:=ksuwag
select 1
if SUBSTR(lksmod,1,1)$"PT"         &&jesli utarg dzienny
  use paragon  
  set filter to datdok=ldata
  go top
  do while.not.eof()
    replace ksiegowy with .t.
    skip
  enddo
else
  lndok=STUFF(lndok,16-LEN(ALLTRIM(lksdow)),LEN(ALLTRIM(lksdow)),ALLTRIM(lksdow))
  do case
    case SUBSTR(lksmod,1,1)="F"
      use dokument index dok_num
    case SUBSTR(lksmod,1,1)="U"
      use dokument index dok_num 
      lndok=STUFF(lndok,12,1,"U")	  	
    case SUBSTR(lksmod,1,1)="R"
      use dokument index dok_num 	
      lndok=STUFF(lndok,12,1,"R")
    case SUBSTR(lksmod,1,1)="N"
      use dokument index dok_num 	
      lndok=STUFF(lndok,12,1,"N")
    case SUBSTR(lksmod,1,1)$"fru"
      use pzdok index pz_num
      lndok=STUFF(space(15),16-LEN(ALLTRIM(lksuwag)),LEN(ALLTRIM(lksuwag)),ALLTRIM(lksuwag))
  endcase
  seek lndok
  if found()
    replace ksiegowy with .t.
  else
    do tkom with "PROBLEM!  Przeprowadz indeksacje i sprawdz poprawnosc transmisji do ksiegi!"
  endif
endif
use
select 2
RETURN