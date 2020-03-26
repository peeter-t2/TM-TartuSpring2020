# Uuema eesti ilukirjanduse mitmikute loendid

### *Uku Raudvere ja Kristel Uiboaed*
### Tartu Ülikooli raamatukogu ja Eesti Rahvusraamatukogu

## Taust

Alates 01.01.2017 jõustus autoriõiguse seaduse muudatus, mis võimaldab digitaalse objekti töötlemist teksti- ja andmekaeve eesmärkidel tingimusel, et selline kasutamine ei taotle ärilisi eesmärke ([AutÕS § 19 lg 31](https://www.riigiteataja.ee/akt/107072016002#para19lg3b1)). Samal ajal hakkas kehtima ka säilituseksemplari seadus, mille järgi on kirjastustel kohustus loovutada raamatukogudele lisaks füüsilistele ka digitaalsed teosed. Seega on uus olukord laiendanud uuema ja mitmekesisema uurimismaterjali kättesaadavust.

Käesolev töö on esimene katse seda materjali kasutades luua teadlaste ja arendajate jaoks vabalt kättesaadav ressurss.

## Ressurss

Mitmikud on esitatud failidena, ühe-, kahe- ja kolmekaupa. Info on failides tabulaatoriga eraldatud (*tab-delimited*) ja organiseeritud järgnevalt: sõnavorm või mitmik, selle sagedus kõigis allikates kokku, allikate arv, kus vorm või mitmik esines.

Näiteks

    ma ei tea	1410	80

tähendab, et sõnakolmik *ma ei tea* esines materjalis 1410 korda 80 erinevas teoses.

Siin on esitatud uuema eestikeelse ilukirjanduse tekstide põhjal koostatud keeleressursid:
- sõnavormide sagedusloend (`1_grams.txt`),
- sõnavormide bigrammid (`2_grams.txt`),
- sõnavormide trigrammid (`3_grams.txt`),
- algvormide ehk lemmade sagedusloend (`1_grams.txt`),
- algvormide ehk lemmade bigrammid (`2_grams.txt`),
- algvormide ehk lemmade trigrammid (`3_grams.txt`),
- kõigi mitmikute koondfail Excelis, kus iga rühm on eraldi töölehel (`n-grammid-koond.xlsx`).

## Koostamispõhimõtted

Peale teksti puhastamist on algmaterjalis ära märgitud lausete algused (\<s\>) ja lausete lõpud (\</s\>). Seejärel koostasime sõnavormide ehk tekstisõnade, bigrammide ja trigrammide loendid.

Kuna mitmikud sisaldavad ka lause alguse- ja lõpumärgendeid, siis pole võimalik lauseid kokku panna eelnevate ja järgnevate lausetega. Samuti jätsime välja kõik n-grammid, mis esinesid ainult ühes algtekstis, nii et ükski loendis sisalduv sõnajärjend pole kokkuviidav ühe konkreetse allikaga. Niisiis on tekst piisavalt fragmenteeritud ja seda pole võimalik algsel kujul taastada.

## Kasutatud teosed

- @keitivilms: Eesti esimene säutsukogumik, Keiti Vilms, 2017, Tallinn: Tänapäev
- 572 sketši neljas võte, Taavi Novek, 2017, Tartu: Paranoia
- 847: kaheksasada nelikümmend seitse, Piret Lai, 2017, Tallinn: Ersen
- Ajapüüdja: mälestusi Kokora mailt, kogunud Andrus Kasemaa, 2017, Põltsamaa: Vali Press
- Ajatu rahutus, Anett Tuisk, 2017, Tallinn: Printeye
- Apteeker Melchior ja Gotlandi kurat: kriminaalromaan vanast Tallinnast, Indrek Hargla, 2017, Tallinn: Tallinna Raamatutrükikoda
- Aristarkhovi meetod, Tuuli Tolmov, 2017, Tallinn: Tänapäev
- Armastus pärast surma, Toomas Raudam, 2017, Tallinn: Eesti Keele Sihtasutus
- Armuadrale sündind, Sende Lipu, 2017, Hiiumaa: Sõru ots
- Doanizarre udulaam, Indrek Hargla, 2017, Tallinn: Paradiis
- Eesti gootika XX: jutte ja lugusid aastatest 1997-2017, Ervin Õunapuu, 2017, Tallinn: Varrak
- Elukargus, Mati Soonik, 2017, Tallinn: Eesti Raamat
- Eneseväärikusel pole sellega mingit pistmist, Heinrich Weinberg, 2017, Tartu: Fantaasia: Täheveski
- Fööniksi viimane lend, Helen Käit, 2017, Tallinn: Tänapäev
- Hingeside: romaan, Gen Noa, 2017, Tallinn: Pakett
- Homse maailma kirjanikud: esimesed 10 aastat, Sass Henno, 2013, Tallinn: Spring Advertising
- Ja sada surma: romaan, Marje Ernits, 2017, Tallinn: Eesti Raamat
- Juured ja võrsed, Eet Tuule, 2017, Tallinn: Tänapäev
- Jääminek, Mathura [kirjutanud ja kujundanud], 2016, Tallinn: Pakett
- Kaks elu: [ulmeromaan], Aare Tamm, 2017, Tallinn: DiPri
- Kaks küünalt, Ülle Solovjova, 2017, Pärnu: Hea Tegu
- Kas keegi kuuleb mind? , Ketlin Priilinn, 2017, Tallinn: Tänapäev
- Kevadsulased nitševood: nitševood ja aastaajad. II, tekst ja karikatuurid: Raimo Aas, 2017, Tallinn: Ajakiri Pilkaja: Vebelex
- Kingin sulle valgust, Inga Raitar, 2013, Tallinn: I.R.A
- Kirjad tütrele, ehk, Kuidas ma emaks kasvasin ja oma last kogemata maha ei tapnud, Dagmar Lamp, 2017, Tallinn: Post Factum
- Kirjailm kastepiisas, Henn Risto Mikelsaar, 2017, Tallinn: Eesti Raamat
- Kohtumine rotveileritega, Jaan Mikweldt, 2017, Habaja: Kentaur
- Kord õide puhkeb iga aed, Siiri Laidla, 2017, Tallinn: Eesti Raamat
- KrattPunktKomm, Köster, 2017, Tallinn: Eesti Keele Sihtasutus
- Kui tee viis üle jõe, Merilin R. Jürjo, 2017, Tallinn: Pegasus
- Kullakene, Tiit Sepa, 2017, Tallinn: Ersen
- Kustunud suitsud Emajõe ääres, Toots Normann, 2017, Viljandi: Print Best
- Kuu, räägi minuga, Maria Lepmaa, 2017, Pärnu: Hea Tegu
- Kuuvirvendus, Arvo Möldri, 2014, Serga (Võrumaa): Divites Publishing
- Käbi ja känd, Stepan Karja, 2017, Tartu: Ilmamaa
- Küpsiseparadiis 2, ehk, Maskid & maskotid, Kerttu Rakke, 2017, Tallinn: Mitu Juttu
- Lastekirju, Epp Petrone, 2017, Tartu: Petrone Print
- Leikude, Erni Kask, 2017, Tallinn: Eesti Keele Sihtasutus
- Lenda, lenda, lepalind, Marje Ernits, 2017, Tallinn: Eesti Raamat
- Liivakella helinal, Tuule Lind, 2017, Tallinn: Tänapäev
- Liivalaia, Heljo Mänd, 2017, Tartu: Petrone Print
- Linnade põletamine, Kai Aareleid, 2017, Tallinn: Varrak
- Loti naine, Aare Tamm, 2017,  Tallinn: DiPri
- Mees minevikust, Saale Väester, 2017, Habaja: Kentaur
- Mine ja kaota ennast: ühe uitaja reisipäevik Euroopast, Egert Rohtla, 2017, Tallinn: Helios
- Minu Armeenia: aus vastus, Brigitta Davidjants, 2017, Tartu: Petrone Print
- Minu erootika saladus , Armin Kõomägi, 2017, Tallinn: Sebastian Loeb
- Minu helesinine elu, Märt Aimla, 2017, Tallinn: Alfapress
- Minu Iisrael: kuidas tõlkida sabatit, Margit Prantsus, 2017, Tartu: Petrone Print
- Minu Island: tule ja jää sümfoonia, Tarvo Nõmm, 2017, Tartu: Petrone Print
- Minu Tšehhi: parajad Švejkid, Kristel Halman, 2017, Tartu: Petrone Print
- Mu koju tood sa, Heli Künnapas, 2017, Jädivere: Heli Kirjastus
- Muidumiljonärid, Reet Kudu, 2017, Tallinn: Eesti Raamat
- Mõtted, Mihkel Mutt, 2017, Tallinn: Kultuurileht
- Neverland: [romaan inimestevahelistest suhetest], Urmas Vadi, 2017, Tartumaa: Kolm Tarka
- Novembriöö kirjad, Mairi Laurik, 2017, Tallinn: Tänapäev
- Nõiatants, Margus Sanglepp, 2017, Tallnn: Tänapäev
- Nädalalõpp: ühe vana mehe lugu, Valter Väljap, 2017, Tallinn: Varrak
- Olla keegi teine,  Arvo Möldri, 2016, Serga (Võrumaa): Divites Publishing
- On nagu on, Jaak Jõerüüt, 2017, Tallinn: Ajakirjade Kirjastus
- Peidust välja, Reet Made, 2017, Tallinn: Koolibri
- Purunenud elud. Eneken, Silja Vaher, 2017, Pärnu: Hea Tegu
- Põgenemine. 1. osa, Alex Lepajõe, 2017, Tallinn: Jõe ja Laan
- Reeturlik metsavend : Krolli esimene juurdlus, Martin Kukk, 2017, Tallinn: Tänapäev
- Roheline suits, Jüri Kolk, 2017, Tallinn: Post Factum
- Rääkimine vaikimine nutmine: vabaduse seletamatu ilu, Pille Õnnepalu, 2017, Tartu: Henrik
- Röntgennägemisega mees, Margit Peterson, 2017, Habaja: Kentaur
- Rünkrasked pilved, Helju Pets, 2017, Tallinn: Printon Trükikoda
- Saatmata kirjad, Heli Künnapas, 2017, Jädivere: Heli Kirjastus
- Saladus sinu sees, Maria Lepmaa, 2017, Habaja: Kentaur
- San Agustini vereohvrid, Reeli Reinaus, 2017, Tallinn: Tänapäev
- Savimäe: romaan ootamatust pärandist, Rein Põder, 2017, Tallinn: Eesti Raamat
- Sina ei pea mitte imestama, Aleksander Torjus, 2011, Tallinn: Eesti Päevaleht
- Sinu enda valitud teel, Mihkel Tattar, 2017, Elva: Ignis Fatuus
- Sõjaväeluure erukolonelleitnant Räimo Siig ja teised Väikelinna kangelased , Rögiwald Pääbo, 2015, Tallinn: Rögiwalt Pääbo
- Taevakirju, Argo Kasela, 2017, Tallinn: Tallinna Raamatutrükikoda
- Taevatee haigla langeb koomasse, Uido Truija, 2017, Habaja: Kentaur
- Talikarged nitševood: nitševood ja aastaajad, Raimo Aas [tekst ja karikatuurid:] , 2017, Tallinn: Ajakiri Pilkaja: Vebelex
- Targa ja rumala jutud, Triin Soomets, 2017, Lelle: Allikaäärne
- Teine elu, Marilin Karu, 2017, Tallinn: Tänapäev
- Tupiktänavas, Kiiri Saar, 2017, Habaja: Kentaur
- Tööraamat, Katrin Kaarep, 2017, Tallinn: Tänapäev
- Vabatahtlikuna Rios, Vivian Tiiman, 2017, Tallinn: V. Tiiman
- Varjajad, Agnes Kolga, 2017, Tallinn: Tänapäev
- Venna arm, Oliver Berg, 2017, Tallinn: Tänapäev
- Vesi minu veskile: videvikulood, Kaie Bergmann, 2017, Rapla: Rajakaar
- Viimsepäeva laupäeva hommikul: novellid, Martti Kalda, 2017, Tallinn: Tuum
- Vikerkaare taga ja ees, Lea Jaanimaa, 2017, Tallinn: L. Jaanimaa
- Virtuaalne kogumik, ehk, "Algernoni" toimetus soovitab,  Indrek Hargla, Kristjan Sander, Karen Orlau, Maniakkide Tänav, Mart Raudsaar, Freya Ek, Juhan Habicht, Siim Veskimees, André Trinity, Elläi Tuulepäälse, Meelis Friedenthal, Erkki Kõlu, Marat Faizijev, August Chang, Taivo Rist, Laur Kraft, Eesti Ulmeühing, 2017, Tallinn: Eesti Ulmeühing
- Õhku joonistatud naeratus, Margit Sarapik, 2017, Tallinn: Tänapäev
- Ühe laulu lugu, Aare Tamm, 2017,  Tallinn: DiPri
- Трудовая книжка = Tööraamat, Merilin Pärli ja Katrin Kaarep, 2017, Tallinn: Tänapäev

