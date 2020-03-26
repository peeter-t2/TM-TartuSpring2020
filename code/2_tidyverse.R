#' ---
#' title: "R ja RStudio"
#' author: "Peeter Tinits"
#' output: html_document
#' ---
#' 
#' # Tidyverse paketid
#' 
#' ## Paketid
#' 
#' Selles peatükis teeme algust tidyverse paketi kasutamisega. Paketid annavad R-i kasutades olulisi lisavõimalusi nagu sai kirjeldatud eelmises peatükis.
#' 
#' Iga pakett tuleb kõigepealt installida. Tavapakettide puhul piisab selleks käsust install.packages(), millele tuleb sisendiks anda paketi nimi jutumärkides. Käivitage järgnev käsk. Kui tidyverse pole arvutisse varem installitud, installib R selle nüüd. Kui pakett on juba installitud, püüab R seda uuendada.
#' 
#' 
## ---- eval=F-----------------------------------------------------------------------
## 
## install.packages("tidyverse")
## 

#' 
#' Paketi sisselugemiseks kasutame funktsiooni library(). Peaaegu samaväärne funktsioon on require() kui mõnikord skriptides on just seda kasutatud. Loeme kõigepealt sisse library(tidyverse).
#' 
## ----------------------------------------------------------------------------------

library(tidyverse)


#' 
#' Tidyverse loetleb avamisel avatud paketid ja mainib paari konflikti teiste pakettide pärast, mille pärast Sa ei pea parasjagu muretsema. Kontrolli, kas Su konsoolis näitas midagi sarnast nagu siin juhendis ülal.
#' 
#' Vajalikud paketid tuleb avada iga kord pärast Rstudio käivitamist, R ei tee eeldusi selle kohta, milliseid pakette Sul võiks vaja minna..
#' 
#' ### Tidyverse arvutiklassis
#' 
#' Mõnede pakettide installimine nõuab arvutis rohkem kui tavakasutaja ligipääsu. Hiljaeaegu sai ka Tidyverse nende pakettide hulka ja kui ligipääsuõiguseid ei ole, nagu näiteks arvutiklassis, siis on vaja teha veel järgmist. Isiklikus arvutis ei ole tõenäoliselt seda vaja teha. Kui tidyverse sisselaadimine ülal töötas, jäta see osa vahele.
#' 
#' JUHUL KUI eelolev ei töötanud täpselt nii nagu oodatud, siis väljuge Rstudiost ja käivitage see uuesti ning kontrollige järgmist:
#' 
#' 1. Mine kohta: "C:/Users/Public/Documents/" (kopeeri see asukohareale) 
#' 2. Kas on kataloog nimega "Rstudio_packages". Kui seda ei ole, siis tee see.
#' 3. Jooksuta järgmist käsku.
#' 
## ----eval=F------------------------------------------------------------------------
## 
## .libPaths("C:/Users/Public/Documents/Rstudio_packages")
## 

#' 
#' See määrab, et R otsib oma pakette just sealt kataloogist. Ja ka uued paketid installitakse sinna. Arvutiklassis on seda vaja, kuna sinu kasutajal ei ole arvuti juures kõiki õigusi. Juhul kui paketid olid varem installitud mujale, ei pruugi R neid enam üles leida ning vastavalt proovib neid sinna installida. Isiklikul arvutil seda tõenäoliselt ei ole vaja teha ning kui ligipääsuprobleeme pole, ärge seda käsku käivitage.
#' 
#' Pärast selle määramist proovi installida *tidyverse* paketti uuesti. Uue asukohaga peaks installimine töötama ja paketi saab siis sisse lugeda.
#' 
#' 
#' ## R ja andmed
#' 
#' Kuigi R-i võib kasutada ka lihtsateks numbriarvutusteks, siis üldiselt kasutatakse R-i tööks andmistekega. Andmestikud on enamasti salvestatud failidesse teatud formaadis (näiteks .csv, .tsv või .xls). Faili sisse lugemiseks on hulk erinevaid käske ja on vähe failitüüpe, millest R pakettide abiga jagu ei saa. Praegu on meil fail .tsv formaadis ja selle lugemiseks sobib meile käsk read_tsv().
#' 
## ----------------------------------------------------------------------------------

read_tsv("data/eesti_top40/eesti_skyplus_top40_1994-2018.tsv")


#' 
#' Siit saime kaks väljatrükki. Esiteks tabeli enda kohta - read_tsv() ütleb, mis tüüpi andmetulpasid ta failist leidis. Siin antud juhul col_character() ehk tekstitulp ja col_double() ehk numbritulp. Oodatavat tüüpi saab ka lugemisel ise määrata. Ja teise asjana trükkis ta välja andmestiku enda, kus näeme, et andmed näevad välja, nagu oodata.
#' 
#' Andmestiku salvestamiseks kasutame tuttavat noole <- tähist. Siis on meil edaspidi andmestik kättesaadav muutuja *edetabel* all.
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel <- read_tsv("data/eesti_top40/eesti_skyplus_top40_1994-2018.tsv")


#' 
#' RStudios näete nüüd "environment" väljal, paremal ülal, et sinna on ilmunud sektsioon 'data' ning selle alla muutuja 'edetabel, kus on 1000 vaatlust ja 9 muutujat ehk 1000 rida ja 9 tulpa. Kui vajutate RStudios hiirega selle peale, avaneb see tabelina ülevaatuseks. Skriptiaknas, vaskul ülal, on nüüd uus sälk andmetele ning tagasi koodifaili saab vajutades koodifaili sälgule. (Selleks saab kasutada ka Ctrl+Tab ja Shift+Ctrl+Tab). 
#' 
#' Muu hulgas näete, et konsoolis jooksis uus käsk
#' 
#'     View(edetabel)
#' 
#' View käsk näitab andmemuutuja sisu eraldi aknas. Proovi kirjutada konsooli sama käsk. 
#' 
## ----------------------------------------------------------------------------------

View(edetabel)


#' 
#' Ülevaatest on näha, et tabelis on järgmised tulbad.
#' 
#' - year - edetabeli aasta
#' - rank - koht edetabelis
#' - votes - häälte arv (kui on)
#' - artist - esineja
#' - song - loo pealkiri
#' - filename - faili nimi hoidlas
#' - source - sõnade allikas (1 - Sasslantis, 2 - muu)
#' - lyrics - laulusõnad
#' - language - keel (et - eesti, en - inglise)
#' 
#' ## Tidy andmestruktuurid
#' 
#' Tidy ehk puhtad andmestruktuurid on kujunenud välja andmeanalüütikute vajadustest. Nimelt taipasid mõned neist, et kui andmestikke salvestatakse pidevalt väga erinevatel kujudel - igaüks mõtleb välja oma viisi - siis andmeanalüüsi jaoks on hea kui nad on suhteliselt samas formaadis ja ehk mida lihtsam seda parem. Tidy andmeloogika on võtnu omaks põhimõtte, et iga andmepunkti kohta võiks olla üks rida ja iga mõõdiku kohta üks tulp. Vastavalt sellele, mida me täpselt tahame teada saada võib erineda see, mis on meie andmepunkt. Andmepunktiks võiks olla näiteks majandusnäitajate Harju keskmine 1990ndate jooksul või siis Eesti riigi koondnäitaja 2019 aasta esimeses kvartalis. Meid võib huvitada üks tekst, üks lause või üks sõna. 
#' 
#' Tidy andmeloogika järgi püütakse siis andmestik ümber kujundada selliselt, et ükskõik mida me teada tahame oleks sel sama struktuur
#' 
#' - Iga rida on üks vaatlus (selle kohta, mida me tahame vaadelda).
#' - Iga tulp on üks vaatluse omadus või omadustekomplekt.
#' 
#' Illustratsioon sellest on juhendis all. Kui seda vaadata, võiks mõelda, et kuidas saaks üldse teisiti. Aga andmestikke on koostatud ja koostatakse pidevalt väga erinevates viisides, mis toimivad ehk ühe koostaja või sisestaja jaoks, aga ei pruugi tunduda teistele sama head. Tidy andmeloogika üritab pakkuda lihtsaimat reeglit, mille järgi orienteeruda.
#' 
#' ![](figures/tidy_data.png)
#' 
#' 
#' ## Tidyverse andmetöötlus
#' 
#' Tidyverse üritab leida ühise aluse ka andmetöötlusele. Eelkõige üritab tidyverse andmetöötluse jaotada selgelt järjestikku operatsioonidest ning järgida *literate programming* loogikat. Selle loogika järgi peaks masinale mõeldud kood olema lihtsalt ja selgelt loetav ka inimese jaoks. Tidyverse püüab ühtse käskude grammatika järgi aidata nii algajal oskusi omandada kui panna andmeid omavahel ühtima. Kuigi tidyverse kood püüab hoida lihtsat ja arusaadavat kuju, ei tähenda, et selle võimekus oleks piiratud. Peaaegu iga käsku on võimalik kirjutada ka tidyverse viisil.
#' 
#' Tidyverse stiilis töötlusel näeb üks R-i käskudekomplekt välja järgmine.
#' 
#'     andmed %>%
#'       protsess1() %>%
#'       protsess2()
#' 
#' Alustuseks on R-is sisse loetud andmed, siis nendega tehakse protsess1() ja siis protsess2(). Selle järjestuse juhendamiseks kasutab tidyverse toru %>% funktsiooni mis suunab andmestiku protsessi ning selle protsessi tulemuse omakorda protsessi. Üks viis selles mõelda on nii, et muutujad on nimisõnad ja protsessid on tegusõnad ja kokkuvõttes huvitab meid, mis algsest nimisõnalisest tegelasest saab.
#' 
#' Andmete töötlemiseks kasutame niisiis rea lõpus toru %>% funktsiooni. Selle võib trükkida välja või võib vajutada korraga ka Ctrl+Shift+M mis asetab %>% torumärgi teksti.
#' 
#' Töötluse näites, kui me trükime edetabel %>% names(), saame andmestiku kõikide tulpade nimed jadana. Proovi järgi: mine reale ja vajuta Ctrl+Enter. R teab, et %>% torumärgile peaks järgnema veel käsk ja ta loeb seda edasi, isegi kui selleks peab minema järgmisele reale. Seda ära kasutades ning töötluse loetavuse nimel paigutatakse tidyverse stiilis iga käsk eraldi reale. Kui koostad keerulise funktsiooni, võid küll sellest ise kergesti aru saada, aga juhuslikule lugejale on palju kergem kui kõik operatsioonid on selgelt eraldatud.
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  names()


#' 
#' 
#' ## filter(), select(), unique(), sample_n()
#' 
#' Teades põhiprintsiipi lähebki vaja hakata operatsioone omavahel kombineerima ja järjestama, et saada andmestikust kätte täpselt seda informatsiooni, mida vaja. Võtame alustuseks neli käsku, mis on mõeldud tabeli osade valimiseks ja loendamiseks. Nimelt filter(), count(), select(), unique().
#' 
#' -  %>% - viib andmed järgmisesse protsessi
#' - select() valib tunnused andmestikust
#' - filter() viib andmestiku läbi filtri/sõela
#' - unique() - võtab tabelist ainult unikaalsed read
#' - sample_n() - võtab ettemääratud suurusega hulga ridu tabelist
#' 
#' 
#' Käsk select() valib andmestikust teatud tulbad. Seda võib teha nime kaudu või mingil muul alusel, nii võib saada ühe või mitu tulpa. Kirjutades select(year) toru järgi valime siis year-nimelise tulba, ehk tulba kus on aastaarvud.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  select(year)


#' 
#' Käsk unique() valib andmestikust kõik read, mis on unikaalse. Näiteks valides unikaalsed read aasta tulbast saame jada 25-st erinevast aastast, mis on andmestikus.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  select(year) %>% 
  unique()


#' 
#' Kui me võtame unikaalsed read tervest andmestikust, saame vastuseks sama andmestiku, kuna kõik read on seal unikaalsed.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  unique()


#' 
#' Kui me soovime kätte saada mingeid konkreetseid ridu, mis vastavad teatud tunnustele, võime andmestiku läbi lasta filter() käsust. Sellisel juhul peame filter() sisse kirjutama tingimuse, mis peab vastama kas tõele või väärale ehk see peab kontrollima võrdsust nagu eelmises tükis sai näidatud.
#' 
#' Näiteks, kui me tahame leida kõiki Smilersi lugusid võime me otsida välja kõik read, kus tunnus artist on sama kui tekst "Smilers". Tähtis on selle päringu juures, et see tunnus peab olema täpselt sama. Pane tähele ka, et siin on siis kasutatud topeltvõrdumärki ==.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(artist=="Smilers")


#' 
#' Kui me kasutame nime smilers väikse algustähega, siis me neid tulemusi ei leia, kuna tulemus pole täpselt sama. Kui me suurest või väiksest algustähest ei hooli, võime muuta terve tunnuse selliseks, et tal on väike algustäht või kasutada regulaaravaldisi vaste leidmiseks. Sellest on näiteid hiljem.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(artist=="smilers")


#' 
#' Proovi nüüd ise leida kõik Ummamuudu lood, kirjutades sarnane koodijupp siia alla.
#' 
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------




#---------------------------------------------


#' 
#' 
#' Me võime ka kombineerida omavahel filter() ja select(), et saata väiksema ülevaate tabelist. Näiteks võime võtta välja kõikide Smilersi lugude aastad ja pealkirjad.
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers") %>% 
  select(year,song)


#' 
#' Neid käske võib ka korduvalt lisada. Näiteks saame võtta kõigepealt Smilersi lood ja siis nende seast välja ainult lood, mis olid edetabelis aastal 1998.
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers") %>% 
  select(year,song) %>% 
  filter(year==1998)


#' 
#' Või näiteks 2000 ja 2008 aasta vahel.
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers") %>% 
  select(year,song) %>% 
  filter(year>2000) %>% 
  filter(year<2008)


#' 
#' Soovi korral võib mitu filtrit ka ühendada ühte käsku. Sel juhul tuleb kasutada & märki nende ühendamiseks. 
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers") %>% 
  select(year,song) %>% 
  filter(year>2000 & year<2008)


#' 
#' Me võime ka kõik filtrid panna kokku ühte käsku
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers" & year>2000 & year<2008) %>% 
  select(year,song)


#' 
#' Filtrite puhul võime kasutada ka või | märki. Näiteks võime sama käsku väljedada ka mitte piirkondadega, vaid andes ette võimalikud variandi võiga.
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers") %>% 
  select(year,song) %>% 
  filter(year==2001 | year==2002 | year==2003 | year==2004 | year==2005 | year==2006 | year==2007)


#' 
#' Viimaks võime kasutada ka eelpool mainitud %in% käsku, mis kontrollib väärtuse olemasolu jadas.
#' 
## ----------------------------------------------------------------------------------

edetabel%>% 
  filter(artist=="Smilers") %>% 
  select(year,song) %>% 
  filter(year %in% 2001:2007)


#' 
#' 
#' 
#' Proovi nüüd kätte saada kõik lood mis olnud smilersil küll esikümnes, aga mitte esiviies. (Vihje: vaata tulpa rank.)
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' Proovi leida ka kõik lood, mis olid 1990ndatel tabelis inglise keeles. (Vihje: vaata tulpa language.)
#' 
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------





#---------------------------------------------


#' 
#' 
#' Tihti soovime näha või kasutada mitte tervet andmestikku, vaid juhuslikku osa sellest. Lihtsa valimi tekitamiseks on ka olemas omaette käsk. sample_n() võtab hulgast välja juhusliku n rida, kus n-i väärtuse me määrame sulgude sees. Teeme väikse katse iseendaga, trükime välja 10 lugu aastast 1997 ja 10 lugu aastast 2017. Vaatame ja võrdleme. Mitu lugu ja esinejat tunneme ära rohkem kui 20 aastat tagasi, mitu esinejat tunneme ära hiljutisest edetabelist. Tulemused ütlevad siinkohal küll rohkem lugeja enda kohta kui andmestiku kohta.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(year==1997) %>% 
  sample_n(10)
  

#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(year==2017) %>% 
  sample_n(10)
  

#' 
#' Proovi ise! Võta andmestikust välja 10 juhuslikku esikohalugu. Vaata, kas neid tead?
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------





#---------------------------------------------


#' 
#' 
#' 
#' ## count(), group_by()
#' 
#' Et meil on tegemist edetabeliga, siis püüame kõigepealt selle tippudest aru saada. Selle jaoks on tidyverse andmetöötluses olemas eraldi käsk count(). Kasulik on siin vaadata ka käsku group_by().
#' 
#' - count() - loeb esinemiste arvu
#' - group_by() - grupeerib tabeli mingi tunnuse alusel.
#' 
#' Et saada tabelist ja selle sisust paremat ülevaadet, on võimalik selles esinevaid väärtusi ka loendada. Näiteks vaatame artistide esinemiskordasid top 40s. Esinemiskordade arv sai salvestatud tulpa n.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  count(artist)


#' 
#' Käskudele saab ka lisada parameetreid. Need on eraldatud sisendist komaga. Näiteks count() puhul on võimalik lisada parameeter sort=T, mis järjestab loenduse tulemused suurest väiksemani. Täpsemalt ütleme siis käsule, et lugegu sort väärtuseks T, kui vaikimisi võib ta olla midagi muud.
#' 
#' Nii saame kätte artistid, kes said kõige enam tabelisse.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  count(artist,sort=T)


#' 
#' Selliseid lisavõimalusi leiab iga käsu juhendist, mida saab vaadata lisades käsu ette küsimärgi. Näiteks ?count. Proovi seda! All vasakul avaneb seepeale juhend Help aknas. Failivaatele tagasi saab vajutades sälgule Files.
#' 
## ----------------------------------------------------------------------------------

?count


#' 
#' Niiviisi võime loendada ka ükskõik mida. Näiteks, palju oli lugusid eri keeltes.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(language,sort=T)


#' 
#' Näeme et 686 lugu on eestikeelset, 133 lugu on ingliskeelset ja 178 loo puhul ei tea me täpselt, mis keeles need on. See on andmestiku eripära, enamikes andmestikes on puuduvaid andmeid. Andmete puuduvuse kontrollimine ei käi võrdusmärkidega, aga funktsiooniga is.na(). Näiteks filter(is.na(language)) annab meile kõik lood, kus on keel puudu.
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(is.na(language))


#' 
#' Võime salvestada tulemuse, et seda lähemalt vaadata. 
#' 
## ----------------------------------------------------------------------------------

puuduvad <- edetabel %>% 
  filter(is.na(language))


#' 
#' Ja vaatame talle sisse.
#' 
## ----------------------------------------------------------------------------------

View(puuduvad)


#' 
#' Selgub, et keel on puudu, sellepärast et lauludel ei ole sõnu lisatud. Sellega tuleb andmestikes arvestada. Samas artistide või laulupealkirjade loendamiseks sobivad need siiski.
#' 
#' Katsetame veel count() funktsiooni. Võime näiteks kokku lugeda, mitu korda esineb iga aastat, ehk et mitu lugu on igas aastas. Näeme, et kenasti 40 lugu aastas on top 40-s.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(year)


#' 
#' Me võime loendada mitut gruppi korraga. Näiteks loendades, mitu korda on artist ja aastaarv koos, saame teada mitu lugu artistilt sel aastal edetabelis oli.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,year,sort =T) 


#' 
#' Me võime ka loendada neid gruppe korduvalt. Näiteks loendades seal veelkord aastaarvu, saame teada, mitu erinevat artisti oli konkreetsel aastal edetabelis.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,year) %>% 
  count(year)


#' 
#' Võime seda kombineerida ka filtritega. Näiteks võime vaadata iga aasta kohta, mitu eesti popmuusika lipulaevade lugu edetabelis oli.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(artist=="Smilers") %>% 
  count(year)


#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(artist=="Terminaator") %>% 
  count(year)


#' 
#' 
#' Nad mõlemad alustasid 1990ndate keskel, aga on hitte teinud veel 2016 ja 2017 aastail.
#' 
#' Proovi veel ühe enda valitud artistiga, mis aastail kui palju lugusid neil on olnud.
#' 
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------





#---------------------------------------------


#' 
#' 
#' Proovi ka teada saada, mitu lugu oli mis keeles 1994 aastal ja 2014 aastal.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------




#---------------------------------------------


#' 
#' 
#' Võib märgata, et kui me loendame tunnuste väärtuseid tabelis, siis me jaotame oma andmestiku gruppideks ja ütleme kui palju seal väärtuseid on. Selleks on olemas R-is ka üldisem funktsioon group_by(). Kui me loendasime artiste aasta peale kasutades count() käsus kaht tunnust, nagu all, siis võime seda teisiti sõnastada ka, et me grupeerisime andmestiku artistide kaupa ja loendasime esinemisi aastas.
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,year,sort =T) 


#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  count(year,sort =T) 


#' 
#' Kui count() on spetsiaalne käsk loendamiseks, siis group_by() on laiema kasutusega käsk, kuidas grupeerida ka teisi operatsioone.
#' 
#' 
#' Me võime grupeerimist ka filtritega. Näiteks võime võrrelda, kui palju oli lugusid eri keeltes 1990ndate aastate keskel ja 2010ndate aastate keskel.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(year%in%c(1994,2014)) %>% 
  count(language,year)


#' 
#' Ja sama võrdlus group_by() funktsiooniga.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(year%in%c(1994,2014)) %>% 
  group_by(year) %>% 
  count(language)


#' 
#' Proovi ise! Grupeeri andmestik lugude kaupa ning vaata, mitmel aastal nad tabelisse said.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' ## arrange(), mutate(), row_number(), summarise(), n()
#' 
#' R-i tõeline väärtus aga tuleb ette kui see, mida me teada tahame, ei ole lihtsalt andmestikus sees, vaid see tuleb sealt alles välja arvutada. Andmestiku muutmiseks on lihtsamad käsud arrange(), mutate(), row_number(), summarise(), n().
#' 
#' - arrange() - muudab tabeli elementide järjekorda, vähim väärtus ees
#' - arrange(desc()) - muudab tabeli elementide järjekorda, suurim väärtus ees
#' - mutate() - lisab tabelile uue tulba
#' - row_number() - väljastab rea järjekorranumbri
#' - summarise() - teeb tabelist kokkuvõtte
#' - n() - loendab kokku, mitu tunnust grupis on
#' 
#' 
#' arrange() käsk järjestab andmestiku mingi tunnuse järgi. Näiteks järjestame tabeli nii, et tipus on kõik esikohad, järgnevad teised kohad ja nii edasi.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  arrange(rank)


#' 
#' Me võime järjestada ka mitme tunnuse alusel. Järjestame nad kõigepealt edetabelikoha järgi, aga lisame, et uuemad lood võiksid olla ees. Selle jaoks saame lisada lihtsalt komaga eraldatult uue tunnuse. desc() funktsioon pöörab tunnuse järjestuse ümber, nii et suurim väärtus on eespool
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  arrange(rank, desc(year))


#' 
#' Samuti ei pruugi järjestada ainult numbrite alusel, vaid saab järjestada ka tekstijuppe tähestiku alusel. Näiteks saame asetada lood tähestiku järjekorda. Seejuures numbrid ja sümbolid on sellistes järjestustes enamasti paigutatud tähtedest ettepoole.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  arrange(song)


#' 
#' Kui me tahaksime kätte saada kõik kolmanda koha lood, võime kasutada käsku filter().
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  filter(rank==3)


#' 
#' Kui me aga tahaksime kätte saada populaarsuselt kolmanda artisti, siis ei ole meil filtreerimiseks kohe alust.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,sort=T)


#' 
#' Me võiksime küll peale vaadata, et kolmanda koha artistil oli edetabelis laule täpselt 24 korda või rohkem kui 21 ja vähem kui 46 korda aga see lahendus toimib juhtumisi ainult selles andmestikus ja ainult praegu. Võimalik, et meil on näiteks artisti nimedes vigu ja lõplikud väärtused ei ole täpselt sellised. 
#' 
#' Et saada kätte kolmanda koha, peame lisama andmestikule uut informatsiooni, näiteks järjekorranumbri. Selleks on tidyverse pakettides käsk mutate(), mis muudab üht andmestiku tulpa. Kui anda sisendiks tulba nimi, mis veel ei eksisteeri, saab käsk selle lisada. Ja teine käsk, mida me saame siin kasutada on row_number(). See tekitab jada, mis algab ühest ja lõppeb rea pikkusega. Tulba lisamiseks märgime nii mutate(tulbanimi = sisend) ehk praegu mutate(rownr = row_number()).
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,sort=T) %>% 
  mutate(rownr = row_number())


#' 
#' Näeme, et uus tulp on lisatud. Nüüd saame selle alusel omakorda võtta välja täpselt kolmanda koha selles tabelis, ükskõik, mis väärtusega n ka parasjagu ei ole.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,sort=T) %>% 
  mutate(rownr = row_number()) %>% 
  filter(rownr == 3)


#' 
#' Tidyverse lubab siinkohal ka natuke lõigata. Nimelt filtrisse minev number ei pruugi olla arvutatud, vaid selle võib ka filtreerimise käigus arvutada. Nii saab täpselt samad tulemused jättes ka mutate() käsu kõrvale. Sisuliselt siiski arvutab filter andmestikus uue muutuja, seda lihtsalt ei jäädvustata kusagile.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  count(artist,sort=T) %>% 
  filter(row_number() == 3)


#' 
#' mutate() võib kohaldada igal pool. Näiteks võime lisada tabelisse väärtuse artisti kohast tähestiku jä
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  arrange(artist) %>% 
  mutate(alphabet_rank = row_number())


#' 
#' Ja võime sellest filtreerida välja esimesed 100 artisti tähestikus.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  arrange(artist) %>% 
  mutate(alphabet_rank = row_number()) %>% 
  filter(alphabet_rank<101)


#' 
#' 
#' mutate() naaberkäsk on summarise(). Nad mõlemad püüavad tabelit muuta, mutate() teeb seda info lisamise või asendamise kaudu. summarise() teeb seda info kokkuvõtmise kaudu. Näiteks võime tabelist välja võtta selle esimese aasta ja viimase aasta min() ja max() kaudu.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  summarise(first=min(year), last=max(year))


#' 
#' Või võime ka kokku lugeda, mitu rida andmestikus on käsuga n().
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  summarise(n = n())


#' 
#' 
#' mutate() ja summarise() käsud muudavad oluliselt oma käitumist kui andmestik on kuidagi grupeeritud. Nimelt kui andmestik on grupeeritud, tehakse neid arvutusi gruppide sees. Näiteks grupeerime andmestiku artistide kaupa ja võtame siis kokku, mitu rida seal on.
#' 
#' ## group_by() kasutamine
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))


#' 
#' Tähelepanelik lugeja märkab, et me saime täpselt sama tulemuse kui eelnevalt count() käsuga ning need käsud ongi täpselt samad. group_by() ja summarise() käskude kombinatsiooniga saab aga teha ka enamat.
#' 
#' Näiteks võime välja võtta andmestikust info iga artisti esimese ja viimase aasta kohta kui nad said andmestikku. Nii saame ülevaate artistide kestvusest.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  summarise(first=min(year), last=max(year))


#' 
#' Võime selle tabeli reastada algusaja järgi, et näha tabelis uusi tulijaid eespool.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  summarise(first=min(year), last=max(year)) %>% 
  arrange(desc(last))


#' 
#' mutate() käsuga võib andmestikust kätte saada täpselt sama info, aga selle asemel, et kokku võtta, lisab ta selle andmestikule. Näiteks eelmised käsud lisavad siis põhiandmestikule uued tulbad.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  mutate(first=min(year), last=max(year))


#' 
#' Samamoodi võib ka andmestikule lisada kui palju oli ühes grupis liikmeid.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  mutate(n=n())


#' 
#' Sellisel juhul võime seda edasi töödelda ja võtta mitte ainult nimed, vaid ka kõik laulud tippartistidelt, kus artist oli tabelis rohkem kui kümne looga.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  mutate(n=n()) %>% 
  filter(n>10)


#' 
#' Ja kokkuvõttes võime näiteks välja arvutada nende lugude keskmise koha. Siis kui me soovime gruppe jälle laiali lahutada, tuleb kasutada funktsiooni ungroup()
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  mutate(n=n()) %>% 
  filter(n>10) %>% 
  ungroup() %>% 
  summarise(mean=mean(rank))


#' 
#' Kui me gruppe laiali ei lahuta, mõõdame nii iga tippartisti keskmist tulemust
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  mutate(n=n()) %>% 
  filter(n>10) %>% 
  summarise(mean=mean(rank))


#' 
#' group_by() muudab veidi ka teiste käskude käitumist. Kuivõrd filter võib viidata otse arvutusele ja mitte ainult tulbale, saab group_by() muuta ka selle käitumist. Näiteks kui me grupeeritud andmestikus kasutame filtrit ja arvutame sinna uue väärtuse, siis teeb ta seda grupi kaupa. Nii võime näiteks leida iga artisti esimesed lood, ilma uut tulpa tekitamata.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  group_by(artist) %>% 
  filter(year==min(year))


#' 
#' group_by() muudab ka select() veidi, kuna grupeerivaid faktoreid ei saa kõrvale jätta. Näiteks proovime seda eelmisel tabelil.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  group_by(artist) %>% 
  filter(year==min(year)) %>% 
  select(year,song)


#' 
#' Soovitav on sellisel juhul pärast igat grupeerimist andmestiku salvestamisel grupid uuesti lahti haakida. See aitab kaasa sellele, et vigu ei tekiks ja samas mõned funktsioonid ei tööta hästi grupeeritud andmetega - nad võivad üldse mitte toimida või muutuda väga aeglaselt kui töötluse peab tegema grupeeritud andmetega näiteks tuhandes väikses grupis ühe suure grupi asemel.
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  group_by(artist) %>% 
  filter(year==min(year)) %>% 
  ungroup() %>% 
  select(year,song)


#' 
#' 
#' 
#' 
#' 
#' ## Käskude ühendamine
#' 
#' Mõtleme nüüd, kuidas võiks saada parima tulemuse saanud loo iga artisti kohta. Alustame andmete grupeerimisest artisti kaupa.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist)


#' 
#' Kasutame funktsiooni arrange tulemuse alusel reastamiseks.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  arrange(artist,rank)


#' 
#' Nüüd me peaksime kätte saama, mitmes paremuselt oli mõni lugu ühe grupi jaoks. Selleks lisame mutate() käsuga uue tulba. row_number() annab meile järjekorranumbri. Niisiis saame tulemused järjestatud artisti kaupa paremuse alusel.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  arrange(artist,rank) %>% 
  mutate(artistbest=row_number())


#' 
#' Nüüd saame teha filtri ainult parimate lugude jaoks ja saamegi tulemuse kätte.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  group_by(artist) %>% 
  arrange(artist, rank) %>% 
  mutate(artistbest=row_number()) %>% 
  filter(artistbest==1) %>% 
  ungroup()


#' 
#' Proovi ise! Kas suudad välja mõelda, kuidas eelmist tulemust saaks kätte ka vähema hulga ridade ja käskudega.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' Proovi ise! Kuidas saad kätte iga artisti paremuselt kümnenda loo?
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' Kuidas saaks kätte iga artisti viimasena tabelisse pääsenud loo?
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------







#---------------------------------------------


#' 
#' ## Uue muutuja loomine
#' 
#' Lõpuks võib proovida mutate() kaudu arvutada välja mõne uue väärtuse. Näiteks, ütleme, et anname lugudele punkte, nii, et esimene koht annab 40 punkti ja 40. koht 1 punkti. Siis on punkti väärtus 41 miinus koht.
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  mutate(skoor=41-rank)


#' 
#' Ja kui meil on olemas selline koondindeks võime proovida kokkku arvutada näiteks parima loo või parima artisti. Selleks saame kasutada funktsiooni summarise(). Näiteks terve tabeli peale saab võtta miinimum ja maksimum positsiooni. Kui me tahame saada parimat lugu selle punktisumma järgi, võime need punktisummad näiteks kokku liita iga loo kohta
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  mutate(skoor=41-rank) %>% 
  group_by(song) %>% 
  summarise(summa=sum(skoor)) %>% 
  arrange(desc(summa))


#' 
#' Käime katuseid mööda võidab suisa 99 punkti, mis tähendab et ta oli tabelis vähemalt kolmel aastal. Ja võime teha sama ka artisti kaupa ja arvutada välja populaarsuse määra, mis arvestab ka positsiooniga tabelis. Kui muidu oli lugude arvult Smilers ja Terminaator üsna ligi teineteisele, siis selle punktisumma järgi on Smilers siiski tublisti Terminaatorist ees. Terminaator vajaks veel 5-t esikümnehitti rohkem kui smilers, et talle järgi tulla.
#' 
#' 
## ----------------------------------------------------------------------------------

edetabel %>% 
  mutate(skoor=41-rank) %>% 
  group_by(artist) %>% 
  summarise(summa=sum(skoor)) %>% 
  arrange(desc(summa))


#' 
#' Proovi ise! Mõtle välja uus muutuja, mida võiks arvutada ning mille alusel artiste järjestada. (Vihje: votes tulpa pole me siiani kasutanud.)
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------







#---------------------------------------------


#' 
#' 
#' 
#' 
#' 
#' 
#' ## Sõnastik
#' 
#' -  %>% - vii andmed järgmisesse protsessi
#' - select() vali muutujad
#' - filter() vii andmestik läbi filtri/sõela
#' - unique() - võtab tabelist ainult unikaalsed read
#' - count() - loeb esinemiste arvu (võib panna mitu tulpa korraga)
#' - group_by() - grupeeri andmestik mingi muutuja alusel (võib panna mitu tulpa korraga)
#' - ungroup() - vii andmestik taas grupeerimata seisu
#' - n() - grupi suurus
#' - row_number() - rea number
#' - mutate() - loo uus muutuja
#' - arrange() - järjesta andmed, lisafunktsioon desc()
#' - summarise() - loob uue, kokkuvõtva, tulba
#' 
#' 
#' 
#' 
#' ## Harjutusülesanded
#' 
#' 1. Leidke artistid, kes olid kõige populaarsemad 2000ndatel.
#' 
#' 2. Leidke kõik lood, mis olid üle ühe aasta edetabelis.
#' 
#' 3. Leidke artistid, kel oli iga tabelisoldud aasta kohta kõige rohkem lugusid.
#' 
#' 4. Leidke lood, mis olid edetabelis mitu aastat.
#' 
#' 5. Nende lugude seast leidke lood, mille maksimaalne häälte hulk ületas nende minimaalse hääle hulga rohkem kui 5 korda.
#' 
