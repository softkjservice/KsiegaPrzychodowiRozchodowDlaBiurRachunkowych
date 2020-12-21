*KSEGA  PROGRAM GLOWNY
set procedure to m
set date german

*   #include "button.ch"
*   #include "inkey.ch"

*   SET( _SET_EVENTMASK, INKEY_ALL )
*   MSETCURSOR(.T.)
set century on
public zlegtryb:="A"
public zsiec:=.f.
public export_dok:=.f.
druk_public()
public kr_mini:=.f.,sh_mini:=.f.
public m_katalog:=space(30),k_katalog:=space(30)
public z_imp_sh:=.t.,z_imp_le:=.f.,z_imp_k2:=.f.,zimp_sciezka:=space(32)
public dostep:=.t.
public haslo:=space(10)
public shaslo:=space(10)
public kr_lic:=.f.
public zzwolniona:=.f.
public drukarka:="LPT1"
public kpoz[12]
public rpoz[12]
for i=1 to 12
  kpoz[i]:=0
  rpoz[i]:=0
next
public rycz_h:=3.3
public rycz_p:=6
public rycz_u:=9.5
public trah:=.f.
public magpraw:=.f.
public vvt:=.t.
public kolor:=0
public colzer:="W/N,N/W,N,N,N/W"
public coldef:="W/N,N/W,N,N,N/W"
public kjhas:="kjhas1957"
public in37:=.f.         && adresowanie kopert w kontrahencie .f. - blokada
public dokexport:=.f.    &&.t.=export dokumentu z programu firma
public wektor:=space(300)
public odlicz:=.t.                &&decyduje o mozliwosci odliczenia vat od zakupu
public pksiega:=.t.
public kssciezka:=space(3)
public stopa1:=21
public stopa2:=33
public stopa3:=45
public dolicz1:=-1212000
public dolicz2:=17856000
public dolicz3:=47820000
public prog2:=90800000
public prog3:=181600000
public plikdruk:=.f.
public lpt15:=.f.
public ms:=1
public me:=space(15)
public importdok:="1dok"
public ksiegakon:=.t.
public ilefirm:=10
public firnazwa:=space(15),zfirmiasto:=space(15),zfirulica:=space(15)
public wielofirm:=.t.
public ksfirnum:=1
public ryczalt:=.f.
public zz:=.f.
public rekon:=.f.
public ft[26],ft1[26]
public hel:="firma"    && okresla tekst w procedurze HELP
public fwar:=".t."      && wyk. przy ustawianiu filtru
public rem_zerk:=0.00
public rem_aktk:=0.00
public daf:=date()  && data obowiazujaca
public wid0:=0
public wid1:=0
public wid2:=0
public pro1:=0
public pro2:=0
public pro3:=0
public pro:=0
public zpoz:=space(6)
public dl:=0
public fwl:=space(33)
public flic1:=space(24)
public flic2:=space(24)
public flic3:=space(24)
public flic4:=space(24)
public flic5:=space(24)
public flic6:=space(24)
public fdys1:=space(34)
public fdys2:=space(34)
public pod_prod:=0  &&stopa oprocentowania
public pod_us:=0   && stopa oprocentowania
public tlo:=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
public siec_pam:=5
public dysk:="A:\"
public margines:=0
public mzao:=0
******************* O wybranej firmie
public zremzer:=0
public zremakt:=0
public zvatzer:=0
public zvatzap:=0
public zvat:=.f.
public zryczalt:=.f.
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
public znip:=space(13)
*public zuwagi:=space(30)
public zgrupa:=space(1)
public znskrot:=space(15)
public zaskrot:=space(15)
public zrabat:=0
public znr_kontr:=0
public zkontrahkonto:=space(40)
public kont:=.f.       &&decyduje czy kontrahent importowany (.t.) czy nowy do zapisu
**********************************Zmienne ksiegi
public zkspoz:=0
public zksday:=0
public zksdow:=space(15)
public zksnaz:=space(30)
public zksadr:=space(30)
public zksopis:=space(16)
public zkstow:=0
public zksusl:=0
public zkssum:=0
public zkszakup:=0
public zksubocz:=0
public zksobrot:=0
public zksobc:=0
public zksrep:=0
public zksgot:=0
public zksnat:=0
public zkswyd:=0
public zkswypos:=0
public zkswydsum:=0
public zksnic:=space(5)
public zksuwag:=space(17)
public zkswukr:=space(15)
public zkskukr:=0
public zksprocp:=0
public zksprocu:=0
public zksdata:=daf
public zksmod:=space(3)
public zksnip:=space(13)
public zks22:=0
public zks07:=0
public zks00:=0
public zkszw:=0
public zksvat22:=0
public zksvat07:=0
public zkszak:=.f.
public zkssprzed:=.f.
public zkskontr:=0
public zksrubr:=0
public zksexport:=.f.
**********************************
public datdem:=date()
public demczas:=14
public licencja:=.t.
**********************************Deklaracja tablicy dla filtrow
sh_firma=.f.
m_firma=.f.
p_firma=.f.
kr_firma=.t.
ft[1]:=space(15)
ft[2]:=space(25)
ft[3]:=space(25)
ft[4]:=space(16)
ft[5]:=space(30)
ft[6]:=space(5)
ft[7]:=space(3)
for i=8 to 24
  ft[i]=0
next
ft[25]:=daf
ft[26]:="*********************"
for i=1 to 26
  ft1[i]:=ft[i]
next
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




fil:=""
calk:=0
*set default to f01\m01
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
*
set default to leg01
if file("drukarki.dbf")
  if kj_use("drukarki",.f.,3)
    locate for dr="*"
	if.not.found()
	  go top
	endif
    druk_lad()	
    use
  endif
endif
set default to
*

sh_firma=.f.
m_firma=.f.
p_firma=.f.
kr_firma=.t.
shfirma=sh_firma
mfirma=m_firma
pfirma=p_firma
krfirma=kr_firma

remzer:=0.00
remakt:=0.00

*stopa1:=21
*stopa2:=33
*stopa3:=45
**dolicz1:=-165.50

*dolicz1:=-165.60
*dolicz2:=2438.40
*dolicz3:=6530.40
*prog2:=12400
*prog3:=24800

pdok=.f.                 &&wymusza pelny ekran w bazie kontrahenta
pksiega=.t.
daf:=date()  && data obowiazujaca
fwar=".t."
set color to (coldef)
do kstl
if.not.kr_lic
  do blokada
  if.not.licencja
    return
  endif  
endif
set color to (colzer)
do haslo with 10,25 
set color to (coldef)
if.not.dostep
  clear
  return
endif  
keyboard chr(205)

if wielofirm
  do wyborfir
  do ksdefault
else
  ksfirnum=1
  do ksdefault
  do tabpoz    
  do ksdefault
endif
*save to pam 
hel="firma"
pozm=1
do while .t.
  zm=.f.
  if kr_mini
    do menu_m
  else
    do menu      &&jesli koniec - zm=.t.
  endif
  if zm
    exit
  endif	
enddo
clear
set default to
save to pam
return




*******************************************************************************
*Procedura przyporzadkowuje numerowi nazwe miesiaca
*Parametry :  pnum-numer miesiaca
*             pnaz-nazwa miesiaca
****************************************************************************** 
PROCEDURE MIESIAC
parameters pnum,pnaz
do case
  case pnum=1
    pnaz="Styczen"
  case pnum=2
    pnaz="Luty"
  case pnum=3
    pnaz="Marzec"
  case pnum=4
    pnaz="Kwiecien"
  case pnum=5
    pnaz="Maj"
  case pnum=6
    pnaz="Czerwiec"
  case pnum=7
    pnaz="Lipiec"
  case pnum=8
    pnaz="Sierpien"
  case pnum=9
    pnaz="Wrzesien"
  case pnum=10
    pnaz="Pazdziernik"
  case pnum=11
    pnaz="Listopad"
  case pnum=12    
    pnaz="Grudzien"
endcase   
RETURN




PROCEDURE SPRDRK
do while .t.
  if isprinter()=.f.
@ 21,11 say" Przygotuj drukarke i nacisnij dowolny klawisz "
@ 22,11 say"              Esc-rezygnacja                   "      
   inkey(0)
set color to   
@ 21,11 say replicate(chr(176),47)   
@ 22,11 say replicate(chr(176),47)   
  else
    exit 
  endif
if lastkey()=27
  exit
endif    
enddo
RETURN




PROCEDURE PODK              && Tlo prawego menu
parameters to
set device to screen  
set color to (n/w,w/n)
    for i=10 to 22
    @ i,60 say replicate(chr(178),17)
    next
    set color to
    @ 21,58 say " Enter-zatwierdzenie "
    @ 22,58 say " Esc-rezygnacja      "
set color to (n/w,w/n)	
@ 11,62 clear to 19,74
@ 12,62 say to
@ 13,62 say "-------------"
    set color to
RETURN



PROCEDURE OK1
do txt with 21,"Wpisy, edycja, przeglad, wydruki ksiegi oraz deklaracji"
RETURN

PROCEDURE OK2
do txt with 21,"Kasowanie aktualnej bazy danych"        
RETURN

PROCEDURE OK3
do txt with 21,"Ustawianie parametrow dotyczacych dzialania programu "
RETURN

PROCEDURE OK4
do case
  case dysk="A:\"
    do txt with 21,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie A:"
  case dysk="B:\"
do txt with 21,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie B:"	
endcase
RETURN

PROCEDURE OK5
do txt with 21,"Powrot do systemu operacyjnego  D O S ."
RETURN




PROCEDURE MENU	
local t1[2],t2[8],t3[5],t4[4],T5[2]
local limport:=importdok
local s:=1
local last:=lastkey()
local em:=savescreen(0,0,24,79)
local lsiac:=month(daf)
local lksiegakon:=ksiegakon
declare t[5]
t1[1]:="L O K A L N Y"
t1[2]:=" Z DYSKIETKI "
if zryczalt
  t2[1]:="  EWIDENCJA   "
else
  t2[1]:=" K S I E G A  "
endif
t2[2]:="REJ. SPRZEDAZY"
t2[3]:=" REJ. ZAKUPOW "
t2[4]:=" WYPOSAZENIE  "
t2[5]:=" AMORT.JEDNOR."
t2[6]:="SR.TRWbezJEDNOR"
t2[7]:="   PROTOKOL    "
t2[8]:="FakturyDlaOsob "

t3[1]:=" B I L A N S  "
t3[2]:=" PARAMETRY    "
*t3[3]:=" ARCHIWIZACJA "
t3[3]:=" INDEKSACJA   "
t3[4]:=" NOWY ROK     "
t[1]:="  W P I S    "
t[2]:=" I M P O R T "
t[3]:=" KONTRAHENT  "
t[4]:=" W Y D R U K "
t[5]:="F-CJE TECHN."
t4[1]:=" K S I E G A  "
t4[2]:="R E J E S T R "
T4[3]:="UTARG MIESIACA"
t4[4]:="DEKLARACJA    "
t5[1]:="   P I T - 5  "
t5[2]:="   V A T - 7  "
pksiega=.t.
aspozyc=10
set color to
set cursor off
@ 4,0 clear to 6,79
@ 4,0 to 6,79 double
@ 5,2 say t[1]
@ 5,17 say t[2]
@ 5,33 say t[3]
@ 5,49 say t[4]
@ 5,65 say t[5]
do kreska with 4,15
do kreska with 4,31
do kreska with 4,47
do kreska with 4,63
@ 4,0 say chr(204)
@ 6,0 say chr(204)
@ 4,79 say chr(185)
@ 6,79 say chr(185)
*@ 4,16 say chr(207)
*@ 4,63 say chr(216)
@ 0,60 say chr(205)
@ 0,61 say chr(205)
@ 0,62 say chr(205)
do pole1 with pozm

do while .t.
@ 2,66 say daf        
  do while .t.
    last=inkey(0)
    if last=27.or.last=13.or.last=19.or.last=4.or.last=1.or.last=6.or.last=83.or.last=115.or.last=70.or.last=102.or.last=90.or.last=122.or.last=82.or.last=114.or.last=75.or.last=107.OR.last=-1.or.last=-2
      exit
    endif
    if last=-9
	  do robak
	endif
  enddo
	  do case
	    case last=-1	
	      do wyborfir
          do ksdefault
		  if zryczalt
            t2[1]:="  EWIDENCJA   "
          else
            t2[1]:=" K S I E G A  "
          endif
        case last=-2
          do wybsiac

	    case last=19     &&strzalka w lewo
	      if pozm>1
		    pozm=pozm-1
		  else
		    pozm=5
		  endif
	    case last=4
	      if pozm<5
		    pozm=pozm+1
		  else
		    pozm=1
		  endif
	    case last=1.or.last=83.or.last=115   &&Sprzedaz
	      pozm=1
	    case last=6.or.last=70.or.last=102   &&Funkcje 
	      pozm=5
		case last=68.or.last=100   &&Dostawy
		  pozm=2		  
        case last=82.or.last=114   &&Rejestr 
		  pozm=3
        case last=75.or.last=107   &&Katalogi
		  pozm=4		  
	    case last=27
          @ 21,1 clear to 23,78
          zm=.t.
          set cursor on
          @ 21,27 to 23,48 double
          set color to w/n*
          @ 22,29 say "K O N I E C  ?  "get zm
          read
          set cursor off
          set color to
          if zm
            return
          endif	
          return

	    case last=13
          do pole1 with pozm	  
		  exit			    	    
	 endcase
     do pole1 with pozm
  enddo
save screen to em
*do ksdefault         &&****
do case
   case pozm=1
     d=1
     do while .t.
       set color to
       @ 6,0 TO 11,15 double   
       d=achoice(7,1,10,14,t4,,,d)   
       do case 
         case d=1
           keyboard chr(205)
           do ksiega with 1
	     case d=2
           keyboard chr(205)
		   do ksiega with 2
		 case d=3
		 * do pit
		 do ksbil with 2
         do knum  		 
		 case d=4
           do while.t.
             set color to
             @ 9,15 TO 12,31 double   
	         imp=1
		     imp=achoice(10,16,11,30,t5,,,imp)   
		     do case
			   case imp=1
			     do pit
			   case imp=2
			     do vat7	 
			   case imp=0
			     exit
			 endcase
		   enddo  
*	   do pit
 *          do ksdefault
         case d=0
            exit 
       endcase
       restore screen from em
     enddo

   case pozm=2.and.z_imp_sh
     do while.t.
       set color to
       @ 6,15 TO 9,31 double   
	   imp=1
       imp=achoice(7,16,8,30,t1,,,imp)   
       do case 
	     case imp=1
		   if zryczalt
		     zksprocp=3.0
		     do skom with "Zatwierdz stawke ryczaltu."
			 set cursor on
			   @ 17,27 say " Stawka ryczaltu       % "
			   @ 17,45 get zksprocp picture "99.9"
			   read
			 set cursor off
		   endif
 		   set default to &importdok
           lksiegakon=ksiegakon
		   ksiegakon=.f. 	               &&skierowanie do odpowiedniej bazy kontrahenta	   
           kr_firma=.f.
		   do kmbuf with -1
           kr_firma=.t.
		   ksiegakon=lksiegakon
		   if lastkey()#27.and.file("dokument.dbf")
		     do rsum with .t.
		   endif	 
		   do ksdefault
		   *do rsum
		   restore screen from em

		 case imp=2
		   if zryczalt
		     zksprocp=rycz_h
		     do skom with "Zatwierdz stawke ryczaltu."
			 set cursor on
			   @ 12,27 say " Stawka ryczaltu       % "
			   @ 12,45 get zksprocp
			   read
			 set cursor off
		   endif
           pksrej=1      && decyduje o wpisie do ksiegi a nie do rejestru
		   dyskready=.t.
		   do dysktest with dyskready
		   if.not.dyskready
		      restore screen from em
	          return
           endif  
           set default to &dysk
		   if file("rejsum.dbf")
		     dyskbyl=.f.
             do ksidentyf with dyskbyl
			 if dyskbyl
			   do ksdefault
			   restore screen from em
			   return
			 endif
             do while.t.
			   do skom with "PgUp - przeglad   ENTER - zatwierdzenie importu   ESC - rezygnacja"
			   inkey(0)
			   do case
			     case lastkey()=27
				   do ksdefault
                   restore screen from em
				   return
				 case lastkey()=18
				   select 1
				   use rejsum index rejsum  
				   browse()
                   use
				   zz=.t.
				   do gkom with "Ksiegowac ?  [T/N] ",zz
				   if lastkey()#27.and.zz
					 do dokdysk
					 restore screen from em					 					 
					 exit
				   endif  
				 case lastkey()=13
				   *do tkom with "Procedura ks"  
				   do dokdysk
                   restore screen from em
				   exit
			   endcase
			 enddo 
             do ksdefault
		   else
		     do tkom with "Dyskietka nie zawiera pliku transmisyjnego !  Zmien i ponow probe.  OK!"
		   endif


*		     do ksnum
*		     use
		 case imp=0
           restore screen from em
		   exit
	   endcase	 	 
	 enddo
***	 do ksnum
*     do ksindex
do knum


   case pozm=2.and.z_imp_le
     leg_import()
     close all
	 do knum
	 
   case pozm=2.and.z_imp_k2
     kam_import()
     do knum	 
   
   case pozm=3
     do kontrah with space(30)
*	 do firdefault
     do ksdefault
   case pozm=4
     pksiega=.t.
     d=1
     do while .t.
       set color to
       @ 6,47 TO 12,63 double   
       d=achoice(7,48,11,62,t2,,,d)   
       do case 
         case d=1.and..not.zryczalt
           do ksiegadr with 1
         case d=1.and.zryczalt
           do ksiegadr with 4		   
	     case d=2
           do ksiegadr with 5     &&rej sprzedazy
*		   do ksdruk with 2
	     case d=3                 &&rej zakupow
*		   do ksdruk with 3		   
           do ksiegadr with 6 
	     case d=4
           zz=.t.
		   do gkom with "Uzupelnic numeracje ?   [T/N] ",zz
		   if lastkey()=27
		     return
		   endif	 
		   if zz
		     do skom with "Czekaj !  Trwaja operacje dyskowe."
			 do wksnum
		   endif
           do skom with "Zatwierdz miesiac . "
		   do ksiegadr with 2
	     case d=5
           zz=.t.
		   do gkom with "Uzupelnic numeracje ?   [T/N] ",zz
		   if lastkey()=27
		     return
		   endif	 
		   if zz
		     do skom with "Czekaj !  Trwaja operacje dyskowe."
			 do jksnum
		   endif
           do skom with "Zatwierdz miesiac . "
		   do ksiegadr with 8		   
		 
		 case d=6
		   do ksdruk with 5   	 
		 case d=7
		   do ksiegadr with 9   	 		   
		 case d=8
		   do ksiegadr with 55  	 		   		   
         case d=0
            exit 
       endcase
     enddo

 case pozm=5
     d=1
     do while .t.
	 restore screen from em
       set color to
       @ 6,63 TO 11,79 double   
       d=achoice(7,64,10,78,t3,,,d)   
       do case 
         case d=1
           do ksbil with 1
         case d=2
           do kparam		   	   
	     case d=33
           do case
             case dysk="A:\"
               do tx with 1,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie A:"
             case dysk="B:\"
               do tx with 1,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie B:"	
           endcase  
           do ksarch
	       pozm=5 
		 case d=3
           do ksindex
         case d=4
		   do nowyrok
         case d=0
            exit 
       endcase
     enddo
endcase
restore screen from em
RETURN

PROCEDURE POLE1
parameters ppoz
do case
  case ppoz=1
    set color to n/w
    @ 5,2 say t[1]
	set color to
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
    do tx with 0,21,"Wpisywanie nowych pozycji, poprawianie, kasowanie, podsumowania   "  
    if wielofirm
      do tx with 1,22,"  F2 - wybor firmy    F3 - wybor miesiaca     F10 - wylaczenie ekranu "
    else
      do tx with 1,22,"  F3 - wybor miesiaca      F10 - wylaczenie ekranu    "	
	endif
    do tx with 1,23,"Enter - Zatwierdzenie pozycji menu       Esc - Rezygnacja"
  case ppoz=2
    @ 5,2 say t[1]
	set color to n/w
    @ 5,17 say t[2]
	set color to
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
    do tx with 0,21,"Import dokumentow z systemu FIRMA (faktury, rachunki, utargi dzienne)"
    if wielofirm
      do tx with 1,22,"    F2 - wybor firmy       F10 - wylaczenie ekranu    "
    else
      do tx with 1,22,"  F3 - wybor miesiaca      F10 - wylaczenie ekranu    "	
	endif
    do tx with 1,23,"Enter - Zatwierdzenie pozycji menu       Esc - Rezygnacja"	
  case ppoz=3
    @ 5,2 say t[1]
    @ 5,17 say t[2]
	set color to n/w
    @ 5,33 say t[3]
	set color to
    @ 5,49 say t[4]
    @ 5,65 say t[5]
    do tx with 0,21,"Wpisywanie nowych kontrahentow, wyszukiwanie, poprawianie, kasowanie"
    if wielofirm
      do tx with 1,22,"    F2 - wybor firmy       F10 - wylaczenie ekranu    "
    else
      do tx with 1,22,"  F3 - wybor miesiaca      F10 - wylaczenie ekranu    "	
	endif
    do tx with 1,23,"Enter - Zatwierdzenie pozycji menu       Esc - Rezygnacja"	
  case ppoz=4
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
	set color to n/w
    @ 5,49 say t[4]
	set color to
    @ 5,65 say t[5]
    do tx with 0,21,"Wydruk ksiegi oraz rejestrow"
    if wielofirm
      do tx with 1,22,"    F2 - wybor firmy       F10 - wylaczenie ekranu    "
    else
      do tx with 1,22,"  F3 - wybor miesiaca      F10 - wylaczenie ekranu    "	
	endif
    do tx with 1,23,"Enter - Zatwierdzenie pozycji menu       Esc - Rezygnacja"	
  case ppoz=5
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
	set color to n/w
    @ 5,65 say t[5]				
	set color to
    do tx with 0,21,"-  BILANS  -  PARAMETRY  -  ARCHIWIZACJA  -  INDEKSACJA  - "
    if wielofirm
      do tx with 1,22,"    F2 - wybor firmy       F10 - wylaczenie ekranu    "
    else
      do tx with 1,22,"  F3 - wybor miesiaca      F10 - wylaczenie ekranu    "	
	endif    
	do tx with 1,23,"Enter - Zatwierdzenie pozycji menu       Esc - Rezygnacja"	
endcase  
RETURN


PROCEDURE KSTL
local lmiesiac:=space(15)
local lnumer:=month(daf)
tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
set color to (colzer)
clear
set color to (coldef)
*@ 7,0,19,79 box tlo
for i=7 to 19
  @ i,0 say replicate(chr(176),80)
next
for i=1 to 3
  @ i,0 say space(80)
next
set color to (colzer)
@ 0,0 to 24,79 double
@ 20,0 to 24,79 double
@ 4,0 to 6,79 double
*@ 20,0 say chr(204)
*@ 20,79 say chr(182)
*@ 4,0 say chr(204)
*@ 6,0 say chr(204)
*@ 4,79 say chr(182)
*@ 6,79 say chr(182) 
*@ 4,16 say chr(216)
*@ 6,16 say chr(207)
*@ 4,32 say chr(209)
*@ 6,32 say chr(207)
*@ 4,48 say chr(209)
*@ 6,48 say chr(207)
*@ 4,64 say chr(209)
*@ 6,64 say chr(207)
*@ 0,16 say chr(209)
*@ 0,63 say chr(209)
@ 1,63 say chr(179)
@ 2,63 say chr(179)
@ 3,63 say chr(179)
*@ 4,63 say chr(207)
@ 1,16 say chr(179)
@ 2,16say chr(179)
@ 3,16 say chr(179)
set color to (coldef)

@ 1,1 say " M I E S I A C "    
do miesiac with lnumer,lmiesiac
@ 2,(16-LEN(ALLTRIM(LMIESIAC)))/2 say lmiesiac
@ 1,66 say " D A T A "
@ 2,66 say daf
if kolor=0
  set color to W/N+
endif          
@ 1,17 say "             *  F  I  R  M  A  *              "
set color to (coldef)
@ 2,17 say "        KSIEGA PRZYCHODOW I ROZCHODOW         "
@ 3,24 say fwl
@ 24,1 say replicate(chr(205),78)
RETURN



PROCEDURE WYBORFIR
local ek:=savescreen(0,0,24,79)
local t[ilefirm],tm[ilefirm],tu[ilefirm]
local i:=1
local lfirnum:=ksfirnum
local s:=ksfirnum
for k=1 to ilefirm
  t[k]:=space(15)
next
select 1
set default to
if .not.file("firdef.dbf")
  do tkom with "Brak mozliwosci zdefiniowania firm !  Nacisnij dowolny klawisz."
  return
else  
  use firdef  
  do while i<=ilefirm
    t[i]:=firnaz
    tm[i]=firmiasto
	tu[i]=firulica
	skip
    if eof()
      exit
    endif
    i=i+1
  enddo  
  use
  save screen to ek
  do skom with "Enter - zatwierdzenie      PgUp - wykaz firm     Esc - rezygnacja"
  @ 12,27 say "  Podaj numer firmy       "
  set cursor on
  @ 12,49 get lfirnum picture "999" range 1,ilefirm
  read
  set cursor off
  do case
    case lastkey()=13.or.lastkey()=3
      ksfirnum=lfirnum
    case lastkey()=18
       s=achoice(8,60,8+ilefirm-1,74,t,,,s)
*    fs=achoice(8,60.12,74,t)
      if lastkey()#27.and.lastkey()#4.and.lastkey()#19
	    ksfirnum=s
	  endif
  endcase
  restore screen from ek
  if ksfirnum>ilefirm
    ksfirnum=ilefirm
  endif
  firnazwa=t[ksfirnum]
  zfirmiasto=tm[ksfirnum]
  zfirulica=tu[ksfirnum]
  @ 3,1 say firnazwa
  if substr(zfirulica,15,1)="."
    export_dok=.t.
  else
    export_dok=.f.	
  endif
endif  
do tabpoz
RETURN  

PROCEDURE TABPOZ
for i=1 to 11
  select 2
  do pksdefault with i
  use ksiega index ksiega
  kpoz[i+1]=kpoz[i]+lastrec()
  use rejestr index rejestr
  rpoz[i+1]=rpoz[i]+lastrec()    
  use
next
RETURN



PROCEDURE STAWKI
parameters pndok,pks22,pks07,pks00,pkszw
local ltyp:=substr(pndok,12,1)
pks22=0
pks07=0
pks00=0
pkszw=0
select 3
do case
  case ltyp$"FRNP"
    use sprzedaz index sprzedaz
  case ltyp$"fr"
    use zakup index zakup 	
endcase
seek pndok
if found()
  do while pndok=tndok
    if substr(tster,1,1)="z"
	   pkszw=pkszw+twartbp	
    else 
	  do case
	    case tstawka=22
	      pks22=pks22+twartbp
	    case tstawka=7
	      pks07=pks07+twartbp
	    case tstawka=0
	      pks00=pks00+twartbp
	   endcase
	endif
	skip
  enddo
else
  do tkom with "Brak dostepu do pozycji"
  @ 24,60 say pndok
endif
use
RETURN

PROCEDURE WYBSIAC
local ek:=savescreen(0,0,24,79)
local lsiac:=month(daf)
local lsiac1:=month(date())
local lmiesiac:=space(12)
local ldat:=space(8)
save screen to ek
          @ 12,29 say "  Podaj miesiac      "
	      set cursor on
	      @ 12,46 get lsiac picture "99" range 1,12  
	      read
	      set cursor off         
	      if lastkey()#27
		    ldat=dtoc(daf)
			if lsiac#month(date())
              ldat=stuff(ldat,1,2,"01") 
			else
			  ldat=dtoc(date())
			endif
			if lsiac>9
			  ldat=stuff(ldat,4,2,str(lsiac,2,0))
			else
			  ldat=stuff(ldat,4,1,"0")
			  ldat=stuff(ldat,5,1,str(lsiac,1,0))
			endif  
			daf=ctod(ldat)		  
	        do ksdefault 
	      endif		  	  
restore screen from ek
do miesiac with lsiac,lmiesiac
@ 2,1 say space(15)
@ 2,(16-LEN(ALLTRIM(LMIESIAC)))/2 say lmiesiac
RETURN


PROCEDURE KSIDENTYF
parameters pdyskbyl
local ek:=savescreen(0,0,24,79)
save screen to ek
@ 0,0,24,79 box tlo
set color to n/w
@ 4,17 to 20,62 double
@ 5,18 say "  IDENTYFIKATOR  DYSKIETKI TRANSMISYJNEJ    "
@ 6,18 say "--------------------------------------------"
set color to 
@ 7,18 say "                                            "
@ 8,18 say " N A D A W C A  :                           "
@ 9,18 say " Nazwa.....                                 "
@ 10,18 say" Cd nazwy..                                 "
@ 11,18 say" Adres.....                                 "
@ 12,18 say" Cd adresu.                                 "
@ 13,18 say" NIP.......                                 "
@ 14,18 say"                                            "
@ 15,18 say"--------------------------------------------"
@ 16,18 say" DOKUMENT :                                 "
@ 17,18 say"--------------------------------------------"
@ 18,18 say"                                            "
@ 19,18 say" PgUp  -  przeglad importowanych dokumentow "
set default to &dysk
select 21
use bufor
@ 9,29 say naz1
@ 10,29 say naz2
@ 11,29 say miasto
@ 12,29 say ulica
@ 13,29 say uwagi
@ 16,30 say opis    &&rodzdok
if przyjeto=.t.
  set color to w/n+*
  @ 13,18 say" UWAGA  !    Dokumenty byly juz importowane."
  pdyskbyl=.t.
  do tkom with "Nacisnij dowolny klawisz !"
endif
use
RETURN

PROCEDURE WERSJA
do tkom with "Dostepne w rozszerzonej wersji programu !  OK!"
RETURN

PROCEDURE DOKDYSK
do skom with "Czekaj !  Trwa ksiegowanie dokumentow z dyskietki. "
do zapiszimp
select 1
use ksiega index ksiega
do ksnum
set default to &dysk
use bufor
replace przyjeto with .t.
use
RETURN					 	

PROCEDURE SUF
set color to n/w
@ 22,0 say "  * sufler *  |                                                  |              "
@ 23,0 say "              |                                                  |  * sufler *  "  
set color to 
RETURN

PROCEDURE KNUM
knum=0
for i=1 to 12
  do pksdefault with i
  select 1
  use ksiega index ksiega
  do while.not.eof()
    knum=knum+1
	replace kspoz with knum
	skip
  enddo
  use
next
do ksdefault
RETURN

PROCEDURE MENU_M	
local t1[2],t2[3],t3[5],t4[4],T5[2]
local limport:=importdok
local s:=1
local last:=lastkey()
local em:=savescreen(0,0,24,79)
local lsiac:=month(daf)
local lksiegakon:=ksiegakon
declare t[5]
t1[1]:="L O K A L N Y"
t1[2]:=" Z DYSKIETKI "
if zryczalt
  t2[1]:="  EWIDENCJA   "
else
  t2[1]:=" K S I E G A  "
endif
t2[2]:=" REJ. SPRZEDAZY"
t2[3]:=" REJ. ZAKUPOW "

t3[1]:=" B I L A N S  "
t3[2]:=" PARAMETRY    "
*t3[3]:=" ARCHIWIZACJA "
t3[3]:=" INDEKSACJA   "
t3[4]:=" NOWY ROK     "
t[1]:="  W P I S    "
t[2]:=" I M P O R T "
t[3]:=" KONTRAHENT  "
t[4]:=" W Y D R U K "
t[5]:="F-CJE TECHN."
t4[1]:=" K S I E G A  "
t4[2]:="R E J E S T R "
T4[3]:="UTARG MIESIACA"
t4[4]:="DEKLARACJA    "
t5[1]:="   P I T - 5  "
t5[2]:="   V A T - 7  "
pksiega=.t.
aspozyc=10
set color to
set cursor off
@ 4,0 clear to 6,79
@ 4,0 to 6,79 double
@ 5,2 say t[1]
@ 5,17 say t[2]
@ 5,33 say t[3]
@ 5,49 say t[4]
@ 5,65 say t[5]
do kreska with 4,15
do kreska with 4,31
do kreska with 4,47
do kreska with 4,63
@ 4,0 say chr(204)
@ 6,0 say chr(204)
@ 4,79 say chr(185)
@ 6,79 say chr(185)
*@ 4,16 say chr(207)
*@ 4,63 say chr(216)
@ 0,60 say chr(205)
@ 0,61 say chr(205)
@ 0,62 say chr(205)
do pole1 with pozm

do while .t.
@ 2,66 say daf        
  do while .t.
    last=inkey(0)
    if last=27.or.last=13.or.last=19.or.last=4.or.last=1.or.last=6.or.last=83.or.last=115.or.last=70.or.last=102.or.last=90.or.last=122.or.last=82.or.last=114.or.last=75.or.last=107.OR.last=-1.or.last=-2
      exit
    endif
    if last=-9
	  do robak
	endif
  enddo
	  do case
	    case last=-1	
	      do wyborfir
          do ksdefault
		  if zryczalt
            t2[1]:="  EWIDENCJA   "
          else
            t2[1]:=" K S I E G A  "
          endif
        case last=-2
          do wybsiac

	    case last=19     &&strzalka w lewo
	      if pozm>1
		    pozm=pozm-1
		  else
		    pozm=5
		  endif
	    case last=4
	      if pozm<5
		    pozm=pozm+1
		  else
		    pozm=1
		  endif
	    case last=1.or.last=83.or.last=115   &&Sprzedaz
	      pozm=1
	    case last=6.or.last=70.or.last=102   &&Funkcje 
	      pozm=5
		case last=68.or.last=100   &&Dostawy
		  pozm=2		  
        case last=82.or.last=114   &&Rejestr 
		  pozm=3
        case last=75.or.last=107   &&Katalogi
		  pozm=4		  
	    case last=27
          @ 21,1 clear to 23,78
          zm=.t.
          set cursor on
          @ 21,27 to 23,48 double
          set color to w/n*
          @ 22,29 say "K O N I E C  ?  "get zm
          read
          set cursor off
          set color to
          if zm
            return
          endif	
          return

	    case last=13
          do pole1 with pozm	  
		  exit			    	    
	 endcase
     do pole1 with pozm
  enddo
save screen to em
*do ksdefault         &&****
do case
   case pozm=1
     d=1
     do while .t.
       set color to
       @ 6,0 TO 9,15 double   
       d=achoice(7,1,8,14,t4,,,d)   
       do case 
         case d=1
           keyboard chr(205)
           do ksiega with 1
	     case d=2
           keyboard chr(205)
		   do ksiega with 2

         case d=0
            exit 
       endcase
       restore screen from em
     enddo

   case pozm=2
		   if zryczalt
		     zksprocp=3.0
		     do skom with "Zatwierdz stawke ryczaltu."
			 set cursor on
			   @ 17,27 say " Stawka ryczaltu       % "
			   @ 17,45 get zksprocp picture "99.9"
			   read
			 set cursor off
		   endif
 		   set default to &importdok
           lksiegakon=ksiegakon
		   ksiegakon=.f. 	               &&skierowanie do odpowiedniej bazy kontrahenta	   
           kr_firma=.f.
		   do kmbuf with -1
           kr_firma=.t.
		   ksiegakon=lksiegakon
		   if lastkey()#27.and.file("dokument.dbf")
		     do rsum with .t.
		   endif	 
		   do ksdefault
		   restore screen from em
           do knum




   
   case pozm=3
     do kontrah with space(30)
     do ksdefault
   case pozm=4
     pksiega=.t.
     d=1
     do while .t.
       set color to
       @ 6,47 TO 10,63 double   
       d=achoice(7,48,9,62,t2,,,d)   
       do case 
         case d=1.and..not.zryczalt
           do ksiegadr with 1
         case d=1.and.zryczalt
           do ksiegadr with 4		   
	     case d=2
           do ksiegadr with 5     &&rej sprzedazy
	     case d=3                 &&rej zakupow
           do ksiegadr with 6 
         case d=0
            exit 
       endcase
     enddo

 case pozm=5
     d=1
     do while .t.
	 restore screen from em
       set color to
       @ 6,63 TO 11,79 double   
       d=achoice(7,64,10,78,t3,,,d)   
       do case 
         case d=1
           do ksbil with 1
         case d=2
           do kparam_m		   	   
	     case d=33
           do case
             case dysk="A:\"
               do tx with 1,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie A:"
             case dysk="B:\"
               do tx with 1,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie B:"	
           endcase  
           do ksarch
	       pozm=5 
		 case d=3
           do ksindex
         case d=4
		   do nowyrok
         case d=0
            exit 
       endcase
     enddo
endcase
restore screen from em
RETURN
