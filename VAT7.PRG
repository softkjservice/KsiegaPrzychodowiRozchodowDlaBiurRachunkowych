local lsiac:=month(daf)
local ek,lvat
local N01:=0,N02:=0,N03:=0,N04:=0,N05:=0,N06:=0,N07:=0,N08:=0
local V01:=0,V02:=0,V03:=0,V04:=0,V05:=0,V06:=0,V07:=0,V08:=0
local NS1:=0,NS2:=0,VS1:=0,VS2:=0,kn1:=0,kn2:=0,kv1:=0
local N_ZW:=0,N_0E:=0,N_0K:=0,N_07:=0,N_03:=0,N_22:=0,V_03:=0,V_07:=0,V_22:=0,NSUM:=0,VSUM:=0
local LN01:=0,LN02:=0,ln03:=0,LN04:=0,LN05:=0,LN06:=0,LN07:=0,LN08:=0
local LV01:=0,LV02:=0,LV03:=0,LV04:=0,LV05:=0,LV06:=0,LV07:=0,LV08:=0
local LNS1:=0,LNS2:=0,LVS1:=0,LVS2:=0,Lkn1:=0,Lkn2:=0,Lkv1:=0
local LN_ZW:=0,LN_0E:=0,LN_0K:=0,LN_07:=0,LN_03:=0,LN_22:=0,LV_03:=0,LV_07:=0,LV_22:=0,LNSUM:=0,LVSUM:=0
save screen to ek
do skom with "Zatwierdz miesac do rozliczenia."	  
@ 8,40 say " Za miesiac :    "
set cursor on
@ 8,54 get lsiac picture "99" range 1,12
read 
if lastkey()=27
  restore screen from ek
  return
endif
do pksdefault with lsiac
set cursor off	 
clear
@ 0,0,24,79 box chr(176)
set color to n/w
@ 0,0 say "        D E K L A R A C J A      V A T - 7       za miesac                      "
@ 0,60 say lsiac picture "99"


*      set filter to substr(ksmod,2,1)#"k".and.kswypos=0.and.kssprzed  	  
do pliksum         &&sumuje ksiega+rejestr iotwiera plik w sel.2
do while.not.eof()
  netsum=round(ks22,2)+round(ks07,2)+round(ks03,2)
  vatsum=round(ksvat22,2)+round(ksvat07,2)+round(ksvat03,2)
  do case
    case kszak
     if .not.substr(ksmod,1,1)$"ar"
     do case
      case substr(ksmod,2,1)="k".and.kswypos#0.and..not.zzwolniona  
	        * korekta srodkow trwalych (sp opodatkowana)
         n01=n01+netsum
		 v01=v01+vatsum
      case substr(ksmod,2,1)="k".and.kswypos#0.and.zzwolniona  
	        * korekta srodkow trwalych (sp opodatkowana i zwolniona)
         n05=n05+netsum
		 v05=v05+vatsum
      case substr(ksmod,2,1)="k".and.(kszakup#0.or.ksubocz#0.or.ksrep#0.or.ksgot#0.or.kswyd#0).and..not.zzwolniona
	        * korekta rubryk:10, 11, 12, 13, 14 (sp.odatkowana)
         n02=n02+netsum
		 v02=v02+vatsum
      case substr(ksmod,2,1)="k".and.kszakup#0.and.zzwolniona
	        * korekta rubryk:10 (sp.odatkowana)
         n02=n02+netsum
		 v02=v02+vatsum		 
      case substr(ksmod,2,1)="k".and.(ksubocz#0.or.ksrep#0.or.ksgot#0.or.kswyd#0).and.zzwolniona  
	        * korekta rubryk:11, 12, 13, 14 (sp.odatkowana i zwolniona)
         n06=n06+netsum
		 v06=v06+vatsum		 
      case substr(ksmod,2,1)#"k".and.kswypos#0.and..not.zzwolniona  
	        * zakup srodkow trwalych (sp opodatkowana)
         n03=n03+netsum
		 v03=v03+vatsum
      case substr(ksmod,2,1)#"k".and.kswypos#0.and.zzwolniona  
	        * zakup srodkow trwalych (sp opodatkowana i zwolniona)
         n07=n07+netsum
		 v07=v07+vatsum
      case substr(ksmod,2,1)#"k".and.(kszakup#0.or.ksubocz#0.or.ksrep#0.or.ksgot#0.or.kswyd#0).and..not.zzwolniona
	        * zakup rubryk:10, 11, 12, 13, 14 (sp.odatkowana)
         n04=n04+netsum
		 v04=v04+vatsum
      case substr(ksmod,2,1)#"k".and.kszakup#0.and.zzwolniona
	        * zakup rubryk:10,(sp.odatkowana i zw.)
         n04=n04+netsum
		 v04=v04+vatsum		 
      case substr(ksmod,2,1)#"k".and.(ksubocz#0.or.ksrep#0.or.ksgot#0.or.kswyd#0).and.zzwolniona  
	        * zakup rubryk: 11, 12, 13, 14 (sp.odatkowana)
         n08=n08+netsum
		 v08=v08+vatsum		 		 
	 endcase
	 endif
    case kssprzed	
      if  substr(ksmod,2,1)#"k"
	    n_zw=n_zw+kszw
		if ksexport
		  n_0e=n_0e+ks00
		else
		  n_0k=n_0k+ks00
		endif  
		n_03=n_03+round(ks03,2)		
		n_07=n_07+round(ks07,2)
		n_22=n_22+round(ks22,2)
		v_03=v_03+round(ksvat03,2)
        v_07=v_07+round(ksvat07,2)
		v_22=v_22+round(ksvat22,2)
	  else
	    kn1=kn1+ks00+ks03+ks07+ks22
		kn2=kn2+kszw
		kv1=kv1+round(ksvat22,2)+round(ksvat07,2)+round(ksvat03,2)
	  endif

  endcase
  skip
enddo

    ln_zw=round(n_zw,0)
    ln_0e=round(n_0e,0)
    ln_0k=round(n_0k,0)
    ln_03=round(n_03,0)
    ln_07=round(n_07,0)
    ln_22=round(n_22,0)
    lv_03=round(v_03,0)
    lv_07=round(v_07,0)
    lv_22=round(v_22,0)

    ln01=round(n01,0)
    ln02=round(n02,0)
    ln03=round(n03,0)
    ln04=round(n04,0)
    ln05=round(n05,0)
    ln06=round(n06,0)
    ln07=round(n07,0)
    ln08=round(n08,0)
    lv01=round(v01,0)
    lv02=round(v02,0)
    lv03=round(v03,0)
    lv04=round(v04,0)
    lv05=round(v05,0)
    lv06=round(v06,0)
    lv07=round(v07,0)
    lv08=round(v08,0)
    lkn1=round(kn1,0)
    lkn2=round(kn2,0)
    lkv1=round(kv1,0)
grosz=.f.
do while.t.
  do vattlo
  if grosz
    @ 7,19 say n01 picture "99999.99"
    @ 10,19 say n02 picture "99999.99"
    @ 13,19 say n03 picture "99999.99"
    @ 16,19 say n04 picture "99999.99"
    @ 7,27 say v01 picture "99999.99"
    @ 10,27 say v02 picture "99999.99"
    @ 13,27 say v03 picture "99999.99"
    @ 16,27 say v04 picture "99999.99"
    @ 7,35 say n05 picture "99999.99"
    @ 10,35 say n06 picture "99999.99"
    @ 13,35 say n07 picture "99999.99"
    @ 16,35 say n08 picture "99999.99"
    @ 7,43 say v05 picture "99999.99"
    @ 10,43 say v06 picture "99999.99"
    @ 13,43 say v07 picture "99999.99"
    @ 16,43 say v08 picture "99999.99"
  
    @ 5,63 say n_zw picture "99999.99"
    @ 7,63 say n_0e picture "99999.99"
    @ 9,63 say n_0k picture "99999.99"
    @ 11,63 say n_03 picture "99999.99"
    @ 13,63 say n_07 picture "99999.99"	
    @ 15,63 say n_22 picture "99999.99"
    @ 11,72 say v_03 picture "99999.99"
    @ 13,72 say v_07 picture "99999.99"	
    @ 15,72 say v_22 picture "99999.99"
 
    @ 19,63 say n_zw+n_0e+n_0k+n_03+n_07+n_22+kn1+kn2 picture "99999.99"
    @ 19,72 say v_03+v_07+v_22+kv1 picture "99999.99"
    @ 21,63 say kn1 picture "99999.99"
    @ 22,63 say kn2 picture "99999.99"
    @ 21,72 say kv1 picture "99999.99"

    @ 19,19 say n01+n02+n03+n04 picture "99999.99"
    @ 19,27 say v01+v02+v03+v04 picture "99999.99"
    @ 19,35 say n05+n06+n07+n08 picture "99999.99"
    @ 19,43 say v05+v06+v07+v08 picture "99999.99"
  
  else
    @ 7,19 say ln01 picture "9999999"
    @ 10,19 say ln02 picture "9999999"
    @ 13,19 say ln03 picture "9999999"
    @ 16,19 say ln04 picture "9999999"
    @ 7,27 say lv01 picture "9999999"
    @ 10,27 say lv02 picture "9999999"
    @ 13,27 say lv03 picture "9999999"
    @ 16,27 say lv04 picture "9999999"
    @ 7,35 say ln05 picture "9999999"
    @ 10,35 say ln06 picture "9999999"
    @ 13,35 say ln07 picture "9999999"
    @ 16,35 say ln08 picture "9999999"
    @ 7,43 say lv05 picture "9999999"
    @ 10,43 say lv06 picture "9999999"
    @ 13,43 say lv07 picture "9999999"
    @ 16,43 say lv08 picture "9999999"
  
    @ 5,63 say ln_zw picture "9999999"
    @ 7,63 say ln_0e picture "9999999"
    @ 9,63 say ln_0k picture "9999999"
    @ 11,63 say ln_03 picture "9999999"
    @ 13,63 say ln_07 picture "9999999"
    @ 15,63 say ln_22 picture "9999999"
    @ 11,72 say lv_03 picture "9999999"
    @ 13,72 say lv_07 picture "9999999"	
    @ 15,72 say lv_22 picture "9999999"
 
    @ 19,63 say ln_zw+ln_0e+ln_0k+ln_03+ln_07+ln_22+lkn1+lkn2 picture "9999999"
    @ 19,72 say lv_03+lv_07+lv_22+lkv1 picture "9999999"
    @ 21,63 say lkn1 picture "9999999"
    @ 22,63 say lkn2 picture "9999999"
    @ 21,72 say lkv1 picture "9999999"

    @ 19,19 say ln01+ln02+ln03+ln04 picture "9999999"
    @ 19,27 say lv01+lv02+lv03+lv04 picture "9999999"
    @ 19,35 say ln05+ln06+ln07+ln08 picture "9999999"
    @ 19,43 say lv05+lv06+lv07+lv08 picture "9999999"

endif

if zzwolniona
  N=N_ZW+N_0E+N_0K+N_03+N_07+N_22+KN1
  ZW=N_ZW+KN2
  K=100*((N-ZW)/N)
  @ 22,5 say "K="
  @ 22,7 say k picture "999.99"
  @ 22,14 say "%"
else
  k=100
endif

do skom with " Grosze    Zlote     Esc "
inkey(0)
  do case
    case lastkey()=-1
      @ 23,5 say "VAT="
	  @ 23,10 say (lv_03+lv_07+lv_22+lkv1)-((lv01+lv02+lv03+lv04)+(lv05+lv06+lv07+lv08)*k/100) picture "999 999 999"
*(vat nalezny)-((vat naliczony - zakupy zwiazane wylacznie ze sprzedaza opodatkowana)+
*(vat naliczony - zakupy zwiazane ze sp. opodatkowana i zw)*wspolczynnik wynikajacy
*ze stosunku sprzedazy opodatkowanej do sp. calkowitej)
      do skom with "Nacisnij dowolny klawisz."
      inkey(0)
    case lastkey()=27
	  exit
	case lastkey()=71.or.lastkey()=103
	  grosz=.t.   
	case lastkey()=90.or.lastkey()=122
	  grosz=.f.   	  
  endcase
enddo

do tkom with "OK!"
restore screen from ek
do ksdefault
close databases
RETURN 

PROCEDURE VATTLO
set color to (coldef)
@ 1,1  say"=============================================================================="
@ 2,1  say"                 | ZAKUPY  ZWIAZANE ZE SPRZEDAZA ||       S P R Z E D A Z     "
@ 3,1  say"                 | OPODATKOWANA  | OPOD. i ZWOLN.||  STAWKA   | NETTO |  VAT  "
@ 4,1  say"                 |-------------------------------||-----------|-------|-------"
@ 5,1  say" R U B R Y K A   | NETTO |  VAT  | NETTO |  VAT  || ZWOLNIONA |       |       "
@ 6,1  say"-----------------|-------|-------|-------|-------||-----------|-------|-------"
@ 7,1  say"KOREKTA SRODKOW  |       |       |       |       || EXPORT 0% |       |       "
@ 8,1  say"TRWALYCH         |       |       |       |       ||-----------|-------|-------"
@ 9,1  say"-----------------|-------|-------|-------|-------|| KRAJ   0% |       |       "
@ 10,1 say"KOREKTA POZOSTA- |       |       |       |       ||-----------|-------|-------"
@ 11,1 say"LYCH ZAKUPOW     |       |       |       |       ||        3% |       |       "
@ 12,1 say"-----------------|-------|-------|-------|-------||-----------|-------|-------"
@ 13,1 say"ZAKUP SRODKOW    |       |       |       |       ||        7% |       |       "
@ 14,1 say"TRWALYCH         |       |       |       |       ||-----------|-------|-------"
@ 15,1 say"-----------------|-------|-------|-------|-------||       22% |       |       "
@ 16,1 say"POZOSTALE        |       |       |       |       ||-----------|-------|-------"
@ 17,1 say"    ZAKUPY       |       |       |       |       || CZESC. ZW.|       |       "
@ 18,1 say"=================|=======|=======|=======|=======||===========|=======|======="
@ 19,1 say"   R A Z E M :   |       |       |       |       || R A Z E M |       |       "
@ 20,1 say"==============================================================================" 
@ 21,1 say"                                                 ||KOR.SP.OPOD|       |       "
@ 22,1 say"                                                 ||KOR.SP.ZWOL|       |       "
@ 23,1 say"                                                 ||==========================="
for i=1 to 23
  @ i,79 say chr(176)
next
RETURN



*"=============================================================================="
*"                 | ZAKUPY  ZWIAZANE ZE SPRZEDAZA ||       S P R Z E D A Z     "
*"                 | OPODATKOWANA  | OPOD. i ZWOLN.||        3%   N_03          "
*"                 |-------------------------------||---------------------------"
*" R U B R Y K A   | NETTO |  VAT  | NETTO |  VAT  ||  STAWKA   | NETTO |  VAT  "
*"-----------------|-------|-------|-------|-------||-----------|-------|-------"
*"KOREKTA SRODKOW  |  N01  |  V01  | N05   | V05   || ZWOLNIONA | N_ZW  |       "
*"TRWALYCH         |       |       |       |       ||-----------|-------|-------"
*"-----------------|-------|-------|-------|-------|| EXPORT 0% | N_0E  |       "
*"KOREKTA POZOSTA- |  N02  |  V02  |  N06  | V06   ||-----------|-------|-------"
*"LYCH ZAKUPOW     |       |       |       |       || KRAJ   0% | N_0K  |       "
*"-----------------|-------|-------|-------|-------||-----------|-------|-------"
*"ZAKUP SRODKOW    |  N03  |  V03  |  N07  | V07   ||        7% | N_07  |  V_07 "
*"TRWALYCH         |       |       |       |       ||-----------|-------|-------"
*"-----------------|-------|-------|-------|-------||       22% | N_22  |  V_22 "
*"POZOSTALE        |  N04  |  V04  |  N08  | V08   ||-----------|-------|-------"
*"    ZAKUPY       |       |       |       |       || CZESC. ZW.|       |       "
*"=================|=======|=======|=======|=======||===========|=======|======="
*"   R A Z E M :   | NS1   |  VS1  | NS2   |  VS2  || R A Z E M | NSUM  | VSUM  "
*"==============================================================================" 
*"                                                 ||KOR.SP.OPOD| KN1   | KV1   "
*"                                                 ||KOR.SP.ZWOL| KN2   | KV2   "
*"                                                 ||==========================="
 