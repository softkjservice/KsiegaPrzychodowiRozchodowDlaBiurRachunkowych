*******************************************************************************
* Bilans miesiaca lub roku                                                    *
* t[]-wartosci rubryk, tz[1]-tz[4] zakupy netto wg.stawek,                    *
*                      tz[5]-tz[6] podatek vat wg. stawek 22% i 7%            *
* ts[] - to samo co tz[] ale dla sprzedazy                                    *
* tz10[] - zakupy netto wg. stawek 22/7/0/zw dla rubryki 10 w ksiedze         *
* Dla vat analizowane sa pozycje z pliku ksiega.dbf oraz rejestr.dbf          * 
*******************************************************************************
parameters ptryb
local t[15],tz[8],ts[8],tz10[4],r[3]
local ek:=savescreen(0,0,24,79),lcolor,ek1
local lsiac:=month(daf)
local lnaz:=space(15)
local ltyt:=space(80)
local licz:=0.00
local rycz:=0.00
local rycznow:=0.00
local rycz7:=0.00
local rycz5:=0.00
local rycz2:=0.00
local ryczodl:=0.00
local zdrowotne:=0.00
local ludz22:=0.00
local ludz07:=0.00
local ludz03:=0.00
local ludz00:=0.00
local ludzzw:=0.00
local lutarg:=0.00
local lksdata:=daf
local lksprocp:=0.0
local lstruk_22:=0
local lstruk_07:=0
local lstruk_03:=0
local lstruk_00:=0
local lstruk_zw:=0
local drukuj:=.t.
local wek:=""
for i=1 to 13
  t[i]:=0.00
next
for i=1 to 8
  tz[i]:=0.00
  ts[i]:=0.00
next
for i=1 to 4
  tz10[i]:=0.00
next
for i=1 to 3
  r[i]:=0.00
next
save screen to ek
@ 21,1 clear to 23,78
@ 22,27 say "  Podaj numer miesiaca     "
do skom with "0 - podliczenie od poczatku roku wlacznie z miesiacem biezacym."
set cursor on
@ 22,50 get lsiac picture "99" range 0,12 
read
if lastkey()=27
  restore screen from ek
  return
endif
set cursor off
if lsiac#0
  do miesiac with lsiac,lnaz
  ltyt=stuff(ltyt,1,33,firnazwa)
  ltyt=stuff(ltyt,35,17,"BILANS ZA MIESIAC")
  ltyt=stuff(ltyt,53,len(lnaz),lnaz)
else
  do miesiac with month(daf),lnaz
  ltyt=stuff(ltyt,1,33,firnazwa)
  ltyt=stuff(ltyt,35,33,"BILANS ZA OKRES: POCZATEK ROKU - ")
  ltyt=stuff(ltyt,68,len(lnaz),lnaz)
endif  
*if ptryb=1
*  do biltlo with ltyt
*endif
if lsiac#0                     &&jesli bilans miesieczny 
  do pksdefault with lsiac
  select 2
  use ksiega index ksiega
  do while.not.eof()
    if zryczalt
	  do case
	    case ksprocp=rycz_u
		  r[1]=r[1]+kstow
	    case ksprocp=rycz_p
		  r[2]=r[2]+kstow
	    case ksprocp=rycz_h
		  r[3]=r[3]+kstow		  		  
	  endcase
	endif
    for i=1 to 13            && sumuje wartosci numeryczne rubryk ksiegi
      t[i]=t[i]+fieldget(i+6)
	next
	for i=1 to 8             && sumuje wartosci netto wg. stawek i vat
	  do case
	    case kszak
		  if i<5.or..not.substr(ksnic,2,2)="-R"     &&pominiecie vatu dla pozycji wylaczonej z rejestru
		    tz[i]=tz[i]+fieldget(i+28)
		  endif	
	    case kssprzed
          if i<5.or..not.substr(ksnic,2,2)="-R"     &&pominiecie vatu dla pozycji wylaczonej z rejestru
		    ts[i]=ts[i]+fieldget(i+28)		  
	      endif		
	  endcase
	next  
    if kszakup#0            &&jesli niezerowy wpis do rubryki [10] ksiegi
      if substr(ksmod,1,1)$"ar"
	    ludz22=ludz22+ks22*1.22
		ludz07=ludz07+ks07*1.07
		ludz03=ludz03+ks03*1.03
	  else
	    ludz22=ludz22+ks22+ksvat22
		ludz07=ludz07+ks07+ksvat07	  
		ludz03=ludz03+ks03+ksvat03	  
	  endif
	  ludz00=ludz00+ks00
	  ludzzw=ludzzw+kszw
	endif
    skip
  enddo

  use rejestr index rejestr  &&analiza pozycji nie wpisywanych do ksiegi
  do while.not.eof()         && ale wplywajacych na vat (np srodki trwale)
    for i=1 to 8           
	  do case
	    case kszak
		  tz[i]=tz[i]+fieldget(i+28)
	    case kssprzed
		  ts[i]=ts[i]+fieldget(i+28)		  
	  endcase
	next      
    skip
  enddo
  use  
else

  for k=1 to month(daf)     && dla kazdego miesiaca od stycznia do biezacego wlacznie
    licz=k
	do pksdefault with licz
    select 2
    use ksiega index ksiega
    do while.not.eof()
      if zryczalt
	    do case
	      case ksprocp=rycz_u
		    r[1]=r[1]+kstow
	      case ksprocp=rycz_p
		    r[2]=r[2]+kstow
	      case ksprocp=rycz_h
		    r[3]=r[3]+kstow		  		  
	    endcase
	  endif
      for i=1 to 13
        t[i]=t[i]+fieldget(i+6)
	  next
*
      for i=1 to 8           
	    do case
	      case kszak
		    tz[i]=tz[i]+fieldget(i+28)
	      case kssprzed
		    ts[i]=ts[i]+fieldget(i+28)		  
	    endcase
	  next      	  
*
      skip
    enddo

  next
endif

udzsum=ludz22+ludz07+ludz03+ludz00+ludzzw
*if udzsum#0
   ludz22=round(100*ludz22/udzsum,3)
   ludz07=round(100*ludz07/udzsum,3)
   ludz03=round(100*ludz03/udzsum,3)
   ludz00=round(100*ludz00/udzsum,3)
   ludzzw=round(100*ludzzw/udzsum,3)
*endif
do case
  case ptryb=1
    do biltlo with ltyt
    if zryczalt
      rycz=r[1]+r[2]+r[3]
	  rycz7=round(r[1]/rycz,4)
	  rycz5=round(r[2]/rycz,4)
	  rycz2=round(r[3]/rycz,4)
      @ 7,7 say r[1] picture " 999 999 999.99"
      @ 8,7 say r[2] picture " 999 999 999.99"
      @ 9,7 say r[3] picture " 999 999 999.99"
      @ 7,24 say r[1]*(rycz_u/100) picture " 999 999 999.99"
      @ 8,24 say r[2]*(rycz_p/100) picture " 999 999 999.99"
      @ 9,24 say r[3]*(rycz_h/100) picture " 999 999 999.99"
      @ 7,40 say rycz7*100 picture "999.99"
      @ 8,40 say rycz5*100 picture "999.99"
      @ 9,40 say rycz2*100 picture "999.99"	  
	  @ 11,7 say rycz picture " 999 999 999.99"
	  @ 11,24 say round(r[1]*rycz_u/100,2)+round(r[2]*rycz_p/100,2)+round(r[3]*rycz_h/100,2)picture " 999 999 999.99"
  	  @ 20,31 say t[4] picture " 999 999 999.99"
      @ 21,20 say ludz22 picture "999.9"
      @ 21,25 say ludz07 picture "999.9"
	  @ 21,30 say ludz03 picture "999.9"
      @ 21,35 say ludz00 picture "999.9"
      @ 21,40 say ludzzw picture "999.9"	  


    else
	  @ 3,31 say t[1] picture " 999 999 999.99"
      @ 4,31 say t[2] picture " 999 999 999.99"
      @ 6,31 say t[3] picture " 999 999 999.99"
      @ 8,31 say t[4] picture " 999 999 999.99"
      @ 9,20 say ludz22 picture "999.9"
      @ 9,25 say ludz07 picture "999.9"
	  @ 9,30 say ludz03 picture "999.9"
      @ 9,35 say ludz00 picture "999.9"
      @ 9,40 say ludzzw picture "999.9"
      @ 10,31 say t[5] picture " 999 999 999.99"
      @ 12,31 say t[4]+t[5] picture " 999 999 999.99"
*     @ 14,31 say t[6] picture " 999 999 999.99"
*     @ 15,31 say t[7] picture " 999 999 999.99"
      @ 14,31 say t[8] picture " 999 999 999.99"
      @ 15,31 say t[9] picture " 999 999 999.99" 
*     @ 18,31 say t[10] picture " 999 999 999.99"
      @ 16,31 say t[11] picture " 999 999 999.99"
     @ 17,31 say t[12] picture " 999 999 999.99"
      @ 19,31 say t[13] picture " 999 999 999.99"
	endif

    @ 3,62 say ts[6] picture " 999 999 999.99"
    @ 4,62 say ts[7] picture " 999 999 999.99"
    @ 5,62 say ts[8] picture " 999 999 999.99"	
    @ 6,62 say ts[6]+ts[7]+ts[8] picture " 999 999 999.99"
    @ 8,62 say tz[6] picture " 999 999 999.99"
    @ 9,62 say tz[7] picture " 999 999 999.99"
    @ 10,62 say tz[8] picture " 999 999 999.99"	
    @ 11,62 say tz[6]+tz[7]+tz[8] picture " 999 999 999.99"
    if lsiac#0
      @ 14,62 say ts[6]+ts[7]+ts[8]-(tz[6]+tz[7]+tz[8]) picture " 999 999 999.99"
      if zryczalt
	    do while.t. 
	      rycznow=round(rycz-ryczodl,0)
	      @ 13,30 say rycz picture " 999 999 999.99"
	      @ 14,30 say ryczodl picture " 999 999 999.99"
          @ 15,30 say rycznow picture " 999 999 999"
          odl_u=round(rycz7*ryczodl,2)
		  odl_p=round(rycz5*ryczodl,2)
		  odl_h=round(rycz2*ryczodl,2)
          pn_u=round(r[1]-odl_u,0)
          pn_p=round(r[2]-odl_p,0)
          pn_h=round(r[3]-odl_h,0)
		  pod_u=round(pn_u*(rycz_u/100),2)
		  pod_p=round(pn_p*(rycz_p/100),2)
		  pod_h=round(pn_h*(rycz_h/100),2)
		  podatek=round(pod_u+pod_p+pod_h,2)
		  @ 16,33 say podatek picture "9 999 999.99" 
		  @ 17,33 say zdrowotne  picture "9 999 999.99"
	      if podatek-zdrowotne>0
		    @ 18,33 say round(podatek-zdrowotne,1)  picture "9 999 999.9"
		  else
		    @ 18,33 say 0 picture "9 999 999.9"
		  endif	
		  do skom with "Wcisnij klawisz F2 aby wpisac kwote odliczenia i skladki zdrowotnej.  Esc - rez."
          inkey(0)
		  set color to n/w
		  do case
		    case lastkey()=-1
			  @ 14,30 say space(15)
		      lcolor=setcolor()
			  set color to n/w,w/n
			  set cursor on
		      @ 14,33 get ryczodl picture "999999999.99"
		      @ 17,33 get zdrowotne picture "999999999.99"
			  setcolor(lcolor)
			  read
		      set cursor off
		    case lastkey()=27
		      exit	
          endcase
	    enddo	  
	  else
	    @ 19,57 say t[3]-(t[4]+t[5]+t[13]) picture " 999 999 999.99"
	  endif	
      *do tkom with "OK!"
    else
      do firdefault
      select 1
      use ksmem
      do while .t.
        set color to (n/w,w/n)
        @ 13,62 say ts[6]+ts[7]+ts[8]-(tz[6]+tz[7]+tz[8]) picture " 999 999 999.99"
        @ 14,50 say " Zaplacono :                 "   
        @ 15,50 say " Pozostalo :                 " 

        @ 14,62 say vatzap picture " 999 999 999.99"
        @ 15,62 say ts[6]+ts[7]+ts[8]-(tz[6]+tz[7]+tz[8])-vatzap picture " 999 999 999.99"
        if.not.zryczalt
		  @ 19,57 say t[3]-(t[4]+t[5]+t[13])-(remzer-remakt) picture " 999 999 999.99"
	      @ 21,50 say " - ( rem_Pocz - rem_Aktual ) " 
          @ 22,50 say "                             " 
        endif
		if zryczalt
		  do skom with "vat_Zaplacono/Doplacono    ESC - rezygnacja"  
		else
		  do skom with "vat_Zaplacono/Doplacono   remanent_Poczatkowy/Aktualny   ESC - rezygnacja"  
        endif
		inkey(0)
        set color to (n/w,w/n)
    	do case
    	  case lastkey()=90.or.lastkey()=122     &&Zaplacono_vat
            @ 14,62 say space(15)
    		set cursor on
    		@ 14,62 get vatzap
    		read
    		set cursor off		
    	  case lastkey()=68.or.lastkey()=100    &&Doplacono_vat
    	    zvatzap=0
            @ 14,62 say space(15)
    		set cursor on
    		@ 14,62 get zvatzap
    		read
    		replace vatzap with vatzap+zvatzap
    		set cursor off		
    	  case (lastkey()=80.or.lastkey()=112).and..not.zryczalt   &&Poczatkowy remanent
    		set cursor on
    		@ 22,50 say " Rem_pocz. "
    		@ 22,62 get remzer picture "999999999.99"
    		read
    		set cursor off		
    	  case (lastkey()=65.or.lastkey()=97).and..not.ryczalt    &&Aktualny remanent
    		set cursor on
    		@ 22,50 say " Rem_aktual."
    		@ 22,62 get remakt picture "999999999.99"
    		read
    		set cursor off		
    	  case lastkey()=27
    	    exit
    	endcase
    	set color to
      enddo
      use
      do ksdefault
    endif  
******************************************************Drukowanie raportu		
    if.not.zryczalt
      zz=.t.
      do gkom with "Wydrukowac raport ?  [T/N] ",zz	
    if.not.zz.or.lastkey()=27
        return	
	endif

	if zz.and.lastkey()#27
      save screen to ek1
      ilosc=1
	  do startdruk with ilosc,drukuj,wek
      if.not.drukuj
        restore screen from ek1
        return
      endif  
      if plikdruk
        do tkom with "Zmien parametry wydruku !"
        restore screen from ek
        return  
      endif
      do skom with "Czekaj !  Trwa drukowanie raportu !"
      set device to printer
      set margin to margines	
      if lsiac#0
        do miesiac with lsiac,lnaz
        ltyt="ROZLICZENIE ZA MIESIAC "+lnaz
      else
        do miesiac with month(daf),lnaz
        ltyt="ROZLICZENIE ZA OKRES: Styczen - "+LNAZ 
      endif  

	  w=prow()
	  @ w,3 say firnazwa
	  w=w+4
	  @ w,20 say ltyt
	  w=w+3
	  @ w,3 say replicate("-",76)
	  w=w+6
	  
	    @ w,3 say "Warto˜† sprzedanych towar¢w i usˆug ................"
		@ w,57 say t[1] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "Pozostale przychody ................................"
		@ w,57 say t[2] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "                                                      --------------"
		w=w+2
		@ w,3 say "                               Razem przychody ....."
		@ w,57 say t[3] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+4
		@ w,3 say "Zakup towarow handlowych i materialow wg cen zakupu "
		@ w,57 say t[4] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "Koszty uboczne zakupu .............................."
		@ w,57 say t[5] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "Koszty reprezentacji i reklamy objete limitem ......"
		@ w,57 say t[8] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "Wynagrodzenie w gotowce i naturze .................."
		@ w,57 say t[9] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "Pozostale wydatki .................................."
		@ w,57 say t[11] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2
		@ w,3 say "Amortyzacja jednorazowa ............................"
		@ w,57 say t[12] picture "999 999 999.99"
		@ w,74 say "ZL"
		w=w+2		
		@ w,3 say "                                                      --------------"
		w=w+2
		@ w,3 say "                               Razem wydatki ......."		
		@ w,57 say t[13] picture "999 999 999.99"
		@ w,74 say "ZL"		

	  endif	  
      w=w+9
	  @ w,3 say "Dokument sporzadzil ..................................  dnia "
	  @ w,66 say date()
	  w=w+1
	  @ w,3 say "                                  podpis"		  
		  
	  eject
	  
	  set device to screen
	  restore screen from ek1
	endif	
******************************************************Koniec drukowania raportu

  case ptryb=2
    do utargtlo
    @ 9,51 say lnaz
	set cursor on
	@ 12,46 get lutarg picture "999999999.99"
	@ 13,46 get lksdata
    if zryczalt
	  @ 12,60 say "Ryczalt :"get lksprocp picture "99.9"
	endif
	read
	set cursor off
    if lastkey()=27
	  return
	endif
    
	@ 17,65 say ludz22 picture "999.999"
    @ 18,65 say ludz07 picture "999.999"
	@ 19,65 say ludz03 picture "999.999"
    @ 20,65 say ludz00 picture "999.999"
    @ 21,65 say ludzzw picture "999.999"			
    lstruk_22=ludz22
    lstruk_07=ludz07
	lstruk_03=ludz03
    lstruk_00=ludz00
    lstruk_zw=ludzzw			
	
	ludz22=((ludz22/100)*lutarg)/1.22   &&wartosc netto utargu ze stawka 22%
	ludz07=((ludz07/100)*lutarg)/1.07    &&        -"-                    07%
	ludz03=((ludz03/100)*lutarg)/1.03    &&        -"-                    03%
	ludz00=(ludz00/100)*lutarg
	ludzzw=(ludzzw/100)*lutarg		
    @ 17,28 say ludz22 picture " 999 999 999.99"
    @ 18,28 say ludz07 picture " 999 999 999.99"
	@ 19,28 say ludz03 picture " 999 999 999.99"
    @ 20,28 say ludz00 picture " 999 999 999.99"
    @ 21,28 say ludzzw picture " 999 999 999.99"
    @ 23,28 say ludz22+ludz07+ludz03+ludz00+ludzzw picture " 999 999 999.99"
    @ 17,46 say ludz22*0.22 picture " 999 999 999.99"
    @ 18,46 say ludz07*0.07 picture " 999 999 999.99"
	@ 19,46 say ludz03*0.03 picture " 999 999 999.99"
    @ 23,46 say ludz22*0.22+ludz07*0.07+ludz03*0.03 picture " 999 999 999.99"
	do while.t.
	  if month(lksdata)=lsiac
	    exit
	  else
	    do skom with "Zmien miesiac w dacie ksiegowania!"
		set cursor on
	  	@ 13,46 get lksdata
		read
		if lastkey()=27
		  return
		endif
		set cursor off
	  endif
	enddo
    zz=.t.
	do gkom with "Wydrukowac raport ?  [T/N] ",zz	
	if zz.and.lastkey()#27
	  do raport with lutarg,lksdata,ludz22,ludz07,ludz03,ludz00,ludzzw,lstruk_22,lstruk_07,lstruk_03,lstruk_00,lstruk_zw
	endif
    zz=.t.
	do gkom with "Zaksiegowac utarg miesieczny ?  [T/N] ",zz
	if zz.and.lastkey()#27
      do pksdefault with lsiac
	  select 1
      use ksiega index ksiega
	  append blank
	  replace ksday with day(lksdata),ksopis with "Utarg miesieczny"
	  replace kstow with ludz22+ludz07+ludz03+ludz00+ludzzw,kssum with ludz22+ludz07+ludz03+ludz00+ludzzw
      replace ksdata with lksdata,ksmod with "m  "
	  replace ks22 with ludz22,ks07 with ludz07,ks03 with ludz03,ks00 with ludz00,kszw with ludzzw
      replace ksvat22 with ludz22*0.22,ksvat07 with ludz07*0.07,ksvat03 with ludz03*0.03,kszak with .f.
	  replace kssprzed with .t.
	  if zryczalt
	    replace ksprocp with lksprocp,ksobrot with kstow*(lksprocp/100)
	  endif
	  use
*	  do tkom with "Bedzie ksiegowane."
	endif
endcase	
RETURN

PROCEDURE BILTLO
parameters pnaz
clear
set color to (coldef)
for i=1 to 23
  @ i,0 say chr(176)
  @ i,48 say chr(176)
  @ i,79 say chr(176)   
next
@ 23,0 say replicate(chr(176),80)
if kolor=0
  set color to n/w
endif  
@ 0,0 say pnaz
if kolor=0
  set color to
endif  
if zryczalt
  @ 1,1 say "          P O D S U M O W A N I E             "
  @ 2,1 say "=============================================="
  set color to n/w 
  @ 3,1 say "                                              "
  @ 4,1 say "         Sprzedaz towarow i uslug             "
  @ 5,1 say " St.  Kwota            Podatek            %   "
  @ 6,1 say " ---  ---------------  ---------------  ----- "
  @ 7,1 say "                                              "
  @ 8,1 say "                                              "
  @ 9,1 say "                                              "
  @ 10,1 say "      ---------------  ---------------        "
  @ 11,1 say "Razem                                         "
  @ 12,1 say "                                              "
  @ 13,1 say " Podstawa opodatkowania .....                 "
  @ 14,1 say " Odliczenie od podstawy .....                 "
  @ 15,1 say " Podstawa po odliczeniu .....                 "
  @ 16,1 say " Podatek ....................                 "
  @ 17,1 say " Skladki ubezp.zdrowotnego ..                 "
  @ 18,1 say " Podatek do zaplaty .........                 "
  @ 19,1 say "                                              "
  @ 20,1 say " [10] Zakup mat.i tow.hand. .                 "
  @ 21,1 say " W tym 22/7/3/0/zw      /    /    /    /     %"
  @ 22,1 say "                                              "
  @ 7,1 say rycz_u picture "99.9"
  @ 8,1 say rycz_p picture "99.9"
  @ 9,1 say rycz_h picture "99.9"
else
  @ 1,1 say "   P O D S U M O W A N I E     R U B R Y K    "
  @ 2,1 say "=============================================="
  set color to n/w 
  @ 3,1 say " [ 7] Sprzedaz tow.i usl. ...                 "
  @ 4,1 say " [ 8] Pozostale przychody ...                 "
  @ 5,1 say "                             ---------------  "
  @ 6,1 say " Razem [7]+[8] ..............                 "
  @ 7,1 say "                                              "
  @ 8,1 say " [10] Zakup mat.i tow.hand. .                 "
  @ 9,1 say " W tym 22/7/3/0/zw      /    /    /    /     %"
  @ 10,1 say " [11] Koszty uboczne zak. ...                 "
  @ 11,1 say "                             ---------------  "
  @ 12,1 say " Razem [10]+[11] ............                 "
  @ 13,1 say "                                              "
*  @ 14,1 say " [12] Podatek obrotowy ......                 "
*  @ 15,1 say " [13] Przerob obcy ..........                 "
  @ 14,1 say " [12] Reprezent.i reklama ...                 "
  @ 15,1 say " [13] Wynagrodzenie w got. ..                 "
* @ 18,1 say " [16] Wynagrodzenie w nat. ..                 "
  @ 16,1 say " [14] Pozostale wydatki .. ..                 "
 @ 17,1 say  " [18] Amort. jednorazowa.....                 "
  @ 18,1 say "                             ---------------  "
  @ 19,1 say " [15] Razem  [12]ö[18] ......                 "
* @ 19,1 say "                                              "  
  @ 20,1 say "                                              "  
  @ 21,1 say "                                              "  
  @ 22,1 say "                                              "        
endif
set color to (coldef)
@ 1,50 say " R O Z L I C Z E N I E   VAT " 
@ 2,50 say "=============================" 
set color to n/w
@ 3,50 say  " NALE  | 22%:                " 
@ 4,50 say  " -ZNY  |  7%                 " 
@ 5,50 say  "          3%                 " 
@ 6,50 say  "       Razem                 " 
@ 7,50 say  " ........................... " 
@ 8,50 say  " NALI- | 22%.                "
@ 9,50 say  " CZONY |  7%                 "
@ 10,50 say "          3%                 " 
@ 11,50 say "       Razem                 " 
@ 12,50 say " ........................... " 
@ 13,50 say " Do zaplaty:                 " 
@ 14,50 say "                             " 
@ 15,50 say "                             "
@ 16,50 say replicate(chr(176),29)
if.not.zryczalt
  set color to (coldef)
  @ 17,50 say "     Z Y S K   F I R M Y     "
  @ 18,50 say "============================="
  set color to n/w
  @ 19,50 say "                          zl."
  @ 20,50 say " ZF = [9] - ([10]+[11]+[19]) "
  @ 21,50 say "                             "  
  @ 22,50 say "                             "
endif
RETURN

PROCEDURE UTARGTLO
*@ 0,0 clear to 20,79
set color to (coldef)
@ 8,18 to 23,75 double
@ 9,19 say  "             Utarg za miesiac                           "
@ 10,19 say "           ********************************             "
@ 11,19 say "                                                        "
@ 12,19 say "    Kwota utargu BRUTTO....                             "
@ 13,19 say "    Data ksiegowania.......                ___________  "
@ 14,19 say " __________________________________________| Struktura  "
@ 15,19 say " Stawka | Utarg NETTO    | Podatek VAT     | zakupow    "
@ 16,19 say " -------|----------------|-----------------|----------  "
@ 17,19 say "   22 % |                |                 |            "
@ 18,19 say "    7 % |                |                 |            "
@ 19,19 say "    3 % |                |                 |            "
@ 20,19 say "    0 % |                |                 |            "
@ 21,19 say "   zw.  |                |                 |            "
@ 22,19 say " -------|----------------|-----------------|----------  "
@ 23,19 say " Razem  |                |                 |  100.0 %   "

RETURN


PROCEDURE RAPORT
parameters pbrutto,pdata,pnet_22,pnet_07,pnet_03,pnet_00,pnet_zw,ps_22,ps_07,ps_03,ps_00,ps_zw
local ek:=savescreen(0,0,24,79)
local ilosc:=1
local drukuj:=.t.
local wek:=""
local lsiac:=0
local lnaz:=""
lsiac=month(pdata)
save screen to ek
do startdruk with ilosc,drukuj,wek
if.not.drukuj
  restore screen from ek
  return
endif  
if plikdruk
  do tkom with "Zmien parametry wydruku !"
  restore screen from ek
  return  
endif
do miesiac with lsiac,lnaz
do skom with "Czekaj !  Trwa drukowanie raportu !"
set device to printer
*@ prow(),pcol() say chr(15)
set margin to margines	
@ 0,6 say firnazwa            
@ 1,0 say "     ZESTAWIENIE SPRZEDAZY BEZRACHUNKOWEJ ZA MIESIAC              ROK       "
@ 1,54 say lnaz picture "@!"
@ 1,70 say year(pdata)
@ 2,0 say "                                                                            "
@ 3,0 say "     NA PODSTAWIE ........................................................."
@ 4,0 say "  =========================================================================   "
@ 5,0 say "                                                                              "
@ 6,0 say "  KWOTA UTARGU MIESIECZNEGO BRUTTO.....                                       "
@ 6,40 say pbrutto
@ 7,0 say "  DATA ZAKSIEGOWANIA...................                                       "
@ 7,40 say pdata
@ 8,0 say "                                                                              "
@ 9,0 say "                                                                              "
@ 10,0 say "  KWOTA PODATKU VAT LICZONA METODA STRUKTURY ZAKUPOW :                        "
@ 11,0 say "  -------------------------------------------------------------------------   "
@ 12,0 say "  |  STAWKA   |   UTARG NETTO   |   PODATEK VAT   |   STRUKTURA ZAKUPOW   |   "
@ 13,0 say "  |-----------------------------------------------------------------------|   "
@ 14,0 say "  |   22 %    |                 |                 |                       |   "
@ 14,18 say pnet_22 picture "9 999 999.99"
@ 14,36 say pnet_22*0.22 picture "9 999 999.99"
@ 14,55 say ps_22 picture "999.999"
@ 15,0 say "  |    7 %    |                 |                 |                       |   "
@ 15,18 say pnet_07 picture "9 999 999.99"
@ 15,36 say pnet_07*0.07 picture "9 999 999.99"
@ 15,55 say ps_07 picture "999.999"
@ 16,0 say "  |    3 %    |                 |                 |                       |   "
@ 16,18 say pnet_03 picture "9 999 999.99"
@ 16,36 say pnet_03*0.03 picture "9 999 999.99"
@ 16,55 say ps_03 picture "999.999"
@ 17,0 say "  |    0 %    |                 |                 |                       |   "
@ 17,18 say pnet_00 picture "9 999 999.99"
@ 17,55 say ps_00 picture "999.999"
@ 18,0 say "  |   ZW.     |                 |                 |                       |   "
@ 18,18 say pnet_zw picture "9 999 999.99"
@ 18,55 say ps_zw picture "999.999"
*@ 18,0 say "  |-----------------------------------------------------------------------|   "
@ 19,0 say "  | RAZEM :   |                 |                 |                       |   "
@ 19,18 say pnet_22+pnet_07+pnet_03+pnet_00+pnet_zw picture "9 999 999.99"
@ 19,36 say pnet_22*0.22+pnet_07*0.07+pnet_03*0.03 picture "9 999 999.99"
@ 19,55 say 100  picture "999.999" 
@ 20,0 say "  -------------------------------------------------------------------------   "
@ 21,0 say "                                                                              "
@ 22,0 say "                                                                              "
@ 23,0 say "                                                                              "
@ 24,0 say "                                                                              "
@ 25,0 say "                                                                              "
@ 26,0 say "  ZESTAWIENIE SPORZADZIL          ........................................    "
@ 27,0 say "                                                   PODPIS                     "
eject
set device to screen
restore screen from ek
RETURN