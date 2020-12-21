*PROCEDURE : TL,TXT,TX,OK1-OK5,KONTO,ROZ,MOP1-MOP5,KONTRAH,KONTTLO,KONTTLO1
*KSEGA
local s:=1
local last:=lastkey()
set procedure to firma
set procedure to kjproc
set procedure to dokum
set procedure to mag
set procedure to ksdruk
set key -9 to robak
*set procedure to przerob
set confirm on
set date german
*set bell on 
public kjhas:="kjhas1957"
public dokexport:=.f.
public drukarka:="LPT1"
public oferil:=.f.
public zryczalt:=.f.
public plik:="\kjdruk.prn"
public ryczalt:=.f.
public odstep:=.f.
public dlugosc:=57
public dtxt1:=space(62)
public dtxt2:=space(62)
public dtxt3:=space(72)
public dtxt4:=space(72)
public dtxt5:=space(72)
public szybki:=.f.
public mocny:=.t.
public grafik:=.t.
public swektor:="chr(27)+chr(73)+chr(0)+chr(27)+chr(77)+chr(27)+chr(67)+chr(0)+chr(12)+chr(27)+chr(67)+chr(72)+chr(18)                                                                                                                                                                                                      "
public mwektor:="chr(27)+chr(77)+chr(27)+chr(67)+chr(0)+chr(12)+chr(27)+chr(67)+chr(72)+chr(18)                                                                                                                                                                                                                             "
public wektor:=mwektor
public plikdruk:=.f.
public lpt15:=.f.
public pksiega:=.f.
public mnoz:=1.00000000
public daf:=date()  && data obowiazujaca
*********************** Zmienne instalacyjne
public fwl:=space(33)
public flic1:=space(24)
public flic2:=space(24)
public flic3:=space(24)
public flic4:=space(24)
public flic5:=space(24)
public flic6:=space(24)
public fdys1:=space(34)
public fdys2:=space(34)
*********************** zmienne ustalajace numeracje 
public nummag:=0
public znummag:=0
public numplat:=0
public znumplat:=0
public numfakt:=0
public numrach:=0
public numpar:=0
public numzlec:=0
public numpz:=0
public numzwrot:=0
public numrek:=0
public numprzer:=0
public numprac:=0
public num1dzy:=0
public num2dzy:=0
public znfakt:=0
public ksiegakon:=.f.
************************Zmienne - nowy dokument
public ztyp:=space(4)
public zndok:=space(15)
public zzewndok:=space(15)

public zdatdok:=daf  
public znskrot:=space(15)
public zwartosc:=0  
public zwar:=0
public znplat:=0
public znodb:=0
public znzamow:=space(14) 
public zdatzam:=daf
public ztermin:=daf+14
public zdatzap:=daf
public zkonto:=0
public zkwota:=0
public zpodatek:=.t.
public zgotowka:=.t.
public zksiegowy:=.f.
public znskrot:=space(15)
public zdvat:=0
public zsposzap:=space(1)
public zdatsp:=daf
public zdatzal:=daf
public ztransport:=space(20)
public zdster:=space(3)
zopis=space(16)
*******************Zmienne - opis kontrahentow
public zplat1:=space(30)
public zplat2:=space(30)
public zodb1:=space(30)
public zodb2:=space(30)
public znaz1:=space(30)
public znaz2:=space(30)
public zmiasto:=space(30)
public zulica:=space(30)
public zkod:=space(6)
public ztel:=space(15)
public zuwagi:=space(12)
public zfax:=space(15)
public zpager:=space(15)
public zkkonto:=space(40)
public zkontrahkonto:=space(29)
public zuwagi:=space(30)
public zgrupa:=space(1)
public znskrot:=space(15)
public zaskrot:=space(15)
public zrabat:=0.0
public znr_kontr:=0

public zkontrahkonto:=space(40)
*******************Zmienne magazyn
public zmnaz:=space(32)
public zmil:=0
public zmcen_d:=0
public zmcen_h:=0
public zmcen_m:=0
public zmrez:=0
public zmkod:=space(7)
public zmjm:=space(3)
public zmdata:=date()
public zmagaz:=0
public znmag:=0
public zmvat:=.f.
public zmstawka:=0
public zmsymbol:=space(10)
public zmmarza_d:=0
public zmmarza_h:=0
public zmwaluta:=space(1)
public zmpasek:=space(15)
public zmster:=space(3)
public zmkoszt:=0
******************Zmienne - nowy pracownik
public rindex:=0
public rnazwisko:=space(20)
public rimie1:=space(15)
******************Zmienne - nowa pozycja rejestrowana w dokumentach
public ztlp:=0
public ztnaz:=space(32)
public ztil:=1.00
public ztcen:=0.000000
public ztwar:=0
public ztopis:=space(32)
public ztkod:=space(10)
public ztmagazyn:=.t.
public ztndok:=space(15)
public ztjm:=space(3)
public ztsymbol:=space(15)
public ztstawka:=0
public ztwartbp:=0
public ztvat:=0
public ztcen_m:=0
public ztnkon:=0
public ztster:=space(3)
public ztkoszt:=0
public ztcen_d:=0
public ztcen_h:=0
public znmag:=0
public ztdat:=daf
public ztpasek:=space(15)
********************** pozostale zienne
public zanuldok:=.f.
public vat:=.t.
public wmag:=.f.           &&.t.-mozliwosc korzystania z wielu magazynow
public wmagil:=4
public opis_dok:=space(16)
public hel:="faktura"    && okresla tekst w procedurze HELP
public fwar:=".t."      && wyk. przy ustawianiu filtru
public fwar1:=""
public cen:=1
public cena:="D"
public dysk:="A:\"        && stacja dyskow do archiwizacjie
public margines:=0
public anul:=.f.
public spisdat:=daf       &&data ostatniego spisu
public licencja:=.t.
public haslo:=space(10)
public shaslo:=space(10)
public papfir:=.f.       &&czy drukowac na papierze firmowym
public podobr:=0         &&drukuje zadeklarowana stope na dokumentach
public asmenu:=.f.       &&czy utworzono menu asortymentowe
public aspoz:=.f.        &&czy istnieje podzial asortymentowy
public marza_d:=0      &&ostatnio stosowana marza detaliczna
public marza_h:=0        &&                         hurtowa
public mzao:=0
public pammiasto:=space(19)
public stanowisko:="A"
public rachuntyp:=3
public NumStan:=0
public NumKas:=1
public kasa:=.f.
public MagPraw:=.t.
public ParamOkno:=.t.
public Orginal:=0
public OpoznionaPlatnosc:=14
public ktm:=.f.
public MagPicture:=.t.        &&.t.-filtr w magazynie tylko duzymi literami
public Sklep:=.f.             &&.t.-cena_d i _h w magazynie deklarowane brutto 
public zadresat:=" "
public kont:=.f.              &&kontrahent odszukany lub zapisz nowego
public wielokas:=.f.
public rekon:=.f.
public zmientyt:=.f.
public ms:=1                   &&miesiac do drukowania
*********************** zmienne instalacyjne
public isprzed:=.t.
public idost:=.t.
public iuslug:=.t.
public itow:=.t.
public mag_lic:=.f.
public wersja:=1
public vvt:=.t.
public datdem:=date()
public demczas:=14
****************************************ZMIENNE - WERSJA PROGRAMU
public in1:=.f.
public in2:=.f.
public in3:=.f.
public in4:=.f.
public in5:=.f.
public in6:=.f.
public in7:=.f.
public in8:=.f.
public in9:=.f.
public in10:=.f.
public in11:=.f.
public in12:=.f.
public in13:=.f.
public in14:=.f.
public in15:=.f.
public in16:=.f.
public in17:=.f.
public in18:=.f.
public in19:=.f.
public in20:=.f.
public in21:=.f.
public in22:=.f.
public in23:=.f.
public in24:=.f.
public in25:=.f.
public in26:=.f.
public in27:=.f.
public in28:=.f.
public in29:=.f.
public in30:=.f.
public in31:=.f.
public in32:=.f.
public in33:=.f.
public in34:=.f.
public in35:=.f.
public in36:=.f.
public in37:=.f.
public in38:=.f.
public in39:=.f.
public in40:=.f.
public in41:=.f.
public in42:=.f.
public in43:=.f.
public in44:=.f.
public in45:=.f.
public in46:=.f.
public in47:=.f.
public in48:=.f.
public in49:=.f.
public in50:=.f.
public in51:=.f.
public in52:=.f.
public in53:=.f.
public in54:=.f.
public in55:=.f.
public in56:=.f.
public in57:=.f.
public in58:=.f.
public in59:=.f.
public in60:=.f.
public in61:=.f.
public in62:=.f.
public in63:=.f.
public in64:=.f.
public in65:=.f.
public in66:=.f.
public in67:=.f.
public in68:=.f.
public in69:=.f.
public in70:=.f.
public in71:=.f.
public in72:=.f.
public in73:=.f.
public in74:=.f.
public in75:=.f.
public in76:=.f.
public in77:=.f.
public in78:=.f.
public in79:=.f.
public in80:=.f.

****************************************DEFINICJA NAZW MAGAZYNOW
public NM[8],MM[8],UM[8]
public znm:=space(15)
public zmm:=space(15)
public zum:=space(15)
for i=1 to wmagil
  NM[i]:=space(15)
  MM[i]:=space(15)
  UM[i]:=space(15)
next
dostep=.t.
wek1="chr(27)+chr(15)"
wek2="chr(18)"
tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
*set default to bazy

if.not. file ("pam.mem")
  @ 0,0,24,79 box tlo
  @ 10,18 say "                                            "  
  @ 11,18 say " PROGRAM NIE ZOSTAL POPRAWNIE ZAINSTALOWANY "
  @ 12,18 say "         Nacisnij dowolny klawisz           "
  @ 13,18 say "                                            "  
  inkey(0)
  clear
  return
endif

restore from pam additive
do dokdefault
restore from pam additive
do case
  case stanowisko="/"
    NumStan=1
  case stanowisko="A"
    NumStan=2
  case stanowisko="B"
    NumStan=3
  case stanowisko="C"
    NumStan=4			
  case stanowisko="D"
    NumStan=5
  case stanowisko="E"
    NumStan=6
  case stanowisko="F"
    NumStan=7
  case stanowisko="G"
    NumStan=8				
endcase
*magil=4
do mdef

do tl

if.not.mag_lic
  do blokada
  if.not.licencja
    return
  endif  
endif

do haslo with 10,25 
if.not.dostep
  clear
  return
endif  
keyboard chr(205)
daf:=date()  && data obowiazujaca
fwar=".t."
rekon=.f.
save to pam
hel="magazyn"
use
pozm=1
do while .t.
  zm=.f.
 * do menu      &&jesli koniec - zm=.t.
 * do fmenu
  if zm
    exit
  endif	
enddo
clear
return






PROCEDURE TL
tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
*clear
clear
@ 7,0,19,79 box tlo
@ 0,0 to 24,79 double
@ 20,0 to 24,79 double
@ 4,0 to 6,79 double
@ 20,0 say chr(204)
@ 20,79 say chr(182)
@ 4,0 say chr(204)
@ 6,0 say chr(204)
@ 4,79 say chr(182)
@ 6,79 say chr(182) 
@ 4,16 say chr(216)
@ 6,16 say chr(207)
@ 4,32 say chr(209)
@ 6,32 say chr(207)
@ 4,48 say chr(209)
@ 6,48 say chr(207)
@ 4,64 say chr(209)
@ 6,64 say chr(207)
@ 0,16 say chr(209)
@ 0,63 say chr(209)
@ 1,63 say chr(179)
@ 2,63 say chr(179)
@ 3,63 say chr(179)
@ 4,63 say chr(207)
@ 1,16 say chr(179)
@ 2,16say chr(179)
@ 3,16 say chr(179)
@ 1,1 say " M A G A Z Y N "    
@ 2,1 say NM[NumStan]
@ 1,66 say "Wersja 01"
if sklep
  @ 2,66 say "S K L E P"
else
  @ 2,66 say "HURTOWNIA"
endif
@ 3,64 say "Data:"
@ 3,70 say date()
set color to W/N+
@ 1,17 say "             *  F  I  R  M  A  *              "
set color to
@ 2,17 say "        OPERACJE HANDLOWE I MAGAZYNOWE        "
@ 3,24 say fwl
RETURN


PROCEDURE TXT
PARAMETERS W,T
@ 21,1 clear to 23,78
@ W,(80-LEN(T))/2 SAY T
@ 23,4 say "  F1 - HELP              Enter-Zatwierdzenie           Esc-Rezygnacja "  
RETURN


PROCEDURE TX
PARAMETERS C,W,T
if c=0
@ 21,1 clear to 23,78
@ 24,0 say chr(200)
@ 24,1 say replicate(chr(205),78)
@ 24,79 say chr(188)
endif
@ W,(80-LEN(T))/2 SAY T
RETURN




PROCEDURE KONTO
parameters pkon,pnkon
local ek:=savescreen(0,0,24,79)
local t[2],q[2]
t[1]:="kon"
t[2]:="nkon"
q[1]:=""
q[2]:=""
set color to
for i=8 to 18
  @ i,2 say replicate(chr(176),76)
next
@ 9,5 say space(70)
@ 9,30 say "NAZWA I NUMER KONTA"
do skom with "Dopisz  Popraw  Kasuj  ENTER-zatwierdz  ESC-zrezygnuj"
select 12
use konto 
locate for nkon=pnkon
keyboard chr(205)
dbedit(10,5,15,74,t,"UK","",q)
use
set color to 
restscreen(0,0,24,79,ek)
RETURN

FUNCTION UK(tryb,numer)
local pole,pol
local last:=lastkey()
commit
do case
  case last=68.or.last=100    &&Dopisz
    set cursor on
    zkon=space(60)
    @ 17,5 get zkon picture "@!"
    read
    if lastkey()#27
      go bottom
	  znkon=nkon
	  append blank
	  replace kon with zkon
	  replace nkon with znkon+1
    endif
    set cursor off
    set color to
    @ 17,5 say replicate(chr(176),70)
    set color to (n/w,w/n)
    keyboard chr(205)
    return 2
  
  case last=75.or.last=107
    delete
    pack
    keyboard chr(205)
    return 2  
  
  case last=80.or.last=112
    pole:=field(numer)
    pol:=&pole
    set cursor on
    @ row(),col() get pol
    read
    set cursor off
    if lastkey()#27
      replace &pole with pol
    endif   
    keyboard chr(205)
    return 2
    
  case last=13
    pnkon=nkon
    pkon=kon
*   keyboard chr(205)  
    return 0  	
	
  case last=27
     return 0
 endcase
RETURN 1



PROCEDURE ROZ
for i=8 to 15
  @ i,21 say replicate(chr(178),35)
next
@ 9,23 say "                               "
@ 10,23 SAY "        OPCJA DOSTEPNA         "
@ 11,23 say " W ROZSZERZONEJ WERSJI SYSTEMU "
@ 12,23 say "                               "
@ 13,23 say "   Nacisnij dowolny klawisz    "
@ 14,23 say "                               "
inkey(0)
for i=9 to 14
  @ i,23 say replicate(chr(176),40)
next  
RETURN

PROCEDURE MOP1
set color to n/w
@ 24,0 say "F1-HELP  F2-Menu  F3-Szukaj  F4-Notat.  F5-Dodaj  F7-Drukuj   Enter/Esc-Zatw/rez"
set color to 
RETURN

PROCEDURE MOP2
set color to n/w
@ 24,0 say "    F1-HELP               Enter-Zatwierdzenie                 Esc- Rezygnacja   "
set color to 
RETURN

PROCEDURE MOP3
set color to n/w
@ 24,0 say "    F1-HELP          Enter/PgDw/PgUp-Zatwierdzenie            Esc- Rezygnacja   "
set color to 
RETURN

PROCEDURE MOP4
set color to n/w
@ 24,0 say "F1-HELP   F2-Nowy    F8-Kasuj   [Ctrl-Enter]-Popraw    Enter-Zatw.   Esc- Rezyg."
set color to 
RETURN

PROCEDURE MOP5
set color to n/w
@ 24,0 say " F1-HELP   F2-Nowy   F8-Kasuj   [Ctrl-Enter]-Popraw   Enter-Zatw.   Esc- Rezyg. "
set color to 
RETURN




PROCEDURE GKOM
parameters ptxt,pzatwierdz
local ek:=savescreen(24,0,24,79)
local kol:=0
ptxt=alltrim(ptxt)
if len(ptxt)>78
  ptxt=substr(ptxt,1,78)
endif
kol=(78-len(ptxt))/2
kol=round(kol,0)
set color to
set color to n/w
set cursor on
@ 24,0 say space(80)
set confirm off
@ 24,kol say ptxt get pzatwierdz
read
set confirm on
set cursor off
set color to 
restscreen(24,0,24,79,ek)
RETURN


PROCEDURE SKOM
parameters ptxt
local kol:=0
ptxt=alltrim(ptxt)
if len(ptxt)>80
  ptxt=substr(ptxt,1,80)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
set color to n/w
@ 24,0 say space(80)
@ 24,kol say ptxt
set color to 
RETURN


PROCEDURE TKOM
parameters ptxt
local ek:=savescreen(24,0,24,79)
local kol:=0
clear typeahead
ptxt=alltrim(ptxt)
if len(ptxt)>78
  ptxt=substr(ptxt,1,78)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
set color to n/w
@ 24,0 say space(80)
@ 24,kol say ptxt 
inkey(0)
set color to 
restscreen(24,0,24,79,ek)
RETURN

PROCEDURE TKOM1
parameters ptxt
local ek:=savescreen(24,0,24,79)
local kol:=0
clear typeahead
ptxt=alltrim(ptxt)
if len(ptxt)>78
  ptxt=substr(ptxt,1,78)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
set color to n/w*
@ 24,0 say space(80)
@ 24,kol say ptxt 
inkey(0)
set color to 
restscreen(24,0,24,79,ek)
RETURN


FUNCTION NUMER
parameters pnum,pkod
local poz:=0
local tnum:=space(15)
local em:=savescreen(0,0,24,79)
local numer:="          / /  "
pkod=substr(pkod,4,1)
if pnum>999999
  do while .t.
    pnum=pnum-1000000
	if pnum<=999999
	  exit
	endif  
  enddo	
endif  
tnum=alltrim(str(pnum))
poz=11-len(tnum)
numer=stuff(numer,poz,len(tnum),tnum)
numer=stuff(numer,12,1,pkod)
numer=stuff(numer,13,1,stanowisko)
numer=stuff(numer,14,2,SUBSTR(ALLTRIM(STR(year(date()))),3))
if wielokas
  NumKasTxt=ALLTRIM(str(NumKas))
  numer=stuff(numer,14,1,NumKasTxt)
endif
RETURN numer


PROCEDURE BLOKADA
if min(datdem,date()-demczas)=datdem.or.min(datdem-1,date())=date()
  licencja=.f.
  save to pam
endif
if.not.licencja
  do bloktxt
endif  
RETURN

PROCEDURE BLOKTXT
set color to n/w
@ 8,18 say "                                           "
@ 9,18 say "  Dzien dobry !                            "
@ 10,18 say "  Przypominam, ze korzystaliscie Panstwo   "
@ 11,18 say "  z  demonstracyjnej  wersji programu. W   "
@ 12,18 say "  celu wykupienia  LICENCJI zapraszam do   "
@ 13,18 say "  firmy Soft-KJ-Service  / Tel.774-39-22   "
@ 14,18 say "  05 - 120  Legionowo  ul.Hetmanska 63 /   "
@ 15,18 say "  Zapewniam  wdrozenie programu , opieke   "
@ 16,18 say "  autorska oraz servis sprzetu i  oprog-   "
@ 17,18 say "  ramowania.                               "
@ 18,18 say "     Autor programu  mgr inz. K.Jaworski   "
@ 19,18 say "                                           "
set color to
@ 21,1 clear to 23,78
@ 22,28 say "Nacisnij dowolny klawisz"
inkey(0)
RETURN





PROCEDURE KRESKA
parameters pw,pk
@ pw,pk say chr(209)
@ pw+1,pk say chr(179)
@ pw+2,pk say chr(207)
RETURN


FUNCTION SKROT
parameters mia,uli
sadres=space(25)
i=1
do while .t.
  if substr(mia,i,1)=" ".or.i>len(mia)
    exit
  else
    i=i+1 	
  endif
enddo  
sadres=stuff(sadres,1,i,substr(mia,1,i))
J=25-I
K=I+1
sadres=stuff(sadres,K,J,substr(uli,1,J))
RETURN sadres


*******************************************************************************
*Przepisanie pliku magdef.dbf do tablicy zapamietanej mastepnie w pliku pam.mem
*******************************************************************************
PROCEDURE MDEF
if.not.file("magdef.dbf")
  return
endif
select 22
use magdef
for i=1 to wmagil
  locate for mag_nr=i
  nm[i]=mag_nazwa          &&nazwa magazynu
  mm[i]=mag_miasto         &&adres-miasto
  um[i]=mag_ulica          &&adres-ulica
next
use
RETURN


*******************************************************************************
*Procedura powraca do katalogu zawierajcego dokumenty kasy okreslonej numerem
*instalacyjnym  NumKas
*******************************************************************************
PROCEDURE DOKDEFAULT
if.not.rekon
  set default to curdir()
  do case
    case NumKas=1
      set default to 1DOK
    case NumKas=2
      set default to 2DOK
    case NumKas=3
      set default to 3DOK
    case NumKas=4
      set default to 4DOK
    case NumKas=5
      set default to 5DOK				
  endcase
endif  
RETURN


*******************************************************************************
*Procedura kiruje do katalogu zawierajacego magazyn przyporzadkowany jako
*glowny dla zainstalowanego stanowiska - decyduje zmienna NumStan
*******************************************************************************
PROCEDURE MAGDEFAULT
set default to curdir()
	do case
	  case NumStan=1
	    set default to 1MAG
	  case NumStan=2
	    set default to AMAG
	  case NumStan=3
	    set default to BMAG
	  case NumStan=4
	    set default to CMAG	
	  case NumStan=5
	    set default to DMAG	
	  case NumStan=6
	    set default to EMAG	
	  case NumStan=7
	    set default to FMAG	
	  case NumStan=8
	    set default to GMAG								  		
	endcase
RETURN

*******************************************************************************
*Procedura kiruje do katalogu zawierajacego magazyn.                      
*Decyduje parametr okreslajacy numer przyporzadkowany magazynowi
*******************************************************************************
PROCEDURE PMAGDEFAULT
parameters pmag
set default to curdir()
	do case
	  case pmag=1
	    set default to 1MAG
	  case pmag=2
	    set default to AMAG
	  case pmag=3
	    set default to BMAG
	  case pmag=4
	    set default to CMAG						
	  case pmag=5
	    set default to DMAG
	  case pmag=6
	    set default to EMAG
	  case pmag=7
	    set default to FMAG
	  case pmag=8
	    set default to GMAG								
	endcase
RETURN



PROCEDURE PRACDEFAULT
if.not.rekon
  set default to curdir()
  set default to pracow
endif
RETURN

PROCEDURE ROBAK
local ek:=savescreen(0,0,24,79)
local last:=inkey()
local w:=0
local k:=0
cls
do while last=0
  clear
  k=k+1
  @ w,k+1 say replicate(chr(176),25)
  @ w+1,k say replicate(chr(176),28)
  @ w+2,k+1 say replicate(chr(176),29)
  @ w+3,k say replicate(chr(176),28)
  @ w+4,k+1 say replicate(chr(176),25)
  @ w+2,k+5 say " * Soft-KJ-Service * "
  @ w+1,k+2 say "Data:        "
  @ w+1,k+8 say date()
  @ w+3,k+2 say "Godz.        "
  @ w+3,k+8 say time()
  last=inkey(1)
  if k>48
    k=0
	w=w+3
  endif
  if w>19
    w=0
  endif
enddo
*inkey(0)
restore screen from ek 
RETURN

