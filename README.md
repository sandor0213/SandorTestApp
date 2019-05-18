# SandorTestApp

Feladat: 
Képkeresés. 
Táblázatban megmutatni a keresési előzményeket: a keresett szavat és a szónak megfelelő képet.

Miután a user megnyomta a “Done” gombot, a keresési mezőbe beirt szóval keresés indul. Miután megkaptuk a szervertől a választ, elmentjük a lokális adatbázisban és hozzáadjuk az eredményt a keresési előzménybe. Ha a keresés sikertelen, tehát nem kaptunk képet, akkor ezt jelezni a usernek.

Lokális adatbázisként Realm-ot használni.

URL a kereséshez:
https://api.gettyimages.com/v3/search/images?phrase=
Kell header az authorizációhoz (authorization).
