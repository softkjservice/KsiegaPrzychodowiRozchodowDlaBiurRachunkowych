PROCEDURE KONTTLO1
     if kolor=0  
	   set color to n/w
     else
	   set color to (coldef)
	 endif  
	   for i=9 to 23
         @ i,24 say replicate(chr(178),55)
       next
       set color to (coldef)
       @ 10,26 say "     D A N E    K O N T R A H E N T A    nr        "

       @ 11,26 say " ------------------------------------------------- "
       set color to n/w
	   
       @ 24,0 say space(80)
       @ 12,26 say " NAZWA............                              .  "
       @ 13,26 say " NIP....             .           |                 "
       @ 14,26 say " KOD POCZTOWY.....  -   .        |                 "
       @ 15,26 say " ADRES............                              .  "	   
       @ 16,26 say " GRUPA..     .............TEL....               .  "
       @ 17,26 say " PAGER..               .  FAX....               .  "      
       @ 18,26 say " KONTO..                                        .  "
       @ 19,26 say " KONTO (CD).................                    .  "
       @ 20,26 say " SKROT ...........               .                 "
       @ 21,26 say "                                                   "	   
       set color to
RETURN	   


*******************************************************************************
* Procedura wprowadza zmienne kontrahenta i generuje skroty nazwy i adresu    *
*******************************************************************************
PROCEDURE KONTRAHGET
local lnaz1:=substr(znaz1,1,15)
local lnaz2:=substr(znaz1,16)
set color to n/w     
  @ 20,54 say substr(zkkonto,41,20)
set color to n/w
       set cursor on
       @ 12,44 get lnaz1 picture "@!"
       @ 12,59 get lnaz2 picture "@!"
       @ 13,34 get znip picture "@!" 
	   @ 14,44 get zkod picture "@!" 	   	   
       @ 15,44 get zmiasto picture "@!"
	   @ 16,34 get zgrupa picture "@!" 
       @ 16,59 get ztel picture "@!" 
       @ 17,34 get zpager picture "@!" 
       @ 17,59 get zfax picture "@!" 
       @ 18,34 get zkkonto picture "@S40"
       @ 20,44 get znskrot picture "@!" 
       read
	   znaz1=stuff(space(30),1,15,lnaz1)
   	   znaz1=stuff(znaz1,16,15,lnaz2)
       if znskrot=space(15)
	     if znip#space(13)
		   znskrot=substr(znip,9)
		 else
		   znskrot=substr(zulica,1,15)
		 endif
         set color to n/w  
         @ 21,44 say znskrot 
         set color to 
       endif
       set color to n/w
	   @ 20,54 say substr(zkkonto,41,20)
	   set color to (coldef)
RETURN	   


*******************************************************************************
* Procedura bada istnienie rekordu po zafiltrowaniu                           *
*******************************************************************************
PROCEDURE PUSTY
parameters ppusty
local recno:=recno(),lile:=0
go top
do while.not.eof()
  lile=lile+1
  skip
enddo
if lile>0
  ppusty=.f.
else
  ppusty=.t.
endif
go recno
RETURN