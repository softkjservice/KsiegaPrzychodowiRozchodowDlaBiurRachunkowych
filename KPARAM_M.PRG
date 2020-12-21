**PROCEDURE PARAM
local ek:=savescreen(0,0,24,79),ek1
local t[10],h[2],T1[2]
local s:=1
local has:=space(10)
zregon=space(15)
hel="param"
t1[1]:="Stawki  VAT  "
t1[2]:="Stawki RYCZALTU"
h[1]:=" PRACOWNIK  "
H[2]:=" ZARZADCA   "
t[1]:="1. HASLO   "
t[2]:="2. RYCZALT "
t[3]:="3. KOLOR   "
t[4]:="4. LPT 15''"
t[5]:="5. Do pliku"
t[6]:="6. ProgiPod"
t[7]:="7. STAWKI  "
t[8]:="8. Sp.zwol."
t[9]:="9. Uzytkown"
t[10]:="10.DRUKARKI"
hel="param"
set color to (coldef)
@ 0,0,24,79 box tlo
if kolor=0
  set color to n/w
endif  
@ 0,0 SAY "  SYSTEM ZARZADZANIA PRZEDSIEBIORSTWEM   * P A R A M E T R Y *                  "
set color to n/w
for i=3 to 19
  @ i,14 say space(19)
next
@ 0,69 say daf
@ 2,1 to 20,33 double

@ 4,14 say "-------------------"
@ 6,16 say zryczalt
@ 7,16 say kolor picture "9"
@ 8,16 say lpt15
@ 9,16 say plikdruk
@ 12,16 say zzwolniona
set color to
@ 4,2 say "-----------"
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
@ 16,43 say "        P R O D U C E N T         "
@ 17,43 say "----------------------------------"
@ 18,43 say fdys1
@ 19,43 say fdys2

do while .t.
set color to
s=achoice(5,2,19,12,t,,,s) 
do suf
do case
  case s=1
        save screen to ek
        @ 7,18 to 10,31 double
		hs=achoice(8,19,9,30,h) 		
        restore screen from ek
		if hs#0
    	  do haslo with 17,5
		  if dostep
		    set cursor on
		    @ 8,16 get has
		    read
		    set cursor off
		    zz=.t.
		    do gkom with "Zatwierdzic nowe haslo ? [T/F] ",zz
		    if zz.and.lastkey()#27.and.hs=1
		      haslo=has
			  set default to
		      save to pam
		    endif	
		    if zz.and.lastkey()#27.and.hs=2.and.MagPraw=.t.
		      shaslo=has
			  set default to
		      save to pam
		    endif				
		  endif
		endif		  
		
  case s=2
		do suf
		@ 22,16 say "  T - rozliczenie ryczaltowe            "
		@ 23,16 say "  F - rozliczenie pelne                 "
		set cursor on
		@ 6,16 get zryczalt   
		read
		set cursor off   
		if lastkey()#27
          do firdefault
		  select 7
		  use ksmem
		  replace ryczalt with zryczalt
		  use
		  do ksdefault
		endif 		
        
  case s=3
		do suf
		@ 22,16 say " 0-Brak kolory  1-niebieski  2-zielony  "
		@ 23,16 say " 3-czerwony  4-brazowy  5-zolty  6-karm."  
        set cursor on
		@ 7,16 get kolor picture "9"
		read
        if lastkey()#27
		  do case
		    case kolor=0
			  coldef="W/N,N/W,N,N,N/W"
		    case kolor=1
			  coldef="GR+/BG+,R+/B+"
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
    	  set default to
		  save to pam
		endif
        set cursor off

  case s=4
        zlpt15=lpt15
		do suf
		@ 22,16 say " T-Wydruk jednoczesciowy na druk. 15cal."
		@ 23,16 say " F-Wydruk dzielony na drukarce 10 cal.  "
		set cursor on
		@ 8,16 get zlpt15
		read
		set cursor off   
		if lastkey()#27
		  lpt15=zlpt15  
          set default to
		  save to pam
		endif 		
  
  case s=5
        zplikdruk=plikdruk
		do suf
		@ 22,16 say " T-Wydruk do pliku \kjdruk.prn          "
		@ 23,16 say " F-Wydruk na drukarke                   "
		set cursor on
		@ 9,16 get zplikdruk
		read
		set cursor off   
		if lastkey()#27
		  plikdruk=zplikdruk
          set default to
		  save to pam
		endif 		  
  case s=6 
      do suf
      @ 22,15 say "       STRZALKI - PRZEMIESZCZANIE KURSORA         "
      @ 23,15 say "        ENTER - POCZATEK I KONIEC EDYCJI          "	  
      set default to
        if file("ram.dbf")
          save screen to ek
		  select 7
		  use ram
		  browse(14,14,19,78)
		  use
		  restore screen from ek
		else
		  do tkom with "Brak dostepu do pliku <ram.dbf>!    Nacisnij dowolny klawisz."  
		endif
  case s=7
      save screen to ek       
      do suf
      @ 22,15 say "       D E F I N I O W A N I E    S T A W E K     "
      @ 23,15 say "                                                  "	    
	  @ 14,14 to 17,30 double
      k=1
	  k=achoice(15,15,17,29,t1,,,k) 
	  if lastkey()#27
         do case
		   case k=2
		     @ 7,14 to 12,30 double
			 @ 8,15 say  "Handel...."
			 @ 9,15 say  "Produkcja."
			 @ 10,15 say "Uslugi...."
			 @ 11,15 say "               "
			 set cursor on
			 @ 8,25 get rycz_h picture "99.9"
			 @ 9,25 get rycz_p picture "99.9"
			 @ 10,25 get rycz_u picture "99.9"			 
			 read
		 endcase
		 set cursor off
		 if lastkey()#27
		   set default to
		   save to pam
		 endif	 
	  endif
      restore screen from ek
	   
  case s=8
		do suf
		@ 22,16 say " T-Wystepuje sprzedaz zwolnina od pod.VAT"
		@ 23,16 say " F-Nie wystepuje sp.zwolniona od pod. VAT"
		set cursor on
		@ 12,16 get zzwolniona   
		read
		set cursor off   
		if lastkey()#27
          do firdefault
		  select 7
		  use ksmem
		  replace zwolniona with zzwolniona
		  use
		  do ksdefault
		endif 		    

  case s=9
    do uzytkwew
  case s=10
    druk_wybor(15,30)
	do ksdefault
  case s=0
    keyboard chr(205)
	exit
endcase
enddo
do ksdefault
set color to
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
* @ 4,40 get lic1
* @ 5,40 get lic2
* @ 6,40 get lnip
* @ 7,40 get lic3
* @ 8,40 get lic4
set color to n/w
  @ 4,40 say lic1
  @ 5,40 say lic2
  @ 6,40 say lnip
  @ 7,40 say lic3
  @ 8,40 say lic4
set color to    

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