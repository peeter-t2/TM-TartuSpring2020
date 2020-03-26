#' ---
#' title: "R ja RStudio"
#' author: "Peeter Tinits"
#' output: html_document
#' ---
#' 
#' # Mitmikud, regulaaravaldised ja märksõnad
#' 
#' Selles peatükis vaatame, kuidas saab tidyverse ja tidytext pakettide abil töötada sõnamitmikega, kasutada regulaaravaldisi otsingutes ning leida märksõnu, mis iseloomustavad mõnd teksti või tekstidegruppi.
#' 
#' Kui me käivitasime just R-i, siis alustame jälle pakettide käivitamisest.
#' 
## ----------------------------------------------------------------------------------

library(tidyverse)
library(tidytext)


#' 
#' Samuti vajame me taaskord andmestikku. Veenduge, et töökataloog on määratud õigesse kohta.
#' 
## ----------------------------------------------------------------------------------

edetabel <- read_tsv("data/eesti_top40/eesti_skyplus_top40_1994-2018.tsv")


#' 
#' ## Bigrammid
#' 
#' Eelmises peatükis kasutasime unnest_tokens() funktsiooni, et lahutada tabelis olevaid tekste sõnapikkusteks üksusteks. Nagu teised funktsioonis R-is on ka unnest_tokens() mõneti paindlik ja sellega saab teha veidi teistsuguseid asju, muutes selle parameetreid. Kasutame küsimärki ? käsu ees, et saada liig selle abifailile. Käsu käivitamine avab abiteksti paremal all ja näitab seda failide asemel. Failide ja abiteksti vahel saab liikuda selle akna menüüs (siis vastavalt Help ja Files sälgud).
#' 
## ----------------------------------------------------------------------------------

?unnest_tokens


#' 
#' 
#' Abikäsk näitab käsu sisu, näiteid ja parameetreid, mida saab selles muuta.
#' 
#'        unnest_tokens(tbl, output, input, token = "words", format = c("text",
#'         "man", "latex", "html", "xml"), to_lower = TRUE, drop = TRUE,
#'           collapse = NULL, ...)
#' 
#' Esimene neist parameetritest on see, millele annab sisendi %>% toru käsk tidyverse töötluses. Antud juhul siis tbl, mis on sisendtabel. Enamasti ongi vaikimisi esimene sisend just andmestik, millega töötatakse. Parameetreid võib määrata järjekorra järgi, või andes ette parameetri nime. Näiteks unnest_tokens(word,text) on sama kui unnest_tokens(output=word, input=text) juhul kui alustabel tbl on söödetud käsu eestpoolt ja toruga.
#' 
#' Funktsioonil on aga veel parameetreid. Kõik parameetrid, millel on antud abifailis võrdusmärgiga = vaste, on parameetrid, millel on olemas vaikimisi väärtus. Ehk, kui me ise just teisiti ei määra, kasutab programm käsu vaikeväärtust. Vaikimisi võtab programm sõna ühikuks token = "words". Samuti määrab ta vaikimisi, et to_lower = TRUE, misläbi muudetakse kõik suurtähed väiketähtedeks ja drop = TRUE, misläbi eemaldatakse sõnade leidmise aluseks olnud tulp. Kõikide parameetrite seletus on antud abifailis veidi allpool.
#' 
#' Vaadates lähemalt token parameetrit näeme, et sellel on hulga variante: "words" (vaikimisi), "characters", "character_shingles", "ngrams", "skip_ngrams", "sentences", "lines, "paragraphs, "regex", "tweets", "ptb". Meil ei ole neid kõiki praegu vaja, aga võime proovida varianti ngrams ehk mitmikud.
#' 
#' Meenutuseks, et eelmises õppetükis tegime sellise tabeli. Me võime seal eraldi märkida, et token = "words", aga me võime selle ka ära jätta, kuna "words" on seal antud juhul vaikeväärtus.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  unnest_tokens(word, lyrics, token = "words")


#' 
#' Samas nägime abifailist, et seda võib ka muuta. Asetame siis selleks "ngrams". Kui väärtuseks on määratud "ngrams", siis me peame omakorda määrama selles lisaparameetreid. Nimelt soovib käsk teada, kui suuri mitmikuid me soovime. Määratleme minimaalse suuruse n_min = 2 ja maksimaalse suuruse n = 2. Sellisel juhul teeb unnest_tokens() sõnade tabeli asemel bigrammide tabeli.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  unnest_tokens(bigram, lyrics, token = "ngrams", n = 2, n_min = 2)


#' 
#' Proovime mängida parameetritega. Näiteks võime käsu sees määratleda ka et mitmike pikkus peaks olema ühest kolmeni. Sellisel juhul näitab käsk kõiki võimalikke mitmike suurusega ühest kolmeni, ehk nii sõnu, bigramme kui trigramme.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  unnest_tokens(bigram, lyrics, token = "ngrams", n = 3, n_min = 1)


#' 
#' Võtame siis ette bigrammid. Et meil on tabelit korduvalt vaja ning selle tekitamine võtab hetk aega, salvestame selle tulemuse jälle muutujasse.
#' 
## ----------------------------------------------------------------------------------

bigrams <- edetabel %>%
  unnest_tokens(bigram, lyrics, token = "ngrams", n = 2, n_min = 2)


#' 
#' Samamoodi kui sõnadest, saame me teha ka bigrammidest sagedustabeli. Levinud fraasid on ikka samad kui keeles ikka 'ei saa', 'ei ole', 'ei tea', 'ma ei', 'ma olen', 'mul on'.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,sort=T)


#' 
#' Nagu sai näidatud varasemates peatükkides saame loendada mitu tunnust korraga. Seeläbi saame näiteks kokku lugeda fraasikordusi ühes laulus. Näiteks na na, oo oo ja ba da on väga populaarsed fraasid.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T)


#' 
#' Samas näeme sellega ära, et meie andmestik on veidi ebamugav selle kohta pealt, et mõni laul on seal mitu korda. Ja samas või selle laulu nimi olla sama või erinev. Kui me nüüd loendame ainult fraasi ja laulunime järgi, siis võib mõni lugu saada seal mitmekordsed numbrid, kuna laul justkui oleks kaks korda nii pikk kui ta on. Teisest küljest, me saame ühest 'Tantsin valssi' loost kätte juba info na na kohta, me ei pea seda kaks korda nägema. 
#' 
#' Kui me loendame laulu, artisti ja aasta kombinatsioone, siis tabel juba mõneti muutubki. Näiteks "jalas polnud" ja "polnud pükse" kaovad edetabelist ära, kuna Peegelpõranda laul oli tabelis kaks aastat, mistõttu olid sõnasagedused leotud topelt.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,artist,year,sort=T)


#' 
#' 
#' ## Valimi parandamine
#' 
#' Me võime võtta nüüd selle arvesse ja püüda meie valimit varasemate teadmiste põhjal parandada. Nimelt, me teame, et mõnikord võib olla pealkiri sama, kuid erineda väike ja suurtähtedelt ning me teame, et mõned lood on tabelis mitu aastat ehk mitu korda.
#' 
#' Me saame aga oma tabelit muuta selle järgi. mutate() käsule saame anda sisendiks, et ta viiks tulbad väiketähtede kujule. Selleks on funktsioon tolower(). Ja me saame grupeerida ja filtreerida andmsetikku nii, et iga artisti ja laulu kombinatsiooni kohta jääb alles ainult esimene aasta.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  mutate(artist=tolower(artist),song=tolower(song)) %>% 
  group_by(artist,song) %>% 
  filter(year==min(year))


#' 
#' Niimoodi andmestikku muutes, saame kokku kokku 947 erinevat lugu eelmise 1000 asemel. Salvestame selle tabeli nime all firstsongs. Grupeeriv faktor tasub salvestades enamasti lahti siduda, kuna mõned funktsioonid nõuavad grupeerimata andmestikku või muutuvad väga aeglaseks siis, kui andmestik on tehtud paljudeks gruppideks.
#' 
## ----------------------------------------------------------------------------------

firstsongs <- edetabel %>%
  mutate(artist=tolower(artist),song=tolower(song)) %>% 
  group_by(artist,song) %>% 
  filter(year==min(year)) %>% 
  ungroup() # Kõige lõpus tasub grupid lahti siduda


#' 
#' Salvestatud puhastatud tabelit saame kasutada nüüd sisendina edasiseks analüüsiks. Leiame uuesti bigrammid tekstide seast ning salvestame need vana muutuja asemele.
#' 
## ----------------------------------------------------------------------------------

bigrams <-firstsongs %>%
  mutate(artist=tolower(artist),song=tolower(song)) %>% 
  group_by(artist,song) %>% 
  filter(year==min(year))%>%
  ungroup() %>% 
  unnest_tokens(bigram, lyrics, token = "ngrams", n = 2, n_min = 2)


#' 
#' Samuti nagu varem võime nüüd loendada bigramme laulude kohta. Seekord aga ei pea vaatama, mis aastaga tegemist on ja paljud kordused on nüüd kadunud. On muidugi lugusid, millel artisti või laulu nimi erineb aasta-aastalt veidi rohkem kui ainult suurtähtede ja väiketähtede kaudu - näiteks seesama tantsin valssi, mille artist on muutunud. Aga paljuski saame me nii juba täpsema info. Et kõik sama loo erinevad variandid saaks eemaldatud, tuleb veel täpsemalt proovida artisti nimesid ühitada. Praegu piirdume suur- ja väiketähtedega.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,artist,sort=T)


#' 
#' ## Regulaaravaldised
#' 
#' Nagu varem sõnadega, võime me filtreerida seda tabelit ka fraasi kaupa. Näiteks 'ei saa' esinemised eri lauludes saame kätte niiviisi. Päris paljudes lauludes kordub fraas 'ei saa' mitmeid kordi. Tähele võib panna, et sellisel juhul on aga oluline, et fraas oleks täpselt selline nagu on kirjeldatud.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(bigram=="ei saa")


#' 
#' Me teame varem koostatud sõnaloendite põhjal, et sõna 'ei' on neis tekstides üldse sage. Kui me nüüd tahaks teada, millises kontekstis sõna 'ei' esineb, ei saa me ette kirjutada kõiki eri variante. Sellisel puhul on meil võimalik kasutada käske tekstiosade kattuvuseks ning regulaaravaldisi. Tidyverse pakettides on ka tekstidega töötamiseks eraldi osa stringr, kus on meid aitavad kaks funktsiooni str_detect(), mis kontrollib, kas tekstis sisaldub ettekirjutatud jupp ja str_extract(), mis eraldab kirjutatud jupi tekstist.
#' 
#' - str_detect(muutuja, "sõne") - kontrolli, kas tekstis esineb selline järjend
#' - str_extract(muutuja, "sõne") - leia selline järjend tekstis ning esita leitud järjend
#' 
#' Need funktsioonid võtavad sisendina vaikimisi regulaaravaldisi, mis avardab meie otsimisvõimekust oluliselt. Otsides ainult järjendit 'ei saa' leiame, et meie esialgne otsing ei leidnud varianti, ei saagi, mida kordub ühe loo sees isegi kõige rohkem. Nimelt läheb edetabeli tippu toe tag pankrott, kus fraas 'ei saagi' esineb suisa 42 korda. Kuivõrd ta on tähenduselt üsna sarnane, siis on seda meilgi ehk oluline teada.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"ei saa"))


#' 
#' Me võime ka otsida kõiki sarnaseid fraase, mis algavad eitusega. Selleks otsime sõna ei, millele järgneb tühik ja siis ükskõik milline tähekombinatsioon. Ja saame, et neid eitavas vormides fraase on lugude seas veel. ei-ei, ei saa, ei hooli, ei pea, ei huvita ei lase, jne.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"ei [a-zõäöü]+"))


#' 
#' Teine viis leida kõik fraasid, mis algavad sõnaga ei, on kasutada regulaaravaldiste teksti alguse tähist ^. Nii teab käsk, et 'ei' peab olema fraasi alguses.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"^ei "))



#' 
#' Tõtt-öelda bigrammidega piisab ka tühikust, kuna neis on tühik alati esimesest sõnast paremal.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"ei "))


#' 
#' Võime proovida otsida ka näiteks sidesõnale ja järgnevaid sõnu.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"ja [a-zõäöü]+"))


#' 
#' Me võime otsida sedasi ükskõik mida.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"ma "))



#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"jama[ a-zõäöü]+"))


#' 
#' Proovige leida nüüd kõik fraasid, mis sisaldavad eestit ükskõik, mis kujul
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------








#---------------------------------------------


#' 
#' 
#' Teine küsimus, kus regulaaravaldised kuluvad eriti ära, on kui me tahame teada saada teatud sõnavormide kohta. Näiteks meid huvitavad kõik armastusega seotud sõnad neis lauludes. Võime teha otsingu, mis hõlmaks 'armastus', 'armastama' ja selle vorme. Nii saame kätte kõik fraasid, kus on sellest mingil määral juttu.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"armast[ua]"))


#' 
#' Kui me aga tahame küsida sõna eri vormide kohta, võime me leidude vasted uude tabeli tulpa panna. str_extract() võtab tekstist välja täpselt sellise vormi, mis me leidsime.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"armast[ua]")) %>% 
  mutate(vorm=str_extract(bigram,"armast[ua]"))


#' 
#' Selleks, et saada tervet sõna, peame regulaaravaldist pikendama, et ta võtaks kaasa kõik tähestiku tähed, aga mitte tühikud.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"armast[ua]")) %>% 
  mutate(vorm=str_extract(bigram,"armast[ua][a-zõäöü]+"))


#' 
#' 
#' Ja nüüd võime omakorda kokku lugeda, mis vormides need sõnad olid
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"armast[ua]")) %>% 
  mutate(vorm=str_extract(bigram,"armast[ua]([a-zõäöü]+)?")) %>% 
  count(vorm,sort=T)


#' 
#' Samamoodi võime võtta näiteks välja kõik sõnad, mis järgnevad sõnale armastus, ükskõik, mis vormis. Lisame otsingule sõna alguse tähise, ning võtame välja kõik, mis järgneb tühikule. Nagu arvata oli on ikka kõige sagedasemad vormid muidu ka levinud sõnad. Samas pidagem meeles, et praegu me vaatasime, mitmes laulus need fraasid on. Me võime ka vaadata mitu korda fraase esineb kokku.
#' 
## ----------------------------------------------------------------------------------

bigrams %>%
  count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"^armast[ua]")) %>% 
  mutate(vorm=str_extract(bigram," [a-zõäöü]+")) %>% 
  count(vorm,sort=T)


#' 
#' Tidyverse %>% märgiga kirjutatud koodis on selleks hea võimalus. Me võime lihtsalt mõne käsu välja kommenteerida # trellidega.
#' 
## ----------------------------------------------------------------------------------

bigrams %>% 
  #count(bigram,song,sort=T) %>%
  filter(str_detect(bigram,"^armast[ua]")) %>% 
  mutate(vorm=str_extract(bigram," [a-zõäöü]+")) %>% 
  count(vorm,sort=T)


#' 
#' 
#' Proovige leida, mis vormides 'eesti' lauludes esineb.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------








#---------------------------------------------


#' 
#' 
#' ## Trigrammid
#' 
#' Sarnaselt bigrammidele saame unnest_tokens() parameetreid sättides võtta tekstidest välja ka trigrammid.
#' 
## ----------------------------------------------------------------------------------

trigrams <- firstsongs %>%
  unnest_tokens(trigram, lyrics, token = "ngrams", n = 3, n_min = 3)


#' 
#' Võime neid samuti loendada.
#' 
## ----------------------------------------------------------------------------------

trigrams %>%
  count(trigram,sort=T)


#' 
#' Ja võime ka nende kordusi loendada.
#' 
## ----------------------------------------------------------------------------------

trigrams %>%
  group_by(artist,song) %>% 
  count(trigram,sort=T)


#' 
#' Kombineerides olemasolevaid käske võime nüüd näiteks otsida välja kõik fraasid, kus esineb sama sõna nii alguses kui lõpus. Me teame, et ^ märk tähistab rea algust ja et $ märk tähistab rea lõppu (vaata regulaaravaldiste juhendit moodle-is). Kui me nüüd võtame välja antud tabelist kõik esimesed ja viimased sõnad ja filtreerime välja ainult read, kus need on sama sõna, saamegi kätte oodatud tulemuse. Päris suur hulk fraase on sellist, kus on sees selline sõnakordus.
#' 
## ----------------------------------------------------------------------------------

trigrams %>%
  group_by(artist,song) %>% 
  count(trigram,sort=T) %>% 
  mutate(firstw=str_extract(trigram,"^[a-zõäöü]+"),lastw=str_extract(trigram,"[a-zõäöü]+$")) %>% 
  filter(firstw==lastw)


#' 
#' Keskmise sõna saaks kätte otsides sõnaäärseid tühikuid str_extract(trigram, " [a-zõäöü]+ "). Olles eraldanud sõna eraldi tulpa, võime sama tulpa käsitleda ka tekstina järgmisteks operatsioonideks. Kasutades olemasolevat informatsiooni, leia kõik fraasid, kus kõik kolm sõna on täpselt samad.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------








#---------------------------------------------


#' 
#' 
#' ## Märksõnade leidmine
#' 
#' Siiani oleme püüdnud leida tekstist meid huvitavaid sõnu eemaldades ebahuvitavad stopsõnad või otsides konkreetseid fraase, mis meile silma jäävad. Tekstitöötluses on üpris palju eri meetodeid ka selleks, et püüda välja arvutada huvitavad sõnad või fraasid mõne teksti kohta. Antconc-is sai seda teha märksõnaotsingu alusel - mida suurem keyness väärtus märksõnal oli, seda rohkem ta oli eriline sellele tekstile.
#' 
#' Üks viis selliseid märksõnu leida, mis on ka tidytext paketti sisse kirjutatud on tf-idf, see tähendab term frequency - inverse document frequency. Loe täpsemat sisu siit https://en.wikipedia.org/wiki/Tf-idf. Selle valemi aluseks on vaist, et kui sõna on sage ühes dokumendis, aga seda teistes tekstides tihti ei leidu, võiks seda pidada seda teksti eristavaks teistest ehk selle teksti märksõnaks. Selle arvutamiseks loetakse kokku kui palju on üht sõna konkreetses tekstis või tekstide kogumis ning korrutatakse läbi arvuga, mis iseloomustab kui paljudes tekstides seda on. Erinevaid variante sellest valemist on mitmeid ja see, milline neist on sobivaim konkreetse küsimuse lahendamiseks võib sõltuda korpuse suurusest, iseloomust või küsimusest endast. Üldjoontes annavad enamik neist mõistlikke tulemusi.
#' 
#' Niisiis, sõna, mis on üldiselt korpuses haruldane, aga sage selles tekstis on sõna, võiks olla selle teksti jaoks eristavaks märksõnaks. Sõnad, mida on palju kõikides tekstides ei erista seda teksti teistest. Samas sõnad, mis on eriti sagedased ühes tekstis võivad siiski osutuda märksõnadeks isegi kui neid on paljudes muudes tekstideski. Teisest küljest sõnad on üldiselt haruldased ning esinevad selles tekstis ainult paar korda, võivad nad juba hästi eristada seda teksti teistest. Tulemus sõltub täpsest valemist, mida on hetkel rakendatud.
#' 
#' Tidytext paketis on selle hõlpsaks leidmiseks olemas oma käsk bind_tf_idf(). See käsk liidab andmestikule tf-idf märksõnalisuse määrad. bind_tf_idf() võtab sisendiks sõna, grupeeriva tulba ning sõna sageduse igas grupis ning võrdleb seda sõna esinemisega teistes gruppides. Käsk teeb arvutustöö kõikide sõnade kohta ning liidab tulemused andmestikuga. Mida suurem on tf-idf, seda märgilisem on see sõna selle grupi jaoks.
#' 
#' Niisiis, saame käsu abiga hõlpsasti tuvastada teatud gruppi eristavad sõnad. Näiteks arvutame alustuseks artiste eristavad sõnad. Arvutame artiste teistest eristavad sõnad. Kuna me oleme seni kasutanud peatükis ainult fraase, siis arvutame kõigepealt laulusõnad. 
#' 
## ----------------------------------------------------------------------------------

laulusonad <- edetabel %>% 
  unnest_tokens(word,lyrics)


#' 
#' Leidmaks tf-idf märksõnu, loendame sõnu artistide kaupa ning siis juhendame, bind_tf_idf() funktsiooni, et ta kasutaks seda informatsiooni oma mõõdikute välja arvutamiseks. Lõpuks järjestame sõnad tf_idf alusel, kus suurem väärtus näitam suuremat eristusjõudu.
#' 
## ----------------------------------------------------------------------------------


tf_idf <- laulusonad %>%
  group_by(artist) %>%
  count(word) %>%
  bind_tf_idf(word, artist,n) %>%
  arrange(desc(tf_idf))



#' 
#' Vaatame tabelit esialgu ise lähemalt.
#' 
## ----------------------------------------------------------------------------------

View(tf_idf)


#' 
#' Tabelis näeme, et eristavad sõnad on väga tihti needsamad, mis olid väga sagedased teatud artistidele. See on parasjagu nii, kuna need olid ühtlasi sõnad, mida teised artistid kasutasid väga vähe. Näiteks satelliidid, Maiu ja piimaauto on üldiselt lauludes harva kasutatavad sõnad.
#' 
#' Põnevamaks muutub see määr kui püüda vaadata mõne konkreetse artisti eristavaid märksõnu.Smilersi puhul on levinud sõnad ja, ma, ei ikkagi tipus, kuna neid kasutatakse nende lugudes läbivalt väga palju. Haruldasemad sõnad ilmnevad hiljem, aga on siiski kohal teises kümendis
#' 
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  group_by(artist) %>%
  count(word) %>%
  bind_tf_idf(word, artist,n) %>%
  arrange(desc(tf_idf)) %>%
  filter(artist=="Smilers") %>%
  filter(row_number()<21)


#' 
#' Artistil, millel on lugusid korpuses vähem, on ka rohkem esil mõne üksiku loo märksõnad. Näiteks Nublul on korpuses kaks lugu ning sõnad, mis kordusid neis lugudes tihti, on selgelt esil. Nt ou, mina, ka.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  group_by(artist) %>%
  count(word) %>%
  bind_tf_idf(word, artist,n) %>%
  arrange(desc(tf_idf)) %>%
  filter(artist=="Nublu")


#' 
#' Mõnikord ei kasutatudki palju erinevaid sõnu. Näiteks artistil Koer saab need sõnad peaaegu kahe käe sõrmedel kokku lugeda ja ainult seetõttu, et ühe sõna iga täht on ka eraldi välja öeldud. Siiski on näha, et 'on' on neil kõige vähem eristavam sõna.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  group_by(artist) %>%
  count(word) %>%
  bind_tf_idf(word, artist,n) %>%
  arrange(desc(tf_idf)) %>%
  filter(artist=="Koer")


#' 
#' Keskmise laulude hulgaga artistidel tulevad samuti märksõnad üksikutest lauludest esile. Nt Kuldsel Triol hopp, johanna, vodka, laika jne on kõik sõnad, mis on korpuses üldiselt väga haruldased, aga nende lugude seas piisavalt sagedased. See, millised sõnad selle valemiga esile tulevad sõltub niisiis nii korpuse iseloomust kui ka tekstide enda suurusest ja kujust. Selleks, et nendest seostest paremini aru saada, tasub katsetada erinevate tekstide puhul, et mis märksõnad peale jäävad. Mõnikord võib lisada neile lisafiltreid - näiteks jätta üldse kõrvale sõnad, mis on väga haruldased või väga tihti kasutatud.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  group_by(artist) %>%
  count(word) %>%
  bind_tf_idf(word, artist,n) %>%
  arrange(desc(tf_idf)) %>%
  filter(artist=="Kuldne Trio")


#' 
#' Proovi ise! Vali välja üks artist ning leia selle artisti kõige eristavamad sõnad.
#' 
## ----------------------------------------------------------------------------------


#---------------------------------------------






#---------------------------------------------


#' 
#' Proovi ise! Vali välja ka üks laul ning proovi leida eristavad sõnad selle laulu kohta.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------



#' 
#' 
#' ## Sõnastik
#' 
#' - unnest_tokens() - segmenteeri tekst ühikute kaupa
#' - unnest_tokens(word, lyrics, token = "ngrams", n = 1, n_min = 1) - segmenteeri tekst sõnedeks
#' - unnest_tokens(bigram, lyrics, token = "ngrams", n = 2, n_min = 2) - segmenteeri tekst bigrammideks
#' - unnest_tokens(trigram, lyrics, token = "ngrams", n = 3, n_min = 3) - segmenteeri tekst trigrammideks
#' - str_detect(muutuja, "sõne") - kontrolli, kas tekstis on selline järjend. võib kasutada regulaaravaldisi
#' - str_extract(muutuja, "sõne") - võta välja tekstist sellele järjendile vastavad osad. võib kasutada regulaaravaldisi
#' - bind_tf_idf() - liidab andmestikule tf-idf märksõnalisuse määrad
#' 
#' 
#' ## Harjutusülesanded
#' 
#' 
#' 1. Leia populaarseimad bigrammid 1990ndatel aastatel.
#' 
#' 2. Leia kõik trigrammid, mis algavad sõnaga "ma "
#' 
#' 3. Leia kõige rohkem ühe loo sees korduvad trigrammid.
#' 
#' 4. Millised märksõnad eristavad aastat 2000 teistest aastatest?
#' 
#' 5. Millised märksõnad eristavad eristavad Smilersi edukaimat laulu teistest Smilersi lauludest?
#' 
