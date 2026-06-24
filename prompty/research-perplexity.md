# Prompty do Perplexity - gdy nie wiesz, co wpisac

Czasem przy budowie kontekstu (M1) albo kart (M3) padnie pytanie, na ktore nie masz od razu odpowiedzi: kim jest moja persona, jak nazwac oferte, jakie CTA, czym sie wyroznic. To normalne. Zamiast zgadywac, otworz [Perplexity](https://www.perplexity.ai) i uzyj gotowego promptu z tej listy. Skopiuj, uzupelnij pola w `[nawiasach]`, wklej. Potem wroc do Claude Code z gotowa odpowiedzia.

Zasada: Perplexity podaje pomysly i punkt wyjscia. Decyzje podejmujesz Ty - bierzesz to, co pasuje do Ciebie i Twoich realnych klientow.

---

## Persona - komu pomagam

**Kiedy:** w M1 (skill kontekst), gdy nie umiesz opisac idealnego klienta.

```
Jestem [czym sie zajmujesz, np. trenerka sprzedazy dla malych firm]. Sprzedaje [oferta].
Pomoz mi opisac mojego idealnego klienta:
- kim jest (rola, etap, sytuacja),
- z czym sie boryka na co dzien,
- jakimi DOSLOWNYMI slowami opisuje swoj problem,
- czego juz probowal i czemu nie zadzialalo,
- co go blokuje przed zakupem takiej oferty jak moja.
Daj 2 rozne warianty persony i przy kazdym 3-5 prawdziwie brzmiacych cytatow.
```

---

## Oferta i pozycjonowanie - czym sie wyroznic

**Kiedy:** w M1 (oferta) i M3 (Karta Strategiczna), gdy oferta brzmi jak u wszystkich.

```
Moja oferta to [opis: co dajesz, dla kogo, jaki efekt].
Konkurencja albo alternatywy, ktore klient rozwaza, to [np. inni trenerzy / kursy / robienie tego samemu].
Pomoz mi spozycjonowac te oferte:
- jaka jest jej najmocniejsza, konkretna obietnica,
- czym realnie roznie sie od alternatyw (nie ogolniki),
- jakie 3 zdania na stronie glownej najjasniej to pokaza.
Pisz prostym jezykiem, bez marketingowego belkotu i bez slow typu "kompleksowo", "synergia", "rozwiazania".
```

---

## Naglowki i CTA - co napisac na gorze strony

**Kiedy:** w M3 (Karta Strategiczna i Architektury), gdy nie wiesz, jaki naglowek albo tekst przycisku.

```
Strona jest dla [persona] i ma jeden cel: [np. zapis na rozmowe / kupno / pobranie lead magnetu].
Oferta: [krotki opis].
Zaproponuj:
- 5 naglowkow do sekcji hero (konkretne, mowiace o efekcie dla klienta, nie o mnie),
- 5 tekstow przyciskow CTA (krotkie, jasne, bez "dowiedz sie wiecej"),
- 3 podtytuly, ktore rozwijaja naglowek jednym zdaniem.
Polski, ludzki ton.
```

---

## Dowody i obiekcje - co moze powstrzymac klienta

**Kiedy:** w M3 (Karta Strategiczna - dowody, oraz sekcja FAQ).

```
Sprzedaje [oferta] dla [persona].
Wypisz typowe obiekcje, ktore taka osoba ma przed zakupem (cena, czas, "czy to dla mnie", zaufanie, czy sobie poradze).
Przy kazdej obiekcji zaproponuj, jak ja rozbroic na stronie: jakim zdaniem, jakim dowodem (opinia, liczba, gwarancja, przyklad).
Daj tez 6 pytan do sekcji FAQ z krotkimi, szczerymi odpowiedziami.
```

---

## Analityka - skad wziac potrzebne ID (do M7)

**Kiedy:** w M7 (skill analityka), gdy skill prosi o ID, a Ty nie wiesz, gdzie je znalezc.

```
Jestem osoba nietechniczna. Wytlumacz mi krok po kroku, prostym jezykiem,
jak zalozyc konto Google Analytics 4 i znalezc Measurement ID dla mojej strony.
Podaj dokladnie, gdzie klikac, i powiedz, kiedy zaczna splywac pierwsze dane.
```

```
Wytlumacz mi prosto, czym jest Google Tag Manager, jak zalozyc kontener
i skad skopiowac jego ID (zaczyna sie od GTM-). Bez zargonu.
```

```
Jak zalozyc Meta Pixel w Meta Business Manager i gdzie znalezc jego numer (ID)?
Tlumacz jak osobie, ktora pierwszy raz to robi.
```

```
Czym jest weryfikacja w Google Search Console i jak ja przejsc dla mojej strony?
Wytlumacz roznice miedzy weryfikacja przez DNS a przez znacznik meta, prosto.
```

```
Czym jest zgoda na cookies (cookie consent) i kiedy jej potrzebuje, jesli
dodaje na strone Google Analytics i Meta Pixel? Wytlumacz w kontekscie RODO,
prostym jezykiem, bez prawniczego belkotu.
```

---

Nie znalazles tu swojego pytania? Napisz wlasny prompt wedlug wzoru: kim jestes, dla kogo, czego potrzebujesz, w jakiej formie ma byc odpowiedz. Im wiecej konkretu o Tobie i Twoich klientach podasz, tym lepsza odpowiedz.
