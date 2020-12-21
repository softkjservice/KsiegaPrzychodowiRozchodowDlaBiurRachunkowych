* Wypelnianie rubryk ksiegi przychodow i rozchodow
parameters pksrej     &&pksrej=1 - wpis do ksiegi
*                     &&pksrej=2 - wpis do rejestru z pominieciem ksiegi
local n[6],t[6],n2[6],t2[6],n3[6],t3[6],n4[6],t4[6],n5[7],t5[7]
ex_public()
public kszapisz:=.f.
public odlicz:=.t.
public fwar:=".t."
set confirm on
zsum=0
n[1]:="kspoz"
n[2]:="ksday"
n[3]:="substr(ksdow,1,10)"
n[4]:="substr(ksnaz,1,15)"
n[5]:="substr(ksadr,1,15)"
n[6]:="substr(ksopis,1,16)"
t[1]:=""
t[2]:="CA"
T[3]:="  KSIEG."
t[4]:="   (NAZWA)   "
t[5]:="   MIASTO,UL "
t[6]:="  PODARCZEGO "
n2[1]:="kspoz"
n2[2]:="kstow"
n2[3]:="ksusl"
n2[4]:="kssum"
n2[5]:="kszakup"
n2[6]:="ksubocz"
t2[1]:=""
t2[2]:="TOW. I USLUG"
t2[3]:=" PRZYCHODY"
T2[4]:=" [7]+[8]  "
t2[5]:="WYCH I MAT."
t2[6]:="  ZAKUPU  "
n3[1]:="kspoz"
n3[2]:="ksobrot"
n3[3]:="ksobc"
n3[4]:="ksrep"
n3[5]:="ksgot"
n3[6]:="ksnat"
t3[1]:=""
t3[2]:=space(12)
t3[3]:="   OBCEJ    "
T3[4]:="  I REKLAMY "
t3[5]:=space(12)
t3[6]:=space(11)
n4[1]:="kspoz"
n4[2]:="kswyd"
n4[3]:="kswypos"
n4[4]:="kswydsum"
n4[5]:="ksnic"
n4[6]:="ksuwag"
t4[1]:=""
t4[2]:=""
t4[3]:=""
T4[4]:=""
t4[5]:=""
t4[6]:=""
n5[1]:="kspoz"
n5[2]:="kswypos"
n5[3]:="kswydsum"
n5[4]:="substr(ksnic,1,1)"
n5[5]:="substr(ksuwag,1,1)"
n5[6]:="substr(kswukr,1,22)"
n5[7]:="kskukr"
for i=1 to 7
  t5[i]:=""
next
****************************** Zmienne - nowa pozycja
zkspoz=0
zksday=0
zksdow=space(15)
zksnaz=space(30)
zksadr=space(30)
zksopis=space(16)
zkstow=0.00
zksusl=0.00
zkssum=0.00
zkszakup=0.00
zksubocz=0.00
zksobrot=0.00
zksobc=0.00
zksrep=0.00
zksgot=0.00
zksnat=0.00
zkswyd=0.00
zkswypos=0.00
zkswydsum=0.00
zksnic=space(5)
zksuwag=space(17)
zkswukr=space(30)
zkskukr=0.00
zksprocp=0.00
zksprocu=0.00
zksdata=daf
zksmod=space(3)
zksnip=space(13)
zks22=0.00
zks07=0.00
zks03=0.00
zks00=0.00
zkszw=0.00
zksvat22=0.00
zksvat07=0.00
zksvat03=0.00
zkszak=.f.
zkssprzed=.f.
zkskontr=0
zksrubr=0
zksexport=.f.
***************************************
p:=0    && przesuniecie istotne przy nanoszeniu poprawek
rubr:=2
str:=1  && numer strony ksiegi
do ksdefault
select 2
do case
  case pksrej=1
    use ksiega index ksiega
  case pksrej=2
    use rejestr index rejestr
endcase	
if dtoc(ksdata)#"  .  .  "     &&wazne gdy baza pusta i zadamy numerowania
  if kspoz<=kpoz[month(ksdata)]
    do ksnum
  endif
endif  
*do while.not.eof()
*  if kspoz=0
*    do ksnum
*	exit
*  endif
*  skip
*enddo

go bottom
recno=recno()
do while .t.
  set color to
  do tlok
  do tyt1

  set color to n/w
  @ 0,56 say month(daf)
  set color to 
  do skom with "Dopisz   Popraw   dRukuj  kOrekta   Text  Filtr  Suma  ESC-rez.   <ды (*)(-)(F2)"
  go recno
  do okno
  do case
    case str=1
      do ram1
      @ 1,34 SAY "  STRONA 1  "
      dbedit(6,1,19,78,n,"U1","",t,"ъ")
    case str=2
      do ram2
      @ 1,34 SAY "  STRONA 2  "
      dbedit(6,1,19,78,n2,"U1","",t2,"ъ")
    case str=3
      do ram3
      @ 1,34 SAY "  STRONA 3  "
      dbedit(6,1,19,78,n3,"U1","",t3,"ъ")   
    case str=4
      do ram4
      do bok

	  @ 1,34 SAY "  STRONA 4  "
      dbedit(7,1,19,73,n4,"U1","",t4,"ъ")  
    case str=5
      do ram5
      @ 1,34 SAY "  STRONA 4A  "
      dbedit(7,1,19,78,n5,"U1","",t5,"ъ")    
  endcase
  do case
    case lastkey()=29
	  str=1
	  keyboard chr(205)	
    case lastkey()=23
	  str=4
	  keyboard chr(205)		
	case lastkey()=2
	  str=str+1
        if str>4
	      str=1
	    endif
	  keyboard chr(205)
	case lastkey()=26
	  keyboard chr(205)	
	  str=str-1
	    if str<1
	      str=4
	    endif
	case lastkey()=10
	  keyboard chr(205)		
	  str=5  
    case lastkey()=27
	  keyboard chr(205)			
	  exit
  endcase	
enddo
use
RETURN


FUNCTION U1(tryb,numer)
local pole,pol,recno,lpoz:=1
local ek:=savescreen(0,0,24,79)
local last:=lastkey()
local m:=0
local ilosc:=1
local drukuj:=.t.
public strona:=1
wek=""
save screen to ek
do zkslad
do case
  case last=-1
    do kosmetyka
	return 2
  case last=45.and..not.substr(ksnic,2,2)="-R"
    zz=.t.
    do gkom with "Wylaczyc pozycje z rejestru VAT ?  [T/N] ",zz
	if lastkey()#27.and.zz
	  replace ksnic with stuff(ksnic,2,2,"-R")
	endif
  case last=45.and.substr(ksnic,2,2)="-R"
    zz=.t.
    do gkom with "Wlaczyc ponownie pozycje do rejestru VAT ?  [T/N] ",zz
	if lastkey()#27.and.zz
	  replace ksnic with stuff(ksnic,2,2,"  ")
	endif	
  case last=42.and..not.substr(ksnic,4,1)="*"
    zz=.t.
    do gkom with "Wylaczyc pozycje z protokolu ?  [T/N] ",zz
	if lastkey()#27.and.zz
	  replace ksnic with stuff(ksnic,4,1,"*")
	endif
  case last=42.and.substr(ksnic,4,1)="*"
    zz=.t.
    do gkom with "Wlaczyc ponownie pozycje do protokolu ?  [T/N] ",zz
	if lastkey()#27.and.zz
	  replace ksnic with stuff(ksnic,4,1," ")
	endif		
  case last=83.or.last=115
    do kssum
  case last=79.or.last=111
    zz=.t.
	if substr(ksmod,2,1)="k"
	  do gkom with "Anulowac atrybur faktury korygujacej ? [T/F] ",zz
	  if zz .and. lastkey()#27
	    replace ksmod with stuff(ksmod,2,2,"  ")
	  endif
	else 
	  do gkom with "Nadac dokumentowi atrybur faktury korygujacej ? [T/F] ",zz
	  if zz .and. lastkey()#27
	    replace ksmod with stuff(ksmod,2,1,"k")
	  endif    
	endif

  case last=82.or.last=114         &&dRukuj        
    go top
	ms=month(ksdata)
    lpoz=druk_menu(lpoz)    
	do case
	  case lpoz=1 
	    do ksiegadr with 101
		select 2
		use ksiega index ksiega
	  case lpoz=2 
	    public wiktor_war:=dbfilter()
		do ksdruk1 with 3
		select 2
		use ksiega index ksiega
		set filter to &wiktor_war
		go top
	  case lpoz=3 
	    public wiktor_war:=dbfilter()
	    do ksdruk1 with 2
		select 2
		use ksiega index ksiega
		set filter to &wiktor_war
		go top		
	endcase
    keyboard chr(205)
	return 2
	
  case last=84.or.last=116         &&Tekst koryguj
      set cursor on
      do case
	    case numer=3.and.str=1
          @ row(),col() get ksdow
	    case numer=4.and.str=1
          @ row(),col() get ksnaz
	    case numer=5.and.str=1
          @ row(),col() get ksadr
	    case numer=6.and.str=1
          @ row(),col() get ksopis
	    case numer=6.and.str=4
          @ row(),col() get ksuwag
	    case numer=6.and.str=5
          @ row(),col() get kswukr
	    case numer=7.and.str=5
          @ row(),col() get kskukr		  		  		  		     		  
	  endcase
	  read
	  set cursor off

   case (last=70.or.last=102).and.in41    &&Filtr
     do kfiltr
	 keyboard chr(205)
     restore screen from ek
	 return 2

  case last=119.or.last=87       &&Wyposazenie
    do wyposaz with .f. 
  case last=106.or.last=74      &&Wyposazenie
    do jednoraz with .f. 	
  case last=13            &&Pokaz
	do kstlopoz
    if substr(zksnic,1,1)="b"	
	  do kssaypoz with .f.
    else
	  do kssaypoz with .t.
	endif	  
    do tkom with "Nacisnij dowolny klawisz."
	restore screen from ek  
    keyboard chr(205)
	return 2	  
  case last=68.or.last=100         &&Dopisz
    do ksdopisz
    if lastkey()#27
	  do ksnum
	endif  
	keyboard chr(205)
    return 2
  case last=80.or.last=112          &&Popraw
*    skip
*	recno=recno()
*	skip -1
	do kstlopoz
	if substr(zksnic,1,1)="b"
	  do kssaypoz with .f.
      do ksgetpoz with .f.
	else
	  do kssaypoz with .t.
      do ksgetpoz with .t.	
	endif
	do ksdefault
	select 2  
	if lastkey()#27
	  do ksreplac
	  if len(alltrim(dbfilter()))=0
	    do ksnum
	  endif
	endif
	restore screen from ek  
    keyboard chr(205)
	return 2
  case (last=75.or.last=107).and.MagPraw          &&Kasuj 
	do kstlopoz
	if substr(zksnic,1,1)="b"
	  do kssaypoz with .f.
	else
	  do kssaypoz with .t.
	endif    

    zz=.f.
	do gkom with "Kasowac pozycje ?  [T/F] ",zz
	if lastkey()#27.and.zz
      delete
	  pack
	  do ksnum
	endif
	restore screen from ek  
	keyboard chr(205)
	return 2	
  case last=85.or.last=117           &&sUma
    do suma 
    keyboard chr(205)
  case last=29.or.last=23.or.last=26.or.last=2.or.last=10.or.last=27
    np=kspoz
    recno=recno()
    return 0
  case last=5.or.last=24.or.last=18.or.last=3
    do okno
endcase  
@ 1,1 say replicate(chr(176),78)
if substr(ksmod,2,1)="k"
    @ 1,24 say " KOREKTA "
endif
if substr(ksmod,1,1)$"rfuURNFP"
    @ 1,1 say "Dokument importowany."
endif
if substr(ksnic,2,2)="-R"
    @ 1,35 say "Wylaczony z rejestru VAT "
endif
if substr(ksnic,4,1)="*"
  @ 1,61 say "Wyl.z protokolu"
endif

RETURN 1



PROCEDURE KSDOPISZ
local ek:=savescreen(0,0,24,79)
local popraw:=.f.
local koncz:=.f.
local nowa:=.f.
save screen to ek
kszapisz=.f.
zsum=0.00
do zkszer
do zkzer
do while.t.
  popraw=.f. 
  koncz:=.f.
  nowa:=.f.
	do kstlopoz
	if substr(zksnic,1,1)="b"
	  do kssaypoz with .f.
      do ksgetpoz with .f.
	else
	  do kssaypoz with .t.
      do ksgetpoz with .t.	
	endif
	do ksdefault
	select 2  	
    if lastkey()=27.or..not.zz
	  exit
	endif
    if kszapisz
      do skom with "dopisz_Wzor/Nowa    Popraw    Koncz "
      do while .t.
        inkey(0)
        k=lastkey()
		if k=87.or.k=119.or.k=78.or.k=110.or.k=80.or.k=112.or.k=75.or.k=107
		  exit
		endif
	  enddo	
      do case
	    *case lastkey()=87.or.lastkey()=119   &&Wzor
		case lastkey()=78.or.lastkey()=110  &&Nowa
		  nowa=.t.
		case lastkey()=80.or.lastkey()=112   &&Popraw
		  popraw=.t.
		case lastkey()=75.or.lastkey()=107   &&Koncz
		  koncz=.t.
	  endcase
	  if.not.popraw
	    select 2
	    append blank

	    do ksreplac	  
	  endif		
	  if nowa
	    do zkszer
	  endif
      if koncz
	    exit
	  endif
	endif	
enddo	
keyboard chr(205)
restore screen from ek	
RETURN


PROCEDURE OKNO
   @ 21,1 clear to 23,78
   A=.T.
   B=.T.
   C=.T.
   D=.T.
   E=.T.
   F=.T.
   G=.T.
   H=.T.
   I=.T.
   J=.T.
   wiersz=21
   do while .t.
     @ 21,50 say "NETTO ..."
	 @ 22,50 say "VAT ....."
	 @ 23,50 say "BRUTTO .."
     @ 21,60 say ks22+ks07+ks03+ks00+kszw picture "999 999 999.99"
     @ 22,60 say ksvat22+ksvat07+ksvat03 picture "999 999 999.99"
     @ 23,60 say ks22+ks07+ks03+ks00+kszw+ksvat22+ksvat07+ksvat03 picture "999 999 999.99"	 
     @ 22,2 say "NIP:"
	 @ 22,7 say ksnip
     koniec=.t.   
     do case
	   case kstow#0.and.A
	     @ wiersz,2 say "Wartosc sprzedanych tow.i uslug..."
*		 @ wiersz,50 say kstow
		 if zryczalt
		   @ 21,30 say "Ryczalt     %  ...."
		   @ wiersz,41 say zksprocp
		 endif  
         koniec=.f.
		 A=.f.
	   case ksusl#0.and.B
	     @ wiersz,2 say "Pozostale przychody..............."
		 if zryczalt
		   @ 23,30 say "Ryczlt  %  ...."
		   @ wiersz,41 say zksprocu		 
		 endif  
*	 @ wiersz,36 say ksusl
		 koniec=.f.
		 B=.f.
	   case kszakup#0.and.C
	     @ wiersz,2 say "Zakup towarow handlowych i mater. "
*	 @ wiersz,36 say kszakup		 		 
		 koniec=.f.
		 C=.f.
	   case ksubocz#0.and.D
	     @ wiersz,2 say "Koszty uboczne zakupu............."
 * @ wiersz,36 say ksubocz
		 koniec=.f.
		 D=.f.
	   case ksobc#0.and.E
	     @ wiersz,2 say "Koszty przerobu i obrobki obcej..."
*	 @ wiersz,36 say ksobc
		 koniec=.f.
		 E=.f.
	   case ksrep#0.and.F
	     @ wiersz,2 say "Koszty reprezentacji i reklamy...."
*	 @ wiersz,36 say ksrep
		 koniec=.f.
		 F=.f.
	   case ksgot#0.and.G
	     @ wiersz,2 say "Koszty wynagrodzenia w gotowce...."
*	 @ wiersz,36 say ksgot
		 koniec=.f.
		 G=.f.
	   case ksnat#0.and.H
	     @ wiersz,2 say "Koszty wynagrodzenia w naturze...."
*	 @ wiersz,36 say ksnat
		 koniec=.f.
		 H=.f.
	   case kswyd#0.and.I
	     @ wiersz,2 say "Pozostale wydatki................."
*	 @ wiersz,36 say kswyd
		 koniec=.f.
		 I=.f.
	   case kswypos#0.and.J
	     @ wiersz,2 say "Srodki trwale....................."
*	 @ wiersz,36 say kswypos		 		 		 		      	 
		 koniec=.f.
		 J=.f.
	 endcase  
	 if koniec
	   exit
	 else
	   wiersz=wiersz+1
	   if wiersz>23
	     exit
	   endif
	 endif
   enddo
  do case
    case pksrej=1
      @ 23,1 say " WPIS DO KSIEGI   "
    case pksrej=2
      @ 23,1 say " WPIS DO REJESTRU "	
  endcase     

RETURN





PROCEDURE SUMA
LOCAL t[5] &&sumuje zawartosc rubryk
local pozyc:=kspoz   
t[1]:=0.00
t[2]:=0.00
t[3]:=0.00
t[4]:=0.00
t[5]:=0.00
@ 21,1 clear to 23,78		
go top
do case
  case str=2
    do while eof()=.f.
          t[1]=t[1]+kstow
          t[2]=t[2]+ksusl
          t[3]=t[3]+kssum
          t[4]=t[4]+kszakup
          t[5]=t[5]+ksubocz
      skip
        enddo
@ 21,1 say space(78)
@ 21,2 say "RAZEM:"
@ 21,8 say t[1] picture "9 999 999.99"
@ 21,23 say t[2] picture "9 999 999.99"
@ 21,38 say t[3] picture "9 999 999.99"
@ 21,53 say t[4] picture "9 999 999.99"
@ 21,68 say t[5] picture "999 999.99"
  case str=3
    do while eof()=.f.
          t[1]=t[1]+ksobrot
          t[2]=t[2]+ksobc
          t[3]=t[3]+ksrep
          t[4]=t[4]+ksgot
          t[5]=t[5]+ksnat
      skip
        enddo
@ 21,1 say space(78)
@ 21,2 say "RAZEM:"
@ 21,9 say t[1] picture  "999 999.99"
@ 21,25 say t[2] picture "999 999.99"
@ 21,40 say t[3] picture "999 999.99"
@ 21,55 say t[4] picture "999 999.99"
@ 21,68 say t[5] picture "999 999.99"
  case str=4
    do while eof()=.f.
          t[1]=t[1]+kswyd
		  t[2]=t[2]+kswypos
          t[3]=t[3]+kswydsum
      skip
        enddo
@ 21,1 say space(78)
@ 21,2 say "RAZEM:"
@ 21,8 say t[1] picture "999 999.99"
@ 21,21 say t[2] picture "999 999.99"
@ 21,34 say t[3] picture "9 999 999.99"
  case str=5
    do while eof()=.f.
          t[1]=t[1]+kskukr
      skip
        enddo
@ 21,1 say space(78)
@ 21,2 say "RAZEM:"
@ 21,69 say t[1] picture "999 999.99"
endcase
seek pozyc
RETURN







PROCEDURE KSWYBOR
local ek:=savescreen(0,0,24,79)
local t[8]
local inw:=space(48)
local in:=replicate(chr(178),52)
local i:=0
t[1]:="A: Obrot ze sprzedazy towarow i uslug...  [ 7]"
t[2]:="B: Pozostale przychody..................  [ 8]"
t[3]:="C: Zakup towarow handlowych i materialow  [10]"
t[4]:="D: Koszty uboczne zakupu................  [11]"
t[5]:="E: Koszty reprezentacji i reklamy.......  [12]"
t[6]:="F: Wynagrodzenie w gotowce i naturze....  [13]"
t[7]:="G: Pozostale wydatki....................  [14]"
do case
  case pksrej=1
    t[8]:="H: Srodki trwale - amortyzacja jednorazowa[18]"
  case pksrej=2
    t[8]:="H: Srodki trwale........................  [18]"
endcase  
hel="wybor"
save screen to ek
set color to n/w
for i=11 to 23
  @ i,14 say in
next
set color to
@ 12,16 say "  :     NAZWA RUBRYKI W KSIEDZE       [NR.RUBR.]" 
@ 13,16 say "================================================" 
do skom with "Wybierz pozycje i zatwierdz klawiszem  [Enter]"
set color to (n/w,w/n)

for i=14 to 22
  @ i,16 say inw
next
  s=achoice(15,17,22,62,t)
  do case
    case s=1
      zksrubr=7
    case s=2
      zksrubr=8
    case s=3
      zksrubr=10
    case s=4
      zksrubr=11
    case s=5
      zksrubr=12          &&[14] - reprezentacja i reklama w ks_94
    case s=6
      zksrubr=13          &&[15] - wynagrodzenie w ks_94
    case s=7
      zksrubr=14          &&[17] - pozostale wydatki w ksiedze 94
    case s=8
      zksrubr=18
  endcase
set color to
restore screen from ek
return

PROCEDURE KSWYBORold
local t[10]
local inw:=space(48)
local in:=replicate(chr(178),52)
local i:=0
t[1]:="1. Obrot ze sprzedazy towarow i uslug...  [ 7]"
t[2]:="2. Pozostale przychody..................  [ 8]"
t[3]:="3. Zakup towarow handlowych i materialow  [10]"
t[4]:="4. Koszty uboczne zakupu................  [11]"
t[5]:="5. Koszty przerobu i obrobki obcej......  [13]"
t[6]:="6. Koszty reprezentacji i reklamy.......  [14]"
t[7]:="7. Wynagrodzenie w gotowce..............  [15]"
t[8]:="8. Wynagrodzenie w naturze..............  [16]"
t[9]:="9. Pozostale wydatki....................  [17]"
T[10]:="W. Wyposazenie..........................  [18]"
hel="wybor"
set color to n/w
for i=8 to 23
  @ i,14 say in
next
set color to 
@ 22,17 say "Wybierz pozycje i zatwierdz klawiszem  [Enter]"
set color to (n/w,w/n)
@ 21,16 say "*KOD  *   NAZWA RUBRYKI W KSIEDZE   *  NR.RUBR.*" 
for i=9 to 19
  @ i,16 say inw
next
s=achoice(9,17,19,62,t)
do case
  case s=1
    zksrubr=7
  case s=2
    zksrubr=8
  case s=3
    zksrubr=10
  case s=4
    zksrubr=11
  case s=5
    zksrubr=13
  case s=6
    zksrubr=14
  case s=7
    zksrubr=15
  case s=8
    zksrubr=16
  case s=9
   zksrubr=17
  case s=10
    zksrubr=18
endcase
set color to

return




PROCEDURE TLOK
local tl:=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
local h:=chr(176)
clear
*@ 0,0,24,79 box tl
set color to (coldef)
@ 1,0,2,79 box tl
@ 20,0,23,79 box tl
for i=1 to 20
@ i,0 say h
@ i,79 say h
next

RETURN

PROCEDURE RAM1
local inw:=space(78)
local i:=0
for i=3 to 6
@ i,1 say inw
next
for i=4 to 6
@ i,6 say chr(179)
@ i,12 say chr(179)
@ i,25 say chr(179)
@ i,61 say chr(179)
next
for i=5 to 6
@ i,43 say chr(179)
next
@ 3,1 say replicate(chr(205),78)
*@ 3,6 say chr(209)
*@ 3,12 say chr(209)
*@ 3,25 say chr(209)
*@ 3,61 say chr(209)

@ 4,33 say "K O N T R A H E N T"
@ 5,29 SAY "NAZW.,IMIE"
@ 6,31 SAY "(NAZWA)"
@ 5,50 SAY "ADRES"
@ 6,48 SAY "MIASTO,UL."
@ 4,16 say "NUMER"
@ 5,16 say "DOWODU"
@ 6,16 SAY "KSIEG."
@ 4,65 say "OPIS ZDA-"
@ 5,65 say "RZENIA GOS-"
@ 6,65 say "PODARCZEGO"
@ 4,8 say "DZ."
@ 5,8 say "M-"
@ 6,8 say "CA"
@ 5,2 say "LP."
RETURN


PROCEDURE TYT1
*local dat:=date()
if kolor=0
  set color to n/w
else
  set color to (coldef)
endif
@ 0,0 say "  K S I E G A   PRZYCHODOW I ROZCHODOW           MIESIAC            ROK         "  
@ 0,56 say month(daf)
@ 0,71 say year(daf)
set color to (colzer)
RETURN

PROCEDURE OK
@ 21,14 clear to 22,65
@ 21,15 say "RUBRYKA "+CHR(186)
@ 22,15 say "NR.     "+chr(186)
RETURN

PROCEDURE RAM111
@ 8,1 clear to 19,78 
for i=8 to 19
@ i,6 say chr(179)
@ i,12 say chr(179)
@ i,25 say chr(179)
@ i,43 say chr(179)
@ i,61 say chr(179)
next
RETURN


*********************************

PROCEDURE RAM2
local inw:=space(78)
local i:=0
for i=3 to 6
@ i,1 say inw
next
for i=4 to 6
@ i,6 say chr(179)
@ i,51 say chr(179)
@ i,66 say chr(179)
next
for i=5 to 6
@ i,21 say chr(179)
@ i,36 say chr(179)
next
@ 3,1 say replicate(chr(205),78)
*@ 3,6 say chr(209)
*@ 3,51 say chr(209)
*@ 3,66 say chr(209)
@ 4,12 say "----  P  R  Z  Y  C  H  O  D  ----"
@ 5,8 SAY "ZE SPRZEDAZY"
@ 5,23 SAY " POZOSTALE  "
@ 5,40 SAY "RAZEM"
@ 4,53 SAY "ZAKUP TOWA-"
@ 5,53 SAY "ROW HANDLO-"
@ 4,70 SAY "KOSZTY"
@ 5,70 SAY "UBOCZNE"
@ 5,2 say "LP."
RETURN


PROCEDURE RAM3
local inw:=space(78)
local i:=0
for i=3 to 6
@ i,1 say inw
next
for i=4 to 6
@ i,6 say chr(179)
@ i,21 say chr(179)
@ i,36 say chr(179)
@ i,51 say chr(179)
next
for i=5 to 6
@ i,66 say chr(179)
next
@ 3,1 say replicate(chr(205),78)
*@ 3,6 say chr(209)
*@ 3,51 say chr(209)
*@ 3,36 say chr(209)
*@ 3,21 say chr(209)
@ 4,10 say "PODATEK"
@ 5,10 say "OBROTOWY"
@ 4,25 SAY "KOSZTY"
@ 5,25 SAY "OBROBKI"
@ 4,39 SAY "  KOSZTY   " 
@ 5,39 SAY " REPREZENT."
@ 5,54 SAY "W  GOTOWCE"
@ 5,69 SAY "W NATURZE"
@ 4,54 SAY "    WYNAGRODZENIE    " 
@ 5,2 say "LP."
RETURN



PROCEDURE RAM4
local inw:=space(73)
local i:=0
for i=3 to 6
@ i,1 say inw
next
for i=4 to 6
@ i,6 say chr(179)
@ i,19 say chr(179)
@ i,32 say chr(179)
@ i,47 say chr(179)
@ i,55 say chr(179)
next
@ 3,1 say replicate(chr(205),73)
*@ 3,6 say chr(209)
*@ 3,19 say chr(209)
*@ 3,32 say chr(209)
*@ 3,47 say chr(209)
*@ 3,55 say chr(209)
@ 4,8 say "POZOSTALE"
@ 5,8 SAY " WYDATKI"
@ 4,21 SAY "  WYPOSA- "
@ 5,21 SAY "  ZENIE   "
@ 4,34 SAY "   RAZEM    "
@ 5,34 SAY "  WYDATKI   "
@ 5,49 SAY "[19]"
@ 5,60 SAY "U W A G I"
@ 5,2 say "LP."
RETURN





PROCEDURE RAM5
local inw:=space(78)
local i:=0
for i=3 to 6
@ i,1 say inw
next
for i=4 to 6
@ i,6 say chr(179)
@ i,19 say chr(179)
@ i,34 say chr(179)
@ i,42 say chr(179)
@ i,38 say chr(179)

next
for i=5 to 6 
@ i,67 say chr(179)
next
@ 3,1 say replicate(chr(205),78)
*@ 3,6 say chr(209)
*@ 3,19 say chr(209)
*@ 3,34 say chr(209)
*@ 3,42 say chr(209)
*@ 3,38 say chr(209)
@ 4,8 say " WYPOSA- "
@ 5,8 SAY " ZENIE "
@ 4,24 SAY "RAZEM"
@ 5,24 SAY "WYDATKI"
@ 5,36 SAY "["
@ 5,40 SAY "U"
@ 5,2 say "LP."
@ 4,59 say "D O D A T K O W E"
@ 5,52 SAY "UWAGI"
@ 5,71 SAY "KOSZTY"
RETURN


PROCEDURE BOK
local bk:=replicate(chr(176),5)
local i:=0
for i=1 to 23
@ i,74 say bk
next
RETURN


PROCEDURE ZKSZER
zkspoz=0
zksday=0
zksdow=space(15)
zksnaz=space(30)
zksadr=space(30)
zksopis=space(16)
zkstow=0.00
zksusl=0.00
zkssum=0.00
zkszakup=0.00
zksubocz=0.00
zksobrot=0.00
zksobc=0.00
zksrep=0.00
zksgot=0.00
zksnat=0.00
zkswyd=0.00
zkswypos=0.00
zkswydsum=0.00
zksnic=space(5)
zksuwag=space(17)
zkswukr=space(30)
zkskukr=0.00
zksprocp=0.0
zksprocu=0.0
zksdata=daf
zksmod=space(3)
zksnip=space(13)
zks22=0.00
zks07=0.00
zks03=0.00
zks00=0.00
zkszw=0.00
zksvat22=0.00
zksvat07=0.00
zksvat03=0.00
zkszak=.f.
zkssprzed=.f.
zkskontr=0
zksrubr=0
zksexport=.f.
odlicz=.t.
RETURN

PROCEDURE ZKSZER1
zkstow=0.00
zksusl=0.00
zkssum=0.00
zkszakup=0.00
zksubocz=0.00
zksobrot=0.00
zksobc=0.00
zksrep=0.00
zksgot=0.00
zksnat=0.00
zkswyd=0.00
zkswypos=0.00
zkswydsum=0.00
zkskukr=0.00
RETURN


PROCEDURE ZKSLAD
local lwyd:=zkszakup+zksubocz+zkswydsum
zkspoz=kspoz
zksday=ksday
zksdow=ksdow
zksnaz=ksnaz
zksadr=ksadr
zksopis=ksopis
zkstow=kstow
zksusl=ksusl
zkssum=kssum
zkszakup=kszakup
zksubocz=ksubocz
zksobrot=ksobrot
zksobc=ksobc
zksrep=ksrep
zksgot=ksgot
zksnat=ksnat
zkswyd=kswyd
zkswypos=kswypos
zkswydsum=kswydsum
zksnic=ksnic
zksuwag=ksuwag
zkswukr=kswukr
zkskukr=kskukr
zksprocp=ksprocp
zksprocu=ksprocu
zksdata=ksdata
zksmod=ksmod
zksnip=ksnip
zks22=ks22
zks07=ks07
zks03=ks03
zks00=ks00
zkszw=kszw
zksvat22=ksvat22
zksvat07=ksvat07
zksvat03=ksvat03
zkszak=kszak
zkssprzed=kssprzed
zkskontr=kskontr
zksrubr=0
zksexport=ksexport
do case
  case zkstow#0
    zksrubr=7
  case zksusl#0
    zksrubr=8
  case zkszakup#0
    zksrubr=10
  case zksubocz#0
    zksrubr=11
*  case zksobc#0
*    zksrubr=13
  case zksrep#0
    zksrubr=12
  case zksgot#0
    zksrubr=13
* case zksnat#0
*   zksrubr=16
  case zkswyd#0
    zksrubr=14
 case zkswypos#0
   zksrubr=18										

otherwise
  zksrubr=zkskukr
endcase
if substr(zksmod,1,1)$"ar"
  odlicz=.f.
else
  odlicz=.t.
endif
  zsum=lwyd
RETURN

PROCEDURE IMP_ZKSLAD
local lwyd:=zkszakup+zksubocz+zkswydsum
zkspoz=kspoz
zksday=ksday
zksdow=ksdow
zksnaz=ksnaz
zksadr=ksadr
zksopis=ksopis
zkstow=kstow
zksusl=ksusl
zkssum=kssum
zkszakup=kszakup
zksubocz=ksubocz
zksobrot=ksobrot
zksobc=ksobc
zksrep=ksrep
zksgot=ksgot
zksnat=ksnat
zkswyd=kswyd
zkswypos=kswypos
zkswydsum=kswydsum
zksnic=ksnic
zksuwag=ksuwag
zkswukr=kswukr
zkskukr=kskukr
zksprocp=ksprocp
zksprocu=ksprocu
zksdata=ksdata
zksmod=ksmod
zksnip=ksnip
zks22=ks22
zks07=ks07
*zks03=ks03
zks00=ks00
zkszw=kszw
zksvat22=ksvat22
zksvat07=ksvat07
*zksvat03=ksvat03
zkszak=kszak
zkssprzed=kssprzed
zkskontr=kskontr
zksexport=ksexport
RETURN




PROCEDURE KSTLOPOZ
       if kolor=0
	     set color to n/w
	   else
	     set color to (coldef)
	   endif	 
       for i=6 to 23
         @ i,24 say replicate(chr(178),55)
       next
       set color to (coldef)
       @ 7,26 say "      *  P O Z Y C J A   W   K S I E D Z E  *      "

       @ 8,26 say " ------------------------------------------------- "
       set color to n/w
       @ 24,0 say space(80)
       @ 9,26 say  " DATA........         .......| KWOTY NETTO  [T/N]  "
       @ 10,26 say " DOKUMENT....               .| 22%                 "
       @ 11,26 say "                             |  7%                 "
       @ 12,26 say " _________KONTRAHENT_________|  3%                 "
       @ 13,26 say "  NAZWA......               .|  0%                 "
       @ 14,26 say "  CD NAZWY...               .| zw.                 "	   
       @ 15,26 say "  ADRES......               .| Razem               "
       @ 16,26 say "  CD ADRESU..               .|                     "      
       @ 17,26 say "  NIP________            ____| PODATEK VAT         "
       @ 18,26 say "                             | 22%                 "
       @ 19,26 say " OPIS........                |  7%                 "
       @ 20,26 say " RUBRYKA.....                |  3%                 "
       @ 21,26 say "                             | Razem               "
	   set color to
       *@ 22,26 say " PgUp-kartoteka  PgDn-koniec  ENTER-zatw.  ESC-rez."
       @ 22,26 say "                                                   "
RETURN	   

PROCEDURE NIETLO
       set color to n/w
       @ 9,55 say  "|Kwota nie podlegajaca"
       @ 10,55 say "|     odliczeniu      "
       @ 11,55 say "|                     "
       @ 12,55 say "|                     "
       @ 13,55 say "|                     "	
       @ 14,55 say "|                     "	   
       @ 15,55 say "|                     "
       @ 16,55 say "|                     "      
       @ 17,55 say "|                     "
       @ 18,55 say "|                     "
       @ 19,55 say "|                     "
       @ 20,55 say "|                     "
       @ 21,55 say "|                     "
	   set color to 
RETURN

PROCEDURE TAKTLO
       set color to n/w
       @ 9,55 say  "| WARTOSC NETTO       "
       @ 10,55 say "| 22%                 "
       @ 11,55 say "|  7%                 "
       @ 12,55 say "|  3%                 "
       @ 13,55 say "|  0%                 "
       @ 14,55 say "| zw.                 "	   
       @ 15,55 say "| Razem               "
       @ 16,55 say "|                     "      
       @ 17,55 say "| PODATEK VAT         "
       @ 18,55 say "| 22%                 "
       @ 19,55 say "|  7%                 "
       @ 20,55 say "|  3%                 "
       @ 21,55 say "| Razem               "
       set color to
RETURN	   


PROCEDURE KSGETPOZ
parameters pnetto
local qq:=savescreen(0,0,24,79)
local lnaz1:=substr(zksnaz,1,15)
local lnaz2:=substr(zksnaz,16,15)
local ladr1:=substr(zksadr,1,15)
local ladr2:=substr(zksadr,16,15)
local lpoz:=1
local lnetto:=pnetto
local lnetsay:=pnetto
set confirm off
@ 22,28 say space(46)
kont=.f.
do while .t.
  do skom with "Enter - zatwierdzenie     PgDn - koniec wypelniania    Esc - rezygnacja"
  do kastlo
  set color to n/w
  set cursor on
  do case
    case lpoz=1.and.MagPraw
	  @ 9,25 say chr(176)
      do skom with "ENTER - zatwierdzenie     ESC - rezygnacja"
	  set color to n/w
	  do while.t.	
        @ 9,39 get zksdata
		read
		if month(zksdata)=month(daf)        
		  exit
		endif 
      enddo
    case lpoz=1.and..not.MagPraw
	  zksdata=daf
	  @ 9,39 say zksdata
    case lpoz=2
      do skom with "ENTER-zatwierdzenie    ESC-rezygnacja/mozliwosc poprawienia poz.poprzedniej"
	  set color to n/w	
	  @ 10,25 say chr(176)	
	  @ 10,39 get zksdow
	  read
	  tone(500,1)
	case lpoz=3
      do skom with "ENTER-zatw.    ESC-rezygnacja/poprawianie     PgUp-wybor kontrahenta"
	  set color to n/w
      for i=13 to 17
	    @ i,25 say chr(176)
	  next	  
	  lnaz1pom=lnaz1
      lnaz1=substr(zksnaz,1,15)
      lnaz2=substr(zksnaz,16,15)
      ladr1=substr(zksadr,1,15)
      ladr2=substr(zksadr,16,15)
      @ 13,39 get lnaz1 picture "@!"
      @ 14,39 get lnaz2 picture "@!"
      @ 15,39 get ladr1 picture "@!"
      @ 16,39 get ladr2 picture "@!"
      @ 17,39 get zksnip picture "@!"	  
	  read
	  if lastkey()#18
        tone(500,1)
	  endif	
        zksnaz=stuff(space(30),1,15,lnaz1)
        zksnaz=stuff(zksnaz,16,15,lnaz2)
        zksadr=stuff(space(30),1,15,ladr1)   
        zksadr=stuff(zksadr,16,15,ladr2)     
        do zkzer
		znaz1=zksnaz
		zmiasto=zksadr
		znip=zksnip
	case lpoz=4
      do skom with "ENTER-zatw.    ESC-rezygnacja/poprawianie      PgUp-wybor opisu "
	  set color to n/w
	  @ 19,25 say chr(176)		
	  @ 19,39 get zksopis
	  read	
      if lastkey()#18
	    tone(500,1)
	  endif
	case lpoz=5
      do skom with "ENTER-zatw.    ESC-rezygnacja/poprawianie      PgUp-wybor rubryki"
	  set color to n/w
	  @ 20,25 say chr(176)		
*!      zksuwag=space(17)
	  do while.t.
	    @ 20,39 get zksrubr picture "99" range 6,18
		read
		if zksrubr#9.and.zksrubr#15.and.zksrubr#16.and.zksrubr#17.and.zksrubr#0
*	  if zksrubr=18
*	    if pksrej=2
			  exit
*		endif
*	  else
*	    exit
*	  endif	
        else
		  if zksrubr=0.and.(lastkey()=27.or.lastkey()=18)
		    exit
		  endif
		endif
	  enddo
      do rubrsay            &&Wydruk nazwy wybranej rubryki
      if zksrubr=18
	    zksuwag="AMORTJEDNO"
	  endif
      set color to n/w
	  
	case lpoz=6
	  warunek="export_dok.and.(zksrubr=7.or.zksrubr=8)"
	  if &warunek
        if kj_gkom(4," Wybor dokumentu ","Czy jest to faktura eksportowa ?","",.t.,5)
		  exportdok_get()
          kszapisz=.t.
		  do kssaypoz with .t.
		  keyboard chr(205)
		  exit
	    endif	
	  endif
      do skom with "T lub Y - podlega odliczeniu    N lub F - nie podlega   ENTER- zatw.  ESC- rez."
	  set color to n/w
	  @ 21,25 say chr(176)			  
	  if vvt
        do case
		  case zksrubr>9.and.zksrubr#13
            @ 21,26 say " PODLEGA ODLICZENIU [Y/F]    |"
	        @ 21,53 get odlicz
			read
			if odlicz
			  zksmod=stuff(zksmod,1,1," ")
			else
			  zksmod=stuff(zksmod,1,1,"a")
			endif
		  case zksrubr=13
		    odlicz=.f.
		  case zksrubr<9
		    odlicz=.t.		
		endcase
      else
        odlicz=.f.	  
	  endif
    case lpoz=7.and.(zksrubr=7.or.zksrubr=8).and.zryczalt
      do skom with "ENTER - zatwierdzenie stawki    ESC-rezygnacja/poprawianie"
	  set color to n/w	
	  @ 21,25 say chr(176)			  	
      @ 21,26 say " Ryczalt                     "
	  @ 21,39 get zksprocp picture "99.9" valid zksprocp=rycz_h.or.zksprocp=rycz_p.or.zksprocp=rycz_u
	  read
	case lpoz=8.and.odlicz
      do skom with "T lub Y - kwoty NETTO      N lub F - KWOTY  BRUTTO     ENTER- zatw.  ESC- rez."
	  set color to n/w
	  @ 9,77 say chr(176)			  	    
      @ 9,56 say  " KWOTY NETTO  [T/N]  "
	  @ 9,76 get lnetto
	  read
	  lnetsay=lnetto
	  if lnetto
	    @ 9,56 say  " KWOTY NETTO :       "
	  else
	    @ 9,56 say  " KWOTY BRUTTO :      "
	  endif
    case lpoz=9
      set confirm on
      do skom with "ENTER-zatwierdzenie   ESC-rezygnacja/mozliwosc poprawienia poz. poprzedniej"
	  set color to n/w	
	  for i=10 to 13
   	    @ i,77 say chr(176)			  	    
	  next
      if.not.lnetto
	    zks22=zks22+zksvat22
		zks07=zks07+zksvat07
		zks03=zks03+zksvat03
	  endif
      do case
	    case odlicz.or.(.not.odlicz.and.zksrubr=10)
		  do taktlo
	      if lnetto
	        @ 9,56 say  " KWOTY NETTO :       "
	      else
	        @ 9,56 say  " KWOTY BRUTTO :      "
	      endif		  
          @ 10,61 get zks22 picture "999999999.99"
          @ 11,61 get zks07 picture "999999999.99"
          @ 12,61 get zks03 picture "999999999.99"
          @ 13,61 get zks00 picture "999999999.99"
          @ 14,61 get zkszw picture "999999999.99"      
		case .not.odlicz
          do nietlo
		  zks22=0
		  zks07=0
		  zks03=0
		  zks00=0
		  zkszw=0
		  @ 13,61 get zkszw picture "999999999.99"      
       endcase
       read
       if odlicz
	     if.not.lnetto
	       zksvat22=round(zks22*22/122,2)
		   zksvat07=round(zks07*7/107,2)
		   zksvat03=round(zks03*3/103,2)
		   zks22=zks22-zksvat22
		   zks07=zks07-zksvat07
		   zks03=zks03-zksvat03
         else
	       zksvat22=round(zks22*0.22,2)
		   zksvat07=round(zks07*0.07,2)
		   zksvat03=round(zks03*0.03,2)
	     endif	   
       else
	     zksvat22=0
		 zksvat07=0
		 zksvat03=0
	   endif		 
	   do kssaypoz with lnetto
    case lpoz=10.and.zks00#0.and.(zksrubr=7.or.zksrubr=8)
	  do skom with "ENTER-zatwierdzenie   ESC-rezygnacja/mozliwosc poprawienia poz. poprzedniej"
	  set color to n/w	
	  @ 16,77 say chr(176)			  	    
      @ 16,56 say " Export  [T/F]       "        
	  @ 16,73 get zksexport
      read
    case lpoz=11.and.odlicz
      do skom with "ENTER-zatwierdzenie   ESC-rezygnacja/mozliwosc poprawienia poz. poprzedniej"
	  set color to n/w		  
	  @ 18,77 say chr(176)			  	    
	  @ 19,77 say chr(176)			  	    	  	
	  @ 20,77 say chr(176)			  	    	  	
      do tlovat 
      @ 18,61 get zksvat22 picture " 999 999 999.99"
      @ 19,61 get zksvat07 picture " 999 999 999.99"
	  @ 20,61 get zksvat03 picture " 999 999 999.99"
	  read
      do kssaypoz with lnetto	  	
    case lpoz=12
      zz=.t.
      do gkom with "PgUp-podglad_NETTO/BRUTTO   ENTER-zatw. ESC-rez.   Czy dane poprawne? [Y/F]",zz
      if lastkey()#18
	    if zz.and.lastkey()#27
          set cursor off
          if.not.lnetto
		    zksnic=stuff(zksnic,1,1,"b")  
		  endif
		  kszapisz=.t.
		  if zksrubr=14.and.(zks22+zks07+zks03+zks00+zkszw)>1000
		    zz=.f.
			do gkom with "Ewidencja wyposazenia ?  [T/N] ",zz
			if lastkey()#27
			  if zz
			    keyboard chr(68)
			    do wyposaz with .t.
			  else
			    zz=.t.
			  endif  
            else
				zz=.f.
				lpoz=1
			endif  
		  endif
		  if zksrubr=18.and.pksrej=1
		    keyboard chr(68)
		    do jednoraz with .t.
		  endif
		  if zz
	        exit
		  endif	
	    else
	      lpoz=1	
        endif	
	  endif	 
	
  endcase
  if lastkey()=27
    kont=.f.
    do skom with "ESC - rezygnacja     Strzalka do gory - popraw poprzednia pozycje    "      
    inkey(0)
  endif
  do case
    case lastkey()=5.and.lpoz#1  
	  lpoz=lpoz-1
	case lastkey()=13.or.lastkey()=3.or.(lpoz=1.and..not.MagPraw).or.(lpoz=3.and.lastkey()#18)
	  lpoz=lpoz+1
    case lastkey()=18
      do case
	    case lpoz=3
	      save screen to qq
	      do kontrah with lnaz1
	      restore screen from qq
	      if lastkey()=13
            do kontsay
		*	do firdefault
		    do ksdefault
		    lpoz=lpoz+1
			kont=.t.
            tone(500,1)
	      else
	        lnaz1=lnaz1pom
			kont=.f.
	      endif	 
		case lpoz=4
		  do zdarzenie
		  select 2
		  if lastkey()=13
		    set color to n/w
            @ 19,39 say zksopis
		    lpoz=lpoz+1
			tone(500,1)
		  endif
        case lpoz=5
          save screen to qq
          do kswybor
          restore screen from qq		
		  do rubrsay
      if zksrubr=18
	    zksuwag="AMORTJEDNO"
	  endif
		  if lastkey()=13
		    lpoz=lpoz+1
		  endif
        case lpoz=12
          lnetsay=.not.lnetsay
	      if lnetsay
	        @ 9,56 say  " KWOTY NETTO :       "
	      else
	        @ 9,56 say  " KWOTY BRUTTO :      "
	      endif		  
		  do kssaypoz with lnetsay
          lpoz=12
	  endcase         		    	

	case lastkey()=27
      set cursor off
	  return  
  endcase	
enddo  


  *****************************
set cursor off
select 2
set confirm on
RETURN





PROCEDURE KSSAYPOZ
parameters pnetto
  set color to n/w
  @ 9,39 say zksdata
  @ 10,39 say zksdow
  @ 13,39 say substr(zksnaz,1,15)
  @ 14,39 say substr(zksnaz,16,15)
  @ 15,39 say substr(zksadr,1,15)
  @ 16,39 say substr(zksadr,16,15)
  @ 17,39 say zksnip 
  @ 19,39 say zksopis
  @ 20,39 say zksrubr picture "99"
  if (zksrubr=7.or.zksrubr=8).and.zryczalt
     @ 21,26 say " Ryczlt % "
	 @ 21,39 say zksprocp picture "99.9"
  endif
  if.not.odlicz.and.zksrubr>9
    @ 21,26 say " Brak odliczenia VAT !"
  else
    @ 21,26 say "                             " 	
  endif
  if odlicz.or.(.not.odlicz.and.zksrubr=10)
    if pnetto
      @ 9,56 say  " KWOTY NETTO :       "
      @ 10,61 say zks22 picture " 999 999 999.99"
      @ 11,61 say zks07 picture " 999 999 999.99"
	  @ 12,61 say zks03 picture " 999 999 999.99"
      @ 13,61 say zks00 picture " 999 999 999.99"
      @ 14,61 say zkszw picture " 999 999 999.99"
      @ 15,62 say ROUND(zks22,2)+ROUND(zks07,2)+ROUND(zks03,2)+zks00+zkszw picture "999 999 999.99"
    else
	  @ 9,56 say  " KWOTY BRUTTO:       "
      @ 10,61 say zks22+zksvat22 picture " 999 999 999.99"
      @ 11,61 say zks07+zksvat07 picture " 999 999 999.99"
	  @ 12,61 say zks03+zksvat03 picture " 999 999 999.99"
      @ 13,61 say zks00 picture " 999 999 999.99"
      @ 14,61 say zkszw picture " 999 999 999.99"
      @ 15,62 say ROUND(zks22+zksvat22,2)+ROUND(zks07+zksvat07,2)+ROUND(zks03+zksvat03,2)+zks00+zkszw picture "999 999 999.99"  
    endif
    @ 18,61 say zksvat22 picture " 999 999 999.99"
    @ 19,61 say zksvat07 picture " 999 999 999.99"
    @ 20,61 say zksvat03 picture " 999 999 999.99"	
    @ 21,62 say ROUND(zksvat22,2)+ROUND(zksvat07,2)+ROUND(zksvat03,2) picture "999 999 999.99"
  else
    do nietlo
    @ 15,61 say zkszw picture " 999 999 999.99"
  endif
  if (zksrubr=7.or.zksrubr=8)
    do case
      case zks00#0.and.zksexport
	    @ 16,56 say "      Export         "        
      case zks00#0.and..not.zksexport
	    @ 16,56 say "    Sp. krajowa      "        	  
    endcase
  endif
  set color to
  do rubrsay
RETURN


PROCEDURE KSREPLAC
do ksrub             &&aktualizacja zmiennych
if zks22=0.and.zks07=0.and.zks03=0.and.zks00=0.and.zkszw=0
  zkskukr=zksrubr
endif
replace kspoz with zkspoz,ksday with day(zksdata),ksdow with zksdow,ksnaz with zksnaz
replace ksadr with zksadr,ksopis with zksopis,kstow with zkstow,ksusl with zksusl
replace kssum with zkssum,kszakup with zkszakup,ksubocz with zksubocz
replace ksobrot with zksobrot,ksobc with zksobc,ksrep with zksrep,ksgot with zksgot
replace ksnat with zksnat,kswyd with zkswyd,kswypos with zkswypos,kswydsum with zkswydsum
replace ksnic with zksnic,ksuwag with zksuwag,kswukr with zkswukr,kskukr with zkskukr
replace ksprocp with zksprocp,ksprocu with zksprocu,ksdata with zksdata,ksmod with zksmod
replace ksnip with zksnip,ks22 with zks22,ks07 with zks07,ks03 with zks03,ks00 with zks00 
replace kszw with zkszw,kszak with zkszak,kssprzed with zkssprzed
replace ksvat22 with zksvat22,ksvat07 with zksvat07,ksvat03 with zksvat03,ksexport with zksexport
replace kskontr with zkskontr
if.not.odlicz
  replace ksmod with stuff(zksmod,1,1,"a")
endif
commit
if.not.kont
  trah=.f.
  do zaptrah
  do ksdefault
endif
RETURN

PROCEDURE IMP_KSREPLAC
replace kspoz with zkspoz,ksday with day(zksdata),ksdow with zksdow,ksnaz with zksnaz
replace ksadr with zksadr,ksopis with zksopis,kstow with zkstow,ksusl with zksusl
replace kssum with zkssum,kszakup with zkszakup,ksubocz with zksubocz
replace ksobrot with zksobrot,ksobc with zksobc,ksrep with zksrep,ksgot with zksgot
replace ksnat with zksnat,kswyd with zkswyd,kswypos with zkswypos,kswydsum with zkswydsum
replace ksnic with zksnic,ksuwag with zksuwag,kswukr with zkswukr,kskukr with zkskukr
replace ksprocp with zksprocp,ksprocu with zksprocu,ksdata with zksdata,ksmod with zksmod
replace ksnip with zksnip,ks22 with zks22,ks07 with zks07,ks00 with zks00 
replace kszw with zkszw,kszak with zkszak,kssprzed with zkssprzed
replace ksvat22 with zksvat22,ksvat07 with zksvat07,ksexport with zksexport
replace kskontr with zkskontr
RETURN



PROCEDURE TLOPROC
  set color to n/w
  for i=10 to 13
    @ i,61 say space(16)
  next	
  set color to
RETURN

PROCEDURE TLOVAT
  set color to n/w
  for i=18 to 19
    @ i,61 say space(16)
  next	
  set color to
RETURN

PROCEDURE KSNUMOLD
local num:=0
local recno:=recno()
use
for i=1 to 12
  do pksdefault with i
  use ksiega index ksiega
  do while.not.eof()
    num=num+1
    replace kspoz with num
    skip
  enddo
  use
next
do ksdefault
use ksiega index ksiega
go recno
RETURN

PROCEDURE KSNUM
local num:=0
local recno:=recno()
if dtoc(ksdata)#"  .  .  "     &&wazne gdy baza pusta i zadamy numerowania
  if pksrej=2
    num=rpoz[month(ksdata)]
  else
    num=kpoz[month(ksdata)]
  endif  
  go top
  do while.not.eof()
    num=num+1
    replace kspoz with num
    skip
  enddo
  go recno
endif  
RETURN


PROCEDURE KSRUB
local sum:=0
do zkszer1
sum=zks22+zks07+zks03+zks00+zkszw
zkssprzed=.f.
do case
  case zksrubr=7
    zkstow=sum
    zksobrot=(zksprocp*sum)/100
	odlicz=.t.
	zkssprzed=.t.
  case zksrubr=8
    zksusl=sum
	zksobrot=(zksprocp*sum)/100
	odlicz=.t.
	zkssprzed=.t.
  case zksrubr=10
    zkszakup=sum
	zkssprzed=.f.
	zkszak=.t.	
  case zksrubr=11
    zksubocz=sum
* case zksrubr=13
*   zksobc=sum
  case zksrubr=12
    zksrep=sum
  case zksrubr=13
    zksgot=sum
* case zksrubr=16
*   zksnat=sum							
  case zksrubr=14
    zkswyd=sum
 case zksrubr=18
   zkswypos=sum	
endcase
zkszak=.not.zkssprzed
zkssum=zkstow+zksusl
zkswydsum=zksobc+zksrep+zksgot+zksnat+zkswyd+zkswypos
RETURN

PROCEDURE NOTZZ
  if zz=.t.
    zz=.f.
  else
    zz=.t.
  endif		
RETURN


PROCEDURE KONTSAY
		   * zksnip=substr(zuwagi,1,13)
			zksnip=znip
			zksnaz=znaz1
			zksadr=stuff(zksadr,1,len(alltrim(zmiasto)),zmiasto)
			zksadr=stuff(zksadr,len(alltrim(zmiasto))+2,30,alltrim(zulica))
			set color to n/w
       @ 13,26 say "  NAZWA......               ."
       @ 14,26 say "  CD NAZWY...               ."
       @ 15,26 say "  ADRES......               ."
       @ 16,26 say "  CD ADRESU..               ."
       @ 17,26 say "  NIP________            ____"
			@ 13,39 say substr(zksnaz,1,15) 
			@ 14,39 say substr(zksnaz,16,15)
			@ 15,39 say substr(zksadr,1,15) 
			@ 16,39 say substr(zksadr,16,15)
			@ 17,39 say zksnip
			set color to 
        *    kont=.t.
RETURN			


PROCEDURE RUBRSAY
local t[8]
local k:=1
zkazak=.f.
zkssprzed=.f.
t[1]:="A: Obrot ze sprzedazy towarow i uslug...  [ 7]"
t[2]:="B: Pozostale przychody..................  [ 8]"
t[3]:="C: Zakup towarow handlowych i materialow  [10]"
t[4]:="D: Koszty uboczne zakupu................  [11]"
t[5]:="E: Koszty reprezentacji i reklamy.......  [12]"
t[6]:="F: Wynagrodzenie w gotowce i naturze....  [13]"
t[7]:="G: Pozostale wydatki....................  [14]"
do case
  case pksrej=1
    t[8]:="H: Srodki trwale - amortyzacja jednorazowa[18]"
  case pksrej=2
    t[8]:="H: Srodki trwale........................  [18]"
endcase  
set color to n/w
  @ 20,39 say zksrubr picture "99"
set color to 
do case
  case zksrubr=7
    k=1
	zkssprzed=.t.
  case zksrubr=8
    k=2
	zkssprzed=.t.
  case zksrubr=10
    k=3
	zkszak=.t.
  case zksrubr=11
    k=4
	zkszak=.t.
  case zksrubr=12
    k=5
	zkszak=.t.
  case zksrubr=13
    k=6
	zkszak=.t.
  case zksrubr=14
    k=7
	zkszak=.t.	
  case zksrubr=18
    k=8
	zkszak=.t.		
endcase
@ 22,28 say t[k]
RETURN


PROCEDURE ZDARZENIE
local ek:=savescreen(0,0,24,79)
hel="slow3"
save screen to ek
set color to (n/w,w/n)
for i=9 to 23
  @ i,3 say replicate(chr(178),20)
next
set color to
@ 10,5 say " *  SLOWNIK  *  "
@ 22,5 say space(16)
do firdefault
if file("zdarzeni.dbf")
  select 11
  use zdarzeni
  do skom with "Dopisz       Popraw       Kasuj      ENTER - zatwierdz     ESC - rezygnuj"
  set color to (n/w,w/n)
  dbedit(11,5,20,20,"ZD_GOSP","us4","","ZDARZENIE  GOSP.","ъ")
  use
else
  do tkom with "Brak mozliwosci zdefiniowania zdarzen !  Nacisnij dowolny klawisz."  
endif    
do ksdefault
restore screen from ek
set color to
RETURN


FUNCTION US4(tr,nur)
local pole,pol
local last:=lastkey()
local zzd_gosp:=space(16)
pole:=field(nur)
pol:=&pole

  do case
	case last=68.or.last=100           &&Dopisz
        set cursor on
		@ 22,5 get zzd_gosp
		read
		set cursor off
        if lastkey()#27
		  append blank
		  replace zd_gosp with zzd_gosp
          keyboard chr(205)
		endif
	
	case last=75.or.last=107            &&Kasuj
	  delete
	  pack

    case last=80.or.last=112            &&Popraw
      set cursor on
      @ row(),col() get pol
      read
      set cursor off
      if lastkey()#27
        replace &pole with pol	
	  endif	
    case last=13
	  zksopis=zd_gosp
      return 0
	case last=27  
	  return 0
   endcase
RETURN 1

PROCEDURE KASTLO
set color to
for i=9 to 22
  @ i,25 say chr(176)
  @ i,77 say chr(176)  
next
RETURN

PROCEDURE KSSUM
local lile07:=0,lile08:=0,lile10:=0,lile11:=0,lile12:=0,lile13:=0,lile14:=0,lile18:=0
local lsum07:=0,lsum08:=0,lsum10:=0,lsum11:=0,lsum12:=0,lsum13:=0,lsum14:=0,lsum18:=0
local ek
local recno:=recno()
save screen to ek
clear
@ 0,0,24,79 box chr(176)
set color to n/w
@ 0,0 say "                  P O D S U M O W A N I E         R U B R Y K                   "
set color to (coldef)
@ 2,6 say  "--------------------------------------------------------------------" 
@ 3,6 say  "|  NUMER  | NAZWA RUBRYKI                | ILOSC | LACZNA WARTOSC  |"
@ 4,6 say  "| RUBRYKI |                              | DOKUM.|    N E T T O    |" 
@ 5,6 say  "|---------|------------------------------|-------|-----------------|" 
@ 6,6 say  "| [ 7 ]   | SPRZEDAZ TOWAROW I USLUG     |       |                 |" 
@ 7,6 say  "|---------|------------------------------|-------|-----------------|" 
@ 8,6 say  "| [ 8 ]   | POZOSTALE PRZYCHODY          |       |                 |" 
@ 9,6 say  "|---------|------------------------------|-------|-----------------|" 
@ 10,6 say "| [ 10]   | ZAKUP MATERIALOW I TOW.HANDL.|       |                 |" 
@ 11,6 say "|---------|------------------------------|-------|-----------------|" 
@ 12,6 say "| [ 11]   | KOSZTY ZAKUPU TOWAROW        |       |                 |" 
@ 13,6 say "|---------|------------------------------|-------|-----------------|" 
@ 14,6 say "| [ 12]   | KOSZTY REPREZENTACJI I REKL. |       |                 |" 
@ 15,6 say "|---------|------------------------------|-------|-----------------|" 
@ 16,6 say "| [ 13]   | WYNAGRODZENIE W GOTOWCE      |       |                 |" 
@ 17,6 say "|---------|------------------------------|-------|-----------------|" 
@ 18,6 say "| [ 14]   | POZOSTALE WYDATKI            |       |                 |" 
@ 19,6 say "|---------|------------------------------|-------|-----------------|" 
@ 20,6 say "| [ 18]   | AMORTYZACJA JEDNORAZOWA      |       |                 |" 
@ 21,6 say "--------------------------------------------------------------------" 
@ 22,6 say "                               | RAZEM   |       |                  " 
@ 23,6 say "                               -------------------                  " 
go top
do while.not.eof()
  do case 
    case kstow#0
      lile07=lile07+1
	  lsum07=lsum07+kstow
    case ksusl#0
      lile08=lile08+1
	  lsum08=lsum08+ksusl
    case kszakup#0
      lile10=lile10+1
	  lsum10=lsum10+kszakup
    case ksubocz#0
      lile11=lile11+1
	  lsum11=lsum11+ksubocz
    case ksrep#0
      lile12=lile12+1
      lsum12=lsum12+ksrep
    case ksgot#0
      lile13=lile13+1
	  lsum13=lsum13+ksgot
    case kswyd#0
      lile14=lile14+1
	  lsum14=lsum14+kswyd
    case kswypos#0
      lile18=lile18+1
  	  lsum18=lsum18+kswypos							
  endcase
  skip
enddo
@ 6,49 say lile07 picture "99999"
@ 8,49 say lile08 picture "99999"
@ 10,49 say lile10 picture "99999"
@ 12,49 say lile11 picture "99999"
@ 14,49 say lile12 picture "99999"
@ 16,49 say lile13 picture "99999"
@ 18,49 say lile14 picture "99999"
@ 20,49 say lile18 picture "99999"
@ 22,49 say lile07+lile08+lile10+lile11+lile12+lile13+lile14+lile18 picture "99999"

@ 6,59 say lsum07 picture "9 999 999.99"
@ 8,59 say lsum08 picture "9 999 999.99"
@ 10,59 say lsum10 picture "9 999 999.99"
@ 12,59 say lsum11 picture "9 999 999.99"
@ 14,59 say lsum12 picture "9 999 999.99"
@ 16,59 say lsum13 picture "9 999 999.99"
@ 18,59 say lsum14 picture "9 999 999.99"
@ 20,59 say lsum18 picture "9 999 999.99"
do tkom with "OK!"
go recno
restore screen from ek
RETURN

PROCEDURE KOSMETYKA
local t[3],ek,s,lksopis,lksopis1
save screen to ek
t[1]:="    N A Z W Y    "
t[2]:="   A D R E S Y   "
t[3]:="     O P I S     "
@ 5,23 clear to 18,57
@ 6,25 to 17,55 double
set color to n/w
@ 7,26 say "     K O S M E T Y K A       "
@ 8,26 say "============================="
@ 14,26 say "-----------------------------"
@ 15,26 say " Korekty zwiazane z importem "
@ 16,26 say "         dokumentow          "
set color to (coldef)
@ 9,31 to 13,49
s=achoice(10,32,12,48,t)
do case
  case s=1
    set filter to substr(ksnaz,30,1)="-"
	go top
  case s=2
    set filter to substr(ksadr,30,1)="-"
	go top	
  case s=3
    @ 10,32 clear to 12,48
    @ 15,26 say "  Podaj  zwyczajowy   opis   "
    @ 16,26 say "  dokumentow importowanych   "	
	lksopis="Sprzed.tow.handl"
	lksopis1="Zakup.tow.handl."	
	set cursor on
	set color to
	@ 10,33 get lksopis
	@ 12,33 get lksopis1
	read
	set color to (coldef)
	set cursor off
	go top
	do while.not.eof()
	  if.not.substr(ksmod,1,1)=" "
	    if kssprzed
          replace ksopis with lksopis
		else
		  replace ksopis with lksopis1
		endif    
	  endif
	  skip
	enddo
endcase
restore screen from ek
keyboard chr(205)
RETURN	

PROCEDURE KFILTR
local q1[9],t[5]
public f_ksnaz,f_ksdow,f_ksdata,f_ksrubr,f_ksopis,f_ksnip,f_ksvv
q1[1]:="NUMER DOKUM"
q1[2]:="DATA DOKUM."
q1[3]:="KONTRAHENT "
q1[4]:="RUBRYKA    "
q1[5]:="KOREKTY    "
q1[6]:="DOK.IMPORT."
q1[7]:="OPIS ZDARZ."
q1[8]:="NIP        "
q1[9]:="STAWKA VAT "
t[1]:=" 22 % "
t[2]:="  7 % "
t[3]:="  3 % "
t[4]:="  0 % "
t[5]:="  zw. "

         if kolor=0
		   set color to n/w
		 else
		   set color to (coldef)
		 endif  
         for i=11 to 23
           @ i,0 say replicate(chr(178),15)
         next
         @ 13,2 say "-----------"
         set color to (coldef)
         @ 12,2 say "*F I L T R*"
         set color to (n/w,w/n)
         z=1
		 z=achoice(14,2,22,12,q1,,,z)
         set color to
         do case
		   case z=1
           @ 21,15 clear to 23,78
           @ 22,16 say "  NUMER DOKUMENTU                                "
           set cursor on
           f_ksdow=ksdow 
             @ 22,40 get f_ksdow picture "@!"
           read
           set cursor off
           if lastkey()#27
             if.not.f_ksdow=space(15)
			   f_ksdow=alltrim(f_ksdow)
             endif
			 set filter to substr(ksdow,1,len(f_ksdow))=f_ksdow
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top
           endif
           set color to 
		   
		   case z=2
             @ 21,15 clear to 23,78
             @ 22,16 say "  D A T A :                                      "
             set cursor on
			 f_ksdata=ksdata
             @ 22,31 get f_ksdata
             read
             set cursor off
             if lastkey()#27
               set filter to ksdata=f_ksdata
               go top
               fwar=fwar+""+".and."+dbfilter()
               set filter to &fwar
               go top
             endif	  
			 
		   case z=3
           @ 21,15 clear to 23,78
           @ 22,16 say "  KONTRAHENT :                                   "
           set cursor on
           f_ksnaz=ksnaz 
             @ 22,40 get f_ksnaz picture "@!"
           read
           set cursor off
           if lastkey()#27
             if.not.f_ksnaz=space(30)
			   f_ksnaz=alltrim(f_ksnaz)
             endif
			 set filter to substr(ksnaz,1,len(f_ksnaz))=f_ksnaz
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top
           endif
           set color to 
		   
		   case z=4
           @ 21,15 clear to 23,78
           @ 22,16 say "  NUMER RUBRYKI                                  "
           set cursor on
           do zkslad
           @ 22,40 get zksrubr picture "99"
           read
		   if lastkey()=18
		     do kswybor
		   endif
           set cursor off
           if lastkey()#27
             do case
			   case zksrubr=7
			     set filter to kstow#0
			   case zksrubr=8
			     set filter to ksusl#0				 
			   case zksrubr=9
			     set filter to kssum#0				 
			   case zksrubr=10
			     set filter to kszakup#0				 
			   case zksrubr=11
			     set filter to ksubocz#0				 
			   case zksrubr=12
			     set filter to ksrep#0				 
			   case zksrubr=13
			     set filter to ksgot#0				 
			   case zksrubr=14
			     set filter to kswyd#0				 
			   case zksrubr=18
			     set filter to kswypos#0				 
			 endcase
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top
           endif
           set color to 		   

		   case z=5
             @ 21,15 clear to 23,78
             set cursor off
             set filter to substr(ksmod,2,1)="k"
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top

		   case z=6
             @ 21,15 clear to 23,78
             set cursor off
             set filter to substr(ksmod,1,1)$"rfuURNFP"
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top
		   
		   case z=7
           @ 21,15 clear to 23,78
           @ 22,16 say "  OPIS ZDARZENIA                                 "
           set cursor on
           f_ksopis=ksopis 
             @ 22,40 get f_ksopis
           read
           set cursor off
           if lastkey()#27
             if.not.f_ksopis=space(15)
			   f_ksopis=alltrim(f_ksopis)
             endif
			 set filter to substr(ksopis,1,len(f_ksopis))=f_ksopis
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top
           endif
           set color to 
		   
		   case z=8
           @ 21,15 clear to 23,78
           @ 22,16 say " NIP KONTRAHENTA                                 "
           set cursor on
           f_ksnip=ksnip 
             @ 22,40 get f_ksnip
           read
           set cursor off
           if lastkey()#27
             if.not.empty(f_ksnip)
			   f_ksnip=alltrim(f_ksnip)
             endif
			 set filter to substr(ksnip,1,len(f_ksnip))=f_ksnip
             go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top
           endif
           set color to 		   

         case z=9
		   s=1
		   @ 17,12 to 23,21
		   s=achoice(18,13,22,20,t,,,s)
             do case
			   case s=1
			     set filter to ks22#0
			   case s=2
			     set filter to ks07#0				 
			   case s=3
			     set filter to ks03#0				 				 
			   case s=4
			     set filter to ks00#0				 
			   case s=5
			     set filter to kszw#0				 
			 endcase
			 go top
             fwar=fwar+""+".and."+dbfilter()
             set filter to &fwar
             go top			 
		 case z=0 
             set filter to		 
		   fwar=".t."
		   go top		 
		 endcase
RETURN

FUNCTION EX_PUBLIC()
  public zsad_numer:=space(20)
  public zsad_dat:=space(10)
  public zwaluta:=space(6)
  public zwal_skrot:=space(3) 
  public zkurs:=space(8)
  public zile_jednostek:=0
  public zdewiz_kwot:=0 
RETURN

FUNCTION EX_LAD()
  zsad_numer=substr(zkswukr,1,20)
  zsad_dat=substr(zkswukr,21)
  zwaluta=substr(zksuwag,1,6)
  zwal_skrot=substr(zksuwag,7,3)
  zkurs=substr(zksuwag,10)
  zile_jednostek=zkskontr
  zdewiz_kwot=zks00*zile_jednostek/val(zkurs)
RETURN

FUNCTION EX_ZAP()
  zkswukr=stuff(space(30),1,20,zsad_numer)
  zkswukr=stuff(zkswukr,21,10,zsad_dat)
  zksuwag=stuff(space(17),1,6,zwaluta)
  zksuwag=stuff(zksuwag,7,3,zwal_skrot)
  zksuwag=stuff(zksuwag,10,8,zkurs)  
  zkskontr=zile_jednostek
  zkskukr=zdewiz_kwot
  zks00=round(zdewiz_kwot*val(zkurs)/zile_jednostek,2)
  zksexport=.t.  
  zksnic=stuff(zksnic,2,2,"-R")
RETURN

FUNCTION EXPORTDOK_GET()
local lsad_numer,lsad_dat
local lwaluta,lwal_skrot,lkurs
local lile_jednostek,ldewiz_kwot
ex_lad()
lsad_numer=zsad_numer
lsad_dat=ctod(zsad_dat)
lwaluta=zwaluta
lwal_skrot=zwal_skrot
lkurs=val(zkurs)
lile_jednostek=zile_jednostek
ldewiz_kwot=zdewiz_kwot
if lile_jednostek=0
  lile_jednostek=1
endif
kj_okno(0,0,8, "  ROZLICZENIE  FAKTURY  EKSPORTOWEJ                                             ",2)	  
if pksrej=1
  @ 2,2 say "Tabela kursow srednich NBP NR: ......"
  @ 3,2 say "Data przekroczenia granicy .........."
else
  @ 2,2 say "SAD  NR ............................."
  @ 3,2 say "Data rozliczenia SAD ................"
endif  

@ 4,2 say "Waluta / skrot ......................"
@ 5,2 say "Ilosc jednostek = kurs sredni  ......          ="
@ 6,2 say "Wartosc faktury w podanej walucie ..."
set cursor on
@ 2,40 get lsad_numer when s_kom("Podaj numer SAD-u.")
@ 3,40 get lsad_dat when s_kom("Podaj date SAD-u  <dzien.miesiac.rok>")
@ 4,40 get lwaluta when s_kom("Podaj nazwe waluty rozliczeniowej")
@ 4,50 get lwal_skrot when s_kom("Podaj skrot waluty rozliczeniowej")
@ 5,40 get lile_jednostek picture "999" when s_kom("Podaj ilosc jednostek okreslanych kursem srednim")
@ 5,52 get lkurs picture "999.9999" when s_kom("Podaj kurs sredni wynikajacy z podanej wyzej tabeli")
@ 6,40 get ldewiz_kwot picture "9999999.99" when s_kom("Podaj wartosc faktury w okreslonej wyzej walucie")
read
set cursor off
if lastkey()#27
  zsad_numer=lsad_numer
  zsad_dat=dtoc(lsad_dat)
  zwaluta=lwaluta
  zwal_skrot=lwal_skrot
  zile_jednostek=lile_jednostek
  zkurs=str(lkurs,8,4)
  zdewiz_kwot=ldewiz_kwot
  ex_zap()
endif
if kj_gkom(12," Rozliczenie faktury eksportowej "," Drukowac ? ","",.t.,5)
  if pksrej=1
    do ksiegadr with 102
  else
	do ksiegadr with 103
  endif	
endif
RETURN

FUNCTION DRUK_MENU(ppoz)
local ltnaz[3],ltlit[3],ltopis[3],lbelka:="",lpoz:=ppoz
ltnaz[1]:=" Tabulogram        "
ltnaz[2]:=" Rejestr Zakupu    "
ltnaz[3]:=" Rejestr Sprzedazy "
ltlit[1]:=" T                 "
ltlit[2]:="         Z         "
ltlit[3]:="         S         "
ltopis[1]:="Prezentacja w formie tabulogramu"
ltopis[2]:="Prezentacja w formie rejestru zakupu"
ltopis[3]:="Prezentacja w formie rejestru sprzedazy"
  lpoz=men_pion(10,30,3,lbelka,ltnaz,ltlit,ltopis,lpoz)
RETURN lpoz
