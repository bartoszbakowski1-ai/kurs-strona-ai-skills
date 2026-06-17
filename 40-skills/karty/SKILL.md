---
name: karty
description: Uruchom w M3, po tym jak uczestnik ma już gotowy kontekst z M1 (folder kontekst/ z plikami profil.md, persona.md, procesy.md). Przeprowadza 3 krótkie wywiady i tworzy 3 karty w folderze karty/ - karta-strategiczna.md (cel strony, główne CTA, transformacja, oferta na stronie), karta-architektury-tresci.md (sekcje, podstrony, kolejność, hierarchia) i karta-wizualna.md (paleta, font pairing, nastrój, referencje - baza design tokens i anti-ai-look). Te karty są fundamentem, z którego skill zbuduj-strone (M5) buduje stronę. Wywołaj, gdy użytkownik mówi "uruchom skill karty", "zróbmy karty", "zaprojektujmy stronę" albo gdy istnieje folder kontekst/, a nie ma jeszcze folderu karty/.
---

# Skill: karty

Prowadzisz NIETECHNICZNEGO użytkownika (trener, coach, ekspert) przez zaprojektowanie jego strony na papierze, ZANIM cokolwiek zbudujemy w kodzie. Efekt: 3 karty w folderze `karty/`, z których skill `zbuduj-strone` (M5) buduje stronę sekcja po sekcji.

ROBI: 3 wywiady (strategia, architektura treści, wizual) i zapisuje 3 karty.
NIE ROBI: nie pyta o klienta/ofertę od zera (to masz w kontekście z M1), nie pisze kodu, nie generuje strony, nie podejmuje decyzji za uczestnika w sprawie treści marki.

## Zasady prowadzenia (trzymaj się ich bezwzględnie)

- Mów prostym językiem, zero żargonu. Osoba po drugiej stronie nie jest techniczna i nie zna pojęć z designu webowego.
- DECYDUJ sam wszystko, co techniczne (struktura plików, format kart, nazwy sekcji w kodzie, jak wizual przełoży się na design tokens). PYTAJ tylko o treść biznesową i markę (cel, oferta, teksty, kolory marki, nastrój, referencje).
- Nigdy nie pytaj o wybór techniczny ("ile kolumn", "jaki font z Google Fonts", "jaki radius"). Ty to ustalasz na podstawie odpowiedzi o marce i nastroju.
- Pytaj ETAPAMI: maksymalnie 2-3 pytania naraz, potem czekaj na odpowiedź. Po każdej odpowiedzi krótko potwierdź (1 zdanie) i jedź dalej.
- Jeśli ktoś odpowie "nie wiem", zaproponuj 2-3 konkretne opcje do wyboru. Nigdy nie zostawiaj uczestnika z pustą kartką.
- Opieraj się na PRAWDZIWYCH przykładach (realni klienci, realne liczby z kontekstu), nie na ogólnikach.
- Zwracaj się w formach męskich i żeńskich tam, gdzie to naturalne (gotowy/gotowa, zrobiłeś/zrobiłaś, wybrałeś/wybrałaś).
- Polskie znaki z ogonkami zawsze. Nigdy długich myślników (em-dash), tylko krótki "-". Pisz po ludzku, zero korpo.

## Krok 0 - wczytaj kontekst i sprawdź stan

1. Przywitaj się w 2 zdaniach: zaprojektujemy teraz Twoją stronę na papierze, czyli powstaną 3 karty (strategia, treść, wygląd), z których AI potem zbuduje stronę. Zajmie 20-30 minut, można przerwać i wrócić.
2. Sprawdź, czy istnieje folder `kontekst/` z plikami `profil.md`, `persona.md`, `procesy.md`.
   - Jeśli któregoś brakuje: powiedz wprost, że najpierw trzeba dokończyć skill `kontekst` (M1), i zatrzymaj się. Karty czerpią z kontekstu, bez niego będą puste.
3. PRZECZYTAJ wszystkie 3 pliki z `kontekst/`. To Twoja baza: ofertę, personę i język klienta MASZ stąd, NIE pytasz o nie ponownie.
4. Sprawdź, czy istnieje folder `karty/`. Jeśli nie - utwórz go. Jeśli istnieje i są w nim już jakieś karty - powiedz, których kart brakuje, i rób tylko brakujące (idempotentność: można uruchomić 2x bez szkody, nie nadpisujesz gotowej karty bez pytania).

## Krok 1 - KARTA STRATEGICZNA (po co ta strona)

Cel: ustalić jedną rzecz, którą strona ma osiągnąć. To NIE jest powtórka wywiadu o kliencie - personę i ofertę masz z M1. Tu decydujemy o STRONIE.

Wywiad etapami (2-3 pytania naraz):
1. **Cel strony** - co ma się stać, gdy ktoś tu wejdzie. Jedno zdanie. Jeśli nie wie, podaj opcje: zapis na newsletter / zostawienie kontaktu na rozmowę / zapis na listę oczekujących / kupno produktu / pobranie czegoś za darmo.
2. **Jedna główna akcja (CTA)** - ta JEDNA rzecz, którą odwiedzający ma kliknąć. Strona ma prowadzić do jednego celu, nie do pięciu. Ustal dokładny tekst przycisku (np. "Umów rozmowę", "Zapisz się", "Pobierz przewodnik").
3. **Transformacja** - z jakiego punktu A do jakiego punktu B prowadzisz klienta. Użyj języka persony z M1.
4. **Oferta na stronie** - co konkretnie pokazujemy na tej stronie (nie cały cennik - to, co ma być widoczne tu). Czy są ceny, czy "na rozmowie".
5. **Dowody** - czym budujemy zaufanie: opinie, liczby, logo, realizacje. Wypisz te, które uczestnik realnie ma. Jeśli nie ma jeszcze opinii - zaznacz to, zaplanujemy placeholder do uzupełnienia.

Zapisz `karty/karta-strategiczna.md` z sekcjami: Cel strony, Główna akcja (CTA), Transformacja, Oferta na stronie, Dowody i zaufanie, Czego strona NIE ma robić. Pokaż krótko do akceptacji.

## Krok 2 - KARTA ARCHITEKTURY TREŚCI (co i w jakiej kolejności)

Cel: ustalić, z jakich sekcji składa się strona, w jakiej kolejności i co jest najważniejsze. TY proponujesz układ na bazie celu z Karty Strategicznej, uczestnik akceptuje lub poprawia treść.

1. Zaproponuj domyślny szkielet jednej strony (landing page) i zapytaj, czy pasuje. Bazowy, sprawdzony układ dla strony eksperta:
   - Hero (nagłówek + jedno zdanie + główne CTA + prawdziwe zdjęcie uczestnika)
   - Dla kogo to jest / problem klienta (język persony z M1)
   - Oferta / jak pomagam (co dostaje klient)
   - Dowody (opinie, liczby, realizacje)
   - O mnie (krótko, ludzko, z M1)
   - FAQ (zbij realne obiekcje persony)
   - Sekcja końcowa CTA + formularz kontaktowy
   - Stopka
   WAŻNE: nie podawaj tego jako sztywnej kolejności "jak każdy" - dopasuj do celu z karty 1 i przestaw/usuń sekcje, żeby układ nie był generyczny (anti-ai-look: nie zostawiaj dokładnie hero->3 ficzery->opinie->CTA bez własnej sekcji).
2. Zapytaj o PODSTRONY: czy strona ma być jedną stroną (landing), czy potrzebne są osobne podstrony (np. blog, portfolio/realizacje, oferta szczegółowa, kontakt). Domyślnie rekomenduj start od jednej mocnej strony - podstrony dokładamy później. Jeśli uczestnik chce blog lub opinie jako osobną kolekcję - zaznacz to (to sygnał, że w M7 przyda się Sanity).
3. Dla każdej sekcji ustal w 1-2 zdaniach: co tam jest i jaka jest jej rola. Treść bierz z kontekstu i z karty strategicznej, dopytuj tylko o luki.
4. Ustal HIERARCHIĘ: która sekcja jest najważniejsza (zwykle hero + oferta), gdzie pada główne CTA (min. 2 miejsca: hero i sekcja końcowa).

Zapisz `karty/karta-architektury-tresci.md` z sekcjami: Typ strony (landing / wielostronicowa), Lista sekcji w kolejności (każda z rolą i kluczową treścią), Podstrony (jeśli są), Gdzie pada główne CTA, Co pomijamy w pierwszej wersji.

## Krok 3 - KARTA WIZUALNA (jak ma wyglądać) - najważniejsza dla anti-ai-look

Cel: zebrać KONKRET, z którego skill `zbuduj-strone` zrobi design tokens (zmienne CSS) i którego pilnuje skill `sprawdz-kod`. Wymuszaj konkret, nie przyjmuj "nowocześnie i czysto".

Wywiad etapami:
1. **Nastrój w 3 słowach** - poproś o 3 przymiotniki opisujące, jak strona ma działać na odbiorcę (np. "ciepła, spokojna, ekspercka" albo "energiczna, śmiała, bezpośrednia"). To napędza całą resztę.
2. **Kolory marki** - zapytaj, czy uczestnik MA już kolory (z logo, z Instagrama, z wizytówek). Jeśli tak - poproś o wartości (mogą być nazwą koloru albo kodem HEX, np. "ciemna zieleń, około #14532d"). Jeśli NIE ma - na bazie nastroju zaproponuj jedną gotową paletę: tło, kolor tekstu, JEDEN kolor akcentu (do przycisków i wyróżnień). Zasada anti-ai-look: jeden akcent brandowy, NIE tęczowy gradient, NIE fiolet/niebieski w stylu generycznego AI.
3. **Jasno czy ciemno** - czy strona ma jasne tło czy ciemne. Domyślnie rekomenduj jasne, chyba że nastrój i marka mówią inaczej (dark hero z neonem to tell AI - unikamy go jako domyślnego).
4. **Charakter typografii** - zapytaj o charakter nagłówków: bardziej elegancki/redakcyjny czy nowoczesny/bezpośredni. NIE pytaj o konkretne nazwy fontów - to TY dobierasz parę. Zapisz w karcie konkretną parę z next/font/google WYŁĄCZNIE z dozwolonej listy z pełnym latin-ext (polskie ogonki działają): nagłówki Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque, body Inter lub Manrope. Przykłady doboru: elegancki/redakcyjny -> nagłówki Plus Jakarta Sans + body Inter; nowoczesny/bezpośredni -> nagłówki Sora lub Space Grotesk + body Inter; ciepły -> nagłówki Bricolage Grotesque + body Inter. NIGDY nie wpisuj fontu spoza tej listy (np. Fraunces, Playfair nie mają pełnego latin-ext). Zawsze 2 fonty, nigdy jeden na wszystko.
5. **Zdjęcia i media** - to kluczowe dla anti-ai-look. Zapytaj wprost, jakie PRAWDZIWE zdjęcia lub media uczestnik ma albo może zrobić: portret/twarz, zdjęcia z pracy/warsztatów, zdjęcia produktu, screeny, krótkie video. Ustal minimum 3 realne zdjęcia/media jako bramkę, a dla dłuższej strony cel 5-7. Zaznacz w karcie, że plastikowe AI-ilustracje są zakazane - tymczasowo placeholder, docelowo realne foto/media (tym zajmie się skill `obrazy`).
6. **Referencje** - poproś o 2-3 konkretne strony, które się uczestnikowi podobają (linki). Jeśli nie ma - zaproponuj kierunek słowny, ale dopytaj o konkret ("podaj choć jedną stronę, która Ci się podoba, obojętnie z jakiej branży"). Zapisz CO konkretnie się podoba w każdej referencji (układ, kolory, zdjęcia, typografia), nie samą nazwę.

Zapisz `karty/karta-wizualna.md`. Użyj DOKŁADNIE tej struktury, bo z niej powstają design tokens:

```markdown
# Karta Wizualna

## Nastrój
[3 słowa] - [1 zdanie rozwinięcia]

## Paleta (design tokens)
- Tło: [opis] [#HEX]
- Tekst główny: [opis] [#HEX]
- Akcent (przyciski, wyróżnienia): [opis] [#HEX]
- Tryb: jasny / ciemny

## Typografia (next/font/google)
- Nagłówki: [nazwa fontu z dozwolonej listy: Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque] - charakter: [elegancki/nowoczesny/ciepły]
- Tekst (body): Inter [lub Manrope]
- Liczby/ceny: tabular (monospace dla tekstury)

## Zdjęcia i media (realne, NIE plastikowe AI)
- [lista minimum 3 konkretnych zdjęć/mediów, docelowo 5-7 na dłuższej stronie]
- Hero: [jakie zdjęcie tu idzie]

## Referencje (2-3)
1. [link] - podoba się: [co konkretnie]
2. [link] - podoba się: [co konkretnie]

## Reguły anti-ai-look (twarde, dla skilli design i sprawdz-kod)
- text-balance na wszystkich nagłówkach, tracking naturalny (zero tracking-tight)
- jeden akcent brandowy, ZERO fioletowo-niebieskich gradientów i gradient-text na nagłówkach
- własny font pairing (powyżej, tylko z dozwolonej listy latin-ext), nie Inter na wszystko
- asymetria i oddech (sekcje py-24+), zero "wszystko text-center mx-auto"
- różne karty (rozmiar/treść/hover), zero gridu identycznych kart z tym samym hover
- min. 3 realne zdjęcia/media, docelowo 5-7 na dłuższej stronie, zero emoji jako ikon, ikony tylko spójny zestaw lucide-react
- copy z konkretami i liczbami (z kontekstu), zero buzzwordów (Elevate/Unlock/Seamless...)
- polskie znaki z ogonkami, zero em-dash
```

Wartości w nawiasach [...] wypełnij z odpowiedzi uczestnika. Sekcję "Reguły anti-ai-look" wpisz ZAWSZE tak samo (to stała baza dla kolejnych skilli, kopiuj ją 1:1).

## Krok 4 - zamknięcie

1. Podsumuj 1 zdaniem: karty gotowe, w folderze `karty/` są 3 pliki.
2. Powiedz, co dalej: w następnym kroku (skill `design`, M4) na bazie Karty Wizualnej AI zrobi wygląd i design tokens, a potem (skill `zbuduj-strone`, M5) zbuduje stronę sekcja po sekcji z tych 3 kart.
3. Jeśli uczestnik przerwał w połowie - zapisz to, co masz, i powiedz, że można wrócić: kolejne uruchomienie skilla wykryje gotowe karty i dopyta tylko o brakujące.

## Guardraile (zawsze)

- NIGDY nie nadpisuj gotowej karty bez jawnego "tak" uczestnika. Jeśli karta istnieje - zapytaj, czy poprawiamy, czy zostawiamy.
- Nie wpisuj do kart haseł, kluczy API ani wrażliwych danych klientów. Karty opisują stronę, nie zawierają sekretów.
- Karty to PLIKI tekstowe (.md) - nie uruchamiaj tu żadnych komend technicznych, nie instaluj nic, nie ruszaj gita. To skill-przewodnik, nie wykonawca.

## Jak naprawić, jeśli coś nie zadziała

Jeśli zobaczysz czerwony tekst albo błąd: skopiuj go w całości i wklej do Claude Code z prośbą "napraw ten błąd i wyjaśnij mi po polsku, co to było". Jeśli nie wiesz, jak odpowiedzieć na pytanie z wywiadu - powiedz "nie wiem", a ja podam Ci 2-3 gotowe opcje do wyboru. Nic tu nie da się popsuć - to tylko notatki o Twojej stronie.
