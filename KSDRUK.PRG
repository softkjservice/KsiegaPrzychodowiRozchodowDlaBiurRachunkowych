*******************************************************************************
* Wydruk rejestru  sprz.{P=2}, rej.zak (p=3)                                  *
* Umozliwia wspolprace z drukarka 15'{lpt15=.t.} oraz 10-12'{lpt15=.f.        *
*******************************************************************************
PARAMETERS P
local lms:=0,ltrwale:=.f.,lpusty:=.f.
local ilosc:=1
local em:=savescreen(0,0,24,79)
local drukuj:=.t.
local bat:=.f.
public strona:=1
public w:=0

korplus=.f.                    && testuje istnienie faktur korygujacych
korminus=.f.
tytul=space(30)
plik:="\kjdruk.prn"
dl=52
dziel=0       &&0-wydr jednoczesciowy, 1-strona A  1-strona B
wek=""
if.not.kr_firma
  zzwolniona=.f.
endif
save screen to em
do startdruk with ilosc,drukuj,wek
if.not.drukuj
  restore screen from em
  return
endif  

set device to printer
@ prow(),pcol() say &zdr_kond
set margin to margines
* * *

*set device to printer
rn_warunek='(substr(ksdow,3,1)$"RN".or.substr(ksdow,4,1)$"RN".or.substr(ksdow,5,1)$"RN".or.substr(ksdow,6,1)$"RN".or.substr(ksdow,7,1)$"RN").and.kswypos=0.and.kssprzed  '
if lpt15
  dziel=0
  do case
    case p=55
      do pliksum
      set filter to &rn_warunek
	  go top  
	  ******* rejestr sprzedazy z wylaczeniem korekt i srodkow trwalych	  
*      do pusty with lpusty
 *     if.not.lpusty
	    do rejsp
*	  endif
  
    case p=2
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kssprzed  
	  go top  
	  ******* rejestr sprzedazy z wylaczeniem korekt i srodkow trwalych	  
*      do pusty with lpusty
 *     if.not.lpusty
	    do rejsp
*	  endif

      set filter to substr(ksmod,2,1)="k".and.kssprzed        
      go top
	  ******* rejestr sprzedazy -  faktury korygujace 
      do pusty with lpusty
      if.not.lpusty
	    tytul="KOREKTA "	  
        eject
        w=0		
	    do rejsp
	  endif

   
    case p=3.and..not.zzwolniona	  
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak
	  go top  	  
	  ********	zakupy z wylaczeniem korekt i sr.trwalych  
 *     do pusty with lpusty
  *    if.not.lpusty
        tytul=space(30)
	    do rejzak
*	  endif	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak
	  go top  	  
	  ********	zakupy - korekty z wylaczeniem  sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA "
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH" 
	    do rejzak
	  endif	  	  	  

    case p=3.and.zzwolniona	  &&wystepuje sprzedaz zwolniona
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak.and.kszakup#0
	  go top  	  
	  ********	zakupy towarow handlowych z wylaczeniem korekt i sr.trwalych  
*      do pusty with lpusty
*      if.not.lpusty
        tytul="ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA"
	    do rejzak
*	  endif	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak.and.kszakup=0
	  go top  	  
	  ********	zakupy towarow nie handlowych z wylaczeniem korekt i sr.trwalych  
	  ********  rubryka 11,12,13,14
      do pusty with lpusty
      if.not.lpusty
	    eject
        w=0		
        tytul="ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA I ZWOLNIONA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak.and.kszakup#0
	  go top  	  
	  ********	zakupy - korekty zakupow tow. handlowych 
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA: ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak.and.kszakup=0
	  go top  	  
	  ********	zakupy - korekty zakupow tow. nie handlowych Rubr 11,12,13,14 
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA: ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA I ZWOLNIONA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH" 
	    do rejzak
	  endif	  	  	  

	  
    case p=5
      select 2
	  use rejestr index rejestr
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE Z WYLACZENIEM AMORTYZOWANYCH JEDNORAZOWO"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH Z WYLACZENIEM AMORTYZOWANYCH JEDNORAZOWO" 
	    do rejzak
	  endif	  	  	  
    case p=6
    case p=7
    case p=8
  endcase
else  
  dziel=1
  do case
    case p=55
      do pliksum
      set filter to &rn_warunek
	  go top  
	  ******* rejestr sprzedazy z wylaczeniem korekt i srodkow trwalych	  
 *     do pusty with lpusty
  *    if.not.lpusty
        tytul="FAKTURY DLA OSOB"
	    do rejsp
*	  endif

    case p=2
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kssprzed  
	  go top  
	  ******* rejestr sprzedazy z wylaczeniem korekt i srodkow trwalych	  
 *     do pusty with lpusty
  *    if.not.lpusty
        tytul=space(30)
	    do rejsp
*	  endif

      set filter to substr(ksmod,2,1)="k".and.kssprzed        
      go top
	  ******* rejestr sprzedazy -  faktury korygujace 
      do pusty with lpusty
      if.not.lpusty
	    tytul="KOREKTA "	  
        eject
        w=0		
	    do rejsp
	  endif

   
    case p=3.and..not.zzwolniona	  
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak
	  go top  	  
	  ********	zakupy z wylaczeniem korekt i sr.trwalych  
 *     do pusty with lpusty
  *    if.not.lpusty
        tytul=space(30)
	    do rejzak
*	  endif	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak
	  go top  	  
	  ********	zakupy - korekty z wylaczeniem  sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA "
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH" 
	    do rejzak
	  endif	  	  	  

    case p=3.and.zzwolniona	  &&wystepuje sprzedaz zwolniona
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak.and.kszakup#0
	  go top  	  
	  ********	zakupy towarow handlowych z wylaczeniem korekt i sr.trwalych  
 *     do pusty with lpusty
  *    if.not.lpusty
     *!   tytul=space(30)
	    tytul="ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA "
	    do rejzak
*	  endif	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak.and.kszakup=0
	  go top  	  
	  ********	zakupy towarow nie handlowych z wylaczeniem korekt i sr.trwalych  
	  ********  rubryka 11,12,13,14
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0			  
        tytul="ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA I ZWOLNIONA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak.and.kszakup#0
	  go top  	  
	  ********	zakupy - korekty zakupow tow. handlowych 
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA: ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak.and.kszakup=0
	  go top  	  
	  ********	zakupy - korekty zakupow tow. nie handlowych Rubr 11,12,13,14 
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA: ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA I ZWOLNIONA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH" 
	    do rejzak
	  endif	  	  	  

**   
    case p=5
      select 2
	  use rejestr index rejestr
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE Z WYLACZENIEM AMORTYZOWANYCH JEDNORAZOWO" 
	    do rejzak
	  endif	  	  	  	  
*      tytul="WYPOSAZENIE"
*	  set filter to kswypos#0
*	  go top
*	  do rejzak
    case p=6
    case p=7
    case p=8
  endcase

    if lastkey()#27
      eject
      w=0
	  dziel=2
      go top
      do case
        case p=55
          do pliksum
          set filter to &rn_warunek
	      go top  
	      ******* rejestr sprzedazy z wylaczeniem korekt i srodkow trwalych	  
 *         do pusty with lpusty
  *        if.not.lpusty
	        tytul=space(30)
		    do rejsp
*	      endif	  
	  
	  
        case p=2
          do pliksum
          set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kssprzed  
	      go top  
	      ******* rejestr sprzedazy z wylaczeniem korekt i srodkow trwalych	  
 *         do pusty with lpusty
  *        if.not.lpusty
	        tytul=space(30)
		    do rejsp
*	      endif

          set filter to substr(ksmod,2,1)="k".and.kssprzed        
          go top
	      ******* rejestr sprzedazy -  faktury korygujace 
          do pusty with lpusty
          if.not.lpusty
	        tytul="KOREKTA "	  
            eject
            w=0		
	        do rejsp
	      endif
**
    case p=3.and..not.zzwolniona	  
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak
	  go top  	  
	  ********	zakupy z wylaczeniem korekt i sr.trwalych  
 *     do pusty with lpusty
  *    if.not.lpusty
        tytul=space(30)
	    do rejzak
*	  endif	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak
	  go top  	  
	  ********	zakupy - korekty z wylaczeniem  sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA "
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH" 
	    do rejzak
	  endif	  	  	  

    case p=3.and.zzwolniona	  &&wystepuje sprzedaz zwolniona
      do pliksum
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak.and.kszakup#0
	  go top  	  
	  ********	zakupy towarow handlowych z wylaczeniem korekt i sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        tytul=space(30)
	    do rejzak
	  endif	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kszak.and.kszakup=0
	  go top  	  
	  ********	zakupy towarow nie handlowych z wylaczeniem korekt i sr.trwalych  
	  ********  rubryka 11,12,13,14
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0			  
        tytul="ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA I ZWOLNIONA"
        tytul=space(30)
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak.and.kszakup#0
	  go top  	  
	  ********	zakupy - korekty zakupow tow. handlowych 
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA: ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos=0.and.kszak.and.kszakup=0
	  go top  	  
	  ********	zakupy - korekty zakupow tow. nie handlowych Rubr 11,12,13,14 
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA: ZAKUPY ZWIAZANE ZE SPRZEDAZA OPODATKOWANA I ZWOLNIONA"
	    do rejzak
	  endif	  	  
	  
      set filter to substr(ksmod,2,1)#"k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - srodki trwale z wylaczeniem korekt
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="SRODKI TRWALE"
	    do rejzak
	  endif	  	  	  
	  
      set filter to substr(ksmod,2,1)="k".and.kswypos#0.and.kszak
	  go top  	  
	  ********	zakupy - korekty sr.trwalych  
      do pusty with lpusty
      if.not.lpusty
        eject
        w=0		
	    tytul="KOREKTA SRODKOW TRWALYCH" 
	    do rejzak
	  endif	  	  	  



   
	  
        case p=5
          do pusty with lpusty
          if.not.lpusty
            eject
            w=0		
            tytul="SRODKI TRWALE Z WYLACZENIEM AMORTYZOWANYCH JEDNORAZOWO" 
	        do rejzak
	      endif	  	  	  
*         tytul="WYPOSAZENIE"
*	      set filter to kswypos#0
*	      go top
*	      do rejzak
        case p=6
        case p=7
        case p=8
      endcase
    endif  && konczy warunek drukowania strony  B   
endif   
* * *
@ prow(),pcol() say &zdr_kkond
if.not.plikdruk
  eject
endif  
set device to screen
use
ferase("&KSSCIEZKA\rejsum.dbf")
ferase ("&KSSCIEZKA\rejsum.ntx")
set device to screen

if plikdruk
  set printer to
  run ne \kjdruk.prn    
endif
restore screen from em
close databases
RETURN


***********************************************************  REJESTR SPRZEDAZY
PROCEDURE REJSP
local cykl:=0
local str:=1
local sep:= '|----|----------|-------------|-------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
konrej=.t.
declare suma[11],folio[11]
pozycja=0        && kolejny numer na wydruku
for i=1 to 11
 suma[i]:=0
 folio[i]:=0
next

do tytrejsp with str

  do while.not.eof()
    if ks00#0.and.substr(ksopis,1,6)="EXPORT"
	  replace ksexport with .t.
	endif
    if ks00#0.and..not.substr(ksopis,1,6)="EXPORT".and.sh_firma
	  replace ksexport with .f.
	endif
      pozycja=pozycja+1
      if w>dl
        do ksstopasp
        eject
        w=0
	    str=str+1
	    for i=1 to 11
	      folio[i]=folio[i]+suma[i]
	      suma[i]=0
	    next
	    do tytrejsp with str
      endif

      for k=1 to 8
        suma[k]=suma[k]+ROUND(fieldget(k+28),2)
      next
*      ksexport=.t.
      if.not.ksexport
        suma[9]=suma[9]+ks00
	    suma[4]=suma[4]-ks00
      endif	
      suma[10]=suma[10]+ROUND(ks22,2)+ROUND(ks07,2)+ROUND(ks03,2)+ks00+kszw+ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
      suma[11]=suma[11]+ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
      do wierszsp
      w=w+1  
      do case
        case dziel=0
          @ w,0 say sep
        case dziel=1
          @ w,0 say substr(sep,1,125)
        case dziel=2
          @ w,0 say substr(sep,125)
      endcase
      w=w+1
	skip
  enddo
do ksstopasp
RETURN


PROCEDURE TYTREJSP
parameters stron
local lmiesiac:=space(15)
local lms:=ms
if pksiega
  @ w,0 say &zdr_kkond+firnazwa+&zdr_kond
  @ w,pcol()+20 say tytul
  w=w+1
else
  if tytul#space(30)
    @ w,10 say tytul+&zdr_kond
	w=w+1
  endif
endif
if dziel#2 
  @ w,5 say "REJESTR SPRZEDAZY TOWAROW I USLUG OPODATKOWANYCH PODATKIEM VAT ZA MIESIAC : "
  do miesiac with lms,lmiesiac
  @ w,82 say lmiesiac
  @ w,pcol()+3 say year(daf)
  @ w,pcol()+1 say "r."
endif
do case
  case dziel=0
    @ w,110 say "Strona :"
    @ w,118 say stron picture "999"
    @ w,141 say fwl
    @ prow()+1,0 say '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '|    |        RACHUNEK   (FAKTURA)          |    ogolna     |                            sprzedaz opodatkowana w/g stawki      V A T                                                        |               |               |'
    @ prow()+1,0 say '|    |--------------------------------------|    wartosc    |-------------------------------------------------------------------------------------------------------------------------------|   sprzedaz    |    podatek    |'
    @ prow()+1,0 say '| Lp.|          |   numer     |             |   sprzedazy   |              22%              |              7%               |              3%               |              0%               |   zwolniona   |    nalezny    |'
    @ prow()+1,0 say '|    |  DATA    |  rachunku   |    N I P    |    brutto     |---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|   od podatku  |  od sprzedazy |'
    @ prow()+1,0 say '|    |          |  (faktury)  |             |               | wartosc netto |     V A T     | wartosc netto |     V A T     | wartosc netto |     V A T     |    eksport    |  sp. krajowa  |               |               |'
    @ prow()+1,0 say '|----|----------|-------------|-------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
	@ prow()+1,0 say '| 1  |   2      |       3     |      4      |       5       |       6       |        7      |        8      |       9       |       10      |       11      |       12      |       13      |       14      |       15      |'
    @ prow()+1,0 say '|===========================================================================================================================================================================================================================|'   
  case dziel=1
    @ w,110 say "Strona A"
	@ w,118 say stron picture "999"
    @ prow()+1,0 say '-----------------------------------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '|    |        RACHUNEK   (FAKTURA)          |    ogolna     |                            sprzedaz opodatkowana w/g stawki    '
    @ prow()+1,0 say '|    |--------------------------------------|    wartosc    |----------------------------------------------------------------'
    @ prow()+1,0 say '| Lp.|          |   numer     |             |   sprzedazy   |              22%              |              7%               |'
    @ prow()+1,0 say '|    |  DATA    |  rachunku   |    N I P    |    brutto     |---------------|---------------|---------------|---------------|'
    @ prow()+1,0 say '|    |          |  (faktury)  |             |               | wartosc netto |     V A T     | wartosc netto |     V A T     |'
    @ prow()+1,0 say '|----|----------|-------------|-------------|---------------|---------------|---------------|---------------|---------------|'
	@ prow()+1,0 say '| 1  |   2      |       3     |      4      |       5       |       6       |        7      |        8      |       9       |'
    @ prow()+1,0 say '|===========================================================================================================================|'
  case dziel=2
    @ w,0 say fwl
    @ w,50 say "Strona B"		
	@ w,58 say stron picture "999"
    @ prow()+1,0 say '-------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '    V A T                                                       |               |               |'
    @ prow()+1,0 say '|-------------------------------|-------------------------------|   sprzedaz    |    podatek    |'
    @ prow()+1,0 say '|              3%               |              0%               |   zwolniona   |    nalezny    |'
    @ prow()+1,0 say '|---------------|---------------|---------------|---------------|   od podatku  |  od sprzedazy |'
    @ prow()+1,0 say '| wartosc netto |     V A T     |    eksport    |  sp. krajowa  |               |               |'
    @ prow()+1,0 say '|---------------|---------------|---------------|---------------|---------------|---------------|'
	@ prow()+1,0 say '|       10      |       11      |       12      |       13      |       14      |       15      |'
    @ prow()+1,0 say '|===============================================================================================|'   
endcase
*w=10
w=prow()+1
RETURN



PROCEDURE WIERSZSP
local wtxt:='|    |          |             |             |               |               |               |               |               |               |               |               |               |               |               |'
local wtxt1:='|    |          |             |             |               |               |               |               |               |               |               |               |               |               |               |'
local lz:=0
local lksnaz,lksadr
local lksdow:=ndok_druk(ksdow)
wtxt=stuff(wtxt,2,4,str(pozycja,4,0))
wtxt=stuff(wtxt,7,10,dtoc(ksdata))
if ksdow=space(15)
  wtxt=stuff(wtxt,18,13,substr(ksopis,1,13))
else
  wtxt=stuff(wtxt,18,13,substr(lksdow,1,13))
endif  
wtxt=stuff(wtxt,32,13,ksnip)
lz=ROUND(ks22,2)+ROUND(ks07,2)+ROUND(ks03,2)+ks00+kszw+ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
wtxt=stuff(wtxt,46,15,strj(lz))
wtxt=stuff(wtxt,62,15,strj(ks22))
wtxt=stuff(wtxt,78,15,strj(ksvat22))
wtxt=stuff(wtxt,94,15,strj(ks07))
wtxt=stuff(wtxt,110,15,strj(ksvat07))
wtxt=stuff(wtxt,126,15,strj(ks03))
wtxt=stuff(wtxt,142,15,strj(ksvat03))
if ksexport
  wtxt=stuff(wtxt,158,15,strj(ks00))
else
  wtxt=stuff(wtxt,174,15,strj(ks00))
endif
wtxt=stuff(wtxt,190,15,strj(kszw))
lz=ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
wtxt=stuff(wtxt,206,15,strj(lz))
do case
  case dziel=0
    @ w,0 say wtxt
  case dziel=1
    @ w,0 say substr(wtxt,1,125)
  case dziel=2
    @ w,0 say substr(wtxt,125)		
endcase
if konrej
  lksnaz=stuff(space(31),1,15,substr(ksnaz,1,15))
*  lksnaz=stuff(lksnaz,17,15,substr(ksnaz,16))  
  lksnaz=stuff(lksnaz,16,15,substr(ksnaz,16))  
  lksadr=stuff(space(31),1,15,substr(ksadr,1,15))
*  lksadr=stuff(lksadr,17,15,substr(ksadr,16))    
  lksadr=stuff(lksadr,16,15,substr(ksadr,16))    
  wtxt1=stuff(wtxt1,2,len(alltrim(lksnaz)),alltrim(lksnaz))
  wtxt1=stuff(wtxt1,4+len(alltrim(lksnaz)),len(alltrim(lksadr)),alltrim(lksadr))  
  w=w+1
  do case
    case dziel=0
      @ w,0 say wtxt1
    case dziel=1
      @ w,0 say substr(wtxt1,1,125)
    case dziel=2
      @ w,0 say substr(wtxt1,125)		
  endcase  
endif
RETURN

**
PROCEDURE KSSTOPASP
local lz:=0
local t[11] 
local  sum:='              |             |               |               |               |               |               |               |               |               |               |               |               |               |'
local lin1:='|---------------------------|(6+8+10+12+13+14)--------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
local lin2:='              |-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|'
for k=1 to 11
   t[k]=0
next
do case
  case dziel=0
    @ w,0 say lin1
  case dziel=1
    @ w,0 say substr(lin1,1,125)
  case dziel=2
	@ w,0 say substr(lin1,125) 
endcase
for i=1 to 3
  sum:='              |             |               |               |               |               |               |               |               |               |               |               |               |               |'
       
  do case
    case i=1
	  for k=1 to 11
	    t[k]=suma[k]
	  next
      sum=stuff(sum,16,13,"Suma folio   ")
    case i=2
	  for k=1 to 11
	    t[k]=folio[k]
	  next
	  sum=stuff(sum,16,13,"Przen.z folio")
    case i=3
	  for k=1 to 11
	    t[k]=suma[k]+folio[k]
	  next	
	  sum=stuff(sum,16,13," Razem       ")  
  endcase
  *lz=t[1]+t[2]+t[3]+t[4]+t[7]
  lz=t[1]+t[2]+t[3]+t[4]+t[5]+t[9]
  sum=stuff(sum,30,15,strj(lz))  
  sum=stuff(sum,46,15,strj(t[10]))
  sum=stuff(sum,62,15,strj(t[1]))
  sum=stuff(sum,78,15,strj(t[6]))
  sum=stuff(sum,94,15,strj(t[2]))  
  sum=stuff(sum,110,15,strj(t[7]))  
  sum=stuff(sum,126,15,strj(t[3]))  
  sum=stuff(sum,142,15,strj(t[8]))    
  sum=stuff(sum,158,15,strj(t[4]))      
  sum=stuff(sum,174,15,strj(t[9]))    
  sum=stuff(sum,190,15,strj(t[5]))    
  sum=stuff(sum,206,15,strj(t[11]))    
  w=w+1
  do case
    case dziel=0
      @ w,0 say sum
      w=w+1
      @ w,0 say lin2
    case dziel=1
      @ w,0 say substr(sum,1,125)
      w=w+1
      @ w,0 say substr(lin2,1,125)
    case dziel=2
      @ w,0 say substr(sum,125)
      w=w+1
      @ w,0 say substr(lin2,125)
  endcase
next
RETURN

**




***********************************************************  REJESTR ZAKUPOW  
PROCEDURE REJZAK
local cykl:=0
local str:=1
local sep:= '|----|----------|-------------|-------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
           

konrej=.t.

declare suma[12],folio[12]
pozycja=0
for i=1 to 12
 suma[i]:=0
 folio[i]:=0
next

do tytrejzak with str

*do while .t.
 * cykl=cykl+1
  do while.not.eof()
      pozycja=pozycja+1
      if w>dl
        do ksstopazak
        eject
        w=0
	    str=str+1
	    for i=1 to 12
	      folio[i]=folio[i]+suma[i]
	      suma[i]=0
	    next
	    do tytrejzak with str
      endif

      if.not.substr(ksmod,1,1)$"ra"
	    for k=1 to 8
          suma[k]=suma[k]+ROUND(fieldget(k+28),2)
        next
	  endif	
*      ksexport=.t.
	  if substr(ksmod,1,1)$"ra"
	    suma[12]=suma[12]+ROUND(ks22,2)+ROUND(ks07,2)+ROUND(ks03,2)+ks00+kszw
	  endif	  
      suma[10]=suma[10]+ROUND(ks22,2)+ROUND(ks07,2)+ROUND(ks03,2)+ks00+kszw+ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
      suma[11]=suma[11]+ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)

      do wierszzak
      w=w+1  
      do case
        case dziel=0
          @ w,0 say sep
        case dziel=1
          @ w,0 say substr(sep,1,125)
        case dziel=2
          @ w,0 say substr(sep,125)
      endcase
      w=w+1
	skip
  enddo
do ksstopazak
RETURN


PROCEDURE TYTREJZAK
parameters stron
local lmiesiac:=space(15)
local lms:=ms
if pksiega
  @ w,0 say &zdr_kkond+firnazwa+&zdr_kond
  @ w,pcol()+20 say tytul
  w=w+1
else
  if tytul#space(30)
    @ w,10 say tytul+&zdr_kond 
	w=w+1
  endif
endif


if dziel#2 
  @ w,5 say "REJESTR ZAKUPU TOWAROW I USLUG OPODATKOWANYCH PODATKIEM VAT ZA MIESIAC : "
  do miesiac with lms,lmiesiac
  @ w,80 say lmiesiac
  @ w,pcol()+3 say year(daf)
  @ w,pcol()+1 say "r."
endif
do case
  case dziel=0
    @ w,110 say "Strona :"
    @ w,118 say stron picture "999"
    @ w,135 say fwl
    @ prow()+1,0 say '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '|    |        RACHUNEK   (FAKTURA)          |    ogolna     |                             zakup opodatkowany  w/g stawki      V A T                                                         |               |  Z a k u p y, |'
    @ prow()+1,0 say '|    |--------------------------------------|    wartosc    |-------------------------------------------------------------------------------------------------------------------------------|   podatek     |  za ktore nie |'
    @ prow()+1,0 say '| Lp.|          |   numer     |             |    zakupu     |              22%              |              7%               |              3%               |      0%       |     zw.       |  naliczony    |  przysluguje  |'
    @ prow()+1,0 say '|    |  DATA    |  rachunku   |    N I P    |    brutto     |---------------|---------------|---------------|---------------|-------------------------------|               |               |   ( 7+9 )     |  odliczenie   |'
    @ prow()+1,0 say '|    |          |  (faktury)  |             |               | wartosc netto |     V A T     | wartosc netto |     V A T     | wartosc netto |     V A T     |               |               |               |  podatku VAT  |'
    @ prow()+1,0 say '|----|----------|-------------|-------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
	@ prow()+1,0 say '| 1  |   2      |       3     |      4      |       5       |       6       |        7      |        8      |       9       |       10      |       11      |       12      |       13      |       14      |      15       |'
    @ prow()+1,0 say '|===========================================================================================================================================================================================================================|'
  case dziel=1
    @ w,110 say "Strona A"
	@ w,118 say stron picture "999"
    @ prow()+1,0 say '-----------------------------------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '|    |        RACHUNEK   (FAKTURA)          |    ogolna     |                              zakup opodatkowany  w/g stawki    '
    @ prow()+1,0 say '|    |--------------------------------------|    wartosc    |----------------------------------------------------------------'
    @ prow()+1,0 say '| Lp.|          |   numer     |             |    zakupu     |              22%              |              7%               |'
    @ prow()+1,0 say '|    |  DATA    |  rachunku   |    N I P    |    brutto     |---------------|---------------|---------------|---------------|'
    @ prow()+1,0 say '|    |          |  (faktury)  |             |               | wartosc netto |     V A T     | wartosc netto |     V A T     |'
    @ prow()+1,0 say '|----|----------|-------------|-------------|---------------|---------------|---------------|---------------|---------------|'
	@ prow()+1,0 say '| 1  |   2      |       3     |      4      |       5       |       6       |        7      |        8      |       9       |'
    @ prow()+1,0 say '|===========================================================================================================================|'
  case dziel=2
    @ w,0 say fwl
    @ w,35 say "Strona B"		
	@ w,43 say stron picture "999"
    @ prow()+1,0 say '------------------------------------------------------------------------------------------------'
    @ prow()+1,0 say '   V A T                                                        |               |  Z a k u p y, |'
    @ prow()+1,0 say '|-------------------------------|-------------------------------|    podatek    |  za ktore nie |'
    @ prow()+1,0 say '|              3%               |      0%       |      zw.      |   naliczony   |  przysluguje  |'
    @ prow()+1,0 say '|-------------------------------|               |               |    ( 7+9 )    |  odliczenie   |'
    @ prow()+1,0 say '| wartosc netto |     V A T     |               |               |               |  podatku VAT  |'
    @ prow()+1,0 say '|---------------|---------------|---------------|---------------|---------------|---------------|'
	@ prow()+1,0 say '|       10      |       11      |       12      |       13      |       14      |      15       |'
    @ prow()+1,0 say '|===============================================================================================|'
endcase
*w=10
w=prow()+1
RETURN



PROCEDURE WIERSZZAK
local wtxt:='|    |          |             |             |               |               |               |               |               |               |               |               |               |               |               |'
local wtxt1:='|    |          |             |             |               |               |               |               |               |               |               |               |               |               |               |'
local lz:=0
local lksnaz,lksadr
wtxt=stuff(wtxt,2,4,str(pozycja,4,0))
wtxt=stuff(wtxt,7,10,dtoc(ksdata))
wtxt=stuff(wtxt,18,13,substr(ksdow,1,13))
wtxt=stuff(wtxt,32,13,ksnip)
lz=ROUND(ks22,2)+ROUND(ks07,2)+ROUND(ks03,2)+ks00+kszw+ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
wtxt=stuff(wtxt,46,15,strj(lz))
if substr(ksmod,1,1)$"ra"
  lz=kszakup+ksubocz+kswydsum
  wtxt=stuff(wtxt,206,15,strj(lz))
  wtxt=stuff(wtxt,46,15,strj(lz))
else
  wtxt=stuff(wtxt,62,15,strj(ks22))
  wtxt=stuff(wtxt,78,15,strj(ksvat22))
  wtxt=stuff(wtxt,94,15,strj(ks07))
  wtxt=stuff(wtxt,110,15,strj(ksvat07))
  wtxt=stuff(wtxt,126,15,strj(ks03))
  wtxt=stuff(wtxt,142,15,strj(ksvat03))  
  wtxt=stuff(wtxt,158,15,strj(ks00))
  wtxt=stuff(wtxt,174,15,strj(kszw))
  lz=ROUND(ksvat22,2)+ROUND(ksvat07,2)+ROUND(ksvat03,2)
  wtxt=stuff(wtxt,190,15,strj(lz))  
endif
do case
  case dziel=0
    @ w,0 say wtxt
  case dziel=1
    @ w,0 say substr(wtxt,1,125)
  case dziel=2
    @ w,0 say substr(wtxt,125)		
endcase
if konrej
  lksnaz=stuff(space(31),1,15,substr(ksnaz,1,15))
 * lksnaz=stuff(lksnaz,17,15,substr(ksnaz,16))  
  lksnaz=stuff(lksnaz,16,15,substr(ksnaz,16))  
  lksadr=stuff(space(31),1,15,substr(ksadr,1,15))
 *lksadr=stuff(lksadr,17,15,substr(ksadr,16))    
  lksadr=stuff(lksadr,16,15,substr(ksadr,16))    
  wtxt1=stuff(wtxt1,2,len(alltrim(lksnaz)),alltrim(lksnaz))
  wtxt1=stuff(wtxt1,4+len(alltrim(lksnaz)),len(alltrim(lksadr)),alltrim(lksadr))  
*  wtxt1=stuff(wtxt1,2,len(alltrim(ksnaz)),alltrim(ksnaz))
*  wtxt1=stuff(wtxt1,4+len(alltrim(ksnaz)),len(alltrim(ksadr)),alltrim(ksadr))  
  w=w+1
  do case
    case dziel=0
      @ w,0 say wtxt1
    case dziel=1
      @ w,0 say substr(wtxt1,1,125)
    case dziel=2
      @ w,0 say substr(wtxt1,125)		
  endcase  
endif

RETURN

**
PROCEDURE KS__OPAZAK
local lz:=0
local t[12] 
local  sum:='              |             |               |               |               |               |               |               |               |               |               |               |               |               |'
local lin1:='|---------------------------|    ( 6+8+10)  |---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
local lin2:='              |-------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|---------------|'
for k=1 to 12
   t[k]=0
next
do case
  case dziel=0
    @ w,0 say lin1
  case dziel=1
    @ w,0 say substr(lin1,1,125)
  case dziel=2
	@ w,0 say substr(lin1,125) 
endcase
for i=1 to 3
  sum:='              |             |               |               |               |               |               |               |               |               |               |               |               |               |'

  do case
    case i=1
	  for k=1 to 12
	    t[k]=suma[k]
	  next
      sum=stuff(sum,16,13,"Suma folio   ")
    case i=2
	  for k=1 to 12
	    t[k]=folio[k]
	  next
	  sum=stuff(sum,16,13,"Przen.z folio")
    case i=3
	  for k=1 to 12
	    t[k]=suma[k]+folio[k]
	  next	
	  sum=stuff(sum,16,13," Razem       ")  
  endcase
  lz=t[1]+t[2]
  sum=stuff(sum,30,15,strj(lz))
  sum=stuff(sum,46,15,strj(t[8]))
  sum=stuff(sum,62,15,strj(t[1]))
  sum=stuff(sum,78,15,strj(t[5]))
  sum=stuff(sum,94,15,strj(t[2]))  
  sum=stuff(sum,110,15,strj(t[6]))  
  sum=stuff(sum,126,15,strj(t[3]))      
  sum=stuff(sum,142,15,strj(t[4]))    
  sum=stuff(sum,158,15,strj(t[9]))    
  sum=stuff(sum,174,15,strj(t[10]))    
  w=w+1
  do case
    case dziel=0
      @ w,0 say sum
      w=w+1
      @ w,0 say lin2
    case dziel=1
      @ w,0 say substr(sum,1,125)
      w=w+1
      @ w,0 say substr(lin2,1,125)
    case dziel=2
      @ w,0 say substr(sum,125)
      w=w+1
      @ w,0 say substr(lin2,125)
  endcase
next
RETURN

**

PROCEDURE KSSTOPAZAK
local lz:=0
local t[12] 
local  sum:='              |             |               |               |               |               |               |               |               |               |               |               |               |               |'
local lin1:='|---------------------------|    ( 6+8 )    |---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|'
local lin2:='              |-------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|---------------|'
for k=1 to 12
   t[k]=0
next
do case
  case dziel=0
    @ w,0 say lin1
  case dziel=1
    @ w,0 say substr(lin1,1,125)
  case dziel=2
	@ w,0 say substr(lin1,125) 
endcase
for i=1 to 3
  sum:='              |             |               |               |               |               |               |               |               |               |               |               |               |               |'

  do case
    case i=1
	  for k=1 to 12
	    t[k]=suma[k]
	  next
      sum=stuff(sum,16,13,"Suma folio   ")
    case i=2
	  for k=1 to 12
	    t[k]=folio[k]
	  next
	  sum=stuff(sum,16,13,"Przen.z folio")
    case i=3
	  for k=1 to 12
	    t[k]=suma[k]+folio[k]
	  next	
	  sum=stuff(sum,16,13," Razem       ")  
  endcase
  *lz=t[1]+t[2]
  lz=t[1]+t[2]+t[3]
  sum=stuff(sum,30,15,strj(lz))
  sum=stuff(sum,46,15,strj(t[10]))
  sum=stuff(sum,62,15,strj(t[1]))
  sum=stuff(sum,78,15,strj(t[6]))
  sum=stuff(sum,94,15,strj(t[2]))  
  sum=stuff(sum,110,15,strj(t[7]))  
  sum=stuff(sum,126,15,strj(t[3]))  
  sum=stuff(sum,142,15,strj(t[8]))    
  sum=stuff(sum,158,15,strj(t[4]))      
  sum=stuff(sum,174,15,strj(t[5]))    
  sum=stuff(sum,190,15,strj(t[11]))    
  sum=stuff(sum,206,15,strj(t[12]))    
  w=w+1
  do case
    case dziel=0
      @ w,0 say sum
      w=w+1
      @ w,0 say lin2
    case dziel=1
      @ w,0 say substr(sum,1,125)
      w=w+1
      @ w,0 say substr(lin2,1,125)
    case dziel=2
      @ w,0 say substr(sum,125)
      w=w+1
      @ w,0 say substr(lin2,125)
  endcase
next
RETURN


********************************************POZOSTALE F-KCJE


*******************************************************************************
* Procedura laczy plik ksiega.dbf z plikiem rejestr dbf , indeksuje wg daty,  *
* nadaje kolejna numery.                                                      *
*******************************************************************************
PROCEDURE PLIKSUM
local numer:=0
if file("ksiega.dbf")
  use
  copy file ksiega.dbf to rejsum.dbf
  select 2
  use rejsum
  do while.not.eof()
    if substr(ksnic,2,2)="-R"
	  delete
	endif  
    skip
  enddo
  pack
  go top
  select 1
  use rejestr
  do while.not.eof()
    do przepisz               &&przepisuje aktualny wiersz
    select 1
    skip
  enddo
else
  select 2
  use rejsum    
endif  
select 2
index on ksday to rejsum
use rejsum index rejsum
go top
do while.not.eof()
  numer=numer+1
  replace kspoz with numer
  skip
enddo
go top
RETURN


*******************************************************************************
* Procedura laczy plik ksiega.dbf z plikiem rejestr dbf , indeksuje wg daty,  *
* nadaje kolejna numery.                                                      *
*******************************************************************************
PROCEDURE PLIKSUM1
local numer:=0
if file("ksiega.dbf")
  use
  copy file ksiega.dbf to rejsum.dbf
  select 2
  use rejsum
*  do while.not.eof()
*    if substr(ksnic,2,2)="-R
*	  delete
*	endif  
*    skip
*  enddo
*  pack
*  go top
  select 1
  use rejestr
  do while.not.eof()
    do przepisz               &&przepisuje aktualny wiersz
    select 1
    skip
  enddo
else
  select 2
  use rejsum    
endif  
select 2
index on ksday to rejsum
use rejsum index rejsum
go top
do while.not.eof()
  numer=numer+1
  replace kspoz with numer
  skip
enddo
go top
RETURN


*******************************************************************************
* Procedura przepisuje aktualny rekord z pliku           do pliku o tej samej *
* strukturze otwartego w sel. 41                                              *
*******************************************************************************
PROCEDURE PRZEPISZ
local t[50]		
  for i=1 to fcount()
    t[i]:=fieldget(i)
  next
  select 2
  append blank
  for i=1 to fcount()
    fieldput(i,t[i])
  next
RETURN


