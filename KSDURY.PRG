PROCEDURE TLOMFA
clear
@ 0,0 say replicate(chr(176),80)
for i=1 to 23
  @ i,0 say chr(176)
  @ i,79 say chr(176)
next
@ 20,1 say replicate(chr(205),78)
set color to n/w
@ 24,0 say space(80)
set color to
do tlomfa1
RETURN

PROCEDURE TLOMFA1
@ 21,2 say "Wartosc bez VATU.."
@ 22,2 say "Rodzaj platnosci.."
@ 23,2 say "Niedoplata........"
@ 21,40 say"Termin platnosci.."
@ 22,40 say"Ostatnia wplata..."
@ 23,40 say"Numer konta......."
RETURN

PROCEDURE DOKLICZ
parameters pnet_22,pnet_07,pvat_22,pvat_07
local lbrut_22:=0
local lbrut_07:=0
    if substr(ndok,12,1)="R".or..not.vvt
      lbrut_22=ROUND(dnet_22/(1-0.1803),2)
	  lbrut_07=ROUND(dnet_07/(1-0.0654),2)
      pvat_22=0.1803*lbrut_22
	  pvat_07=0.0654*lbrut_07
      pnet_22=lbrut_22-pvat_22
	  pnet_07=lbrut_07-pvat_07
	else
      pnet_22=dnet_22
	  pnet_07=dnet_07
	  if substr(ndok,12,1)#"r"
        pvat_22=dnet_22*0.22
        pvat_07=dnet_07*0.07	  
	  else
	    pvat_22=0
		pvat_07=0
	  endif	
    endif
RETURN

PROCEDURE FIRMEMNEW
*local lremzer,lremakt,lvatzer,lvatzap,lvat,lryczlt
select 100
create nowa
use nowa 
append blank
replace field_name with "remzer"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "remakt"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "vatzer"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "vatzap"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ksnum1"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ksnum2"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ksnum3"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2

append blank
replace field_name with "vat"
replace field_type with "L"
replace field_len with 1
append blank
replace field_name with "ryczalt"
replace field_type with "L"
replace field_len with 1
append blank
replace field_name with "zwolniona"
replace field_type with "L"
replace field_len with 1
append blank
replace field_name with "siec"
replace field_type with "L"
replace field_len with 1
append blank
replace field_name with "kslog1"
replace field_type with "L"
replace field_len with 1
append blank
replace field_name with "kslog2"
replace field_type with "L"
replace field_len with 1
append blank
replace field_name with "kslog3"
replace field_type with "L"
replace field_len with 1

append blank
replace field_name with "ksopis1"
replace field_type with "C"
replace field_len with 20
append blank
replace field_name with "ksopis2"
replace field_type with "C"
replace field_len with 20
append blank
replace field_name with "ksopis3"
replace field_type with "C"
replace field_len with 20

append blank
replace field_name with "ksdat1"
replace field_type with "D"
replace field_len with 8
append blank
replace field_name with "ksdat2"
replace field_type with "D"
replace field_len with 8
append blank
replace field_name with "ksdat3"
replace field_type with "D"
replace field_len with 8

create ksmem from nowa
close
plik=stuff(space(16),1,7,kssciezka)
plik=stuff(plik,8,9,"\nowa.dbf")
erase &plik

if file("firmem.dbf")
  use firmem
  lremzer=remzer
  lremakt=remakt
  lvatzer=vatzer
  lvatzap=vatzap
  lvat=vat
  lryczalt=ryczalt
  use ksmem
  append blank
  replace remzer with lremzer,remakt with lremakt,vatzer with lvatzer
  replace vatzap with lvatzap,vat with lvat,ryczalt with lryczalt
  close
  plik=stuff(space(18),1,7,kssciezka)
  plik=stuff(plik,8,11,"\firmem.dbf")
  erase &plik
endif

RETURN