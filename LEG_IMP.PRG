*******************************************************************************
* Program importuje dokumentu z systemu LLEGOS  formacie LEGOS                *
*******************************************************************************
FUNCTION LEG_IMPORT()
local lcolor:=setcolor(),ldatlast:=date(),limp_sciezka:=stuff(space(32),1,len(zimp_sciezka),zimp_sciezka)
local ltyt:="        IMPORT   DOKUMENTOW  Z  SYSTEMU   LEGOS          "
local lplik:="",t[8],q[8],ek
local lznaki:="",lpoz:=1
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
@ 7,14 say "Program zaksi©guje dokumenty zawarte w pilku o nazwie"
@ 8,14 say "        >  T R A N S D O K . D B F  <                "
@ 11,14 say "Sciezka dostepu :"
set cursor on
@ 11,31 get limp_sciezka
read
if.not.lastkey()=27
  zimp_sciezka=limp_sciezka
  set default to
  save to pam
  lplik=alltrim(limp_sciezka)+"transdok.dbf"
  if file(lplik)
    select 0
    use &lplik
    index on DTOC(eddatdok)+edndok to transdok    
*index on str(month(eddatdok))+str(day(eddatdok))+edndok to transdok    
*	index on edndok to transdok    
    set index to transdok
	tra_sel=select()
	save screen to ek
	if kj_gkom(18,"","Plik transmisyjny odnaleziony.","Wyswietlic zawarte w nim dokumenty ?",.t.,5) 
*  dbedit(0,1,23,79,t,"I_FU","",q,"ß",,"ß")
      trans_say()
      restore screen from ek
	endif
    if kj_gkom(18,"","Zatwierdzic import ?","",.t.,5) 
      if file("leg01\zpnn.exe")
	    clear
		use
        lpoz=znaki_menu(lpoz)
		do case
		  case lpoz=2
			do case
			  case empty(limp_sciezka)
			    run leg01\zpnn /o7 transdok.dbf transdok.dbf
			  case alltrim(limp_sciezka)="a:\".or.alltrim(limp_sciezka)="A:\"	
			    run leg01\zpnn /o7 a:\transdok.dbf a:\transdok.dbf
		    endcase 
		  case lpoz=3
			do case  
			  case empty(limp_sciezka)
			    run leg01\zpnn /i7 transdok.dbf transdok.dbf
			  case alltrim(limp_sciezka)="a:\".or.alltrim(limp_sciezka)="A:\"	
			    run leg01\zpnn /i7 a:\transdok.dbf a:\transdok.dbf		  
			endcase 	
		endcase
		restore screen from ek
	    select 0
        use &lplik
        set index to transdok
        tra_sel=select()	  
	  endif
	  
	  if lastrec()=0
        kj_tkom(18," Uwaga!","Plik o nazwie",lplik,"nie zawiera dokumentow do importu.",5)  
        close all
		return 
      endif
	  if.not.leg_pisz()
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

FUNCTION LEG_PISZ()
local lsukces:=.t.,lmiasto:="",lnet_sum:=0
local lksdow,lksnaz,lksadr,lksdata,lksnip
local lks22:=0,lks07:=0,lks03:=0,lks00:=0,lkszw:=0,lksvat22:=0
local lksvat07:=0,lksvat03:=0,lkszak,lksexport
local lkstow:=0,lkszakup:=0
local lksopis:=space(16),lmiesiac
local lksubocz:=0,lksobrot:=0,lksobc:=0,lksrep:=0,lksgot:=0,lksnat:=0
local lkswyd:=0,lkswypos:=0,lkswydsum:=0,lksusl:=0,liledok:=0
local lerejestr:=.t.,leksiega:=.t.
local lzastap_all:=.f.
select &tra_sel
go top
do while.not.eof()
  lkstow=0
  lkszakup=0
  do case
    case zlegtryb="A"
      lks22=enet_a
      lks07=enet_c
      lks03=enet_d
      lks00=enet_e
      lkszw=enet_z
      lksvat22=evat_a
      lksvat07=evat_c
      lksvat03=evat_d
    case zlegtryb="B"
      lks22=enet_a
      lks07=enet_b
      lks03=enet_c
      lks00=enet_d
      lkszw=enet_z
      lksvat22=evat_a
      lksvat07=evat_b
      lksvat03=evat_c  
  endcase
  lksexport=eeksport
  lkszak=.f.
  lkssprzed=.f.
  lnet_sum=enet_a+enet_b+enet_c+enet_d+enet_e+enet_f+enet_z
  do case
    case edekret="7"
	  lkstow=lnet_sum
      lkssprzed=.t.
    case edekret="8"
	  lksusl=lnet_sum
      lkssprzed=.t.	  
    case edekret="10"
	  lkszakup=lnet_sum
      lkszak=.t.
    case edekret="11"
	  lksubocz=lnet_sum
      lkszak=.t.	  
    case edekret="12"
	  lksrep=lnet_sum
      lkszak=.t.	  
    case edekret="13"
	  lksgot=lnet_sum
      lkszak=.t.	  
    case edekret="14"
	  lkswyd=lnet_sum
      lkszak=.t.	  
  endcase
  lksdow=stuff(space(15),1,len(alltrim(edndok)),alltrim(edndok))
  lksdata=eddatdok
  lksnaz=alltrim(eknaz1)+" "+alltrim(eknaz2)
  lksnaz=substr(lksnaz,1,30)
  *lmiasto=alltrim(ekkod)+" "+alltrim(ekmiasto)
  lmiasto=alltrim(ekmiasto)
  lksadr=substr(lmiasto,1,15)+" "+substr(ekulica,1,14)
  lksnip=eknip
  lksopis=eopis
  lmiesiac=month(lksdata)
  lerejestr=erejestr
  leksiega=eksiega
  do pksdefault with lmiesiac
  if leksiega
    use ksiega index ksiega new
  else
    use rejestr index rejestr
  endif	
  *locate for ksdow=lksdow.and.ksnaz=lksnaz.and.ksdata=lksdata.and.ksnip=lksnip
   * locate for alltrim(ksdow)=alltrim(lksdow).and.alltrim(ksnaz)=alltrim(lksnaz).and.ksdata=lksdata.and.alltrim(ksnip)=alltrim(lksnip)
    locate for alltrim(ksdow)=alltrim(lksdow).and.ksdata=lksdata.and.alltrim(ksnip)=alltrim(lksnip)
    if found()
      if.not.lzastap_all
	    if kj_gkom(18," Uwaga!","Dokument "+alltrim(lksdow)+" ju¾ istnieje. Zastapi† ?","Wybierz [Tak] aby zast¥pi† , [Nie] aby dopisa† dokument, Esc - aby pomin¥†",.f.,5)
	      if.not.lastkey()=27.and.kj_gkom(18," Uwaga!","","Zast¥pi† wszystkie ?",.t.,5)
	        lzastap_all=.t.
	      endif     
        else
          if.not.lastkey()=27
	        append blank
	      endif		
	    endif
	  endif
    else
      append blank
    endif	
  if.not.lastkey()=27
    replace ksday with day(lksdata),ksdow with lksdow,ksnaz with lksnaz
    replace ksadr with lksadr,ksopis with lksopis, kstow with lkstow
    replace ksusl with lksusl,kssum with lkstow+lksusl,kszakup with lkszakup
    replace ksubocz with lksubocz,ksobrot with lksobrot,ksobc with lksobc
    replace ksrep with lksrep,ksgot with lksgot,ksnat with lksnat
    replace kswyd with lkswyd,kswypos with lkswypos
    replace kswydsum with lksobc+lksrep+lksgot+lksnat+lkswyd+lkswypos
    replace ksdata with lksdata,ksmod with "KAM",ksnip with lksnip
    replace ks22 with lks22, ks07 with lks07, ks03 with lks03, ks00 with lks00,kszw with lkszw
    replace ksvat22 with lksvat22,ksvat07 with lksvat07,ksvat03 with lksvat03,kszak with lkszak
    replace kssprzed with lkssprzed,ksexport with lksexport 
	replace ksmod with stuff(ksmod,1,1,"F")
	if.not.lerejestr
	  replace ksnic with stuff(ksnic,2,2,"-R")
	endif
	liledok=liledok+1
  endif
  close
  
  @ 0,0 say "Zapisywany dokument : "+lksdow
  select &tra_sel
  skip
enddo
kj_tkom(18," Ok!","Import danych zakonczony pomyslnie.","","Zaimportowano "+alltrim(str(liledok))+" dokum.",5)
RETURN lsukces


**********
FUNCTION TRANS_SAY()
local ek,t[30],q[30]
local lplik:=alltrim(zimp_sciezka)+"transdok"
t[1]:="edndok"
t[2]:="eddatdok"
t[3]:="substr(eopis,1,15)"
t[4]:="enet_a+enet_b+enet_c+enet_d+enet_e+enet_f+enet_z"
t[5]:="evat_a+evat_b+evat_c+evat_d+evat_e+evat_f"
t[6]:="edndow"
t[7]:="eddatdow"
t[8]:="enet_a"
t[9]:="enet_b"
t[10]:="enet_c"
t[11]:="enet_d"
t[12]:="enet_e"
t[13]:="enet_f"
t[14]:="enet_z"
t[15]:="evat_a"
t[16]:="evat_b"
t[17]:="evat_c"
t[18]:="evat_d"
t[19]:="evat_e"
t[20]:="evat_f"
t[21]:="erejestr"
t[22]:="eksiega"
t[23]:="eeksport"

q[1]:="Numer dokumentu"
q[2]:="Data dokumentu"
q[3]:="Opis zdarzenia"
q[4]:="Warto˜† netto"
q[5]:="Podatek VAT"
q[6]:="Numer dowodu"
q[7]:="Data dowodu"
q[8]:="Netto-stawka A"
q[9]:="Netto-stawka B"
q[10]:="Netto-stawka C"
q[11]:="Netto-stawka D"
q[12]:="Netto-stawka E"
q[13]:="Netto-stawka F"
q[14]:="Netto-stawka Z"
q[15]:="VAT-stawka A"
q[16]:="VAT-stawka B"
q[17]:="VAT-stawka C"
q[18]:="VAT-stawka D"
q[19]:="VAT-stawka E"
q[20]:="VAT-stawka F"
q[21]:="Rejestr"
q[22]:="Ksi©ga"
q[23]:="Exsport"


save screen to ek
kj_okno(0,0,24, "  Dokumenty przeznaczone do zaksi©gowania                                       ",2)
set default to
select &tra_sel
*use &lplik
dbedit(1,1,20,78,t,"TR_FU","",q,"ß",,"ß")
restore screen from ek
RETURN 

FUNCTION TR_FU()
local last:=lastkey()
@ 21,2 say "Kontrahent:"
@ 22,2 say space(76)
@ 23,2 say space(76)
@ 22,2 say alltrim(eknaz1)+"  "+eknaz2
@ 23,2 say ekkod+"   "+alltrim(ekmiasto)+"  "+alltrim(ekulica)
@ 21,55 say "Export dokumentu do:"
do case
  case erejestr.and.eksiega
	@ 22,55 say "Ksi©gi i rejestru VAT"
  case erejestr.and..not.eksiega
	@ 22,55 say "Rejestru VAT"	
  case eksiega.and..not.erejestr
	@ 22,55 say "Ksi©gi   P. i R."	
  case .not.eksiega.and..not.erejestr
	@ 22,55 say "                      "
endcase
do case
  case last=27
    return 0
endcase
RETURN 1
*********

FUNCTION ZNAKI_MENU(ppoz)
local ltnaz[3],ltlit[3],ltopis[3],lbelka:="",lpoz:=ppoz
ltnaz[1]:=" BEZ ZMIAN          "
ltnaz[2]:=" MAZIWIA >> LATIN_2 "
ltnaz[3]:=" LATIN_2 >> MAZOWIA "
ltlit[1]:=" B "
ltlit[2]:=" M "
ltlit[3]:=" L "
ltopis[1]:="Polskie znaki s¥ poprawne."
ltopis[2]:="Zmieä standart MAZIWII na standart LATIN_2."
ltopis[3]:="Zmieä standart LATIN_2 na standart MAZOWII."
  lpoz=men_pion(16,30,3,lbelka,ltnaz,ltlit,ltopis,lpoz)
RETURN lpoz