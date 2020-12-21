* OBLICZANIE ZALICZKI NA PODATEK DOCHODOWY PIT5
local t[13],tz[6],ts[6],tz10[4],t1[2],n[2],tyt[2]
local lsiac:=month(daf)
local ek
p78a=0.00
t1[1]:=" WYPELNIANIE "
t1[2]:=" DEFINIOWANIE"
n[1]:="substr(p7,1,20)"
n[2]:="p106"
tyt[1]:="Podatnik: nazwisko/" 
tyt[2]:="udzial  % "
save screen to ek
for i=1 to 13
  t[i]:=0.00
next
zp107=0.00
zp108=0.00
zp109=0.00
zp110:=0.00
  for i=1 to 13
    t[i]:=0.00
  next

  set color to
      do skom with "Zatwierdz miesac do rozliczenia."	  
	  @ 8,40 say " Za miesiac :    "
	  set cursor on
	  @ 8,54 get lsiac picture "99" range 1,12
	  read 
	  set cursor off	  
      do skom with "ENTER - zatwierdz podatnika   Dopisz    Popraw    Kasuj    ESC - rezygnuj"
      if lastkey()=27
	    return
	  endif 
	  set default to
	  select 7
	  use ram
	  do zramlad
      use
	  for k=1 to lsiac
	    do pksdefault with k
        select 2
        use ksiega index ksiega
        do while.not.eof()
          for i=1 to 13            && sumuje wartosci numeryczne rubryk ksiegi
            t[i]=t[i]+fieldget(i+6)
	      next	  
		  skip
	    enddo	
	  next	
      use
	  zp107=t[3]
	  zp108=t[4]+t[5]+t[13]+zremzer-zremakt	  
*	  zp108=t[4]+t[5]+t[9]+zremzer-zremakt	  
	  licz=zp107-zp108
      do case
	    case licz=0
		  zp109=0
		  zp110=0
		case licz>0
		  zp109=licz
		  zp110=0
		case licz<0
		  zp109=0
		  zp110=-1*licz    
	  endcase
do firdefault
select 1
use pit5

@ 10,31 to 16,67 double
keyboard chr(205)
dbedit(11,32,15,66,n,"UP","",tyt)	  
restore screen from ek
RETURN

FUNCTION UP(tryb,numer)
local last:=lastkey()
local lblok:=0.00
local licz:=0
do case
  case lastkey()=13
    
      replace p107 with zp107*p106/100
      replace p108 with zp108*p106/100
      replace p109 with zp109*p106/100
	  replace p110 with zp110*p106/100    
      do dzialzal
*      do pitlicz 
      do daneget
  case last=68.or.last=100    &&Dopisz
    append blank
	do pitget
  case last=80.or.last=112      &&Popraw
    do pitget
  case last=75.or.last=107      &&Kasuj
    zz=.t.
	do gkom with "Usunac podatnika z bazy ? [Y/F]  ",zz
	if zz.and.lastkey()#27
	  delete
	  pack
	endif
  
  case last=27
    keyboard chr(205)
    return 0
endcase
RETURN 1

PROCEDURE PITGET
set cursor on
@ row(),32 get p7 picture "@S20"
@ row(),56 get p106
read
set cursor off
RETURN


PROCEDURE PITGETold
local t[5]
local ek:=savescreen(0,0,24,79)
t[1]:=" URZAD SKARBOWY - w ktorym skladana jest deklaracja  "
t[2]:=" PLATNIK - dane platnika skladajacego deklatacje     "
t[3]:=" POZAROLNICZA DZIALALNOSC GOSPODARCZA. I WOLNE ZAWODY"
t[4]:=" SAMODZIELNIE WYKONYWANA DZIALALNOSC  (ART.13 PKT 2) "
t[5]:=" NAJEM, PODNAJEM, DZIERZAWA (ART.10.UST. 1PKT 6 UST) "

sp=1
for i=20 to 23
  @ i,1 say replicate(chr(176),78)
next
save screen to ek
@ 17,12 to 23,66 double
set cursor on
do while.t.
  do skom with "wybierz :  ENTER - zatwierdzenie    ESC - rezygnacja"
  sp=achoice(18,13,22,65,t,,,sp)   
  do case
    case sp=1
      do mig with row(),13,"*"  
	  do rubtlo
      @ 2,1 say " [05]  Urzad Skarbowy : ..............." get p05
	  @ 4,1 say " [06]  Ulica : ........................" get p06 
	  @ 6,1 say " [07]  Numer domu : ..................." get p07
	  @ 8,1 say " [08]  MIejscowosc : .................." get p08
	  @ 10,1 say" [09]  Kod pocztowy : ................." get p09
      read
    case sp=2
      do mig with row(),13,"*"  	
	  do rubtlo
	  @ 1,1 say " P O D A T N I K  -  udzial w firmie : " get p106
      @ 2,1 say " [10]  Numer identyf.podatkowej NIP : ." get p10
	  @ 3,1 say " [11]  Numer REGON lub PESEL : ........" get p11 
	  @ 4,1 say " [12]  Nazwisko : ....................." get p12
	  @ 5,1 say " [13]  Pierwsze imie : ................" get p13
	  @ 6,1 say " [14]  Drugie imie : .................." get p14
      @ 7,1 say " [15]  Imie ojca : ...................." get p15
	  @ 8,1 say " [16]  Imie matki : ..................." get p16 
	  @ 9,1 say " [17]  Data urodzenia : ..............." get p17
	  @ 10,1 say" [18]  Miejsce urodzenia : ............" get p18
	  @ 11,1 say " A D R E S    P O D A T N I K A"
	  @ 12,1 say" Wojewodztwo: " get p19
	  @ 13,1 say" Ulica : ....." get p21
	  @ 14,1 say" Miejscowosc: " get p24
  	  @ 15,1 say " Poczta : ...." get p26
	  @ 12,50 say "Nr.domu: ........." get p22 
	  @ 13,50 say "Nr.lokalu: ......." get p23
	  @ 14,50 say "Kod pocztowy: ... " get p25
	  @ 15,50 say "Telefon: ........." get p27
      read
    case sp=3
      do mig with row(),13,"*"  	
	  do rubtlo
      @ 1,1 say " C.1"
	  @ 2,1 say " [28]  Numer  NIP : ..................." get p28
	  @ 3,1 say " [29]  Numer REGON : .................." get p29 
	  @ 4,1 say " [30]  Rodzaj dzialalnosci : .........." get p30
	  @ 5,1 say " [31]  MIejsce prowadzenia : .........." get p31
      @ 6,1 say " C.2"
	  @ 7,1 say " [35]  Numer  NIP : ..................." get p35
	  @ 8,1 say " [36]  Numer REGON : .................." get p36 
	  @ 9,1 say " [37]  Rodzaj dzialalnosci : .........." get p37
	  @ 10,1 say " [38]  MIejsce prowadzenia : .........." get p38
      @ 11,1 say " C.3"
	  @ 12,1 say " [42]  Numer  NIP : ..................." get p42
	  @ 13,1 say " [43]  Numer REGON : .................." get p43 
	  @ 14,1 say " [44]  Rodzaj dzialalnosci : .........." get p44
	  @ 15,1 say " [45]  MIejsce prowadzenia : .........." get p45	  	  
      read
    case sp=4
      do mig with row(),13,"*"  
	  do rubtlo
      @ 2,1 say " [49]  Rodzaj dzialalnosci : .........." get p49
      read
    case sp=5
      do mig with row(),13,"*"  	
	  do rubtlo
      @ 2,1 say " [53]  Przedmiot najmu : .............." get p53
      @ 4,1 say " [54]  Miejsce polozenia : ............" get p54
      read	  
    case sp=0
	  restore screen from ek
	    set cursor off
	  return
  endcase
enddo
set cursor off
restore screen from ek
keyboard chr(205)
RETURN


PROCEDURE RUBTLO
@ 0,0 clear to 17,79 
@ 0,0 to 17,79 double
set color to (coldef)
@ 0,26 say " DEKLARACJA PODATKOWA PIT5 "
do skom with "ENTER - zatwierdzenie    ESC - rezygnacja"
RETURN

PROCEDURE MIG
parameters pw,pc,ptxt
set color to w/n+*
@ pw,pc say ptxt
set color to
return
RETURN

PROCEDURE DANEGET
local ek:=savescreen(0,0,24,79)
local t[41],q[41]
local licz:=0
for i=1 to 41
  t[i]:="                            |            |            |            |            "
  q[i]=space(28)
next
q[1]="27/28/29/30  Pozarol.dz.gosp"
q[2]="31/32/33/34  Najem,dzierzawa"
q[3]="35/36/37/38  Dz.wykon.osob. "
q[4]="39/40/41/42  Wynagr.z zagran"
q[5]="43/44  Emerytury,renty zagr."
q[6]="49  Dochod zwolniony od pod."
q[7]="52  Straty z lat ubieglych  "
q[8]="54  Straty z lat ubieglych  "
q[9]="55  Darowizny               "
q[10]="Skladki ubezp. spolecznego  "
q[11]="57  Doksztalcanie podatnika "
q[12]="59  Ksztalcenie dzieci      "
q[13]="60  Cele rehabilitacyjne    "
q[14]="61  Akcje Skarbu Panstwa    "
q[15]="62  Ulgi mieszkaniowe       "
q[16]="63  Zakup gruntu            "
q[17]="64  Budowa budynku mieszkal."
q[18]="65  Remont i modernizacja   "
q[19]="66  Budowa wlasnego budynku "
q[20]="68  Ulgi inwestycyjne       "
q[21]="70  Ulgi inwestycyjne       "
q[22]="72  Inne odliczenia         "
q[23]="74  Inne odliczenia         "
q[24]="76  Inne odliczenia         "
q[25]="80  Podatek podl. odroczeniu"
q[26]="81  Ulgi inwestycyjne przyzn"
q[27]="82  Ulgi za wyszkol. ucznia "
q[28]="Ubezpieczenie zdrowotne     "
q[29]="87  Remanent wg cen zakupu  "
q[30]="88  Wskaznik procentowy     "
q[31]="89  Dochod z remanentu likw."

q[32]="92  Pod. za poprzednie mies."
q[33]="95  Kwota podatku zaplacon. "
q[34]="106  Udzial w %             "
q[35]="107/108/109/110 Dzialal.gosp"
q[36]="115  Udzial w %             "
q[37]="116/117/118/119 Dzialal.gosp"
q[38]="122  Udzial w %             "
q[39]="123/124/125/126 Najem,dzierz"
q[40]="129  Udzial w %             "
q[41]="130/131/132/133 Najem,dzierz"
for i=1 to 41
  t[i]=stuff(t[i],1,28,q[i])
next
t[1]=nt(t[1],p27,p28,p29,p30)
t[2]=nt(t[2],p31,p32,p33,p34)
t[3]=nt(t[3],p35,p36,p37,p38)
t[4]=nt(t[4],p39,p40,p41,p42)
t[5]=nt(t[5],p43,0,p44,0)
t[6]=nt(t[6],p49,0,0,0)
t[7]=nt(t[7],p52,0,0,0)
t[8]=nt(t[8],p54,0,0,0)
t[9]=nt(t[9],p55,0,0,0)
t[10]=nt(t[10],p56,0,0,0)
t[11]=nt(t[11],p57,0,0,0)
t[12]=nt(t[12],p59,0,0,0)
t[13]=nt(t[13],p60,0,0,0)
t[14]=nt(t[14],p61,0,0,0)
t[15]=nt(t[15],p62,0,0,0)
t[16]=nt(t[16],p63,0,0,0)
t[17]=nt(t[17],p64,0,0,0)
t[18]=nt(t[18],p65,0,0,0)
t[19]=nt(t[19],p66,0,0,0)
t[20]=nt(t[20],p68,0,0,0)
t[21]=nt(t[21],p70,0,0,0)
t[22]=nt(t[22],p72,0,0,0)
t[23]=nt(t[23],p74,0,0,0)
t[24]=nt(t[24],p76,0,0,0)
t[25]=nt(t[25],p80,0,0,0)
t[26]=nt(t[26],p81,0,0,0)
t[27]=nt(t[27],p82,0,0,0)
t[28]=nt(t[28],p84,0,0,0)
t[29]=nt(t[29],p87,0,0,0)
t[30]=nt(t[30],p88,0,0,0)
t[31]=nt(t[31],p89,0,0,0)
t[32]=nt(t[32],p92,0,0,0)

t[33]=nt(t[33],p95,0,0,0)
t[34]=nt(t[34],p106,0,0,0)
t[35]=nt(t[35],p107,p108,p109,p110)
t[36]=nt(t[36],p115,0,0,0)
t[37]=nt(t[37],p116,p117,p118,p119)
t[38]=nt(t[38],p122,0,0,0)
t[39]=nt(t[39],p123,p124,p125,p126)
t[40]=nt(t[40],p129,0,0,0)
t[41]=nt(t[41],p130,p131,p132,p133)

save screen to ek
do dantlo
do pitlicz
do sumsay
x=1
do while.t.
  x=achoice(3,1,13,78,t,,,x)   
  set cursor on
  do case
     case x=1
	  @ row(),30 get p27
	  @ row(),43 get p28
      read
	  licz=p27-p28
	  do case
	    case licz=0
		  replace p29 with 0
		  replace p30 with 0
	    case licz>0
		  replace p29 with licz
		  replace p30 with 0
	    case licz<0
		  replace p29 with 0
		  replace p30 with -1*licz  
	  endcase
      t[x]=nt(t[x],p27,p28,p29,p30)
     case x=2
	  @ row(),30 get p31
	  @ row(),43 get p32
      read
	  licz=p31-p32
	  do case
	    case licz=0
		  replace p33 with 0
		  replace p34 with 0
	    case licz>0
		  replace p33 with licz
		  replace p34 with 0
	    case licz<0
		  replace p33 with 0
		  replace p34 with -1*licz  
	  endcase	  
	  t[x]=nt(t[x],p31,p32,p33,p34)
     case x=3
	  @ row(),30 get p35
	  @ row(),43 get p36
      read
	  licz=p35-p36
	  do case
	    case licz=0
		  replace p37 with 0
		  replace p38 with 0
	    case licz>0
		  replace p37 with licz
		  replace p38 with 0
	    case licz<0
		  replace p37 with 0
		  replace p38 with -1*licz  
	  endcase	  
  	  t[x]=nt(t[x],p35,p36,p37,p38)
     case x=4
	  @ row(),30 get p39
	  @ row(),43 get p40
      read
	  licz=p39-p40
	  do case
	    case licz=0
		  replace p41 with 0
		  replace p42 with 0
	    case licz>0
		  replace p41 with licz
		  replace p42 with 0
	    case licz<0
		  replace p41 with 0
		  replace p42 with -1*licz  
	  endcase	  
	  t[x]=nt(t[x],p39,p40,p41,p42)      

     case x=5
	  @ row(),30 get p43
      read
      replace p44 with p43
      t[x]=nt(t[x],p43,0,p44,0)
     case x=6
	  @ row(),30 get p49
      read
      t[x]=nt(t[x],p49,0,0,0)	  
     case x=7
	  @ row(),30 get p52
      read
      t[x]=nt(t[x],p52,0,0,0)	  
     case x=8
	  @ row(),30 get p54
      read
      t[x]=nt(t[x],p54,0,0,0)	  
     case x=9
	  @ row(),30 get p55
      read
      t[x]=nt(t[x],p55,0,0,0)	  	  	  	  
     case x=10
	  @ row(),30 get p56
      read
      t[x]=nt(t[x],p56,0,0,0)	  
     case x=11
	  @ row(),30 get p57
      read
      t[x]=nt(t[x],p57,0,0,0)	  
     case x=12
	  @ row(),30 get p59
      read
      t[x]=nt(t[x],p59,0,0,0)	  
     case x=13
	  @ row(),30 get p60
      read
      t[x]=nt(t[x],p60,0,0,0)	  	  	  	  	  
     case x=14
	  @ row(),30 get p61
      read
      t[x]=nt(t[x],p61,0,0,0)	  
     case x=15
	  @ row(),30 get p62
      read
      t[x]=nt(t[x],p62,0,0,0)	  
     case x=16
	  @ row(),30 get p63
      read
      t[x]=nt(t[x],p63,0,0,0)	  
     case x=17
	  @ row(),30 get p64
      read
      t[x]=nt(t[x],p64,0,0,0)	  	  	  	  	  
     case x=18
	  @ row(),30 get p65
      read
      t[x]=nt(t[x],p65,0,0,0)	  
     case x=19
	  @ row(),30 get p66
      read
      t[x]=nt(t[x],p66,0,0,0)	  
     case x=20
	  @ row(),30 get p68
      read
      t[x]=nt(t[x],p68,0,0,0)	  
     case x=21
	  @ row(),30 get p70
      read
      t[x]=nt(t[x],p70,0,0,0)	  	  	  	  	  
     case x=22
	  @ row(),30 get p72
      read
      t[x]=nt(t[x],p72,0,0,0)	  
     case x=23
	  @ row(),30 get p74
      read
      t[x]=nt(t[x],p74,0,0,0)	  
     case x=24
	  @ row(),30 get p76
      read
      t[x]=nt(t[x],p76,0,0,0)	  
     case x=25
	  @ row(),30 get p80
      read
      t[x]=nt(t[x],p80,0,0,0)	  	  	  	  	  
     case x=26
	  @ row(),30 get p81
      read
      t[x]=nt(t[x],p81,0,0,0)	  
     case x=27
	  @ row(),30 get p82
      read
      t[x]=nt(t[x],p82,0,0,0)	  
     case x=28
	  @ row(),30 get p84
      read
      t[x]=nt(t[x],p84,0,0,0)	  
     case x=29
	  @ row(),30 get p87
      read
      t[x]=nt(t[x],p87,0,0,0)	  	  	  	  	  
     case x=30
	  @ row(),30 get p88
      read
      t[x]=nt(t[x],p88,0,0,0)	  
     case x=31
	  @ row(),30 get p89
      read
      t[x]=nt(t[x],p89,0,0,0)	  
     case x=32
	  @ row(),30 get p92
      read
      t[x]=nt(t[x],p92,0,0,0)	  

     case x=33
	  @ row(),30 get p95
      read
      t[x]=nt(t[x],p95,0,0,0)	  
     case x=34
	  @ row(),30 get p106
      read
      t[x]=nt(t[x],p106,0,0,0)	  	  	  	  	  
     case x=35
	  @ row(),30 get p107
	  @ row(),43 get p108
      read
	  licz=p107-p108
	  do case
	    case licz=0
		  replace p109 with 0
		  replace p110 with 0
	    case licz>0
		  replace p109 with licz
		  replace p110 with 0
	    case licz<0
		  replace p109 with 0
		  replace p110 with -1*licz  
	  endcase
      t[x]=nt(t[x],p107,p108,p109,p110)	  
      do dzialzal
	  t[1]=nt(t[1],p27,p28,p29,p30)
     case x=36
	  @ row(),30 get p115
      read
      t[x]=nt(t[x],p115,0,0,0)	  	  	  	  	  
     case x=37
	  @ row(),30 get p116
	  @ row(),43 get p117
      read
	  licz=p116-p117
	  do case
	    case licz=0
		  replace p118 with 0
		  replace p119 with 0
	    case licz>0
		  replace p118 with licz
		  replace p119 with 0
	    case licz<0
		  replace p118 with 0
		  replace p119 with -1*licz  
	  endcase
      t[x]=nt(t[x],p116,p117,p118,p119)	  	  
      do dzialzal
	  t[1]=nt(t[1],p27,p28,p29,p30)	  
     case x=38
	  @ row(),30 get p122
      read
      t[x]=nt(t[x],p122,0,0,0)	  	  	  	  	  
     case x=39
	  @ row(),30 get p123
	  @ row(),43 get p124
      read
	  licz=p123-p124
	  do case
	    case licz=0
		  replace p125 with 0
		  replace p126 with 0
	    case licz>0
		  replace p125 with licz
		  replace p126 with 0
	    case licz<0
		  replace p125 with 0
		  replace p126 with -1*licz  
	  endcase
      t[x]=nt(t[x],p123,p124,p125,p126)	  	  
      do najzal
	  t[2]=nt(t[2],p31,p32,p33,p34)	  
     case x=40
	  @ row(),30 get p129
      read
      t[x]=nt(t[x],p129,0,0,0)	  	  	  	  	  	  	  	  
     case x=41
	  @ row(),30 get p130
	  @ row(),43 get p131
      read
	  licz=p130-p131
	  do case
	    case licz=0
		  replace p132 with 0
		  replace p133 with 0
	    case licz>0
		  replace p132 with licz
		  replace p133 with 0
	    case licz<0
		  replace p132 with 0
		  replace p133 with -1*licz  
	  endcase
      t[x]=nt(t[x],p130,p131,p132,p133)	  	  
      do najzal
	  t[2]=nt(t[2],p31,p32,p33,p34)	  
	case x=0
	    set cursor off
		exit
  endcase
  commit
  set color to
  set cursor off 
  do pitlicz
  do sumsay  
enddo  
restore screen from ek

RETURN

PROCEDUR DANTLO
local ltx1:=" Numer/nazwa rubryki        |                                               "
clear
if kolor=0
  set color to n/w
else
  set color to (coldef)
endif  
@ 0,0 say space (80)
@ 0,23 say "WYPELNIANIE RUBRYK DEKLARACJI PIT5"
if kolor=0
  set color to
endif  
for i=1 to 24 
  @ i,0 say chr(176)
  @ i,79 say chr(176)  
next 
@ 1,1 say ltx1
if zremzer-zremakt#0
  @ 1,31 say"UWAGA! Remanent_Akt-Remanent_Pocz=            "
  set color to w/n+*
  @ 1,65 say zremakt-zremzer picture "999999999.99"
  set color to (coldef)
endif
@ 2,1 say replicate(chr(205),78)
@ 14,0 say replicate(chr(176),80)
@ 15,1 say replicate(chr(205),78)
@ 15,26 say "  P O D S U M O W A N I E  "
@ 16,1 say " Razem przychod    | Razem koszty      | Razem dochody     | Razem strata     "  
@ 17,1 say " 45.               | 46.               | 47.               | 48               "  
@ 18,1 say " Podst.pod.(do 1gr)| Odliczenia od doch| Podstawa podatku  | Podatek w/g skali" 
@ 19,1 say " 50.               | 77.               | 78.               | 79               "  
@ 20,1 say " Odliczenia od pod.| Pod. po odliczen. | Zryczaltowany doch| Nalezny podatek  " 
@ 21,1 say " 85.               | 86.               | 90.               | 91               "  
@ 22,1 say " Nalezna zaliczka  | Nadwyzka          | KWOTA DO ZAPLATY  | Kwota nadplacona " 
@ 23,1 say " 93.               | 94.               | 96.               | 97               "  
do skom with "STRZALKI - wybor rubryki     ENTER - zatwierdzenie     ESC - rezygnacja"
RETURN

*******************************************************************************
* Tworzy tekst dla tablicy t[36]                                              *
*******************************************************************************
FUNCTION NT
parameters ptxt,pn1,pn2,pn3,pn4
local ltx:="                            |            |            |            |            "
ptxt=stuff(ltx,1,29,substr(ptxt,1,29))
if pn1#0
  ptxt=stuff(ptxt,30,12,str(pn1,12,2))
endif
if pn2#0  
  ptxt=stuff(ptxt,43,12,str(pn2,12,2))
endif
if pn3#0  
  ptxt=stuff(ptxt,56,12,str(pn3,12,2))
endif
if pn4#0  
  ptxt=stuff(ptxt,69,10,str(pn4,10,2))
endif  
RETURN ptxt

PROCEDURE SUMSAY
@ 17,5 say p45 picture " 999 999 999.99"
@ 17,25 say p46 picture " 999 999 999.99"		
@ 17,45 say p47 picture " 999 999 999.99"
@ 17,64 say p48 picture " 999 999 999.99"
@ 19,5 say p78a picture " 999 999 999.99"
@ 19,25 say p77 picture " 999 999 999.99"
@ 19,45 say p78 picture " 999 999 999.99"
@ 19,64 say p79 picture " 999 999 999.99"
@ 21,5 say p85 picture " 999 999 999.99"
@ 21,25 say p86 picture " 999 999 999.99"
@ 21,45 say p90 picture " 999 999 999.99"
@ 21,64 say p91 picture " 999 999 999.99"
@ 23,5 say p93 picture " 999 999 999.99"
@ 23,25 say p94 picture " 999 999 999.99"
@ 23,45 say p96 picture " 999 999 999.99"
@ 23,64 say p97 picture " 999 999 999.99"
RETURN

PROCEDURE PITLICZold
local licz:=0.00
local lpod:=0.00
replace p63 with p32+p39+p46+p50+p55+p58+p61
replace p64 with p33+p40+p47+p51+p56+p59
replace p65 with p34+p41+p48+p52+p57+p60+p62
replace p68 with p65+p66+p67
replace p70 with p68-p69
replace p89 with p71+p72+p73+p74+p75+p76+p77+p78+p79+p80+p81+p82+p83+p84+p85+p86+p87+p88
licz=round(p70-p89,0)
if licz>0
  replace p90 with licz
else
  replace p90 with 0.00
endif  
do case
  case licz<=prog2
    lpod=round(licz*stopa1/100+dolicz1,1)
	if lpod<0
	  lpod=0
	endif
  case licz>prog2.and.licz<=prog3
    lpod=round(((licz-prog2)*33)/100+dolicz2,1)
  case licz>prog3
    lpod=round(((licz-prog3)*45)/100+dolicz3,1)
endcase
replace p91 with lpod
replace p96 with p92+p93+p94+p95
replace p97 with p91-p96
licz=p97-p98
if licz>=0
  replace p99 with licz,p100 with 0
else
  licz=-licz
  replace p100 with licz,p99 with 0
endif  
licz=p97-p101
if licz>=0
  replace p102 with licz,p103 with 0
else
  licz=-licz
  replace p103 with licz,p102 with 0
endif    
replace p107 with (p104*p105)/1000  
if p102>0
  replace p108 with p107+p102
else
  replace p108 with p107-p103
endif  
RETURN

PROCEDURE PITLICZ
local licz:=0.00
local lpod:=0.00

replace p45 with p27+p31+p35+p39+p43
replace p46 with p28+p32+p36+p40
licz=p45-p46
do case
  case licz=0
    replace p47 with 0
	replace p48 with 0
  case licz>0
    replace p47 with licz
	replace p48 with 0
  case licz<0
    replace p47 with 0
	replace p48 with -1*licz
endcase
licz=p47-p49
if licz<0
  replace p50 with 0
else
  replace p50 with licz
endif  
replace p77 with p52+p54+p55+p56+p57+p59+p60+p61+p62+p63+p64+p65+p66+p68+p70+p72+p74+p76
p78a=p50-p77
licz=round(p50-p77,0)
if licz<0
  replace p78 with 0
else
  replace p78 with licz
endif  
do case
  case licz<=prog2
    lpod=round(licz*stopa1/100+dolicz1,2)
	if lpod<0
	  lpod=0
	endif
  case licz>prog2.and.licz<=prog3
    lpod=round(((licz-prog2)*stopa2)/100+dolicz2,2)
  case licz>prog3
    lpod=round(((licz-prog3)*stopa3)/100+dolicz3,2)
endcase
replace p79 with lpod
replace p85 with p80+p81+p82+p84
licz=p79-p85
if licz<0
  replace p86 with 0
else
  replace p86 with round(licz,0)
endif
replace p90 with 0.1*p89
replace p91 with p86+p90
licz=p91-p92
if licz<0
  replace p93 with 0
else
  replace p93 with licz
endif
licz=p92-p91
if licz<0
  replace p94 with 0
else
  replace p94 with licz
endif
licz=p91-p95
if licz<0
  replace p96 with 0
else
  replace p96 with licz
endif
licz=p95-p91
if licz<0
  replace p97 with 0
else
  replace p97 with licz
endif

RETURN


PROCEDURE ZRAMLAD
stopa1=rstopa1
stopa2=rstopa2
stopa3=rstopa3
dolicz1=rdolicz1
dolicz2=rdolicz2
dolicz3=rdolicz3
prog2=rprog2
prog3=rprog3
RETURN

PROCEDURE DZIALZAL
replace p27 with p107+p116,p28 with p108+p117
	  licz=p27-p28
	  do case
	    case licz=0
		  replace p29 with 0
		  replace p30 with 0
	    case licz>0
		  replace p29 with licz
		  replace p30 with 0
	    case licz<0
		  replace p29 with 0
		  replace p30 with -1*licz  
	  endcase
RETURN

PROCEDURE NAJZAL
replace p31 with p123+p130,p32 with p124+p131	  
	  licz=p31-p32
	  do case
	    case licz=0
		  replace p33 with 0
		  replace p34 with 0
	    case licz>0
		  replace p33 with licz
		  replace p34 with 0
	    case licz<0
		  replace p33 with 0
		  replace p34 with -1*licz  
	  endcase	  
RETURN