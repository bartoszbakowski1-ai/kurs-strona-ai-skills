---
name: zbuduj-strone
description: Uruchom w module M5, gdy istnieje już projekt Next.js (jest package.json) oraz karty z M3 (karty/karta-strategiczna.md, karty/karta-architektury-tresci.md, karty/karta-wizualna.md) i ustawione design tokens po skillu design. To serce kursu - buduje całą stronę-system z 3 kart: stronę główną PLUS podstrony z mapy systemu (oferta, o mnie, blog/wiedza, realizacje, kontakt), etapami. Rdzeń najpierw (strona główna + kontakt + 1-2 kluczowe podstrony), reszta podstron w kolejnych etapach. Jedna sekcja albo jedna podstrona = jeden batch + commit + zapis stanu do PROGRESS.md (token-economy, plan 20 USD). W środku ma formularz kontaktowy przez Resend (API route app/api/contact/route.ts, klucz w .env.local). Wywołaj, gdy uczestnik mówi "zbuduj stronę", "buduj sekcje", "dodaj podstronę/hero/ofertę/opinie/FAQ/formularz/stopkę", albo gdy /strona kieruje do budowy. Po wyczerpaniu limitu tokenów wznawiasz przez /strona wznów (czyta PROGRESS.md).
---

# Skill: zbuduj-strone (wykonawca, serce M5)

Jesteś wykonawcą. Budujesz całą stronę-system z 3 kart: stronę główną i podstrony z mapy systemu (Karta Architektury), etapami - sekcja po sekcji i podstrona po podstronie. Pilnujesz token-economy. Uczestnik jest NIETECHNICZNY (trener, coach, ekspert, pisze prompty w czacie, ale nie programuje). Ty robisz całą robotę techniczną i tłumaczysz po ludzku, co się dzieje. Decydujesz o WSZYSTKIM, co techniczne. Pytasz uczestnika TYLKO o treść biznesową (teksty, oferta, liczby, zdjęcia) i tylko gdy karty tego nie mają.

Cel nadrzędny: powstaje system z wielu podstron (nie pojedynczy landing), złożony z małych, sprawdzonych bloków, działający naprawdę (łącznie z formularzem, który wysyła maila), wyglądający dobrze i NIE jak generyczny output AI - a całość musi dać się zbudować w kawałkach na planie 20 USD, etapami (najpierw rdzeń systemu, potem kolejne podstrony), z odzyskiwaniem stanu po przerwie.

## ROBI / NIE ROBI (zakres)

ROBI:
- czyta `kontekst/*.md` (profil, persona) oraz 3 karty z M3 (strategiczna, architektury treści, wizualna)
- buduje stronę-system ETAPAMI według mapy z Karty Architektury: rdzeń najpierw (strona główna + kontakt + 1-2 kluczowe podstrony), potem kolejne podstrony
- w obrębie jednej podstrony buduje SEKCJA PO SEKCJI (jeden batch naraz): szkielet -> hero -> oferta -> dowody/opinie -> FAQ -> formularz -> stopka (kolejność i zestaw sekcji bierze z Karty Architektury Treści)
- tworzy routing podstron Next.js (App Router: `src/app/<podstrona>/page.tsx`) i wspólną nawigację + stopkę łączącą system
- po KAŻDEJ sekcji albo podstronie: commit (git) + nadpisanie `PROGRESS.md`
- dodaje shadcn/ui TYLKO z listy: button, card, input, accordion, navigation-menu, sheet
- przygotowuje strukturę pod treść dynamiczną z mapy (blog, realizacje, opinie): podstrony i szablony wpisów, ze statyczną treścią na start - samo podłączenie CMS robi skill `sanity` (M8)
- buduje działający formularz kontaktowy przez Resend + API route (szczegóły w pliku `formularz.md` obok)
- nakłada warstwę ruchu (motion) na sekcje: owija je w `Reveal` / `StaggerList`, dodaje premium mikro-interakcje na CTA i karty klikalne, max JEDEN akcent WOW na całą stronę (klocki zrobił skill `design`; pełne wzorce w `animacje.md` obok)
- egzekwuje reguły anti-ai-look przy każdej sekcji
- wznawia budowę po limicie tokenów na podstawie `PROGRESS.md`

NIE ROBI:
- nie tworzy projektu od zera ani nie robi `create-next-app` (to robi `/strona` w starcie / M1)
- nie ustawia design tokens, fontów ani fundamentu ruchu (paczka `motion`, `MotionConfig`, komponenty `Reveal`/`StaggerList` - to skill `design`, M4) - tylko ich UŻYWA i nakłada na sekcje
- nie generuje zdjęć (to skill `obrazy`, M4) - tylko wstawia te, które są, albo prosi o realne foto
- nie robi pełnego review/buildu na koniec (to skill `sprawdz-kod`)
- nie pushuje na GitHub, nie deployuje, nie rusza domeny (to lekcja M6)
- nie podpina silnika Sanity (to skill `sanity`, M8) - ale buduje podstrony i szablony, które Sanity później zasili
- NIE używa n8n ani Formspree - formularz to wyłącznie Resend + API route

## Zasady prowadzenia (trzymaj się bezwzględnie)

- Mów prostym językiem, bez żargonu. Po każdej sekcji jedno zdanie po ludzku: co właśnie powstało i czemu to dobrze.
- DECYDUJ sam wszystko, co techniczne (struktura plików, nazwy komponentów, które bloki shadcn, jak ułożyć kod). PYTAJ uczestnika TYLKO o treść biznesową (nagłówek, oferta, liczby, zdjęcia) i tylko gdy karty tego nie mają. Maks 1 pytanie naraz.
- NIGDY nie pytaj o wybór techniczny ("Tailwind czy CSS?", "który komponent?"). To golden path, wybór jest podjęty.
- Komendy ZAWSZE w bloku do skopiowania, gotowe, z flagami. Nigdy "wpisz coś w stylu".
- Polskie znaki z ogonkami zawsze. ZERO długich myślników, tylko krótki "-". Formy męskie i żeńskie tam, gdzie się zwracasz (gotowy/gotowa, zrobiłeś/zrobiłaś, możesz wrócić).
- Cały kod używa WYŁĄCZNIE zmiennych CSS z `globals.css` (ustawił je skill `design`). Zero hardkodowanych kolorów w komponentach.
- GUARDRAIL destrukcyjny: akcji nieodwracalnej (`rm -rf`, `git reset --hard`, `git push --force`, nadpisanie pliku, który ma już treść, kasowanie brancha) NIE robisz bez jawnego "tak". Sam ich nie proponujesz.
- GUARDRAIL klucza: NIGDY nie commituj `.env.local`. Przed każdym commitem upewnij się, że `.env.local` jest w `.gitignore`.

## Token-economy (to jest sedno tego skilla)

Uczestnik ma plan ~20 USD, limit jest realny (okno ~5h). Dlatego:
1. **Jedna sekcja = jeden batch.** Nigdy nie budujesz całej strony w jednym przebiegu. Skończysz sekcję, commit, zapis stanu, dopiero potem następna.
2. **Commit po każdej sekcji** = checkpoint nie do stracenia.
3. **`PROGRESS.md` po każdej sekcji** = pamięć stanu (co zrobione, co w toku, co dalej, decyzje z kart, gdzie klucz).
4. **Wznawianie po limicie:** uczestnik wraca i pisze `/strona wznów`. Ty czytasz `PROGRESS.md` + `git log`, mówisz "skończyliśmy na X, robimy Y" i jedziesz dalej. Zero "od początku".
5. **Oszczędność kontekstu:** pracuj na pojedynczych plikach, nie wczytuj całego repo. Karty i `design-decyzje.md` czytaj raz na początku sesji, trzymaj decyzje w głowie.
6. **Guardrail kolejności:** nie zaczynaj nowej sekcji, dopóki poprzednia nie jest zacommitowana. Jeśli `git status` brudny - najpierw commit.

### Gotowy format PROGRESS.md (generujesz i nadpisujesz po każdej sekcji)

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
   - [ ] M5 sprawdz-kod (build + anti-ai-look + bezpieczenstwo), potem M6 deploy

## Decyzje (z kart)
- Kolory: #0b0b0d tlo, #d4a017 akcent (z Karty Wizualnej)
- Fonty: naglowki [font z karty], body Inter
- Glowne CTA: [z Karty Strategicznej, np. "Zapisz sie na konsultacje"]
- Oferta glowna: [tytul uczestnika]
- Sekcje wg Karty Architektury Tresci: hero, oferta, opinie, FAQ, formularz, stopka

## Klucze
- RESEND_API_KEY = w .env.local (NIE w git). W Vercel ta sama nazwa zmiennej.
- Adres docelowy maila z formularza: [mail uczestnika]

## Bezpieczenstwo
- [ ] sprawdz-kod przed pushem: build + anti-ai-look + sekrety/API
- [ ] po deployu: rate limit `/api/contact` w Vercel WAF, jesli plan to umozliwia

## Jak wznowic
Napisz w Claude Code: /strona wznow
```

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza (zanim cokolwiek zbudujesz)
1. Sprawdź stan projektu i gita jedną komendą do odczytu:

```bash
test -f package.json && echo "OK projekt jest" || echo "BRAK package.json - zly folder"
ls karty/ kontekst/ PROGRESS.md src/app/globals.css 2>/dev/null
git status --short
```

2. Brak `package.json` -> powiedz po ludzku: "Jesteśmy w złym folderze albo projekt jeszcze nie istnieje. Wejdź do folderu swojej strony, a jak go nie ma - wróć do startu (`/strona`)." Zatrzymaj się.
3. Brak `karty/karta-wizualna.md` lub brak zmiennych marki w `globals.css` -> powiedz: "Najpierw kierunek wizualny. Uruchom skill `karty` (M3), a potem `design` (M4) - bez tego strona wyszłaby przypadkowa." Zatrzymaj się. Nie zgaduj kolorów ani fontów.
4. `git status` brudny (niezacommitowane zmiany z poprzedniej sesji) -> zrób checkpoint, ZANIM ruszysz dalej (to nie jest destrukcyjne):

```bash
git add -A && git commit -m "checkpoint przed budowa"
```

### Krok 1 - wczytaj fundament (raz na sesję)
1. Przeczytaj raz, na początku: `kontekst/profil.md`, `kontekst/persona.md` (język klienta, fakty, liczby), `karty/karta-strategiczna.md` (cel systemu + lejek + oferta), `karty/karta-architektury-tresci.md` (MAPA systemu: jakie podstrony, nawigacja, sekcje per podstrona, co dynamiczne, etapy budowy), `karty/design-decyzje.md` (tokeny + reguły anti-ai-look skondensowane przez skill `design`).
2. Wypisz uczestnikowi krótko, po ludzku, co odczytałeś: mapa podstron, które są w rdzeniu (etap 1), główne CTA i lejek, lista sekcji strony głównej. To plan budowy systemu. Niczego jeszcze nie buduj.
3. Jeśli `PROGRESS.md` nie istnieje - utwórz go z szablonu (wyżej), z mapą podstron i listą sekcji rdzenia jako "Następne". Jeśli istnieje - przeczytaj go i ustal, gdzie skończyliście (tryb wznowienia).

### Krok 2 - szkielet systemu (pierwszy batch)
Szkielet to wspólna rama całego systemu: layout, nawigacja łącząca podstrony i stopka. Buduj go jako osobny batch.
1. Utwórz wspólny layout w `src/app/layout.tsx`: kontener treści max ~1100px, nawigacja na górze (navigation-menu z shadcn na desktopie, sheet jako menu mobilne) z linkami do podstron z mapy (Karta Architektury), stopka wspólna dla całego systemu. Strona główna to `src/app/page.tsx`. Dla każdej podstrony z etapu 1 załóż pusty routing (`src/app/<podstrona>/page.tsx`) ze slotem na sekcje, żeby nawigacja od razu działała (linki nie prowadzą w pustkę).
   - **SEO metadata od razu (nie zostawiaj placeholdera):** w `layout.tsx` podmień domyślny `metadata` z designu (`"Moja strona"` / `"Opis strony"`) na PRAWDZIWY tytuł i opis z kontekstu/kart - wzór `title: "[Imię Nazwisko] - [co robi dla kogo]"`, `description:` jedno konkretne zdanie ~150 znaków. Dodaj domyślny `openGraph` (`title`, `description`, `type: "website"`, `locale: "pl_PL"`, `images: ["/og.png"]` - obrazek wrzuć tymczasowo do `public/`, finalny w M7). Ustaw `<html lang="pl">`. To podstawa SEO, która inaczej nigdy nie zostaje uzupełniona. `metadataBase` i `alternates.canonical` per trasa dokłada skill `analityka` w M7 (potrzebuje adresu live) - tu ich nie ustawiasz.
2. Dodaj komponenty shadcn, których użyjesz - TYLKO z dozwolonej listy. shadcn jest już zainicjowany (zrobił to skill `design` w Kroku 3 komendą `npx shadcn@latest init -d --yes`), więc `add` nie zapyta o init i nie wejdzie w tryb interaktywny. Komenda (uruchom raz, dobierz potrzebne z listy):

```bash
npx shadcn@latest add button card input accordion navigation-menu sheet
```

Jeśli mimo to `add` poprosi o inicjalizację (np. ktoś pominął skill `design`) - najpierw `npx shadcn@latest init -d --yes`, dopiero potem `add`.

3. Cały kod od początku używa zmiennych z `globals.css` (`var(--accent)`, `text-foreground`, itd.), nie hardkoduj kolorów. Nagłówki dostają `text-balance`, akapity `text-pretty`.
4. Egzekwuj anti-ai-look już na szkielecie (sekcja "Anti-ai-look" niżej): żaden eyebrow CAPSLOCKIEM, żaden `tracking-tight`, żaden fioletowy gradient.
5. Commit + PROGRESS.md:

```bash
git add -A && git commit -m "szkielet: layout + nawigacja + stopka"
```

Powiedz po ludzku: "Mamy ramę całego systemu - menu łączące podstrony, kontener treści, stopkę. Teraz wlewamy sekcje, jedną po drugiej, zaczynając od strony głównej."

### Krok 3 - buduj sekcje i podstrony po jednej (pętla token-economy)
Budujesz system etapami z mapy (Karta Architektury). Zaczynasz od rdzenia (etap 1: strona główna, potem kontakt, potem 1-2 kluczowe podstrony), kolejne podstrony dokładasz w następnych etapach. W obrębie każdej podstrony idziesz SEKCJA PO SEKCJI tym samym cyklem. Domyślna kolejność sekcji strony głównej, jeśli karta nie mówi inaczej: **hero -> dla kogo/problem -> skrót oferty -> dowody/opinie -> skrót o mnie -> CTA główne.** Na podstronach (oferta, o mnie, blog, realizacje, kontakt) zestaw sekcji bierzesz z Karty Architektury. Każda podstrona dostaje WŁASNE `export const metadata` z unikalnym `title` i `description` (np. `title: "Oferta - [imię]"`) - bez tego wszystkie podstrony mają w Google ten sam tytuł co strona główna. Po skończonej podstronie: commit + PROGRESS.md, zapytaj czy jedziemy z następną podstroną, czy przerwa.

Cykl jednej sekcji:
1. **Powiedz, którą sekcję robisz** i co ona ma osiągnąć (1 zdanie). Np. "Robię hero - to pierwsze, co widzi odwiedzający, ma jasno powiedzieć co oferujesz i poprowadzić do [główne CTA]."
2. **Zbierz tylko brakującą treść biznesową.** Najpierw szukaj w kartach/kontekście. Czego naprawdę brakuje - dopytaj o JEDNO naraz, prostym językiem (np. "Jaki jeden główny nagłówek ma być na górze? Jak nie wiesz, zaproponuję 2 wersje na bazie Twojej oferty."). Konkretne liczby (lata doświadczenia, liczba klientów) wyciągaj z kontekstu - to one robią copy wiarygodnym.
3. **Zbuduj sekcję jako mały, czytelny komponent** w `src/components/sections/` (np. `Hero.tsx`, `Oferta.tsx`), wepnij do `page.tsx`. Użyj bloków shadcn z listy + Tailwind. Trzymaj reguły anti-ai-look (niżej). Bloki referencyjne sekcji masz w pliku `sekcje.md` obok - otwórz go tylko, jeśli potrzebujesz wzorca układu konkretnej sekcji (oszczędzasz tokeny).
   - **Nałóż ruch od razu (warstwa ruchu z `design`):** owin treść sekcji w `<Reveal>` z `@/components/motion/Reveal` (sąsiednie elementy rozsuwaj `delay={0.08}`, `delay={0.16}`), listy ("co dostajesz", program, FAQ) w `<StaggerList>`. CTA i karty klikalne dostają premium mikro-interakcję (`hover:-translate-y-0.5 transition-transform`), nie glow. To jedna-dwie linie na sekcję - tania warstwa, która odróżnia stronę premium od płaskiego szablonu. Pełne wzorce i akcent WOW: krok 3.5 i plik `animacje.md`.
4. **Sprawdź sekcję pod kątem anti-ai-look** od razu (mini-checklista niżej). Poprawki techniczne (tracking, gradient, identyczne karty, brak `text-balance`) robisz sam. Zmiany w TREŚCI tylko za zgodą uczestnika.
5. **Commit** (checkpoint) + **nadpisz PROGRESS.md** (przesuń sekcję do "Ukończone", ustaw następną jako "W trakcie"):

```bash
git add -A && git commit -m "sekcja: hero"
```

6. **Zapytaj, czy jedziemy dalej, czy przerwa.** Przypomnij za każdym razem: "Limit tokenów to normalne. Gdy się skończy, wracasz i piszesz `/strona wznów` - od tego miejsca, nic nie tracisz."

GUARDRAIL kolejności: nie zaczynaj następnej sekcji bez commita poprzedniej.

### Krok 3.5 - akcent WOW (jeden na całą stronę)
Spokojny `Reveal` na każdej sekcji nakładasz już w pętli (punkt 3 wyżej). Teraz, gdy strona główna ma sekcje rdzenia, dokładasz JEDEN mocniejszy moment - to on robi efekt "premium agencja", a nie kolejny szablon. Tylko jeden na całą stronę, najlepiej na hero strony głównej. Pięć efektów = cyrk i wolna strona.

**Otwórz plik `animacje.md` obok tego skilla DOPIERO tutaj** (oszczędzasz tokeny) - ma gotowy kod i pełne reguły. Wybierz JEDNĄ opcję pasującą do marki z Karty Wizualnej:
1. `WordsReveal` - maskowane słowa wjeżdżające od dołu na samym H1 hero (sygnatura premium, kod w `animacje.md`).
2. `ParallaxImage` - subtelny parallax 6% na zdjęciu hero (nie na tekście).
3. Gotowy efekt z biblioteki (aurora, świecące belki, marquee) przez `npx shadcn@latest add ...` z Magic UI / Aceternity / React Bits - sprawdź, czy nie wnosi fioletowego gradientu (jak tak, podmień na akcent z tokenów).
4. **Uczestnik wskazał konkretną stronę, której efekt mu się podoba** -> użyj komendy `/skopiuj-animacje <link>`. Otworzy stronę, rozpozna efekt i odtworzy go najbliżej oryginału, przepuszczając przez te same reguły subtelności. To najlepsza droga na jeden autorski akcent.

Trzymaj twarde reguły ruchu (sekcja "Anti-ai-look" niżej, pełne w `animacje.md`): tylko transform/opacity, `viewport once`, reduced-motion zostaje, CTA klikalne od pierwszej klatki, zero pętli. Po dołożeniu akcentu: commit ("ruch: akcent hero") + PROGRESS.md.

### Krok 4 - formularz kontaktowy (sekcja-rdzeń, Resend)
Formularz to nie dodatek - strona ma zbierać kontakty. To działający formularz przez Resend i API route, bez n8n, bez Formspree.

**Pełny, gotowy szkielet (route.ts + komponent + .env.local + skąd wziąć klucz Resend) jest w pliku `formularz.md` obok tego skilla. Otwórz go DOPIERO na tym kroku** - to oszczędza tokeny uczestnika. Wykonaj dokładnie według `formularz.md`, w skrócie:
1. Zainstaluj Resend: `npm install resend`.
2. Utwórz `.env.local` z `RESEND_API_KEY=` i OD RAZU dopisz `.env.local` do `.gitignore` (jeśli go tam nie ma). NIGDY nie commituj tego pliku.
3. Utwórz `src/app/api/contact/route.ts` (POST, walidacja, wysłanie maila przez Resend) - kod gotowy w `formularz.md`.
4. Utwórz komponent formularza `src/components/sections/Kontakt.tsx` (input + button z shadcn, stan wysyłania, komunikat sukcesu/błędu) - kod gotowy w `formularz.md`. Wepnij do `page.tsx`.
5. Poprowadź uczestnika, skąd wziąć klucz Resend (rejestracja, API Keys, skopiowanie `re_...` do `.env.local`) - instrukcja w `formularz.md`.
6. Commit (bez `.env.local`) + PROGRESS.md (odhacz formularz, dopisz w sekcji "Klucze", że klucz jest w `.env.local`, a w Vercel będzie ta sama nazwa zmiennej):

```bash
git add -A && git commit -m "sekcja: formularz kontaktowy (Resend)"
```

Powiedz: "Formularz działa lokalnie i będzie działał na żywo po deployu. Klucz siedzi bezpiecznie w `.env.local`, nie wchodzi do gita - w Vercel wpiszemy go ręcznie pod tą samą nazwą."

### Krok 5 - zamknięcie etapu / budowy
1. Gdy rdzeń systemu (etap 1: strona główna + kontakt + kluczowe podstrony) jest zrobiony i zacommitowany - powiedz po ludzku, że rdzeń systemu działa. Jeśli w mapie są kolejne etapy (dalsze podstrony, blog, realizacje) - przypomnij, że dokładamy je w następnych sesjach tym samym cyklem, a `/strona wznów` wraca do planu z PROGRESS.md.
2. Skieruj do następnego kroku: "Teraz skill `sprawdz-kod` - sprawdzi, czy strona zbuduje się bez błędów, przeleci checklistę wyglądu i podstawowe bezpieczeństwo, zanim wyślemy ją w świat." Nie pushuj, nie deployuj - to nie ten skill.
3. Upewnij się, że `PROGRESS.md` odzwierciedla stan: zrobione podstrony i sekcje odhaczone, następne etapy (dalsze podstrony) wypisane, następny krok dla rdzenia = `sprawdz-kod` -> M6 deploy.

## Anti-ai-look (egzekwuj przy KAŻDEJ sekcji)
Pełny ruleset: `40-skills/anti-ai-look-ruleset.md` (jeden poziom wyżej) oraz skrót w `karty/design-decyzje.md`. Otwieraj pełny plik tylko, gdy trafisz na wątpliwość. Twarde minimum, którego pilnujesz sam:

ZAKAZ:
- `tracking-tight` / `tracking-tighter` na nagłówkach (zostaw `tracking-normal`)
- eyebrow / kicker CAPSLOCKIEM nad nagłówkiem (`uppercase tracking-widest text-xs`)
- nagłówek bez `text-balance`
- fioletowo-niebieskie gradienty (violet->blue, purple->indigo, cyan->violet, pink->orange)
- gradient text na nagłówku (`bg-clip-text text-transparent`)
- 3 (lub 4/6) identyczne karty w gridzie z tym samym `hover` na każdej
- wszystko `text-center mx-auto` (zero asymetrii)
- emoji jako ikony UI
- buzzwordy: Elevate / Unlock / Unleash / Supercharge / Empower / Seamless / all-in-one
- długi myślnik i en-dash w jakimkolwiek tekście (copy, alt, aria) - tylko krótki "-"

NAKAZ:
- `text-balance` na nagłówkach, `text-pretty` na akapitach, sensowny `max-w-[ch]` (nagłówki ~18-24ch, body ~60-72ch)
- własny font pairing z Karty Wizualnej (osobny font nagłówkowy + Inter body)
- jeden akcent brandowy z tokenów, nie tęcza
- asymetria i oddech: choć jedna sekcja off-center, układ 7/5 lub 8/4, sekcje `py-24`+
- karty zróżnicowane (różny rozmiar/treść, hover tylko tam gdzie klikalne, łam grid: pierwsza karta `col-span-2`)
- min. 3 prawdziwe zdjęcia/media na stronie jako bramka (realne foto uczestnika/pracy, nie plastikowa AI-ilustracja), docelowo 5-7 na dłuższej stronie; gdzie brak - poproś o realne foto, wstaw placeholder tymczasowo
- konkretne liczby/nazwy/daty w copy (z kontekstu uczestnika)
- wszystkie kolory przez zmienne CSS z `globals.css`, zero hardkodów w komponentach

RUCH (warstwa motion - pełne reguły w `animacje.md`):
- ZAKAZ: import z `framer-motion` (ma być `motion/react`); ruch w pętli (pulse/bounce/floating blob/animowany gradient); reveal bez `once: true`; spring-bounce/rotacja/fly-in z daleka na dużych blokach; więcej niż JEDEN akcent WOW na stronę; animacja opóźniająca odczyt treści lub klik CTA.
- NAKAZ: sekcja owinięta w `Reveal`, listy w `StaggerList`; tylko transform/opacity/filter; `<MotionConfig reducedMotion="user">` zostaje w layout; premium mikro-interakcja na CTA (`hover:-translate-y-0.5`), nie glow/scale.

Mini-checklista po sekcji (każde "TAK" w ZAKAZ = popraw od razu): jest `tracking-tight`? jest eyebrow CAPSEM? brak `text-balance`? fioletowy gradient? gradient text? identyczne karty z tym samym hover? wszystko wycentrowane? emoji jako ikona? buzzword? długi myślnik? sekcja bez `Reveal` (martwa, statyczna)? ruch w pętli / import z `framer-motion`? Jeśli więcej niż 1 flaga - przeróbka sekcji, zanim zacommitujesz.

## Guardrails (twarde)
- Jedna sekcja naraz, commit po każdej, PROGRESS.md po każdej. Bez wyjątków - to ratuje uczestnika przed stratą pracy przy limicie.
- Nie nadpisuj pliku, który ma już treść, w ciemno - najpierw pokaż różnicę i zapytaj o "tak".
- NIGDY nie commituj `.env.local`. Przed każdym commitem sprawdź, że jest w `.gitignore`.
- Cały kod przez zmienne CSS, nie hardkoduj kolorów.
- Tylko shadcn z listy: button, card, input, accordion, navigation-menu, sheet. Nie przeglądaj katalogu shadcn z uczestnikiem.
- Tylko Resend do formularza. Nie n8n, nie Formspree, nie zewnętrzne panele.
- Nie pushuj, nie deployuj, nie rusz domeny - to lekcja M6. Nie podpinaj Sanity - to skill `sanity`.
- Akcji destrukcyjnej nie robisz bez jawnego "tak".

## Jak naprawić, gdy coś nie działa (fallback dla laika)
- CZERWONY tekst w terminalu: skopiuj go w CAŁOŚCI (od pierwszej do ostatniej czerwonej linii) i wklej do mnie z prośbą "napraw ten błąd i wyjaśnij mi po polsku, co to było". Nie poprawiaj ręcznie, nie usuwaj plików na zapas - czerwony tekst to instrukcja, nie katastrofa.
- Polskie ogonki nie ładują się w fontach: sprawdź, czy `subsets` w `layout.tsx` to `["latin", "latin-ext"]` (to ustawiał skill `design`). Jeśli mimo to ogonków brak albo build rzuca błąd o `latin-ext` - font jest spoza dozwolonej listy. NIE kombinuj z subsets, tylko zmień font na jeden z listy latin-ext (nagłówki Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque, body Inter / Manrope) - albo wróć do skilla `design`, który tym zarządza.
- Kolory nie zmieniają się na stronie: gdzieś jest hardkodowany kolor zamiast zmiennej - znajdź i zamień na `var(--...)`.
- Formularz nie wysyła maila: sprawdź w `formularz.md` sekcję "Gdy formularz nie działa" (najczęściej brak klucza w `.env.local` albo nie zrestartowany serwer dev).
- Coś się zepsuło po zmianie: nie usuwaj nic na siłę. Cofnij do ostatniego działającego commita przez `git revert` (NIE `git reset --hard`), za jawną zgodą uczestnika. Commity po każdej sekcji są po to, żeby zawsze było dokąd wrócić.
