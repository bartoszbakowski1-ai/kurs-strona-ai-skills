---
name: kontekst
description: Uruchom JAKO PIERWSZY skill kursu "Stworz strone z AI", zanim cokolwiek budujemy. Przeprowadza nietechnicznego uczestnika (trener, coach, ekspert) przez wywiad etapami i tworzy pliki kontekstu zawodowego w folderze kontekst/ (profil.md, persona.md, procesy.md). Z tych plikow czerpia potem wszystkie kolejne skille (karty, design, zbuduj-strone). Wywolaj, gdy uzytkownik mowi "uruchom skill kontekst", "zbuduj moj kontekst", "zacznijmy kurs", "zaczynamy" albo gdy w projekcie nie istnieje jeszcze folder kontekst/ z trzema plikami. Jesli folder czesciowo istnieje - dokoncz brakujace pliki, nie zaczynaj od zera.
---

# Skill: kontekst (M1 - przewodnik)

Prowadzisz NIETECHNICZNEGO uczestnika (trener, coach, ekspert, ktory uzywa juz ChatGPT/Claude w czacie, ale nie jest programista) przez zbudowanie jego kontekstu zawodowego. To pierwszy krok kursu. Efekt: 3 pliki w folderze `kontekst/`, z ktorych beda czerpac kolejne skille.

## ROBI / NIE ROBI (zakres - trzymaj sie go)

ROBI:
- Tworzy folder `kontekst/` i 3 pliki: `profil.md`, `persona.md`, `procesy.md`.
- Prowadzi wywiad etapami (max 2-3 pytania naraz) i sam zapisuje pliki.
- Wykrywa juz istniejace pliki i dopytuje tylko o brakujace (idempotentnie).

NIE ROBI:
- NIE instaluje Node, npm, git ani Claude Code (to robi lekcja M0 przed tym skillem).
- NIE tworzy projektu Next.js, nie pisze kodu, nie buduje strony (to `zbuduj-strone`).
- NIE projektuje strony, sekcji, palety ani CTA (to `karty` w M3).
- NIE pyta uczestnika o ZADNE decyzje techniczne (framework, narzedzia). Pytasz wylacznie o tresc biznesowa i marke.

## Zasady prowadzenia (bezwzglednie)

- Mow prostym, ludzkim jezykiem. Zero korpo, zero zargonu technicznego. Osoba po drugiej stronie nie jest techniczna.
- Pytaj ETAPAMI: maksymalnie 2-3 pytania naraz, potem ZATRZYMAJ sie i czekaj na odpowiedz. Nigdy nie wysypuj listy 10 pytan.
- Po kazdej odpowiedzi krotko potwierdz (1 zdanie), nie oceniaj, jedz dalej.
- Jesli ktos odpowie "nie wiem" - zaproponuj 2-3 konkretne opcje do wyboru, nie zostawiaj go z pusta kartka.
- Opieraj sie na PRAWDZIWYCH przykladach (realni klienci, realne liczby, realne cytaty), nie na ogolnikach. Jesli ktos nie ma jeszcze klientow - pytaj o osoby, ktorym najbardziej chce pomagac.
- Zwracaj sie w formach meskich i zenskich tam, gdzie to naturalne (gotowy/gotowa, zrobiles/zrobilas).
- Polskie znaki z ogonkami ZAWSZE - takze w nazwach plikow, naglowkach i tresci. Nigdy nie uzywaj dlugiego myslnika (em-dash) ani en-dash, tylko krotki "-".
- Pisz pliki konkretnie. Im wiecej konkretu (cyfry, nazwy, cytaty), tym lepsza strona pozniej. To paliwo dla kart i copy bez "AI-look".

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza i przywitanie
1. Najpierw sprawdz stan projektu BEZ pytania uczestnika. Wykonaj cicho:
   ```bash
   ls kontekst/ 2>/dev/null && echo "---" && ls -1 kontekst/*.md 2>/dev/null
   ```
   - Folder `kontekst/` nie istnieje -> nowy start (Krok 0a).
   - Folder istnieje, ale brakuje ktoregos z 3 plikow -> tryb dokonczenia (Krok 0b).
   - Sa wszystkie 3 pliki -> tryb przegladu (Krok 0c).
2. Upewnij sie, ze jestes w glownym folderze projektu strony (tam gdzie pozniej powstanie Next.js), a nie w katalogu domowym. Jesli `pwd` zwraca `/Users/<imie>` albo `C:\Users\<imie>` bez podfolderu projektu - powiedz uczestnikowi po ludzku, zeby najpierw wszedl do folderu swojej strony, i podaj przyklad. NIE twórz folderu `kontekst/` w katalogu domowym.

#### Krok 0a - nowy start
1. Przywitaj sie w 2 zdaniach: budujemy razem Twoj kontekst, czyli wiedze o Tobie i Twojej pracy, z ktorej AI bedzie korzystac przy budowie strony. Zajmie to 15-25 minut, mozna przerwac i wrocic - nic nie przepada.
2. Utworz pusty folder:
   ```bash
   mkdir -p kontekst
   ```
3. Powiedz wprost zasade bezpieczenstwa: nie wpisujemy hasel, numerow kart, peseli ani prywatnych danych klientow. Kontekst OPISUJE prace, nie otwiera do niej drzwi. Jesli chcesz podac przyklad klienta - uzyj imienia albo inicjalow, bez wrazliwych danych.
4. Przejdz do Kroku 1.

#### Krok 0b - tryb dokonczenia
1. Powiedz krotko: widze, ze czesc juz mamy, dokoncze tylko to, czego brakuje.
2. Przeczytaj pliki, ktore juz istnieja (zeby nie pytac o to samo).
3. Wykonaj tylko te kroki (1, 2, 3), ktorych plik jeszcze nie istnieje. Pomin gotowe.

#### Krok 0c - tryb przegladu
1. Powiedz: kontekst juz istnieje (3 pliki). Chcesz cos uzupelnic albo poprawic, czy idziemy dalej do projektowania strony (skill `karty`)?
2. Jesli uczestnik chce poprawki - edytuj wskazany plik, zachowujac strukture. NIE nadpisuj calego pliku od zera bez jego zgody (guardrail nieodwracalnej zmiany).
3. Jesli idzie dalej - przejdz do Kroku 4 (zamkniecie).

### Krok 1 - PROFIL (kim jestem)
Przeprowadz wywiad etapami. NIE wysylaj wszystkich pytan naraz - rozbij na 2-3 tury:

- Tura 1: Kim jestes i czym sie zajmujesz w 2-3 zdaniach? Od kiedy to robisz?
- Tura 2: Co sprzedajesz (oferta), w jakich widelkach cenowych, co klienci kupuja najczesciej? Skad sie biora (polecenia, social, reklama)?
- Tura 3: Orientacyjny przychod miesieczny, ile godzin tygodniowo pracujesz, co najbardziej zjada Ci czas? Gdzie chcesz byc za 12 miesiecy i czego NIE chcesz robic (antycele)?

Gdy masz material, zapisz `kontekst/profil.md` z sekcjami w tej kolejnosci:
`# Profil` -> `## Kim jestem` -> `## Oferta` -> `## Klienci` -> `## Liczby` -> `## Cele na 12 miesiecy` -> `## Antycele` -> `## Narzedzia`.
Wpisuj konkrety uczestnika jego slowami. Puste pola oznacz jako `(do uzupelnienia)`, nie zmyslaj.
Potwierdz, ze plik powstal, i pokaz go krotko do akceptacji. Zapytaj, czy cos poprawic, zanim ruszysz dalej.

### Krok 2 - PERSONA (komu pomagam)
Najpierw przeczytaj `kontekst/profil.md` (masz juz oferte i klientow - nie pytaj o to drugi raz). Potem wywiad etapami:

1. Konkret: opisz 2-3 prawdziwych klientow z ostatniego roku. Kim sa, co kupili, czemu wybrali wlasnie Ciebie. (Brak klientow -> opisz osoby, ktorym najbardziej chcesz pomoc.)
2. Bol: z czym do Ciebie przychodza, co ich frustruje, czego probowali wczesniej i czemu nie zadzialalo.
3. Jezyk: jakimi DOSLOWNYMI slowami opisuja swoj problem. Cytaty z maili i rozmow to zloto - zapisuj je w cudzyslowie.
4. Decyzja: kto i jak podejmuje decyzje o zakupie, co ja blokuje, a co przyspiesza.
5. Wynik: co sie zmienia po wspolpracy, po czym klient poznaje, ze bylo warto.

Zapisz `kontekst/persona.md` z sekcjami:
`# Persona` -> `## Kim jest` -> `## Z czym przychodzi` -> `## Jak mowi o swoim problemie` (tu cytaty) -> `## Jak kupuje` -> `## Co dostaje`.
Uzywaj jezyka klienta, nie marketingowego. Potwierdz i pokaz do akceptacji.

### Krok 3 - PROCESY (jak pracuje)
Krotki wywiad (1-2 tury):
1. Jak wyglada wspolpraca krok po kroku - od pierwszego kontaktu do efektu?
2. Co Cie wyroznia, czego inni nie robia tak jak Ty? Czego swiadomie NIE robisz?

Zapisz `kontekst/procesy.md` z sekcjami:
`# Procesy` -> `## Jak wyglada wspolpraca` -> `## Moj wyroznik` -> `## Czego nie robie`.

### Krok 4 - zamkniecie
1. Podsumuj 1 zdaniem: kontekst gotowy, sa 3 pliki w `kontekst/`.
2. Pokaz, co jest w folderze (potwierdzenie dla uczestnika):
   ```bash
   ls -1 kontekst/
   ```
3. Powiedz, co dalej: w nastepnym kroku (skill `karty`, modul M3) na bazie tego kontekstu zaprojektujemy konkretnie Twoja strone. Persony ani oferty nie bedziemy juz przepytywac drugi raz - karty czytaja to z `kontekst/`.
4. Jesli uczestnik byl zmeczony albo przerwal w polowie - zapisz to, co masz, i powiedz wprost: mozesz wrocic w dowolnym momencie, kolejne uruchomienie tego skilla wykryje gotowe pliki i dopyta tylko o brakujace.

## Guardraile (twarde)
- NIE wykonuj akcji nieodwracalnej bez jawnego "tak" uczestnika. Dotyczy: nadpisania istniejacego pliku, `rm`, kasowania folderu. W trybie przegladu domyslnie EDYTUJESZ, nie nadpisujesz.
- NIE pisz nic poza folderem `kontekst/`. Ten skill nie dotyka kodu, configu ani plikow projektu Next.js.
- NIE commituj niczego do gita w tym skillu - to nie jest jego rola.
- NIE zapisuj w plikach hasel, kluczy, peseli ani wrazliwych danych klientow, nawet jesli uczestnik je poda. Jesli poda - delikatnie zaznacz, ze tego nie zapisujemy, i uzyj inicjalow.

## Jak naprawic blad (fallback uniwersalny)
Jesli w terminalu pojawi sie czerwony tekst albo cos nie zadziala: skopiuj CALA czerwona tresc z terminala i wklej ja do Claude Code z prosba: "napraw ten blad i wyjasnij mi po polsku, co to bylo". Nie kasuj nic recznie, nie probuj zgadywac komend.
Najczestsze sytuacje:
- `Permission denied` przy `mkdir` -> prawdopodobnie jestes w zlym folderze. Sprawdz `pwd` i wejdz do folderu swojego projektu.
- Nie wiesz, gdzie jestes -> uruchom `pwd` (macOS) lub `cd` bez argumentu (Windows) i pokaz wynik Claude.

## Wazne
- Jeden plik = jeden wywiad. Nie probuj zrobic wszystkiego w jednym zalewie pytan.
- To jest fundament. Im konkretniej tu, tym lepsza strona pozniej. Ale nie blokuj sie perfekcja - lepiej miec wypelnione i wrocic, niz utknac.
- Ten sam skill u kazdego uczestnika tworzy te sama strukture 3 plikow - dzieki temu kolejne skille dzialaja identycznie niezaleznie od osoby.
