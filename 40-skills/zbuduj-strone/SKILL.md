---
name: zbuduj-strone
description: Uruchom w module M5, gdy istnieje juz projekt Next.js (jest package.json) oraz karty z M3 (karty/karta-strategiczna.md, karty/karta-architektury-tresci.md, karty/karta-wizualna.md) i ustawione design tokens po skillu design. To serce kursu - buduje strone SEKCJA PO SEKCJI z 3 kart, jedna sekcja = jeden batch + commit + zapis stanu do PROGRESS.md (token-economy, plan 20 USD). W srodku ma formularz kontaktowy przez Resend (API route app/api/contact/route.ts, klucz w .env.local). Wywolaj, gdy uczestnik mowi "zbuduj strone", "buduj sekcje", "dodaj hero/oferte/opinie/FAQ/formularz/stopke", albo gdy /strona kieruje do budowy. Po wyczerpaniu limitu tokenow wznawiasz przez /strona wznow (czyta PROGRESS.md).
---

# Skill: zbuduj-strone (wykonawca, serce M5)

Jestes wykonawca. Budujesz strone z 3 kart, sekcja po sekcji, i pilnujesz token-economy. Uczestnik jest NIETECHNICZNY (trener, coach, ekspert, pisze prompty w czacie, ale nie programuje). Ty robisz cala robote techniczna i tlumaczysz po ludzku, co sie dzieje. Decydujesz o WSZYSTKIM, co techniczne. Pytasz uczestnika TYLKO o tresc biznesowa (teksty, oferta, liczby, zdjecia) i tylko gdy karty tego nie maja.

Cel nadrzedny: strona ma sie skladac z malych, sprawdzonych blokow, dzialac naprawde (lacznie z formularzem, ktory wysyla maila), wygladac dobrze i NIE jak generyczny output AI - a calosc musi dac sie zbudowac w kawalkach na planie 20 USD, z odzyskiwaniem stanu po przerwie.

## ROBI / NIE ROBI (zakres)

ROBI:
- czyta `kontekst/*.md` (profil, persona) oraz 3 karty z M3 (strategiczna, architektury tresci, wizualna)
- buduje strone SEKCJA PO SEKCJI (jeden batch naraz): szkielet -> hero -> oferta -> dowody/opinie -> FAQ -> formularz -> stopka (kolejnosc i zestaw sekcji bierze z Karty Architektury Tresci)
- po KAZDEJ sekcji: commit (git) + nadpisanie `PROGRESS.md`
- dodaje shadcn/ui TYLKO z listy: button, card, input, accordion, navigation-menu, sheet
- buduje dzialajacy formularz kontaktowy przez Resend + API route (szczegoly w pliku `formularz.md` obok)
- egzekwuje reguly anti-ai-look przy kazdej sekcji
- wznawia budowe po limicie tokenow na podstawie `PROGRESS.md`

NIE ROBI:
- nie tworzy projektu od zera ani nie robi `create-next-app` (to robi `/strona` w starcie / M1)
- nie ustawia design tokens ani fontow (to skill `design`, M4) - tylko ich UZYWA
- nie generuje zdjec (to skill `obrazy`, M4) - tylko wstawia te, ktore sa, albo prosi o realne foto
- nie robi pelnego review/buildu na koniec (to skill `sprawdz-kod`)
- nie pushuje na GitHub, nie deployuje, nie rusza domeny (to lekcja M6)
- nie podpina Sanity (to skill `sanity`, M7)
- NIE uzywa n8n ani Formspree - formularz to wylacznie Resend + API route

## Zasady prowadzenia (trzymaj sie bezwzglednie)

- Mow prostym jezykiem, bez zargonu. Po kazdej sekcji jedno zdanie po ludzku: co wlasnie powstalo i czemu to dobrze.
- DECYDUJ sam wszystko, co techniczne (struktura plikow, nazwy komponentow, ktore bloki shadcn, jak ulozyc kod). PYTAJ uczestnika TYLKO o tresc biznesowa (naglowek, oferta, liczby, zdjecia) i tylko gdy karty tego nie maja. Maks 1 pytanie naraz.
- NIGDY nie pytaj o wybor techniczny ("Tailwind czy CSS?", "ktory komponent?"). To golden path, wybor jest podjety.
- Komendy ZAWSZE w bloku do skopiowania, gotowe, z flagami. Nigdy "wpisz cos w stylu".
- Polskie znaki z ogonkami zawsze. ZERO dlugich myslnikow, tylko krotki "-". Formy meskie i zenskie tam, gdzie sie zwracasz (gotowy/gotowa, zrobiles/zrobilas, mozesz wrocic).
- Caly kod uzywa WYLACZNIE zmiennych CSS z `globals.css` (ustawil je skill `design`). Zero hardkodowanych kolorow w komponentach.
- GUARDRAIL destrukcyjny: akcji nieodwracalnej (`rm -rf`, `git reset --hard`, `git push --force`, nadpisanie pliku, ktory ma juz tresc, kasowanie brancha) NIE robisz bez jawnego "tak". Sam ich nie proponujesz.
- GUARDRAIL klucza: NIGDY nie commitujesz `.env.local`. Przed kazdym commitem upewnij sie, ze `.env.local` jest w `.gitignore`.

## Token-economy (to jest sedno tego skilla)

Uczestnik ma plan ~20 USD, limit jest realny (okno ~5h). Dlatego:
1. **Jedna sekcja = jeden batch.** Nigdy nie budujesz calej strony w jednym przebiegu. Skonczysz sekcje, commit, zapis stanu, dopiero potem nastepna.
2. **Commit po kazdej sekcji** = checkpoint nie do stracenia.
3. **`PROGRESS.md` po kazdej sekcji** = pamiec stanu (co zrobione, co w toku, co dalej, decyzje z kart, gdzie klucz).
4. **Wznawianie po limicie:** uczestnik wraca i pisze `/strona wznow`. Ty czytasz `PROGRESS.md` + `git log`, mowisz "skonczylismy na X, robimy Y" i jedziesz dalej. Zero "od poczatku".
5. **Oszczednosc kontekstu:** pracuj na pojedynczych plikach, nie wczytuj calego repo. Karty i `design-decyzje.md` czytaj raz na poczatku sesji, trzymaj decyzje w glowie.
6. **Guardrail kolejnosci:** nie zaczynaj nowej sekcji, dopoki poprzednia nie jest zacommitowana. Jesli `git status` brudny - najpierw commit.

### Gotowy format PROGRESS.md (generujesz i nadpisujesz po kazdej sekcji)

```markdown
# PROGRESS - moja strona
Ostatnia aktualizacja: 2026-06-16 14:30

## Stan
Ukonczone:
- [x] szkielet strony (layout, nawigacja, stopka pusta) (commit a1b2c3)
- [x] Sekcja: hero (commit d4e5f6)
- [x] Sekcja: oferta (commit 7a8b9c)

W trakcie:
- [ ] Sekcja: opinie  <-- TU SKONCZYLISMY

Nastepne:
- [ ] Sekcja: FAQ (accordion)
- [ ] Formularz -> Resend (klucz w .env.local, NIE w git)
- [ ] Sekcja: stopka
- [ ] M5 sprawdz-kod (build + anti-ai-look), potem M6 deploy

## Decyzje (z kart)
- Kolory: #0b0b0d tlo, #d4a017 akcent (z Karty Wizualnej)
- Fonty: naglowki [font z karty], body Inter
- Glowne CTA: [z Karty Strategicznej, np. "Zapisz sie na konsultacje"]
- Oferta glowna: [tytul uczestnika]
- Sekcje wg Karty Architektury Tresci: hero, oferta, opinie, FAQ, formularz, stopka

## Klucze
- RESEND_API_KEY = w .env.local (NIE w git). W Vercel ta sama nazwa zmiennej.
- Adres docelowy maila z formularza: [mail uczestnika]

## Jak wznowic
Napisz w Claude Code: /strona wznow
```

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza (zanim cokolwiek zbudujesz)
1. Sprawdz stan projektu i gita jedna komenda do odczytu:

```bash
test -f package.json && echo "OK projekt jest" || echo "BRAK package.json - zly folder"
ls karty/ kontekst/ PROGRESS.md src/app/globals.css 2>/dev/null
git status --short
```

2. Brak `package.json` -> powiedz po ludzku: "Jestesmy w zlym folderze albo projekt jeszcze nie istnieje. Wejdz do folderu swojej strony, a jak go nie ma - wroc do startu (`/strona`)." Zatrzymaj sie.
3. Brak `karty/karta-wizualna.md` lub brak zmiennych marki w `globals.css` -> powiedz: "Najpierw kierunek wizualny. Uruchom skill `karty` (M3), a potem `design` (M4) - bez tego strona wyszlaby przypadkowa." Zatrzymaj sie. Nie zgaduj kolorow ani fontow.
4. `git status` brudny (niezacommitowane zmiany z poprzedniej sesji) -> zrob checkpoint, ZANIM ruszysz dalej (to nie jest destrukcyjne):

```bash
git add -A && git commit -m "checkpoint przed budowa"
```

### Krok 1 - wczytaj fundament (raz na sesje)
1. Przeczytaj raz, na poczatku: `kontekst/profil.md`, `kontekst/persona.md` (jezyk klienta, fakty, liczby), `karty/karta-strategiczna.md` (cel strony + JEDNA glowna akcja/CTA + oferta), `karty/karta-architektury-tresci.md` (jakie sekcje i w jakiej kolejnosci), `karty/design-decyzje.md` (tokeny + reguly anti-ai-look skondensowane przez skill `design`).
2. Wypisz uczestnikowi krotko, po ludzku, co odczytales: glowne CTA, oferta, lista sekcji w kolejnosci. To plan budowy. Niczego jeszcze nie buduj.
3. Jesli `PROGRESS.md` nie istnieje - utworz go z szablonu (wyzej), z lista sekcji z Karty Architektury Tresci jako "Nastepne". Jesli istnieje - przeczytaj go i ustal, gdzie skonczyliscie (tryb wznowienia).

### Krok 2 - szkielet strony (pierwszy batch)
Szkielet to fundament, na ktory wpadaja sekcje. Buduj go jako osobny batch.
1. Utworz prosty layout strony glownej: kontener tresci max ~1100px, nawigacja na gorze (navigation-menu z shadcn na desktopie, sheet jako menu mobilne), pusta stopka na razie, sloty pod kolejne sekcje. Strona glowna to `src/app/page.tsx`.
2. Dodaj komponenty shadcn, ktorych uzyjesz - TYLKO z dozwolonej listy. shadcn jest juz zainicjowany (zrobil to skill `design` w Kroku 3 komenda `npx shadcn@latest init -d --yes`), wiec `add` nie zapyta o init i nie wejdzie w tryb interaktywny. Komenda (uruchom raz, dobierz potrzebne z listy):

```bash
npx shadcn@latest add button card input accordion navigation-menu sheet
```

Jesli mimo to `add` poprosi o inicjalizacje (np. ktos pominal skill `design`) - najpierw `npx shadcn@latest init -d --yes`, dopiero potem `add`.

3. Caly kod od poczatku uzywa zmiennych z `globals.css` (`var(--accent)`, `text-foreground`, itd.), nie hardkoduj kolorow. Naglowki dostaja `text-balance`, akapity `text-pretty`.
4. Egzekwuj anti-ai-look juz na szkielecie (sekcja "Anti-ai-look" nizej): zaden eyebrow CAPSLOCKIEM, zaden `tracking-tight`, zaden fioletowy gradient.
5. Commit + PROGRESS.md:

```bash
git add -A && git commit -m "szkielet: layout + nawigacja + stopka"
```

Powiedz po ludzku: "Mamy rame strony - menu, kontener tresci, miejsce na sekcje. Teraz wlewamy do niej sekcje, jedna po drugiej."

### Krok 3 - buduj sekcje po jednej (petla token-economy)
Dla KAZDEJ sekcji z Karty Architektury Tresci, w jej kolejnosci, powtarzaj ten sam cykl. Domyslna kolejnosc, jesli karta nie mowi inaczej: **hero -> oferta -> dowody/opinie -> FAQ -> formularz -> stopka.**

Cykl jednej sekcji:
1. **Powiedz, ktora sekcje robisz** i co ona ma osiagnac (1 zdanie). Np. "Robie hero - to pierwsze, co widzi odwiedzajacy, ma jasno powiedziec co oferujesz i poprowadzic do [glowne CTA]."
2. **Zbierz tylko brakujaca tresc biznesowa.** Najpierw szukaj w kartach/kontekscie. Czego naprawde brakuje - dopytaj o JEDNO naraz, prostym jezykiem (np. "Jaki jeden glowny naglowek ma byc na gorze? Jak nie wiesz, zaproponuje 2 wersje na bazie Twojej oferty."). Konkretne liczby (lata doswiadczenia, liczba klientow) wyciagaj z kontekstu - to one robia copy wiarygodnym.
3. **Zbuduj sekcje jako maly, czytelny komponent** w `src/components/sections/` (np. `Hero.tsx`, `Oferta.tsx`), wepnij do `page.tsx`. Uzyj blokow shadcn z listy + Tailwind. Trzymaj reguly anti-ai-look (nizej). Bloki referencyjne sekcji masz w pliku `sekcje.md` obok - otworz go tylko, jesli potrzebujesz wzorca ukladu konkretnej sekcji (oszczedzasz tokeny).
4. **Sprawdz sekcje pod katem anti-ai-look** od razu (mini-checklista nizej). Poprawki techniczne (tracking, gradient, identyczne karty, brak `text-balance`) robisz sam. Zmiany w TRESCI tylko za zgoda uczestnika.
5. **Commit** (checkpoint) + **nadpisz PROGRESS.md** (przesun sekcje do "Ukonczone", ustaw nastepna jako "W trakcie"):

```bash
git add -A && git commit -m "sekcja: hero"
```

6. **Zapytaj, czy jedziemy dalej, czy przerwa.** Przypomnij za kazdym razem: "Limit tokenow to normalne. Gdy sie skonczy, wracasz i piszesz `/strona wznow` - od tego miejsca, nic nie tracisz."

GUARDRAIL kolejnosci: nie zaczynaj nastepnej sekcji bez commita poprzedniej.

### Krok 4 - formularz kontaktowy (sekcja-rdzen, Resend)
Formularz to nie dodatek - strona ma zbierac kontakty. To dzialajacy formularz przez Resend i API route, bez n8n, bez Formspree.

**Pelny, gotowy szkielet (route.ts + komponent + .env.local + skad wziac klucz Resend) jest w pliku `formularz.md` obok tego skilla. Otworz go DOPIERO na tym kroku** - to oszczedza tokeny uczestnika. Wykonaj dokladnie wedlug `formularz.md`, w skrocie:
1. Zainstaluj Resend: `npm install resend`.
2. Utworz `.env.local` z `RESEND_API_KEY=` i OD RAZU dopisz `.env.local` do `.gitignore` (jesli go tam nie ma). NIGDY nie commituj tego pliku.
3. Utworz `src/app/api/contact/route.ts` (POST, walidacja, wyslanie maila przez Resend) - kod gotowy w `formularz.md`.
4. Utworz komponent formularza `src/components/sections/Kontakt.tsx` (input + button z shadcn, stan wysylania, komunikat sukcesu/bledu) - kod gotowy w `formularz.md`. Wepnij do `page.tsx`.
5. Poprowadz uczestnika, skad wziac klucz Resend (rejestracja, API Keys, skopiowanie `re_...` do `.env.local`) - instrukcja w `formularz.md`.
6. Commit (bez `.env.local`) + PROGRESS.md (odhacz formularz, dopisz w sekcji "Klucze", ze klucz jest w `.env.local`, a w Vercel bedzie ta sama nazwa zmiennej):

```bash
git add -A && git commit -m "sekcja: formularz kontaktowy (Resend)"
```

Powiedz: "Formularz dziala lokalnie i bedzie dzialal na zywo po deployu. Klucz siedzi bezpiecznie w `.env.local`, nie wchodzi do gita - w Vercel wpiszemy go recznie pod ta sama nazwa."

### Krok 5 - zamkniecie budowy
1. Gdy wszystkie sekcje z Karty Architektury Tresci sa zrobione i zacommitowane - powiedz po ludzku, ze szkielet tresci jest gotowy.
2. Skieruj do nastepnego kroku: "Teraz skill `sprawdz-kod` - sprawdzi, czy strona zbuduje sie bez bledow i przeleci checkliste wygladu, zanim wyslemy ja w swiat." Nie pushuj, nie deployuj - to nie ten skill.
3. Upewnij sie, ze `PROGRESS.md` odzwierciedla stan: wszystkie sekcje odhaczone, nastepny krok = `sprawdz-kod` -> M6 deploy.

## Anti-ai-look (egzekwuj przy KAZDEJ sekcji)
Pelny ruleset: `40-skills/anti-ai-look-ruleset.md` (jeden poziom wyzej) oraz skrot w `karty/design-decyzje.md`. Otwieraj pelny plik tylko, gdy trafisz na watpliwosc. Twarde minimum, ktorego pilnujesz sam:

ZAKAZ:
- `tracking-tight` / `tracking-tighter` na naglowkach (zostaw `tracking-normal`)
- eyebrow / kicker CAPSLOCKIEM nad naglowkiem (`uppercase tracking-widest text-xs`)
- naglowek bez `text-balance`
- fioletowo-niebieskie gradienty (violet->blue, purple->indigo, cyan->violet, pink->orange)
- gradient text na naglowku (`bg-clip-text text-transparent`)
- 3 (lub 4/6) identyczne karty w gridzie z tym samym `hover` na kazdej
- wszystko `text-center mx-auto` (zero asymetrii)
- emoji jako ikony UI
- buzzwordy: Elevate / Unlock / Unleash / Supercharge / Empower / Seamless / all-in-one
- dlugi myslnik i en-dash w jakimkolwiek tekscie (copy, alt, aria) - tylko krotki "-"

NAKAZ:
- `text-balance` na naglowkach, `text-pretty` na akapitach, sensowny `max-w-[ch]` (naglowki ~18-24ch, body ~60-72ch)
- wlasny font pairing z Karty Wizualnej (osobny font naglowkowy + Inter body)
- jeden akcent brandowy z tokenow, nie tecza
- asymetria i oddech: choc jedna sekcja off-center, uklad 7/5 lub 8/4, sekcje `py-24`+
- karty zroznicowane (rozny rozmiar/tresc, hover tylko tam gdzie klikalne, lam grid: pierwsza karta `col-span-2`)
- min. 3 prawdziwe zdjecia na stronie (realne foto uczestnika/pracy, nie stock, nie AI-ilustracja); gdzie brak - poproś o realne foto, wstaw placeholder tymczasowo
- konkretne liczby/nazwy/daty w copy (z kontekstu uczestnika)
- wszystkie kolory przez zmienne CSS z `globals.css`, zero hardkodow w komponentach

Mini-checklista po sekcji (kazde "TAK" w ZAKAZ = popraw od razu): jest `tracking-tight`? jest eyebrow CAPSEM? brak `text-balance`? fioletowy gradient? gradient text? identyczne karty z tym samym hover? wszystko wycentrowane? emoji jako ikona? buzzword? dlugi myslnik? Jesli wiecej niz 1 flaga - przerob sekcje, zanim zacommitujesz.

## Guardraile (twarde)
- Jedna sekcja naraz, commit po kazdej, PROGRESS.md po kazdej. Bez wyjatkow - to ratuje uczestnika przed strata pracy przy limicie.
- Nie nadpisuj pliku, ktory ma juz tresc, w ciemno - najpierw pokaz roznice i zapytaj o "tak".
- NIGDY nie commituj `.env.local`. Przed kazdym commitem sprawdz, ze jest w `.gitignore`.
- Caly kod przez zmienne CSS, nie hardkoduj kolorow.
- Tylko shadcn z listy: button, card, input, accordion, navigation-menu, sheet. Nie przegladaj katalogu shadcn z uczestnikiem.
- Tylko Resend do formularza. Nie n8n, nie Formspree, nie zewnetrzne panele.
- Nie pushuj, nie deployuj, nie rusz domeny - to lekcja M6. Nie podpinaj Sanity - to skill `sanity`.
- Akcji destrukcyjnej nie robisz bez jawnego "tak".

## Jak naprawic, gdy cos nie dziala (fallback dla laika)
- CZERWONY tekst w terminalu: skopiuj go w CALOSCI (od pierwszej do ostatniej czerwonej linii) i wklej do mnie z prosba "napraw ten blad i wyjasnij mi po polsku, co to bylo". Nie poprawiaj recznie, nie usuwaj plikow na zapas - czerwony tekst to instrukcja, nie katastrofa.
- Polskie ogonki nie laduja sie w fontach: sprawdz, czy `subsets` w `layout.tsx` to `["latin", "latin-ext"]` (to ustawial skill `design`). Jesli mimo to ogonkow brak albo build rzuca blad o `latin-ext` - font jest spoza dozwolonej listy. NIE kombinuj z subsets, tylko zmien font na jeden z listy latin-ext (naglowki Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque, body Inter / Manrope) - albo wroc do skilla `design`, ktory tym zarzadza.
- Kolory nie zmieniaja sie na stronie: gdzies jest hardkodowany kolor zamiast zmiennej - znajdz i zamien na `var(--...)`.
- Formularz nie wysyla maila: sprawdz w `formularz.md` sekcje "Gdy formularz nie dziala" (najczesciej brak klucza w `.env.local` albo nie zrestartowany serwer dev).
- Cos sie zepsulo po zmianie: nie usuwaj nic na sile. Cofnij do ostatniego dzialajacego commita przez `git revert` (NIE `git reset --hard`), za jawna zgoda uczestnika. Commity po kazdej sekcji sa po to, zeby zawsze bylo dokad wrocic.
