# Prompty do Perplexity - gdy nie wiesz, co wpisać

Czasem przy budowie kontekstu (M1) albo kart (M3) padnie pytanie, na które nie masz od razu odpowiedzi: kim jest moja persona, jak nazwać ofertę, jakie CTA, czym się wyróżnić. To normalne. Zamiast zgadywać, otwórz [Perplexity](https://www.perplexity.ai) i użyj gotowego promptu z tej listy. Skopiuj, uzupełnij pola w `[nawiasach]`, wklej. Potem wróć do Claude Code z gotową odpowiedzią.

Zasada: Perplexity podaje pomysły i punkt wyjścia. Decyzje podejmujesz Ty - bierzesz to, co pasuje do Ciebie i Twoich realnych klientów.

---

## Persona - komu pomagam

**Kiedy:** w M1 (skill kontekst), gdy nie umiesz opisać idealnego klienta.

```
Jestem [czym się zajmujesz, np. trenerka sprzedaży dla małych firm]. Sprzedaję [oferta].
Pomóż mi opisać mojego idealnego klienta:
- kim jest (rola, etap, sytuacja),
- z czym się boryka na co dzień,
- jakimi DOSŁOWNYMI słowami opisuje swój problem,
- czego już próbował i czemu nie zadziałało,
- co go blokuje przed zakupem takiej oferty jak moja.
Daj 2 różne warianty persony i przy każdym 3-5 prawdziwie brzmiących cytatów.
```

---

## Oferta i pozycjonowanie - czym się wyróżnić

**Kiedy:** w M1 (oferta) i M3 (Karta Strategiczna), gdy oferta brzmi jak u wszystkich.

```
Moja oferta to [opis: co dajesz, dla kogo, jaki efekt].
Konkurencja albo alternatywy, które klient rozważa, to [np. inni trenerzy / kursy / robienie tego samemu].
Pomóż mi spozycjonować tę ofertę:
- jaka jest jej najmocniejsza, konkretna obietnica,
- czym realnie różni się od alternatyw (nie ogólniki),
- jakie 3 zdania na stronie głównej najjaśniej to pokażą.
Pisz prostym językiem, bez marketingowego bełkotu i bez słów typu "kompleksowo", "synergia", "rozwiązania".
```

---

## Nagłówki i CTA - co napisać na górze strony

**Kiedy:** w M3 (Karta Strategiczna i Architektury), gdy nie wiesz, jaki nagłówek albo tekst przycisku.

```
Strona jest dla [persona] i ma jeden cel: [np. zapis na rozmowę / kupno / pobranie lead magnetu].
Oferta: [krótki opis].
Zaproponuj:
- 5 nagłówków do sekcji hero (konkretne, mówiące o efekcie dla klienta, nie o mnie),
- 5 tekstów przycisków CTA (krótkie, jasne, bez "dowiedz się więcej"),
- 3 podtytuły, które rozwijają nagłówek jednym zdaniem.
Polski, ludzki ton.
```

---

## Dowody i obiekcje - co może powstrzymać klienta

**Kiedy:** w M3 (Karta Strategiczna - dowody, oraz sekcja FAQ).

```
Sprzedaję [oferta] dla [persona].
Wypisz typowe obiekcje, które taka osoba ma przed zakupem (cena, czas, "czy to dla mnie", zaufanie, czy sobie poradzę).
Przy każdej obiekcji zaproponuj, jak ją rozbroić na stronie: jakim zdaniem, jakim dowodem (opinia, liczba, gwarancja, przykład).
Daj też 6 pytań do sekcji FAQ z krótkimi, szczerymi odpowiedziami.
```

---

## Analityka - skąd wziąć potrzebne ID (do M7)

**Kiedy:** w M7 (skill analityka), gdy skill prosi o ID, a Ty nie wiesz, gdzie je znaleźć.

```
Jestem osobą nietechniczną. Wytłumacz mi krok po kroku, prostym językiem,
jak założyć konto Google Analytics 4 i znaleźć Measurement ID dla mojej strony.
Podaj dokładnie, gdzie klikać, i powiedz, kiedy zaczną spływać pierwsze dane.
```

```
Wytłumacz mi prosto, czym jest Google Tag Manager, jak założyć kontener
i skąd skopiować jego ID (zaczyna się od GTM-). Bez żargonu.
```

```
Jak założyć Meta Pixel w Meta Business Manager i gdzie znaleźć jego numer (ID)?
Tłumacz jak osobie, która pierwszy raz to robi.
```

```
Czym jest weryfikacja w Google Search Console i jak ją przejść dla mojej strony?
Wytłumacz różnicę między weryfikacją przez DNS a przez znacznik meta, prosto.
```

```
Czym jest zgoda na cookies (cookie consent) i kiedy jej potrzebuję, jeśli
dodaję na stronę Google Analytics i Meta Pixel? Wytłumacz w kontekście RODO,
prostym językiem, bez prawniczego bełkotu.
```

---

Nie znalazłeś tu swojego pytania? Napisz własny prompt według wzoru: kim jesteś, dla kogo, czego potrzebujesz, w jakiej formie ma być odpowiedź. Im więcej konkretu o Tobie i Twoich klientach podasz, tym lepsza odpowiedź.
