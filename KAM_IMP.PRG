*******************************************************************************
* Program importuje dokumentu z systemu KAMIL w formacie RAKS                 *
*******************************************************************************
FUNCTION KAM_IMPORT()
local lcolor:=setcolor(),ldatlast:=date(),limp_sciezka:=stuff(space(32),1,len(zimp_sciezka),zimp_sciezka)
local ltyt:="      IMPORT   DOKUMENTOW  Z  SYSTEMU   KRAM_2000      "
local lplik:="",t[8],q[8],ek
t[1]:="data_dow"
t[2]:="nr_dowodu"
t[3]:="konto_wn"
t[4]:="kwota"
t[5]:="substr(nazwa_full,1,30)"
t[6]:="substr(kod_miasto,1,15)"
t[7]:="substr(ulica_dom,1,15)"
t[8]:="nr_nip"
q[1]:="Data"
q[2]:="Numer dokumentu"
q[3]:="Konto"
q[4]:="Kwota"
q[5]:="Nazwa kontrahenta"
q[6]:="Adres: miasto"
q[7]:="Adres: ulica"
q[8]:="NIP"
set color to r/g
clear
set color to n/w,w/n
kj_okno(4,12,10,ltyt,1)
@ 7,14 say "Zatwierdz date"
@ 8,14 say "Dokumenty od dnia **.**.** do dnia : "
@ 11,14 say "Sciezka dostepu :"
set cursor on
@ 8,55 get ldatlast
@ 11,31 get limp_sciezka
read
if.not.lastkey()=27
  zimp_sciezka=limp_sciezka
  set default to
  save to pam
  lplik=alltrim(limp_sciezka)+"fk"+substr(dtos(ldatlast),3)+".dbf"
  if file(lplik)
    select 0
    use &lplik
    zrod_sel=select()
	save screen to ek
	if kj_gkom(18,"","Plik transmisyjny odnaleziony.","Wyswietlic zawarte w nim dokumenty ?",.t.,5) 
	  dbedit(0,1,23,79,t,"I_FU","",q,"ß",,"ß")
	  restore screen from ek
	endif
    if kj_gkom(18,"","Zatwierdzic import ?","",.t.,5) 
      if lastrec()=0
        kj_tkom(18," Uwaga!","Plik o nazwie",lplik,"nie zawiera dokumentow do importu.",5)  
        close all
		return 
      endif
	  if.not.kam_pisz()
	    kj_tkom(18," Uwaga!","Import danych nie zakonczony pomyslnie.","Odtworz baze ksiegi z archiwum,","sprawdz plik transmisyjny i ponow probe.",5)
	  endif
	endif
  else
    kj_tkom(18," Uwaga!","Plik o nazwie",lplik,"nie odnaleziony.",5)
  endif	
*  @ 0,0 say lplik
*  inkey(0)
endif
set cursor off
setcolor(lcolor) 
RETURN 

FUNCTION I_FU()
local last:=lastkey()
do case
  case last=27
    return 0
endcase
RETURN 1

FUNCTION KAM_PISZ()
local lsukces:=.t.
*@ 0,0 say "IMPORTUJE"
*INKEY(0)
local lksdow,lksnaz,lksadr,lksdata,lksnip
local lks22:=0,lks07:=0,lks00:=0,lkszw:=0,lksvat22:=0
local lksvat07:=0,lkszak,lksexport
local lkstow:=0,lkszakup:=0
local lksopis:=space(16),lmiesiac
local lksubocz:=0,lksobrot:=0,lksobc:=0,lksrep:=0,lksgot:=0,lksnat:=0
local lkswyd:=0,lkswypos:=0,lkswydsum:=0,lksusl:=0,liledok:=0
go top
do while.not.eof()
  lkstow=0
  lkszakup=0
  lks22=0
  lks07=0
  lks00=0
  lkszw=0
  lksvat22=0
  lksvat07=0
  lksexport=.f.
  lkszak=.f.
  lkssprzed=.f.
  lksdow=nr_dowodu
  lksnaz=substr(nazwa_full,1,30)
  lksadr=substr(kod_miasto,1,15)+substr(ulica_dom,1,15)
  lksdata=data_dow
  lksnip=nr_nip
  do while nr_dowodu=lksdow.and.substr(nazwa_full,1,30)=lksnaz.and.nr_nip=lksnip
    do case
	  case alltrim(konto_wn)=="NET_07_22"
	    lks22=kwota
		lkstow=lkstow+kwota
        lksopis="Sprzedaz towarow"
	    lkssprzed=.t.
	  case alltrim(konto_wn)=="NET_07_07"
	    lks07=kwota
		lkstow=lkstow+kwota
        lksopis="Sprzedaz towarow"		
		lkssprzed=.t.
	  case alltrim(konto_wn)=="NET_07_00".or.alltrim(konto_wn)=="NET_07_00E"
	    lks00=kwota
		lkstow=lkstow+kwota
        lksopis="Sprzedaz towarow"
		lkssprzed=.t.
        if alltrim(konto_wn)=="NET_07_00"
		  lksexport=.f.
		else
		  lksexport=.t.  
		endif
	  case alltrim(konto_wn)=="NET_07_ZW"
	    lkszw=kwota
		lkstow=lkstow+kwota
        lksopis="Sprzedaz towarow"		
		lkssprzed=.t.
	  case alltrim(konto_wn)=="VAT_07_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_07_07"
	    lksvat07=kwota		


	  case alltrim(konto_wn)=="NET_08_22"
	    lks22=kwota
		lksusl=lksusl+kwota
        lksopis="Pozos.przychod"
		lkssprzed=.t.
	  case alltrim(konto_wn)=="NET_08_07"
	    lks07=kwota
		lksusl=lksusl+kwota
        lksopis="Sprzedaz uslug"
		lkssprzed=.t.
	  case alltrim(konto_wn)=="NET_08_00".or.alltrim(konto_wn)=="NET_08_00E"
	    lks00=kwota
		lksusl=lksusl+kwota
        lksopis="Sprzedaz uslug"
		lkssprzed=.t.
        if alltrim(konto_wn)=="NET_08_00"
		  lksexport=.f.
		else
		  lksexport=.t.  
		endif
	  case alltrim(konto_wn)=="NET_08_ZW"
	    lkszw=kwota
		lksusl=lksusl+kwota
        lksopis="Sprzedaz uslug"						
		lkssprzed=.t.
	  case alltrim(konto_wn)=="VAT_08_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_08_07"
	    lksvat07=kwota		
		
		


	  case alltrim(konto_wn)=="NET_10_22"
	    lks22=kwota
		lkszakup=lkszakup+kwota
        lksopis="Zakup towarow"
		lkszak=.t.
	  case alltrim(konto_wn)=="NET_10_07"
	    lks07=kwota
		lkszakup=lkszakup+kwota
        lksopis="Zakup towarow"
		lkszak=.t.
	  case alltrim(konto_wn)=="NET_10_00"
	    lks00=kwota
		lkszakup=lkszakup+kwota
        lksopis="Zakup towarow"
		lkszak=.t.
	  case alltrim(konto_wn)=="NET_10_ZW"
	    lkszw=kwota
		lkszakup=lkszakup+kwota
        lksopis="Zakup towarow"						
		lkszak=.t.
	  case alltrim(konto_wn)=="VAT_10_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_10_07"
	    lksvat07=kwota		

	  case alltrim(konto_wn)=="NET_11_22"
	    lks22=kwota
		lksubocz=lksubocz+kwota
        lksopis="Koszty uboczne"
		lkszak=.t.
	  case alltrim(konto_wn)=="NET_11_07"
	    lks07=kwota
		lksubocz=lksubocz+kwota
        lksopis="Koszty uboczne"
		lkszak=.t.
	  case alltrim(konto_wn)=="NET_11_00"
	    lks00=kwota
		lksubocz=lksubocz+kwota
        lksopis="Koszty uboczne"
		lkszak=.t.				
	  case alltrim(konto_wn)=="NET_11_ZW"
	    lksZW=kwota
		lksubocz=lksubocz+kwota
        lksopis="Koszty uboczne"
		lkszak=.t.		
	  case alltrim(konto_wn)=="VAT_11_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_11_07"
	    lksvat07=kwota				

	  case alltrim(konto_wn)=="NET_12_22"
	    lks22=kwota
		lksrep=lksrep+kwota
        lksopis="Koszty reprez."
		lkszak=.t.
	  case alltrim(konto_wn)=="NET_12_07"
	    lks07=kwota
		lksrep=lksrep+kwota
        lksopis="Koszty reprez."
		lkszak=.t.		
	  case alltrim(konto_wn)=="NET_12_00"
	    lks00=kwota
		lksrep=lksrep+kwota
        lksopis="Koszty reprez."
		lkszak=.t.		
	  case alltrim(konto_wn)=="NET_12_ZW"
	    lkszw=kwota
		lksrep=lksrep+kwota
        lksopis="Koszty reprez."
		lkszak=.t.		
	  case alltrim(konto_wn)=="VAT_12_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_12_07"
	    lksvat07=kwota						
		
	  case alltrim(konto_wn)=="NET_13_22"
	    lks22=kwota
		lksgot=lksgot+kwota
        lksopis="Wynagrodzenie"
		lkszak=.t.		
	  case alltrim(konto_wn)=="NET_13_07"
	    lks07=kwota
		lksgot=lksgot+kwota
        lksopis="Wynagrodzenie"
		lkszak=.t.				
	  case alltrim(konto_wn)=="NET_13_00"
	    lks00=kwota
		lksgot=lksgot+kwota
        lksopis="Wynagrodzenie"
		lkszak=.t.		
	  case alltrim(konto_wn)=="NET_13_ZW"
	    lkszw=kwota
		lksgot=lksgot+kwota
        lksopis="Wynagrodzenie"
		lkszak=.t.				
	  case alltrim(konto_wn)=="VAT_13_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_13_07"
	    lksvat07=kwota						

	  case alltrim(konto_wn)=="NET_14_22"
	    lks22=kwota
		lkswyd=lkswyd+kwota
        lksopis="Pozostale wyd."
		lkszak=.t.		
	  case alltrim(konto_wn)=="NET_14_07"
	    lks07=kwota
		lkswyd=lkswyd+kwota
        lksopis="Pozostale wyd."
		lkszak=.t.				
	  case alltrim(konto_wn)=="NET_14_00"
	    lks00=kwota
		lkswyd=lkswyd+kwota
        lksopis="Pozostale wyd."
		lkszak=.t.				
	  case alltrim(konto_wn)=="NET_14_ZW"
	    lkszw=kwota
		lkswyd=lkswyd+kwota
        lksopis="Pozostale wyd."
		lkszak=.t.		
	  case alltrim(konto_wn)=="VAT_14_22"
	    lksvat22=kwota
	  case alltrim(konto_wn)=="VAT_14_07"
	    lksvat07=kwota						
	endcase
	skip
  enddo
  lmiesiac=month(lksdata)
  do pksdefault with lmiesiac
  use ksiega index ksiega new
  *locate for ksdow=lksdow.and.ksnaz=lksnaz.and.ksdata=lksdata.and.ksnip=lksnip
  locate for alltrim(ksdow)=alltrim(lksdow).and.alltrim(ksnaz)=alltrim(lksnaz).and.ksdata=lksdata.and.alltrim(ksnip)=alltrim(lksnip)
  if found()
    if.not.kj_gkom(18," Uwaga!","Dokument "+alltrim(lksdow)+" juz istnieje. Zastapic ?","Wybierz [Tak] aby zastapic , [Nie] aby dopisac dokument",.f.,5)
      append blank
	endif
  else
    append blank
  endif	
  replace ksday with day(lksdata),ksdow with lksdow,ksnaz with lksnaz
  replace ksadr with lksadr,ksopis with lksopis, kstow with lkstow
  replace ksusl with lksusl,kssum with lkstow+lksusl,kszakup with lkszakup
  replace ksubocz with lksubocz,ksobrot with lksobrot,ksobc with lksobc
  replace ksrep with lksrep,ksgot with lksgot,ksnat with lksnat
  replace kswyd with lkswyd,kswypos with lkswypos
  replace kswydsum with lksobc+lksrep+lksgot+lksnat+lkswyd+lkswypos
  replace ksdata with lksdata,ksmod with "KAM",ksnip with lksnip
  replace ks22 with lks22, ks07 with lks07, ks00 with lks00,kszw with lkszw
  replace ksvat22 with lksvat22,ksvat07 with lksvat07,kszak with lkszak
  replace kssprzed with lkssprzed,ksexport with lksexport 
  close
  liledok=liledok+1
  @ 0,0 say "Zapisywany dokument : "+lksdow
  select &zrod_sel
enddo
kj_tkom(18," Ok!","Import danych zakonczony pomyslnie.","","Zaimportowano "+alltrim(str(liledok))+" dokum.",5)
RETURN lsukces
