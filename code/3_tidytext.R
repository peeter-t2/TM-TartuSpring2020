#' ---
#' title: "R ja RStudio"
#' author: "Peeter Tinits"
#' output: html_document
#' ---
#' 
#' 
#' # Tidytext ja tekstitöötlus
#' 
#' Selles peatükis teeme esimest tutvust tidytext paketiga, mis on loodud tidyverse stiilis tekstitöötluseks R-is. See pakett ei suuda teha kõike ja ei pruugi olla alati ka kõige kiirem, aga teeb siiski ära lihtsama tekstitöötluse, mida meil vaja võib minna. Kui tekib huvi juurde õppida, siis selle paketi enda juhend on siin https://www.tidytextmining.com/.
#' 
#' Kui me alustasime R-i programmi uuesti on tarvis kõigepealt sisse lugeda paketid.
#' 
## ----------------------------------------------------------------------------------

library(tidyverse)


#' 
#' tidytext pakett on tidyverse põhipaketist eraldi ning seetõttu tuleb eraldi sisse lugeda. Kui seda pole varem installitud, siis utleb ta ka installida.
#' 
## ----eval=F------------------------------------------------------------------------
## 
## install.packages("tidytext")
## 

#' 
## ----------------------------------------------------------------------------------

library(tidytext)


#' 
#' Kui me käivitasime R-i uuesti, siis on meil vaja töötamiseks ka andmefail uuesti sisse lugeda.
#' 
## ----------------------------------------------------------------------------------

edetabel <- read_tsv("data/eesti_top40/eesti_skyplus_top40_1994-2018.tsv")



#' 
#' 
#' ## unnest_tokens()
#' 
#' Peamine käsk, mis aitab meil tekstidega R-is töötada on unnest_tokens(). unnest_tokens() võtab sisendiks ühe tekstitunnuse ning jaotab ta mingil alusel elementideks (tokeniseerib). Näiteks siis saab teha tekstidest sõnaloendi. Kui see on tehtud asetab ta iga elemendi omale reale, järgides tidy data põhimõtteid, et meil peaks olema üks vaatlusobjekt rea kohta. Lisaks eemaldab ta tekstist numbrid, kirjavahemärgid, suurtähed ning teeb muud eeltöötlust, et eraldada elemendid tekstist.
#' 
#' unnest_tokens() - muudab andmestikku nii et iga tekstitunnuse element oleks omal real.
#' 
#' 
#' Vaatame kõigepealt selle lihtsamat tulemust. Järgmine käsk võtab andmestiku tunnnuse lyrics, teeb selle elementideks (mis on vaikimisi sõnad) ning salvestab kõik 'word' nimelisse tulpa.
#' 
## ----------------------------------------------------------------------------------

edetabel %>%
  unnest_tokens(word,lyrics)



#' 
#' Kui meil varem oli üks lugu tabelis iga rea kohta, siis nüüd on meil igal real üks sõna sellele kaasneva metainfoga. Ehk näha on midagi sellist.
#' 
## ----------------------------------------------------------------------------------
# A tibble: 157,632 x 9
# year  rank votes artist    song      filename                   source language word          
# <dbl> <dbl> <dbl> <chr>     <chr>     <chr>                       <dbl> <chr>    <chr>         
#   1  1994     1    NA Ummamuudu Kõnõtraat lyrics-ummamuudu-konotraat      1 et       välän         
# 2  1994     1    NA Ummamuudu Kõnõtraat lyrics-ummamuudu-konotraat      1 et       külmetas      
# 3  1994     1    NA Ummamuudu Kõnõtraat lyrics-ummamuudu-konotraat      1 et       ja            
# 4  1994     1    NA Ummamuudu Kõnõtraat lyrics-ummamuudu-konotraat      1 et       taivast       
# 5  1994     1    NA Ummamuudu Kõnõtraat lyrics-ummamuudu-konotraat      1 et       satas         
# 6  1994     1    NA Ummamuudu Kõnõtraat lyrics-ummamuudu-konotraat      1 et       lummõ    

#' 
#' 
#' Kuna me kasutame seda andmekuju korduvalt ja tokeniseerimine võtab iga kord veidi aega, salvestame selle töötluse tulemuse ja viitame edaspidi juba töötluse lõpptulemusele.
#' 
## ----------------------------------------------------------------------------------

laulusonad <- edetabel %>%
  unnest_tokens(word,lyrics)


#' 
#' Selle tabeliga saame teha samasuguseid operatsioone kui edetabeliga enne. Näiteks võime võtta kõik sõnad, mis on ühelt bändilt.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  filter(artist=="Smilers")

laulusonad %>%
  filter(artist=="Terminaator")

laulusonad %>%
  filter(artist=="Ummamuudu")


#' 
#' 
#' Proovi ise! Vali välja üks artist ning võta tabelist välja ainult nende kasutatud sõnad
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' 
#' 
#' ## Sagedussõnastikud
#' 
#' Et sõnade valikutest midagi huvitavat teada saada, võime hakata neid loendama - ehk siis teha sagedussõnastiku.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  count(word,sort=T)


#' 
#' Nagu näeme, on enimkasutatud sõnad ka lauludes enamvähem samad kui keeles üldiselt. On, ja, ei, ma, kui, sa jne.
#' 
#' Me võime filtrite abil koostada ka sagedussõnastiku mõnele üksikule artistile ja vaadata neid ühekaupa.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  filter(artist=="Põhja-Tallinn") %>%
  count(word,sort=T)

laulusonad %>%
  filter(artist=="Ummamuudu") %>%
  count(word,sort=T)


laulusonad %>%
  filter(artist=="Nublu") %>%
  count(word,sort=T)



#' 
#' Proovi ise! Vali välja üks artist ning vaata nende enimkasutatud sõnu.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' ## Stopsõnad
#' 
#' Leiame, et nagu ikka eesti keeles, on ka lauludes levinumad sõnad sidesõnad ja asesõnad ja muu selline. Nagu meil loengust läbi käis on siis tihti kasulik eemaldada stopsõnad, et saada selgemalt aru, mis laule teineteisest erinevad ja millest need lood räägivad.
#' 
#' Me võime kasutada ükskõik, millist tabelit sõnade loendina. Eesti keele jaoks on olemas hea stopsõnade loend siin http://datadoi.ut.ee/handle/33/78. Loeme selle sisse eraldi tabelina.
#' 
## ----------------------------------------------------------------------------------

stopsonad <- read_tsv("data/uiboaed_stopwords/estonian-stopwords.txt",col_names = "word")


#' 
#' Nüüd on meil kaks tabelit ja me soovine neid omavahel võrrelda ja ühendada. Selleks on olemas tidyverse paketis join() käsud. join() käsud võtavad tabelis ühe või mitu tunnust ning proovib seda klapitada valitud tunnuse või tunnustega teises tabelis. Kõik read, kus on tunnuste kaupa täpselt sama väärtus on võimalik ühendada. Teistes pakettides kasutatakse siin merge() käsku, mis töötab sama loogikaga. Vaatame kõigepealt pildiülevaadet juhendis.
#' 
#' 
#' ![](figures/joins.png)
#' 
#' 
## ----echo=F, eval=F----------------------------------------------------------------
## library(grid)
## grid.newpage(); grid.raster(png::readPNG("figures/joins.png"))
## 

#' 
#' Pildi peal on kujutatud see ridadehulk, mis alles jääb. Täpsemalt öeldes, left_join() hoiab esimese tabeli terviklikuna. right_join() hoiab teise tabeli terviklikuna. inner_join() hoiab alles ainult kattuvad read. full_join() hoiab mõlemad tabelid terviklikuna. Ning anti_join() eemaldab teise tabeliga kattuvad read esimesest tabelist.
#' 
#' -left_join() - liidab vasakpoolse andmestiku külge need read, mis sobivad paremast.
#' - right_join() - liidab parempoolse andmestiku külge need read, mis sobivad vasakust.
#' - inner_join() - jätab alles ainult sobivad read kummastki
#' - full_join() - jätab alles kõik read mõlemast tabelist, isegi kui ükski ei kattu.
#' - anti_join() - töötab vastupidiselt ja eemaldab vasakust kõik read, mis ühtivad parempoolse tabeliga.
#' 
#' Hetkel on meil kaks tabelit. Käivita järgmised read, et neid näha.
#' 
## ----------------------------------------------------------------------------------

laulusonad
stopsonad


#' 
#' Nüüd, liidame tabeli 'laulusonad' tabeliga 'stopsonad', kasutades inner_join() funktsiooni ja teeme seda "word" nimelise tulba kaudu, mis on mõlemas tabelis olemas. Tegelikult otsivad tidyverse join() käsud ka ise samanimelisi tulpasid ja kui neile täpsemaid juhiseid pole antud, siis ühendavad need. Kui me tegeleme uue andmestikuga on kasulik see alati välja kirjutada, et ei tekiks vigu.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  inner_join(stopsonad,by="word")


#' 
#' See käsk niisiis leidis ainult kattuvad read kahes tabelis ning seeläbi jättis alles kõikidest lugudest ainult stopsõnad. Kui meid huvitavad näiteks asesõnade kasutus või sõnakordused, siis võimalik, et täpselt see meid huvitabki.
#' 
#' Me võime proovida neid kahte tabelit liita left_join() funktsiooni kaudu. Sellega küll ei muutu midagi, kuna liidetud tabel stopsonad sisaldabki ainult ühte tulpa, ning liidetud sõnad sulanduvad esimesse tabelisse.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  left_join(stopsonad,by="word")


#' 
#' Et kattuvad read ära markeerida võime teha stopsõnade tabelisse uue tulba, mis märgib, et on tõene, et see sõna on stopsõna.
#' 
## ----------------------------------------------------------------------------------

stopsonad2 <- stopsonad %>%
  mutate(onstopsona=TRUE)


#' 
#' Kui me nüüd ühendame tabelid left_join() kaudu, siis saame kaasa ka selle lisatulba.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  left_join(stopsonad2,by="word")



#' 
#' Lihtsa väljundina võime näiteks kokku lugeda kumba on kui palju on kokku neid stopsõnu ja kui palju on muid sõnu (ehk neid, millel puudub informatsioon selle kohta, kas ta on stopsõna).
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  left_join(stopsonad2,by="word") %>%
  count(onstopsona)


#' 
#' Seal näeme, et teksti koguhulgast on stopsõnu veidi alla poole ja veidi üle poole on kõiki muid sõnu.
#' 
#' Samal põhimõttel võime ka leida kõige stopsõnaderikkama laulu.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  left_join(stopsonad2,by="word") %>%
  group_by(artist,song) %>%
  count(onstopsona) %>%
  mutate(proportsioon=n/sum(n)) %>% #  proportsiooni võime arvutada jagades loendatud arvu kõikide arvude summaga.
                                    #  kuna tabel on ikka veel gruppideks jaotatud, siis seda loetakse iga artisti-laulu sees
  filter(onstopsona==TRUE) %>%
  arrange(desc(proportsioon))



#' 
#' Ja saame loo HND 'Kui sa vaid saad', millel on kolm neljandikku sõnu stopsõnad. Ainuüksi pealkiri koosnebki ainult stopsõnadest.
#' 
#' Proovi ise! Vali välja üks artist ja vaata milliseid stopsõnu nad kasutavad ja kui palju.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' Enamasti on aga stopsõnade nimekiri kasulik, et need sõnad tekstist eemaldada. Näiteks võime võtta sama tabeli ja jätta alles ainult sõnad, mis ei ole stopsõnad. Selleks kasutame algusest tuttavat funktsiooni is.na(), mis kontrollib kas väärtus on puuduv. onstopsona == NA ei töötaks, kuna R-i jaoks on puuduvad väärtused erilised.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  left_join(stopsonad2,by="word") %>%
  filter(is.na(onstopsona))


#' 
#' Täpselt sama teeb ka käsk anti_join(), mis jätab kõrvale kõik read, kus tunnused on sama väärtusega. Seda kasutame ka edaspidi.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  anti_join(stopsonad,by="word")


#' 
#' Sellega loendada kokku kõik sõnad, mis pole stopsõnad ja teha neist sagedustabeli.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  count(word,sort=T)


#' 
#' Nüüd näeme veel üht probleemi meie sõnaloendis. Paljud lood on ingliskeelsed ja seal on ka hulk sagedasi sõnu, mis samuti esiotsa pürgivad. Tabelis on olemas ka tunnus loo keele kohta ning selle abil võime piirduda edasi ainult eestikeelsete lugudega. Eestikeelsed lood on siin tähistatud rahvusvahelise tähisega 'et'.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  filter(language=="et") %>%
  count(word,sort=T)


#' 
#' Saadud tabel on juba veidi informatiivsem
#' 
## ----------------------------------------------------------------------------------
# A tibble: 15,823 x 2
# word      n
# <chr> <int>
#   1 ref     360
# 2 täna    325
# 3 tean    296
# 4 hea     289
# 5 aeg     280
# 6 päev    279
# 7 öö      264
# 8 taas    258
# 9 elu     257
# 10 jälle   226

#' 
#' 
#' ref viitab siin refräänile. muidu on sagedased päev, öö, taas, jälle, hea, aeg, täna, tean. Olenevalt sellest, mis meid huvitab, tasub meil stopsõnadenimekirja žanrile kohandada. Näiteks võime siin lisaks stopsõnadele tabelist välja võtta ka sõna 'ref'.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  filter(language=="et") %>%
  count(word,sort=T) %>%
  filter(!word %in% c("ref")) #Hüüumärk näitab eitust


#' 
#' Salvestame selle tabeli samuti edasiseks kasutuseks.
#' 
## ----------------------------------------------------------------------------------

sonaloend <- laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  filter(language=="et") %>%
  count(word,sort=T) %>%
  filter(!word %in% c("ref"))


#' 
#' 
#' ## Võrdlus teise korpusega
#' 
#' Me võime nüüd mõelda, kui tüüpiline meie laulusõnade korpus on võrreldes keelega üldisemalt. Nagu loengutes sai räägitud, on selleks kasulik vaadata sõnade suhtelist osakaalu korpuses, mitte absoluutarvu, kuna tekstikogude suurused võivad olla väga erinevad. Niisiis saame jagada leitud sõnade arvu kõikide sõnade arvu hulgaga, saades kätte millise proportsiooni see sõna tervikkorpusest moodustab.
#' 
## ----------------------------------------------------------------------------------

sonaloend %>%
  mutate(proportsioon=n/sum(n))


#' 
#' Meil on võimalik seda proportsiooni võrrelda eesti ilukirjandusest tehtud korpusega. Ühe sellise korpuse kohta on sõnasageduste statistika saadaval siin. http://datadoi.ut.ee/handle/33/41. Loeme sisse sõnade sageduse info.
#' 
## ----------------------------------------------------------------------------------

ilukirj_sonad <- read_tsv("data/raudvere_uiboaed_mitmikud/token_1_grams.tsv",col_names = c("word","n_token","n_docs"))


ilukirj_sonad <- ilukirj_sonad %>%
  mutate(prop_ilukirj=round(n_token/sum(n_token),3))


#' 
#' 
#' 
#' Samamoodi nagu stopsõnade puhul, saame me nüüd ühendada need kaks tabelit.
#' 
## ----------------------------------------------------------------------------------

sonaloend %>%
  mutate(proportsioon=n/sum(n)) %>%
  left_join(ilukirj_sonad, by="word")


#' 
#' Vaadates nüüd väljatrükitud esikümmet võime näha, et suhtelise sageduse järgi on aeg, elu, jälle ja kord ikukirjanduses sagedasemad kui lauludes. Samas on öö, päev ja tean, vastupidi, sagedasemad just laulusõnades. Need erinevused võivad olla suuremad keskmise levikuga sõnade kohta.
#' 
#' Proovi vaadata ise mõne valitud sõna kohta, kuidas nende sagedused erinevad.
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------


#' 
#' 
#' Kui meil on stopsõnad eemaldatud, võime ka vaadata kindlate artistide levinumaid sõnu, mis võiksid väljendada ka paremini nende lugude sisu. Niisiis, teeme sagedussõnastikud nende artistide kohta ja vaatame lähemalt.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  filter(artist=="Põhja-Tallinn") %>%
  count(word,sort=T)


laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  filter(artist=="Ummamuudu") %>%
  count(word,sort=T)


laulusonad %>%
  anti_join(stopsonad,by="word") %>%
  filter(artist=="Nublu") %>%
  count(word,sort=T)



#' 
#' 
#' Proovi ise! Vali välja üks artist ning vaata nende enimkasutatud sõnu ilma stopsõnadeta.
#' 
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------






#---------------------------------------------



#' 
#' 
#' ## Kordused laulu sees
#' 
#' Just laulusõnade puhul võib isegi artistidest huvitavamaks osutuda üksiklaulude vaatamine. Näiteks, kuna paljudel lauludel on refräänid (mõnikord on need küll andmetes ainult üks kord), siis võib oodata neil palju sõnakordusi.
#' 
#' Et teha sõnaloendeid laulude kohta, grupeerime tabeli kõigepealt laulude kaupa ning mõõdame sõnasagedusi sellel põhjal. Me võime siis vaadata näiteks kui suure osa kogu laulu sõnadest moodustab mõni konkreetne sõna.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>%
  filter(language=="et") %>%
  group_by(artist, song) %>%
  count(word,sort=T) %>%
  filter(!word %in% c("ref")) %>%
  mutate(proportsioon=n/sum(n)) %>%
  arrange(desc(proportsioon))


#' 
#' Saame tulemuseks, et laulus satelliidid esineb sõn satelliidid 36 korda, see on üle poole sisust.
#' Samas kui laulus Maiu on piimaauto, on nii maiu, on kui piimaauto 16 korda, ehk 20% kõigist sõnadest.
#' 
#' Proovi ise! Kui lugeda mitte proportsiooni järgi vaid koguarvult, siis mis sõna on kõige rohkem ühe laulu sees kordumas ja mis laulus?
#' 
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------





#---------------------------------------------




#' 
#' 
#' Kui palju muutub tabel kui eemaldada stopsõnad?
#' 
## ----------------------------------------------------------------------------------

#---------------------------------------------








#---------------------------------------------


#' 
#' 
#' 
#' ## Asukoht tekstis
#' 
#' Kasutades etteantud vahendeid on võimalik ka esitada küsimusi sõnade asukoha kohta. Näiteks, et kui laul kasutas sõna satelliidid nii palju kordi, siis kas seda laulu lõpus või alguses või läbivalt igal pool. Selleks saame kasutada käske group_by(), mutate() ja row_number(). Nimelt, et kui me vaatasime eelmises peatükis edetabeleid row_number() kaudu, siis nüüd võime kasutada seda ka sõnadel nende loomulikus järjekorras. Numbrid ühest kuni loo pikkuseni viitavad sõna asukohale tekstis.
#' 
#' Niisiis, saame iga laulu sees sõna asukoha grupeerides laulud eraldi ning lisades uue tulba row_number().
#' 
## ----------------------------------------------------------------------------------

laulusonad %>% 
  group_by(artist,song,year) %>% 
  mutate(nr=row_number())



#' 
#' Kuna lood on erineva pikkusega, siis on võrdluse huvides ehk kasulik vaadata loo pikkust protsentidena. Selleks võime lisada ka loendi n() kaudu. mutate() võimaldab nii lisada mitu uut tunnust.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>% 
  group_by(artist,song,year) %>% 
  mutate(nr=row_number(), n=n())


#' 
#' Ja kui meil on olemas nii rea number kui ridade arv võime välja arvutada sõna suhtelise asukoha. Lisame selleks tunnusele n ühe, et kõik tulemused oleks väiksem kui üks. 
#' 
## ----------------------------------------------------------------------------------

laulusonad %>% 
  group_by(artist,song,year) %>% 
  mutate(nr=row_number(), n=n()) %>% 
  mutate(asukoht=nr/(n+1))


#' 
#' Selle tulemuse põhjal saame arvutada, millisel kümnendikul loos sõna paikneb. Selleks võime korrutada asukoha, mis on nullist üheni, kümnega, et saada vahemiku 0-st 10-ni ja iga tulemuse ümardada alla, et kätte saada, millises kümnendikus sõna esines. Kui me jagame selle uuesti 10-ga saame kätte väärtused 0, 0.1, 0.2 ... 0.9.
#' 
## ----------------------------------------------------------------------------------

laulusonad %>% 
  group_by(artist,song,year) %>% 
  mutate(nr=row_number(), n=n()) %>% 
  mutate(asukoht=nr/(n+1)) %>% 
  mutate(asukoht_perc=floor(asukoht*10)/10)



#' 
#' Et me kasutame seda korduvalt võime jälle selle salvestada.
#' 
## ----------------------------------------------------------------------------------

asukohad <- laulusonad %>% 
  group_by(artist,song,year) %>% 
  mutate(nr=row_number(), n=n()) %>% 
  mutate(asukoht=nr/(n+1)) %>% 
  mutate(asukoht_perc=floor(asukoht*10)/10)%>% 
  ungroup()



#' 
#' Ja siis võime näiteks vaadata sõnu, mis palju kordi kordusid. Salvestame selle ka muutujana.
#' 
## ----------------------------------------------------------------------------------

kordused <- laulusonad %>%
  filter(language=="et") %>%
  group_by(artist, song,year) %>%
  count(word,sort=T) %>%
  filter(!word %in% c("ref")) %>%
  mutate(proportsioon=n/sum(n)) %>%
  arrange(desc(proportsioon)) %>% 
  ungroup()


#' 
#' Võtame 20 kõige enam ühe loo sees korratud sõna ja ühendame selle asukohtade tabeliga nii, et kattuvad nii artist, laul, aasta kui ka sõna. Salvestame selle tulemuse ja vaatame sisse.
#' 
## ----------------------------------------------------------------------------------

asukohad_ja_kordused <- kordused %>% 
  filter(row_number()<21) %>% 
  inner_join(asukohad,by=c("artist","song","year","word"))


#' 
#' Seejärel võime kokku lugeda, et kui palju neid sellel protsendil on.
#' 
## ----------------------------------------------------------------------------------

kus_on_kordused <- asukohad_ja_kordused %>% 
  group_by(artist,song,year,word) %>% 
  count(asukoht_perc) 


#' 
#' Ülalolevast tabelist on küll raske ülevaadet saada, kuna see on pikk rodu numbreid ja mõned on puudu. R-is on tabelite pööramiseks hulk käske, tidyverse-is on selleks pivod_wider() ja pivot_longer(), mis teevad siis vastavalt tabeli laiaks horisontaalskaalal või pikaks vertikaalskaalal. pivot_wider() puhul määrame ära, millised tulbad jäävad nii-öelda paigale, id-tulpadeks, ja millised lahutame lahti.
#' 
#' ![](figures/pivot_wider_tidybook.png)
#' 
#' Laotame siis tabeli laiali ja vaatame, kus on need sagedasi korduvad sõnad.
#' 
## ----------------------------------------------------------------------------------

kus_on_kordused %>%
  arrange(asukoht_perc) %>%
  pivot_wider(id_cols=c("artist","song","year","word"),names_from="asukoht_perc",values_from="n")


#' 
#' Siit tabelist on näha, et 'sinine' ja 'vilkur' on Meie Mehe loos Sinine vilkur üsna läbivalt. Samas 'veel' Anaconda laulus Veel Veel Veel ainult alguses ja lõpus. Beebilõust räägib 'mentidest' läbivalt, sõnad oo ja na on aga ainult laulude lõpus. Nende fraasidega võiks saada proovida läbi teiste lugude ka statistikat koguda. Siin tuleb küll silmas pidada, et laulusõnad on veidi erinevas formaadis ja mõnel neist ei ole korduv refrään taas uuesti kirjutatud, vaid on kasutatud lihtsalt sõna ref uuesti. Et täpsemalt analüüsi tuleks andmeid ka lähemalt ise vaadata.
#' 
#' 
#' ![](figures/pivot_longer_tidybook.png)
#' 
#' Kui me tahame laia tabeli taas pikaks teha, kasutame funktsiooni pivot_longer(). pivot_longer() tahab teada, milliseid tulpi lahutada ja mis kahe uue tulba nimeks panna.
#' 
## ----------------------------------------------------------------------------------

kus_on_kordused %>%
  arrange(asukoht_perc) %>%
  ungroup() %>% 
  pivot_wider(id_cols=c("artist","song","year","word"),names_from="asukoht_perc",values_from="n") %>% 
  mutate(year=as.character(year)) %>% 
  pivot_longer(cols=starts_with("0"), names_to="asukoht_perc", values_to="n")


#' 
#' 
#' 
#' Proovi ise! Vali mõni lugu ja sõna selles ning vaata, mis asukohtadel ta esineb.
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
#' - unnest_tokens() - võtab tekstijupi ja jupitab selle mingil alusel ja paneb iga jupi eraldi reale.
#' - left_join() - liidab vasakpoolse andmestiku külge need read, mis sobivad paremast.
#' - right_join() - liidab parempoolse andmestiku külge need read, mis sobivad vasakust.
#' - inner_join() - jätab alles ainult sobivad read kummastki
#' - full_join() - jätab alles kõik read mõlemast tabelist, isegi kui ükski ei kattu.
#' - anti_join() - töötab vastupidiselt ja eemaldab vasakust kõik read, mis ühtivad parempoolse tabeliga.
#' - group_by() - grupeeri andmestik mõne tunnuse alusel
#' - ungroup() - vii andmestik grupeerimata kujule
#' - pivot_wider() - vii tabel laiaks
#' - pivot_longer() - vii tabel pikak
#' 
#' ## Harjutusülesanded
#' 
#' 
#' 1. Millised olid levinuimad sõnad Vaiko Epliku sõnavaras?
#' 
#' 2. Millised olid levinuimad sõnad Vaiko Epliku sõnavaras kui eemaldada ka stopsõnad?
#' 
#' 3. Milline oli levikult kolmeteistkümnes sõna kõigis eestikeelsetes tekstides?
#' 
#' 4. Mitu sõna esines kõigil 25-l aastal?
#' 
#' 5. Leia sõnad, mida korrati kõige rohkem laulu teises pooles.
