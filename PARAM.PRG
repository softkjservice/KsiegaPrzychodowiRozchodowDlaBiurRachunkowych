**PROCEDURE PARAM
local ek,ek1
local t[15],h[2],w[15],d[3],m[3],o[2],d1[2]
local s:=1
local has:=space(10)
ztrah=trah
hel="param"
o[1]:="iloscDNI"
o[2]:="DATA/DNI"
m[1]:="DEF.NAZW"
m[2]:="OKNO AS."
m[3]:="DOKUM-AS"
w[1]:="Na ekran"
w[2]:="Pelny 15"
w[3]:="Papier  "
w[4]:="StronaDl"
w[5]:="Margines"
w[6]:="Odstep  "
w[7]:="Waluta  "
w[8]:="Tekst d1"
w[9]:="Tekst d2"
w[10]:="Tekst m "
w[11]:="Tlusty  "
w[12]:="W-Z  P-Z"
w[13]:="*       "
w[14]:="*       "
w[15]:="*       "
d[1]:= "FAKTURA "
d[2]:= "RACHUNEK"
d[3]:= "PARAGON "
d1[1]:= "PRZESUN."
d1[2]:= " W - Z  "
*d1[3]:= " P - Z  "


h[1]:=" PRACOWNIK  "
H[2]:=" ZARZADCA   "
t[1]:="NUMERACJA  "
t[2]:="PAR.WYDRUKU"
t[3]:="DYSK(A:/B:)"
t[4]:="HASLO      "
t[5]:="MAGAZYNY   "
t[6]:="ZAOKRAGLENI"
t[7]:="UZYTKOWNI  "
t[8]:="TYP DOKUM. "
t[9]:="TERMIN PLAT"
t[10]:="KOLOR      "
t[11]:="KONTRAHENT "
t[12]:="Powt.  KTM "
t[13]:="Szukaj KTM "
t[14]:="Detal_cen  "
t[15]:="CENY BRUTTO"
hel="param"
set color to (coldef)
@ 0,0,24,79 box tlo
set color to
@ 4,2 say "-----------"
if kolor=0
  set color to n/w
else
  set color to (coldef)
endif  
@ 0,0 SAY "  SYSTEM ZARZADZANIA PRZEDSIEBIORSTWEM   * P A R A M E T R Y *                  "
@ 0,69 say daf
set color to n/w

for i=3 to 19
  @ i,14 say space(19)
next

@ 2,1 to 20,33 double

@ 4,14 say "-------------------"
*@ 5,14 say daf
@ 7,14 say dysk
@ 10,14 say mzao picture "999"
*@ 11,14 say wzdruk
*@ 11,16 say pzdruk
@ 13,14 say opoznionaPlatnosc picture "999"
@ 14,16 say kolor picture "9"
@ 15,16 say ztrah
@ 16,16 say ktm
*@ 14,16 say lpt15
@ 17,16 say pierkod  
@ 18,16 say cendet
@ 19,16 say sklep
set color to
do suf
@ 22,15 say "   WYBIERZ POZYCJE I ZATWIERDZ KLAWISZEM ENTER    "
@ 3,2 say " - WYBOR - "
@ 3,14 say "- P A R A M E T R -"
set color to (n/w,w/n)
for i=4 to 13   
  @ i,42 say space(36)
next
@ 4,42 to 13,77 double
@ 5,43 say "LICENCJONOWANY UZYTKOWNIK PROGRAMU"
@ 6,43 say "----------------------------------"
@ 7,43 say flic1
@ 8,43 say flic2
@ 9,43 say flic3
@ 10,43 say flic4
@ 11,43 say flic5
@ 12,43 say flic6
for i=15 to 20
  @ i,42 say space(36)
next
@ 15,42 to 20,77 double
@ 16,43 say "         P R O D U C E N T        "
@ 17,43 say "----------------------------------"
@ 18,43 say fdys1
@ 19,43 say fdys2

do while .t.
set color to
s=achoice(5,2,19,12,t,,,s) 
do suf
save screen to ek1
do case
  case s=1
    do dnumery
  case s=2
    save screen to ek
    ww=1
    do while.t.
      @ 4,14 to 20,33 double
	  for j=5 to 19
		    @ j,24 say chr(176)
	  next
	  set color to n/w
	  @ 5,27 say plikdruk
	  @ 6,27 say lpt15
	  @ 7,29 say orginal picture "9"
	  @ 8,27 say dlugosc picture "999"
	  @ 9,28 say margines picture "99"
	  @ 10,27 say odstep
*	  @ 11,27 say drukarka
	  @ 15,27 say grafik
	  set color to 		
	  ww=achoice(5,15,19,23,w,,,ww)
	  set cursor on
      do case
		    case ww=1
		      do suf
		      @ 22,16 say "F - wydruki kirowane na drukarke.       "
		      @ 23,16 say "T - wydruki kierowane na ekran.         "	
		      @ 5,27 get plikdruk
              read
		    case ww=2
			  do suf
		      @ 22,16 say "T - wydruki jednoczesciowe  (15 cali)   "
		      @ 23,16 say "F - wydruki laczone  (10 cali)          "	
		      @ 6,27 get lpt15 
			  read
		    case ww=3
		      do suf
		      @ 22,16 say "0-papier przebitkowy opisany, 1-papier  "
		      @ 23,16 say "bez przebitki, 2-przebitkowy bez opisu  "		
		      @ 7,29 get orginal picture "9"
			  read
		    case ww=4
			  do suf
		      @ 22,16 say "Okreslenie optymalnej ilosci wierszy dla"
		      @ 23,16 say "wydrukow.                               "
		      @ 8,27 get dlugosc picture "999"
			  read
		    case ww=5
              do suf
			  @ 22,15 say "        WYDRUK BEDZIE PRZESUNIETY O WIELKOSC      "
              @ 23,15 say "            ZADEKLAROWANEGO  MARGINESU            "  
		      @ 9,28 get margines picture "99"
			  read			  			  
		    case ww=6
			  do suf
		      @ 22,16 say "T - wprowadzenie odstepow w drukow.poz. "
		      @ 23,16 say "F - pozycje drukowane w sposob ciagly.  "				
		      @ 10,27 get odstep
			  read			  
		    case ww=7
			  do suf
		      @ 22,16 say "Zatwierdzone nazwa walut pojawia sie    " 
		      @ 23,16 say "na wydrukach dokumentow.                "	
		      @ 10,25 to 12,54 double
              @ 11,26 say " Nazwa waluty : _____._____ "
			  @ 11,42 get zwaluta1
			  @ 11,48 get zwaluta2
    		  read			  	
	          restore screen from ek		  			  			  
		    case ww=8
			  do suf
		      @ 22,16 say "Wprowadzony tu tekst pojawi sie na wyd- " 
		      @ 23,16 say "rukach dokumentow !     Nacisnij klawisz"	
			  inkey(0)
		      @ 21,0 clear to 24,79
			  @ 22,0 get dtxt1
			  @ 24,0 get dtxt2
			  read			  
		    case ww=9
			  do suf
		      @ 22,16 say "Wprowadzony tu tekst pojawi sie na wyd- " 
		      @ 23,16 say "rukach dokumentow z opozniona platnoscia"	
			  inkey(0)
              @ 18,0 to 24,31 double
			  @ 19,1 get dtxt6
			  @ 20,1 get dtxt7
			  @ 21,1 get dtxt8
			  @ 22,1 get dtxt9
			  @ 23,1 get dtxt10
			  read			  			  
		    case ww=10
			  do suf
		      @ 22,16 say "Wprowadzony tu tekst pojawi sie na wyd- " 
		      @ 23,16 say "rukach oferty!     Nacisnij klawisz!    "	
			  inkey(0)			
		      @ 21,0 clear to 24,79
			  @ 22,0 get dtxt3
			  @ 23,0 get dtxt4
			  @ 24,0 get dtxt5
			  read
		    case ww=11
			  do suf
		      @ 22,16 say "T - uwypuklenie waznych czesci wydrukow " 
		      @ 23,16 say "F - wydruk jednolity                    "	
		      @ 15,27 get grafik
			  read			  			  			  
		    case ww=12
              @ 22,15 say " T *  Mozliwosc drukowania dokumentu   W  -  Z    "
              @ 23,15 say " * T  Mozliwosc drukowania dokumentu   P  -  Z    "
              set cursor on
              @ 16,25 get wzdruk
              @ 16,27 get pzdruk	
              read
              set cursor off
              if lastkey()#27
                save to pam
              endif	  		  
            case ww=0
			  exit
	  endcase 
	  set cursor off
	  if lastkey()#27
	    if file("firma\pam.mem")
		  save to firma\pam.mem
		else   
		  save to pam
		endif  
      endif
    enddo
    restore screen from ek
  case s=3
    @ 22,15 say " ZADEKLAROWANA TU STACJA DYSKOW BEDZIE OBOWIAZYWAC"
    @ 23,15 say "PRZY ARCHIWIZACJI I REKONSTRUKCJI  /A lub B/      "  
    set cursor on
    do while .t.
      @ 7,14 get dysk picture "!"
      read
      if dysk="A".or.dysk="B"
	    if lastkey()=13
		  dysk=stuff(dysk,2,2,":\")
	      save to pam
	    endif	    
        exit
      else
        @ 22,15 say " NIEDOZWOLONA NAZWA DYSKU - MOZLIWE JEST: A lub B "
        @ 23,15 say "    Nacisnij dowolny klawisz i wpisz  A lub B     "      
        inkey(0)		
      endif
    enddo
    
    set cursor off
  case s=4	
		do suf
		@ 22,16 say "Dwupoziomowe haslo wejsciowe do systemu."
		@ 23,16 say "                                        "
        hs=1
		if in28           &&jesli zainstalowano haslo dwupoziomowe  
          save screen to ek
          @ 7,18 to 10,31 double
		  hs=achoice(8,19,9,30,h) 		
          restore screen from ek
		endif  
		if hs#0
    	  do haslo with 17,5
		  if dostep
		    set cursor on
		    @ 8,14 get has
		    read
		    set cursor off
		    zz=.t.
		    do gkom with "Zatwierdzic nowe haslo ? [T/F] ",zz
		    if zz.and.lastkey()#27.and.hs=1
		      haslo=has
		      if.not.in28
			    shaslo=haslo
			  endif
			  save to pam
		    endif	
		    if zz.and.lastkey()#27.and.hs=2.and.MagPraw=.t.
		      shaslo=has
		      save to pam
		    endif				
		  endif
		endif		  
  case s=55
        zpapfir=papfir
		set cursor on
		@ 9,16 get zpapfir
		read
		set cursor off   
		if lastkey()#27
		  papfir=zpapfir
		  save to pam
		endif 
		
	  case s=5
        save screen to ek
        ww=1
        do while.t.
	      @ 8,14 to 12,33 double
		  for j=9 to 11
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 10,27 say wyboras
		  @ 11,27 say asmenpar
		  set color to 		
		  ww=achoice(9,15,11,23,m,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "Mozliwosc zdefiniowania nazw i adresow  "
		      @ 23,16 say "magazynow wspolpracujacych.             "
              if file("magdef.dbf")
                save screen to ek
                select 22
		        use magdef
		        browse(8,14,16,78)
		        use
	            do mdef 
		        restore screen from ek
		      else
		        do tkom with "Dostepne w wersji wielomagazynowej. Nacisnij dowolny klawisz."  
		      endif

		    case ww=2.and.in42
			  do suf
		      @ 22,16 say "T - Wejscie do magazynu poprzedza okno   "
		      @ 23,16 say "wyboru asortymentu  F - pominiecie okna. "	
		      @ 10,27 get wyboras 
			  read			  
		    case ww=3.and.in42
			  do suf
		      @ 22,16 say "T - Wejscie do magazynu poprzedza okno wyboru"
		      @ 23,16 say "asortymentu z poziomu dokumentu  F-Rezygnacja"	
		      @ 11,27 get asmenpar
			  read			  			  
            case ww=0
			  exit
		  endcase 
		  set cursor off
		  if lastkey()#27
		    save to pam
	      endif
        enddo
        restore screen from ek

		
  case s=6
    if sh_firma
        zmzao=mzao
		do suf
		@ 22,16 say "2 :zaokraglenie do grosza, 1 : do 10 gr."
		@ 23,16 say "0:do zlotowki, -1:do 10zl., -2 :do 100zl"
		set cursor on
		@ 10,16 get zmzao picture "9"range -2,2  
		read
		set cursor off   
		if lastkey()#27
		  mzao=zmzao    
		  save to pam
		endif 
      else
		      @ 22,16 say " Parametr  dostepny  w innych  modulach  "
		      @ 23,16 say " pakietu.    Nacisnij dowolny klawisz !  "	
			  inkey(0)			  
	  endif				
        
  case s=7
    do uzytkwew
              if lastkey()#27
                save to pam
              endif	  		  		  
    case s=8
      save screen to ek
      ww=1
      do case
	   case sh_firma.and.vvt 
	    do while.t.
	      @ 12,14 to 16,33 double
		  for j=13 to 16
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 13,27 say fakturtyp picture "9"
		  @ 14,27 say rachuntyp picture "9" 
		  @ 15,27 say paragtyp picture "9"
*	  @ 16,27 say przestyp picture "9"
		  set color to 		
		  ww=achoice(13,15,15,23,d,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "1 - faktury liczone w cenach NETTO      "
		      @ 23,16 say "2 - faktury liczone w cenach BRUTTO     "	
		      @ 13,27 get fakturtyp picture "9" range 1,2
              read
		    case ww=2
		      @ 22,16 say "1 - rachunki liczone w cenach NETTO     "
		      @ 23,16 say "2 - rachunki liczone w cenach BRUTTO    "	
		      @ 14,27 get rachuntyp picture "9" range 1,2
              read
		    case ww=3
		      @ 22,16 say "BEZIMIENNE: 1-ceny NETTO  2-ceny BRUTTO "
		      @ 23,16 say "IMIENNE:    3-ceny NETTO  4-ceny BRUTTO "	
		      @ 15,27 get paragtyp picture "9" range 1,4
              read			
			  do case
			    case paragtyp=1.or.paragtyp=2
				  gonful=.f.			  
			    case paragtyp=3
				  paragtyp=1
				  gonful=.t.
			    case paragtyp=4
				  paragtyp=2
				  gonful=.t.				  
			  endcase
            case ww=0
			  exit
		  endcase 
		  if lastkey()#27
		    save to pam
	      endif	  		  
        enddo
		
       case m_firma
	    do while.t.
	      @ 12,14 to 15,33 double
		  for j=13 to 14
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 13,27 say przestyp picture "9"
		  @ 14,27 say wztyp picture "9" 
*         @ 15,27 say pztyp picture "9"
*	  @ 16,27 say przestyp picture "9"
		  set color to 		
		  ww=achoice(13,15,14,23,d1,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "1 - przes. w ceanch magazynowych NETTO  "
		      @ 23,16 say "2 - przes. w cenach detalicznych BRUTTO "	
		      @ 13,27 get przestyp picture "9" range 1,2
              read
		    case ww=2
		      @ 22,16 say "1 :  W - Z   liczone w cenach NETTO     "
		      @ 23,16 say "2 :  W - Z   liczone w cenach BRUTTO    "	
		      @ 14,27 get wztyp picture "9" range 1,2
              read
*		    case ww=3
*		      @ 22,16 say "1 :  P - Z   liczone w cenach NETTO     "
*		      @ 23,16 say "2 :  P - Z   liczone w cenach BRUTTO    "	
*		      @ 15,27 get pztyp picture "9" range 1,2
*             read			
            case ww=0
			  exit
		  endcase 
		  if lastkey()#27
		    save to pam
	      endif	  		  
        enddo	   
	   
	   
        case p_firma
		      @ 22,16 say " Parametr  dostepny  w innych  modulach  "
		      @ 23,16 say " pakietu.    Nacisnij dowolny klawisz !  "	
			  inkey(0)		
	  endcase 
		  if lastkey()#27
		    save to pam
	      endif	  
		  set cursor off		  
      restore screen from ek
******
	case s=9
      if sh_firma    
        save screen to ek
        ww=1
        do while.t.
	      @ 13,14 to 16,33 double
		  for j=14 to 15
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 14,27 say OpoznionaPlatnosc picture "999"
		  @ 15,27 say opdat
		  set color to 		
		  ww=achoice(14,15,15,23,o,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "Podana tu ilosc dni bedzie doliczana do  "
		      @ 23,16 say "aktualnej daty aby podac termin platnosci"
		      set cursor on
		      @ 14,27 get OpoznionaPlatnosc picture "999"
		      read
              zOpoznionaPlatnosc=OpoznionaPlatnosc
		    case ww=2
			  do suf
		      @ 22,16 say "T - Zatwierdzanie daty rozliczenia dok.  "
		      @ 23,16 say "F - Zatwierdzanie ilosci dni opozn.platn."	
		      @ 15,27 get opdat 
			  read
			  
            case ww=0
			  exit
		  endcase 
		  set cursor off
		  if lastkey()#27
		    save to pam
	      endif
        enddo
        restore screen from ek
      else
		      @ 22,16 say " Parametr  dostepny  w innych  modulach  "
		      @ 23,16 say " pakietu.    Nacisnij dowolny klawisz !  "	
			  inkey(0)			  
	  endif




  case s=10
		do suf
		@ 22,16 say " 0-Brak kolory  1-niebieski  2-zielony  "
		@ 23,16 say " 3-czerwony  4-brazowy  5-zolty  6-karm."  
        set cursor on
		@ 14,16 get kolor picture "9"
		read
        if lastkey()#27
		  do case
		    case kolor=0
			  coldef="W/N,N/W,N,N,N/W"
		    case kolor=1
			 * coldef="W/B,B/W"
			   coldef="bg+"
		    case kolor=2
			  coldef="N/G,G/N"
		    case kolor=3
			  coldef="W/R,R/W"			  			  			  
			case kolor=4
			  coldef="W/GR,GR/W"  
			case kolor=5
			  coldef="W/GR+,GR+/W"  			  
			case kolor=6
			  coldef="W/RB,RB/W"  			  
		  endcase
		  set color to (coldef)
		  save to pam
		endif
        set cursor off
  case s=11
    if sh_firma.or.m_firma
        ztrah=trah
		do suf
		@ 22,16 say " T - aktywna baza pomocnicza kontrahenta   "
		@ 23,16 say " F - baza pomocnicza dostepna jako archiwum"		
		set cursor on
		@ 15,16 get ztrah 
		read
		set cursor off   
		if lastkey()#27
		  trah=ztrah
		  save to pam
		endif 
      else
		      @ 22,16 say " Parametr  dostepny  w innych  modulach  "
		      @ 23,16 say " pakietu.    Nacisnij dowolny klawisz !  "	
			  inkey(0)			  
	  endif 		

  case s=12
        zktm=ktm
		do suf
		@ 22,16 say " F - dowolny kod towarow w magazynie       "
		@ 23,16 say " T - kontrola dublowania kodu towarow      "		
		set cursor on
		@ 16,16 get zktm 
		read
		set cursor off   
		if lastkey()#27
		  ktm=zktm
		  save to pam
		endif 
      

  case s=1333
        zkasa=kasa
		do suf
		@ 22,16 say " T - Wybor towarow z poziomu magazynu      "
		@ 23,16 say " F - Wybor towarow z poziomu dokumentu     "		
		set cursor on
		@ 17,17 get zkasa 
		read
		set cursor off   
		if lastkey()#27
		  kasa=zkasa
		  save to pam
		endif 

  case s=13
        zpierkod=pierkod
		do suf
		@ 22,16 say " F - Wyszukiwanie pozzycji po nazwie       "
		@ 23,16 say " T - Wyszukiwanie pozycji po kodzie        "		
		set cursor on
		@ 17,16 get zpierkod
		read
		set cursor off   
		if lastkey()#27
		  pierkod=zpierkod
		  save to pam
		endif 		
  case s=14
        zcendet=cendet 
		do suf
		@ 22,16 say " T - Cena detaliczna jako podstawowa       "
		@ 23,16 say " F - Cena hurtowa jako podstawowa          "		
		set cursor on
		@ 18,16 get zcendet
		read
		set cursor off   
		if lastkey()#27
		  cendet=zcendet 
		  save to pam
		endif 				
  case s=15
		do suf
		@ 22,16 say " F - Definiowanie cen NETTO  tow. handlowych"
		@ 23,16 say " T - Definiowanie cen BRUTTO tow. handlowych"		
		set cursor on
		@ 19,16 get sklep
		read
		set cursor off   
		if lastkey()#27
		  save to pam
		endif 						

  case s=0
    keyboard chr(205)
	exit
endcase
restore screen from ek1
set color to n/w
@ 7,14 say dysk
@ 10,14 say mzao picture "999"
*@ 11,14 say wzdruk
*@ 11,16 say pzdruk
@ 13,14 say opoznionaPlatnosc picture "999"
@ 14,16 say kolor picture "9"
@ 15,16 say ztrah
@ 16,16 say ktm
*@ 14,16 say lpt15
@ 17,16 say pierkod  
@ 18,16 say cendet
@ 19,16 say sklep
set color to (coldef)
enddo
set color to
RETURN

PROCEDURE SUF
set color to n/w
@ 22,0 say "  * sufler *  |                                                  |              "
@ 23,0 say "              |                                                  |  * sufler *  "  
set color to 
RETURN

PROCEDURE KONTO
parameters pkon,pnkon
local ek:=savescreen(0,0,24,79)
local t[2],q[2]
t[1]:="kon"
t[2]:="nkon"
q[1]:=""
q[2]:=""
set color to (coldef)
for i=8 to 18
  @ i,2 say replicate(chr(176),76)
next
@ 9,5 say space(70)
@ 9,5 say "NAZWA I NUMER KONTA           CD                            "
do skom with "Dopisz  Popraw  Kasuj  ENTER-zatwierdz  ESC-zrezygnuj"
use konto new
*locate for nkon=pnkon
keyboard chr(205)
dbedit(10,5,15,74,t,"UK","",q)
use
set color to (coldef) 
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
    set color to (coldef)
    @ 17,5 say replicate(chr(176),70)
    set color to I,
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
    znkon=nkon
    zkonto=nkon
    zkon=kon
*   keyboard chr(205)  
   
    return 0  	
	
  case last=27
     return 0
 endcase
RETURN 1


PROCEDURE DNUMERY
local lnumfakt,lnumrach,lnumpar,lnumpz,lnum1dzy,lnum2dzy,lnumprzer,ek
save screen to ek
if file("firma\bazy\1dok\dpam.dbf")
  use firma\bazy\1dok\dpam new
else
  use dpam new
endif  
do case
  case sh_firma
    lnumfakt=dnumfakt+1
    lnumrach=dnumrach+1
    lnumpar=dnumpar+1
    lnumpz=dnumpz+1


    @ 22,15 say " Wpisz numery poczatkowe wystawianych w programie "
    @ 23,15 say "             d o k u m e n t o w                  "
    @ 5,15 to 10,53 double
    @ 6,16 say " Poczatkowy numer FAKTURY            "
    @ 7,16 say " Poczatkowy numer RACHUNKU           "
    @ 8,16 say " Poczatkowy numer PARAGONU           "		
    @ 9,16 say " Poczatkowy numer DOK.ZAKUPU         "
	set cursor on
	@ 6,45 get lnumfakt picture "999999"
	@ 7,45 get lnumrach picture "999999"
	@ 8,45 get lnumpar picture "999999"
	@ 9,45 get lnumpz picture "999999"	
	read
	set cursor off
	if lastkey()#27
	  replace dnumfakt with lnumfakt-1
	  replace dnumrach with lnumrach-1
	  replace dnumpar with lnumpar-1
	  replace dnumpz with lnumpz-1
	endif
  case m_firma
    lnum1dzy=dnum1dzy+1
    lnum2dzy=dnum2dzy+1
    @ 22,15 say " Wpisz numery poczatkowe wystawianych w programie "
    @ 23,15 say "             d o k u m e n t o w                  "
    @ 5,15 to 8,53 double
    @ 6,16 say " Dokument - magazyn wydal            "
    @ 7,16 say " Dokument - magazyn przyjal          "	
	set cursor on
	@ 6,45 get lnum1dzy picture "999999"
	@ 7,45 get lnum2dzy picture "999999"	
	read
	set cursor off
	if lastkey()#27
	  replace dnum1dzy with lnum1dzy-1
	  replace dnum2dzy with lnum2dzy-1
	endif	
  case p_firma	
    lnumprzer=dnumprzer+1
    @ 22,15 say " Wpisz numery poczatkowe wystawianych w programie "
    @ 23,15 say "             d o k u m e n t o w                  "
    @ 5,15 to 8,53 double
    @ 6,16 say " Numer dokumentu przerobu            "
    @ 7,16 say "                                     "	
	set cursor on
	@ 6,45 get lnumprzer picture "999999"
	read
	set cursor off
	if lastkey()#27
	  replace dnumprzer with lnumprzer-1
	endif		
endcase  
close
restore screen from ek	
RETURN	

PROCEDURE UZYTKWEW
local lic1:="      PARAMETRY FIRMY         "
local lic2:=" Wypelnij starannie rubryki   "
local lic5:=" 1 - 5  !!!                   "
local lic3:=" gdyz ich modyfikacja  bedzie "
local lic4:=" ograniczona !  Esc-rezygnacja"
local lkod:="  -   ",lnip:=substr(lic5,1,13),lkonto1:=space(30),lkonto2:=space(30)
local ltel:=space(20),lregon:=space(15),lpammiasto:=space(19),lzapisz:=.f.,ek
local pomlic1:=lic1
local pomlic2:=lic2
local pomlic3:=lic3
local pomlic4:=lic4
local pomlic5:=lic5
if alltrim(flic1)#"WERSJA DEMONSTRACYJNA"
  lic1=flic1
  lic2=flic2
  lic3=flic3
  lic4=flic4
  lic5=flic5
  lkod=substr(flic6,1,6)
  lnip=substr(flic5,1,13)
  ltel=substr(flic6,10,20)
  lpammiasto=pammiasto
  lkonto1=substr(zkon,1,30)
  lkonto2=substr(zkon,31,30)  
  lregon=zregon
endif
save screen to ek
do while.t.
  clear
  @ 2,2 to 22,77 double
  @ 4,4 say "1. Nazwisko i imie lub nazwa firmy "
  @ 5,4 say "2. Cd. ............................"
  @ 6,4 say "3. Numer identyfikacyjny   N I P .."  
  @ 7,4 say "4. Adres firmy.    Miasto: ........"
  @ 8,4 say "5. Adres firmy.    Ulica / Nr ....."
  @ 10,4 say "Adres firmy.    Kod pocztowy ......"

  @ 13,4 say"Nuemr statystyczny   R E G O N  ..."
  @ 15,4 say"Nazwa i numer konta bankowego ....."
  @ 16,4 say"Cd. ..............................."
  @ 18,4 say"Numer telefonu ...................."
  @ 20,4 say"Miejsce prowadznia sprzedazy ......" 
  set cursor on
  @ 4,40 get lic1
  @ 5,40 get lic2
  @ 6,40 get lnip
  @ 7,40 get lic3
  @ 8,40 get lic4
  @ 10,40 get lkod
  
  @ 13,40 get lregon
  @ 15,40 get lkonto1
  @ 16,40 get lkonto2
  @ 18,40 get ltel
  @ 20,40 get lpammiasto
  read
  set cursor off
  if lastkey()=27
    flic1=lic1
    flic2=lic2
    flic3=lic3
    flic4=lic4
    flic5=lic5
    fwl=flic1
    save to pam.mem
    exit
  endif
  do fragwew
  set color to n/w
  @ 6,43 say lic1
  @ 7,43 say lic2
  @ 8,43 say lic3
  @ 9,29say lkod
  @ 9,43 say lic4
  @ 10,32 say lnip
  @ 10,56 say lregon
  @ 11,43 say lkonto1
  @ 12,43 say lkonto2
  @ 13,36 say ltel
  set color to
  do konczwew with lzapisz,19,25 
  if lastkey()=27
    exit
  endif
  if lzapisz
    if sh_lic.or.m_lic.or.p_lic.or.kr_lic
      if.not.pierwsza
	      if (flic1#lic1.or.flic2#lic2).and.(ilezmian<2.or.zmiana_naz)
            fold1=flic1
			fold2=flic2
		    flic1=lic1
			flic2=lic2
		    if.not.zmiana_naz
			  ilezmian=ilezmian+1
			endif  
			zmiana_naz=.t.
		  endif
	      if substr(flic5,1,13)#lnip.and.(ilezmian<2.or.zmiana_nip)
		    fold5=flic5
			flic5=lnip
		    if.not.zmiana_nip
			  ilezmian=ilezmian+1
			endif  
			zmiana_nip=.t.
		  endif		  
	      if (flic3#lic3.or.flic4#lic4).and.(ilezmian<2.or.zmiana_adr)
		    fold3=flic3
			fold4=flic4
			flic3=lic3
			flic4=lic4
		    if.not.zmiana_adr
			  ilezmian=ilezmian+1
			endif  
			zmiana_adr=.t.
		  endif		  

	  else	  
	    flic1=lic1
        flic2=lic2
        flic3=lic3
        flic4=lic4
        flic5=lnip
	  endif	
      flic6=stuff(flic6,1,6,lkod)
      flic6=stuff(flic6,10,20,ltel)
      fwl=flic1
      pammiasto=lpammiasto
      zkon=stuff(space(60),1,30,lkonto1)
	  zkon=stuff(zkon,31,30,lkonto2)
      zregon=lregon
      if lic1#pomlic1.or.lic2#pomlic2.or.lic3#pomlic3.or.lic4#pomlic4.or.lic5#pomlic5
        pierwsza=.f.
	  endif	
      save to pam.mem
	  exit
    else
      do tkom with " UWAGA ! Definiowanie parametrow Uzytkownika mozliwe w wersji licencjonowanej."
      exit
	endif  
  endif
enddo
restore screen from ek
RETURN

PROCEDURE FRAGWEW
local f[20]
clear
f[1]:="                        F A K T U R A   V A T  NR     "
f[2]:="                        =============================="
f[3]:="       ..............................                 "
f[4]:="            PIECZEC   SPRZEDAWCY                      "
f[5]:="S P R Z E D A W C A  :                                "
f[6]:="| Nazwisko i imie ...                               | "
f[7]:="| lub nazwa firmy ...                               | "
f[8]:="| Adres: Miasto .....                               | "
f[9]:="| Kod:        Ulica..                               | "
f[10]:="| N I P :                 REGON :                   | "
f[11]:="| Konto .............                               | "
f[12]:="| Cd konta...........                               | "
f[13]:="   Telefon :                                          "
f[14]:="======================================================"
@ 5,1 say "FRAGMENT        ³¯ "
@ 6,1 say "   DOKUMENTU    ³¯¯"
@ 7,1 SAY "      SPRZEDAZY ³¯ " 
@ 0,0 to 24,79 double
set color to n/w
for i=1 to 14
  @ i,22 say f[i]
next
@ 24,0 say "                         [ Esc ]  -  rezygnacja                                 "
set color to
RETURN

PROCEDURE KONCZWEW
parameters pzapisz,pw,pk
local t[2],s
pzapisz=.f.
t[1]:="     Zapamietaj zmiany        "
t[2]:="     Powroc do  edycji        "
@ pw,pk to pw+3,pk+31 double
s=achoice(pw+1,pk+1,pw+2,pk+30,t)
if s=1
  pzapisz=.t.
endif
RETURN
