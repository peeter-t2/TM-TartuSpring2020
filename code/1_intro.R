#' ---
#' title: "R ja RStudio"
#' author: "Peeter Tinits"
#' output: html_document
#' ---
#' 
#' 
#' # R-i alused
#' 
#' 
#' ## R ja käsud
#' 
#' Suhtlus R-iga käib käskude kaudu. Sisestades R-is käsu ja vajutades ENTERit püüab R selle tulemust välja arvutada ja salvestada kui selleks on juhised antud. Skriptid koondavad kokku hulga käske, mida võib järgemööda käivitada. Skriptidesse on hea käske koondada, kuna siis võib kunagi hiljem töötluskäigu täpselt taastada, seda võib kergesti parandada ja see töötab ka kellegi teise arvutis.
#' 
#' Skriptifaile koostatakse üldiselt niimoodi, et kui otsast käske käivitada, siis jookseb skript kenasti lõpuni. Sellest tuleb ka pöidlareegel, et kui mõnes salvestatud skriptifailis mõni varemsalvestatud käsk ei tööta, võib proovida faili algusest peale kõik uuesti läbi teha ja vaadata, kas viga on ikka olemas. Kui on, siis võib olla probleem salvestatud skriptis.
#' 
#' R-is saab salvestada skripte lihtsas skriptifailis, millel on .R lõpp või siis Rmarkdown failis, millel on .Rmd lõpp. Rmarkdown on lisamoodul R-is mis aitab teksti ja koodi hoida samas failis.
#' 
#' Nii .R kui .Rmd failis või RStudio kaudu käske käivitada ühekaupa. Üldiselt on käsk ühe rea peal, ning selle käivitamiseks tuleb viia oma tekstikursor sellele reale ja vajutada Windowsis ja Linuxis CTRL+ENTER, Mac-is CMD+ENTER. Sama käsk on ka RStudios ülal Run all Run -> Run selected line(s). Tekstikursoriga saab valida ka mitu rida või osa ühest või mitmest reast ja kui osa teksti on valitud, siis käivitab R ainult selle. Käsu jooksutamiseks konsooliaknas (RStudios all vasakul) kasutage lihtsalt ENTER.
#' 
#' Peaaegu kõikide käskude puhul on võimalik lisada käsu ette küsimärk, mille käivitamisel ilmub paremalle alla nurka selle käsu kasutusjuhend.
#' 
#' 
## ----------------------------------------------------------------------------------

?read.csv


#' 
#' 
#' ## R lihtsa kalkulaatorina
#' 
#' Näiteks võib lasta tal arvutada lihtsamat matemaatikat. Näiteks võime käsuks anda lihtsalt 5+7 ja R käivitab selle ning trükib välja tulemuse.
#' 
#' 
## ----------------------------------------------------------------------------------

5 + 7


#' 
#' Tulemus on näha ülal. Kui käivitad käsu RStudios, jõuab tulemus konsooli. 5 ja 7 olid sisendnumbrid ja + oli operatsioon, mille R tegi, mis antud juhul tähendas liitmist. R-is saab ka teha teisi tehteid.
#' 
#' 
## ----------------------------------------------------------------------------------

1+1
4-2
4*2
27*17
459/17
sqrt(25)


#' 
#' Tärn tähistab kordusmärki ja kaldkriips jagamist. sqrt() võtab ruutjuure sellest numbrist. Viimane ongi tüüpiline viis R-ile käske anda
#' 
#'     funktsioon(sisend)
#' 
#' Tidyverse-s on selle kõrval teine tava.
#' 
#'     andmed %>% 
#'         funktsioon()
#' 
#' Nad mõlemad teevad täpselt sama asja, lihtsal Tidyverse-i võtab vaikimisi sissesöödetud andmed funktsiooni sisendiks. Sellest rohkem peagi.
#' 
#' 
#' ## Tulemuste salvestamine
#' 
#' Kui R-i võib kasutada lihtsa kalkulaatorina, siis selle jõud tuleb välja siis kui tuleb mingit andmehulka või tehteid korduvalt kasutada. Selle jaoks on võimalik nii andmeid kui funktsioone R-is kergesti salvestada.
#' 
#' Tavaliselt kasutatakse salvestamiseks noolt <-, mis on koostatud väiksem-kui märgist ja sidekriipsust. Üksikut võrdusmärki = saab aga kasutada enamasti samas tähenduses. Seda märki saab teha ka vajutades korraga alla ALT + - ehk ALT + miinusmärk. Tähele tuleb panna, et üksik võrdusmärk = ja topelt võrdusmärk == on R-is erinevas tähenduses.
#' 
#' Me võime alustuseks teha muutuja x, mille sisuks on  5 + 7. Selleks kirjuta x <- 5 + 7."
#' 
#' 
#' 
## ----------------------------------------------------------------------------------

x <- 5 + 7


#' 
#' Kui R salvestab tulemuse muutujasse, ei trüki ta seda enam välja. Seda seepärast, et ta salvestamise juures eeldab, et me soovime sellega midagi veel teha. Et vaadata muutuja sisu, trükime selle lihtsalt sisse.
#' 
#' 
## ----------------------------------------------------------------------------------

x


#' 
#' Me võime muutujat omakorda kasutada uue muutuja loomiseks. Näiteks loome muutuja y, mis koosneb x-st ja 3-st. R otsib üles x-i väärtuse ja kasutab seda y-i arvutamiseks. Kui x poleks määratud, siis R sellist y-it vastu ei võtaks.
#' 
#' 
## ----------------------------------------------------------------------------------

y <- x - 3


#' 
#' Me võime vaadata y-i väärtust nüüd samamoodi.
#' 
#' 
## ----------------------------------------------------------------------------------

y


#' 
#' Seejuures kui me nüüd muudame x-i tagantjärele, siis y enam ei muutu. Muudame x-i neljaks ja vaatame, et y-i väärtus säilib ikka.
#' 
#' 
## ----------------------------------------------------------------------------------

x <- 4
y


#' 
#' X-i saab määrata nii noole <- kui ka võrdusmärgi = abil. Järgmised operatsioonid on võrdsed.
#' 
#' 
## ----------------------------------------------------------------------------------

x <- 4
x =  4


#' 
#' ## Tehete järjekord
#' 
#' Muutujate tegemisel on oluline operatsioonide järjekord. Samamoodi nagu matemaatikas tehete järjekorra määramiseks, saame järjekorda R-is määrata sulgude kaudu. Näiteks tavamatemaatikaga sarnaselt on järgmised kaks tehet erinevad.
#' 
#' 
## ----------------------------------------------------------------------------------

z <- x+y*2
z
z <- (x+y)*2
z



#' 
#' ## Võrdused ja võrratused
#' 
#' Väga sagedasti on meil andmetöötlusel vaja kahte väärtust võrrelda. Näiteks leida kõik inimesed, kes on vanemad kui 60 või siis kõik andmed, mis pärinevad 2010 jaanuarikuust. Selleks on R-is kasutusel hulk viise kontrollida samasust ja erinevust.
#' 
#' Kaks võrdusmärki == kontrollib, kas kaks objekti on täpselt võrdsed ja vastab sellele, kas TRUE või FALSE ehk kas tõene või väär. Koodi kirjutades võib TRUE ja FALSE lühendada vastavalt T ja F.
#' 
#' 
## ----------------------------------------------------------------------------------

1==1
1==2
x==4
x==y
x==y*2


#' 
#' Eitust märgitakse nendes kontrollides hüüumärgiga !. Võrdsusetuse kontrollimiseks võime kasutada märki hüüumärki koos võrdusmägiga != või asetada hüüumärgi ! kontrolllause ette. Kõik järgnevad laused kontrollivad hüüumärgi kaudu ühenduse eitust.
#' 
#' 
## ----------------------------------------------------------------------------------

1!=1
1!=2
!1==1
!1==2


#' 
#' Lisaks võrdsusele saame numbrite puhul kontrollida ka kas esimene number on väiksem kui <, suurem kui >, väiksem/võrdne <= või suurem/võrdne >= teisest numbrist.
#' 
#' 
## ----------------------------------------------------------------------------------

1 < 1
2 > 1
1 <= 1
2 >= 2



#' 
#' 
#' ## Muutujate nimed ja tekst
#' 
#' R-is töödeldakse lisaks numbritele ka teksti. Et mitte segamini ajada muutujate nimesid ja teksti, peab tekst olema alati jutumärkides. Kui me kirjutame x või y ilma jutumärkideta, otsib R üles need muutujad ja väljastab nende väärtuse. Kui me tahame, et R mõistaks x-i ja y-it tekstina, peame need ümbritsema jutumärkidega, kas ühekordsete ('näidis') või kahekordsetega ("näidis")."
#' 
#' 
## ----------------------------------------------------------------------------------

x
y
'x'
"y"


#' 
#' Seni kuni ta on tekstijupi sees on ta ükskõik kui pikk, võib sisaldada tühikuid ja muid märke.
#' 
#' 
## ----------------------------------------------------------------------------------

"Siin on kirjutatud lause ühe tekstielemendina."


#' 
#' Ja sellegi saame me salvestada samamoodi.
#' 
#' 
## ----------------------------------------------------------------------------------


a <- "Siin on kirjutatud lause ühe tekstielemendina."



#' 
#' Seejuures võib muutujate nimeks olla peaaegu ükskõik mis. Muutuja ei või ainult alata numbriga, sisaldada tühikuid sidekriipse, kooloneid, trelle ja muud, millel on R-i algsüntaksis juba tähendus. Muutuja võib kasutada suuri ja väikseid tähti. Näiteks võime teha muutuja kuuliLennuTeeTunneliLuuk.
#' 
#' 
## ----------------------------------------------------------------------------------


kuuliLennuTeeTunneliLuuk <- "Siin on kirjutatud lause ühe tekstielemendina."



#' 
#' Üldiselt on ka soovitus, et muutujate nimed võiksid olla pigem informatiivsed kui a, b ja c, kuna kuue kuu pärast ei mäleta enam keegi, mis see a täpselt oli, ilma hoolikalt koodi lugemata.
#' 
#' Kui me aga unustame tekstielemendi ümber jutumärgid, siis annab R meile veateate. Ta ei leia sellist objekti üles.
#' 
#' 
## ---- eval=F-----------------------------------------------------------------------
## tundmatumuutujanimi
## 

#' 
#' 
## ----------------------------------------------------------------------------------

# Error: object 'tundmatumuutujanimi' not found.


#' 
#' Selliseid veateateid annab R üldse kui kuskil on koodis viga ning R ei suuda seda käivitada. Tihti tuleb ette, et kuskil on sulud vales kohas või sulgemata ja R arvab, et miski peaks olema objekt kuigi see on mõeldud funktsioonina. Kui oma silm kohe viga ei leia, tasub panna veateade google-isse. Kuna sarnased probleemid tulevad teistelgi sagedasti ette, siis on tihti seal esimese vastusena lahendus olemas. 
#' 
#' ## Jadad
#' 
#' Tavaliselt töötab R rohkem kui ühe väärtusega korraga kasutades jadasid ehk vektoreid. Jadasid võib teha näiteks numbritest või tekstijuppidest, aga näiteks ka tabelitest (nendest siin õppetükis ei räägi).
#' 
#' Selleks on kaks lihtsamat võimalust. Kooloniga : saab teha numbrijärjendi ja c() funktsiooniga saab teha järjendi numbritest või tekstielementidest. Sarnaseid funktsioone on veel, nt seq() või rep(), mida saate ise edasi uurida. Näiteks all on jadad 1 kuni 10 ja a, b, c.
#' 
#' 
## ----------------------------------------------------------------------------------

1:10
c("a","b","c")


#' 
#' Ka c()-ga võib teha jadasid, samuti võib sinna panna muutujate nimesid. Kui jada sisaldab vähemalt ühte tekstielementi, teeb ta ka kõik numbrid tekstiks. Jad elemendiks võib olla ka teine jada, c() käsk seab nad kõik samale tasapinnale
#' 
#' 
## ----------------------------------------------------------------------------------

x <- 4

c("a", 1, x)

c(1, 4, 8)

c(1:8, 2, 4)

c(4, 6, c(1, 2, 3))



#' 
#' Et kontrollida, kas miski element on olemas jadas, kasutatakse käsku %in%. %in% kontrollib, kas esimest elementi leidub teises
#' 
#' 
## ----------------------------------------------------------------------------------

1 %in% 1:10


#' 
#' Samaaegselt võib kontrollida ka mitut elementi ühes jadas. Järgmine kontrollib, millised elemendid jadast 2 kuni 10 on ühtlasi jadas 1 kuni 5
#' 
#' 
## ----------------------------------------------------------------------------------

2:10 %in% 1:5


#' 
#' Sama võib teha ka tekstijadaga.
#' 
#' 
## ----------------------------------------------------------------------------------

c("a","b","c","f") %in% c("a","b","c","d","e")


#' 
#' Ka %in% märki saab kombineerida hüüumärgiga.
#' 
#' 
## ----------------------------------------------------------------------------------

!2:10 %in% 1:2



#' 
#' Vektoreid saab samamoodi salvestada nagu muid R-i objekte
#' 
#' 
## ----------------------------------------------------------------------------------

numbrivektor <- 1:10
numbrivektor

tekstivektor <- c("a", "b", "c", "d","e","f","g","h","i","j")
tekstivektor



#' 
#' 
#' Lisaks numbritele ja tekstidele on R-is veel üks oluline vektoritüüp, faktor. Faktorid on kategoorilised muutujad, kus väike hulk tüüpe, mis korduvad.
#' 
#' 
## ----------------------------------------------------------------------------------

faktor <- factor(c("a","a","a","a","a","b","b","b","b","b"))
faktor



#' 
#' Näiteks ülal on siis 10 elemendi pikkune faktor, kus on kaks tüüpi a ja b. Faktoril on niisiis lisaks jadale oluliseks selle tasandid levels(). 
#' 
#' 
## ----------------------------------------------------------------------------------

levels(faktor)


#' 
#' Tasandeid saab ümber nimetada, muutes neid kogu jada ulatuses. 
#' 
#' 
## ----------------------------------------------------------------------------------

levels(faktor) <-c("naine","mees")
faktor


#' 
#' Ning tasandite järjestust saab muuta. Tasandite järjestuse muutmine ei muuda jada ennast. Tüüp a jääb a-ks ja tüüp b jääb b-ks.
#' 
#' 
## ----------------------------------------------------------------------------------

faktor <-factor(faktor,levels=c("mees","naine"))
faktor


#' 
#' Tasandite järjestus mängib olulist rolli mudelite ja graafikute loomisel. Failide sisselugemisel tasub kontrollida, et tekstitulp ei oleks sisseloetud faktorina. R on traditsiooniliselt seda teinud ning selle vea kõrvaldamata jätmine on viinud valede tulemusteni nii mõnegi avaldatud teadustöö. Tidyverse paketid andmete sisselugemisel enam faktoreid vaikimisi ei lisa. Selle muutmiseks tuleb silmas pidada parameetrit *stringsAsFactors*.
#' 
#' ## R paketid
#' 
#' Lisaks põhikäskudele on R-is hulk lisapakette, mis avavad uusi kasutusvõimalusi ning teevad olemasolevaid võimalusi mugavamaks. Praeguse õppetüki fookuses olev *tidyverse* on pakettide komplekt, mis püüab teha mõlemat.
#' 
#' Iga paketi puhul tuleb see R-is esiteks 1) arvutisse installida ja teiseks 2) iga kord R-i või RStudiot käivitades sisse lülitada.
#' 
#' Paketi installimiseks on olemas käsk install.packages(). Sama käsu leiab ka ülalt menüüst Tools -> Install Packages... alt, kus saab kirjutada endale soovitavad paketid komadega eraldatult sisse. RStudio pakub ka kirjutamise ajal välja, mis paketid need võiksid olla. Uuemates RStudio versioonides on ka mõnikord skriptiakna kohal teade, et teatud paketid on installimata, kas soovite neid installida. Kui vajutada seal install, siis käivitab R sama install.packages() protsessi.
#' 
#' Installime kõigepealt oma arvutisse tidyverse paketid. See võtab natuke aega, las arvuti töötab. Konsoolis näidatakse installikäiku, seal võib olla punast teksti ja hoiatusi, aga kui lõpuks on teade "* DONE (tidyverse)", on kõik hästi. RStudios hakkab installimise ajal vilkuma punane stopnupp konsooli ülal-paremal otsas. Ärge sinna vajutage. Kui vajutate võib installimine katki minna. Kui see millegipärast on juhtunud, siis enamasti aitab remove.packages() samadele pakettidele ja siis uuesti proovida.
#' 
#' 
## ----eval=F------------------------------------------------------------------------
## install.packages("tidyverse")
## 

#' 
#' Paketi sisselugemiseks kasutame funktsiooni library(). Peaaegu samaväärne funktsioon on require() kui mõnikord skriptides on just seda kasutatud. Loeme kõigepealt sisse library(tidyverse).
#' 
#' 
## ----------------------------------------------------------------------------------

library(tidyverse)


#' 
#' Tidyverse käivitamisel võiks teie isiklikus arvutis näha midagi sellist. Ta näitab seal ka paari konflikti, aga nende pärast ei pea praegu muretsema. Neid tuleb teinekord ette kui uues paketis on mõni käsk sama nimega kui mõnes teises sisselaetud paketis. Sellisel juhul arvab R, et viimasena laetud funktsioon on õigeim.
#' 
#' Väljatrükitust on näha, et R-i on sisselaetud paketid ggplot2, purr, tibble, dplyr, tidyr, stringr, readr ja forcats. Enamik pakette loevad sisse iseenda + enda töötamiseks vajalikud abipaketid (mida võib olla terve hulk). Tidyverse on üks väheseid pakette, mis loeb terve komplekti, mistõttu teised paketid võivad näidata teistlaadi teateid või, tavapäraselt, ei näitagi mingeid teateid. Senikaua kuni R veateadet ei näita library() käsu puhul, peaks olema kõik hästi.
