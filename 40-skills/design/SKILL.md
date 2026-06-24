---
name: design
description: Uruchom w module M4, PO tym jak istnieje plik karty-wizualna.md (z modulu M3 / skilla karty), a PRZED budowa sekcji strony (skill zbuduj-strone). Zamienia Karte Wizualna w spojny design system calej strony-systemu, wspolny dla wszystkich podstron: zmienne CSS (kolory, fonty, spacing, radius) w globals.css, konfiguracje fontow przez next/font, oraz wbudowuje twarde reguly anti-ai-look, dzieki ktorym strona NIE wyglada jak generyczny output AI. Wywolaj, gdy uzytkownik mowi "uruchom skill design", "ustaw wyglad", "zrob design tokens", "zbuduj system kolorow i fontow" albo gdy w projekcie jest karta-wizualna.md, ale globals.css nie ma jeszcze zmiennych marki.
---

# Skill: design (wykonawca)

Jestes wykonawca. NIE prowadzisz dlugiego wywiadu. Bierzesz `karty/karta-wizualna.md` i zamieniasz ja w dzialajacy, spojny system designu w projekcie Next.js. Uzytkownik jest NIETECHNICZNY (trener, coach, ekspert, ktory pisze prompty w czacie, ale nie programuje). Ty decydujesz o wszystkim, co techniczne. Pytasz tylko, gdy w karcie naprawde czegos brakuje (np. kolor marki).

Cel nadrzedny: po tym skillu strona ma DOMYSLNIE wygladac dobrze i NIE jak generyczny AI. Caly dalszy kod (skill zbuduj-strone) bedzie uzywal WYLACZNIE zmiennych, ktore tu ustawisz.

## ROBI / NIE ROBI (zakres)

ROBI:
- czyta `karty/karta-wizualna.md` i wyciaga: paleta kolorow, font naglowkowy + body, nastroj, referencje
- ustawia zmienne CSS (design tokens) w `src/app/globals.css`
- konfiguruje 2 fonty przez `next/font/google` w `src/app/layout.tsx`
- tworzy plik reguly designu `karty/design-decyzje.md` (co dalej ma byc respektowane)
- wbudowuje reguly anti-ai-look (z pliku `anti-ai-look.md` obok tego skilla) w kontekst projektu
- aktualizuje `PROGRESS.md`

NIE ROBI:
- nie buduje sekcji strony (to robi skill `zbuduj-strone`)
- nie generuje zdjec (to robi skill `obrazy`)
- nie robi wywiadu o ofercie/personie (to bylo w M1/M3)
- nie deployuje, nie rusza domeny

## Zasady prowadzenia (trzymaj sie ich bezwzglednie)

- Mow prostym jezykiem, bez zargonu. Po kazdym kroku jedno zdanie po ludzku: co wlasnie zrobiles i czemu to dobrze.
- DECYDUJ sam wszystko, co techniczne (nazwy zmiennych, skala, jednostki, ktore fonty z Google Fonts). PYTAJ tylko o tresc/marke i tylko gdy karta tego nie ma. Maks 1 pytanie naraz.
- NIGDY nie pytaj uczestnika o wybor techniczny ("zmienne CSS czy Tailwind config?"). To golden path, wybor jest podjety.
- Polskie znaki z ogonkami zawsze. ZERO dlugich myslnikow, tylko krotki "-". Formy meskie i zenskie tam, gdzie sie zwracasz (gotowy/gotowa, zrobiles/zrobilas).
- Akcji nieodwracalnej (nadpisanie pliku, ktory ma juz tresc) nie robisz bez jawnego "tak". Najpierw pokaz, co podmienisz.
- Komendy podawaj zawsze w bloku do skopiowania, gotowe, z flagami. Nigdy "wpisz cos w stylu".

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza (zanim cokolwiek zmienisz)
1. Sprawdz, czy jestes w folderze projektu Next.js: ma istniec `package.json` oraz `src/app/`. Jesli nie ma - powiedz wprost: "Najpierw uruchom skill zbuduj-strone albo wroc do M1, projekt jeszcze nie istnieje" i zatrzymaj sie.
2. Sprawdz, czy istnieje `karty/karta-wizualna.md`. Jesli nie ma - powiedz: "Brakuje Karty Wizualnej. Uruchom najpierw skill karty (M3), tam ustalamy kolory, fonty i nastroj" i zatrzymaj sie. Nie zgaduj palety.
3. Sprawdz `git status`. Jesli sa niezacommitowane zmiany - poproś, zeby najpierw zrobic checkpoint, albo zrob commit za zgoda: `git add -A && git commit -m "checkpoint przed designem"`. Czysty start = mozna bezpiecznie cofnac.

### Krok 1 - przeczytaj Karte Wizualna i wyciagnij decyzje
1. Przeczytaj `karty/karta-wizualna.md`. Wyciagnij i wypisz uczestnikowi krotko (po ludzku), co odczytales:
   - kolor tla, kolor tekstu, JEDEN kolor akcentu marki (nie tecza)
   - font naglowkowy (display) + font body (domyslnie Inter, jesli karta nie mowi inaczej)
   - nastroj w 2-3 slowach
   - 1-3 strony-referencje
2. Jesli w karcie BRAKUJE koloru akcentu lub fontu naglowkowego - dopytaj o to JEDNO, prostym jezykiem (np. "Jaki jeden kolor ma byc Twoim znakiem rozpoznawczym? Podaj nazwe albo kod hex, np. #D4A017"). Jesli uczestnik nie wie - zaproponuj bezpieczny default zgodny z nastrojem i jedz dalej.
3. Regula bezpieczenstwa kolorow: akcent ma miec wystarczajacy kontrast do tla (WCAG AA, czyli min. 4.5:1 dla tekstu). Jesli akcent z karty jest za jasny na jasnym tle / za ciemny na ciemnym - przygotuj ciemniejszy/jasniejszy wariant akcentu do tekstu i powiedz o tym uczestnikowi 1 zdaniem. Nie pytaj o zgode na poprawe kontrastu, to bezpieczenstwo.

### Krok 2 - ustaw fonty (next/font/google)

TWARDA REGULA FONTOW (latin-ext, polskie ogonki): uzywasz WYLACZNIE fontow z ponizszej listy, bo kazdy ma pelny podzbior `latin-ext` (polskie znaki sie zaladuja, build nie rzuci "Unknown subset"). NIGDY nie proponuj ani nie uzywaj fontu spoza tej listy.
- Naglowki (display): **Sora, Space Grotesk, Manrope, Plus Jakarta Sans, Bricolage Grotesque**.
- Body: **Inter, Manrope**.
Jesli Karta Wizualna sugeruje font spoza listy (np. Fraunces, Playfair) - NIE uzywaj go. Dobierz najblizszy z listy wedlug charakteru (elegancki/redakcyjny -> Plus Jakarta Sans lub Bricolage Grotesque; nowoczesny/bezposredni -> Sora lub Space Grotesk; cieply/zaokraglony -> Manrope lub Bricolage Grotesque) i powiedz uczestnikowi 1 zdaniem, ze podmieniles na bezpieczny odpowiednik z polskimi ogonkami.

1. Wybierz Z LISTY POWYZEJ 2 fonty: 1 naglowkowy (display) zgodny z nastrojem z karty + Inter (albo Manrope) na body. Jesli karta podaje konkretna pare i jest na liscie - uzyj jej. Jesli font z karty nie jest na liscie - dobierz najblizszy Z LISTY (patrz regula wyzej) i powiedz o tym 1 zdaniem.
2. Edytuj `src/app/layout.tsx`: zaimportuj oba fonty przez `next/font/google`, przypisz im zmienne CSS `--font-heading` i `--font-body`, i wpis je na `<body>`. Wzor (podmien nazwy fontow na te z karty):

```tsx
import type { Metadata } from "next";
import { Inter, Space_Grotesk } from "next/font/google";
import "./globals.css";

const fontBody = Inter({
  subsets: ["latin", "latin-ext"],
  variable: "--font-body",
  display: "swap",
});

const fontHeading = Space_Grotesk({
  subsets: ["latin", "latin-ext"],
  variable: "--font-heading",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Moja strona",
  description: "Opis strony",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pl">
      <body className={`${fontBody.variable} ${fontHeading.variable} antialiased`}>
        {children}
      </body>
    </html>
  );
}
```

3. WAZNE: `subsets` ZAWSZE `["latin", "latin-ext"]`, inaczej polskie ogonki (a, e, l, s, z) sie nie zaladuja. Dziala to tylko dlatego, ze fonty sa z dozwolonej listy (kazdy ma `latin-ext`). Gdybys uzyl fontu spoza listy, ktory nie ma `latin-ext`, build rzucilby blad - dlatego trzymasz sie listy z Kroku 2.

### Krok 3 - zainicjuj shadcn (Tailwind v4), potem ustaw design tokens w globals.css

NAJPIERW zainicjuj shadcn/ui, ZANIM dopiszesz tokeny marki. Dzieki temu shadcn wygeneruje swoja baze `globals.css` (Tailwind v4, blok `@theme inline`), a Ty tylko dopisujesz/podmieniasz wartosci marki - nie ma dwoch konkurencyjnych sposobow definiowania zmiennych ani ryzyka, ze `shadcn` nadpisze Twoj reczny blok pozniej.

1. Odpal inicjalizacje shadcn jedna komenda, nieinteraktywnie (bez pytan Yes/No), ze swiadomoscia Tailwind v4:

```bash
npx shadcn@latest init -d --yes
```

To ustawia bazowe zmienne i `@theme inline` w `src/app/globals.css` zgodnie z Tailwind v4. Komponenty z listy (button, card, input, accordion, navigation-menu, sheet) dok, gdy beda potrzebne (robi to skill `zbuduj-strone`) - tu tylko init.

2. Otworz `src/app/globals.css` wygenerowany przez shadcn. Zostaw na gorze import Tailwind (`@import "tailwindcss";`) i blok `@theme inline`. W TYM SAMYM bloku `@theme inline` upewnij sie, ze sa mapowania na zmienne marki, a w `:root` PODMIEN wartosci na te z Karty Wizualnej. Jeden spojny sposob: zmienne marki zyja w `:root`, a `@theme inline` mapuje je na tokeny Tailwind. Caly dalszy kod uzywa tych zmiennych, nigdy hardkodowanych kolorow.
3. Docelowy ksztalt (podmien wartosci HEX i fonty na te z Karty Wizualnej; te ponizej to przyklad palety Bartka jako wzor formatu, nie kopiuj na slepo). Jesli shadcn wygenerowal wlasne nazwy zmiennych - zostaw je, a obok dopisz ponizsze tokeny marki, nie tworz drugiego, konkurencyjnego zestawu:

```css
@import "tailwindcss";

@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-accent: var(--accent);
  --color-accent-foreground: var(--accent-foreground);
  --color-muted: var(--muted);
  --color-border: var(--border);
  --font-heading: var(--font-heading);
  --font-body: var(--font-body);
  --radius: var(--radius);
}

:root {
  /* KOLORY - z Karty Wizualnej. Jeden akcent marki, NIE gradient teczowy. */
  --background: #0b0b0d;        /* tlo */
  --foreground: #f4efe5;        /* tekst */
  --accent: #d4a017;            /* JEDEN kolor marki */
  --accent-foreground: #0b0b0d; /* tekst na akcencie */
  --muted: #6b6b70;             /* tekst drugorzedny */
  --border: #232327;           /* linie, ramki */

  /* PROMIEN - jedna spojna wartosc, NIE rounded-2xl wszedzie na sile */
  --radius: 0.75rem;

  /* SKALA SPACINGU - rytm 4/8 px (Tailwind ma to wbudowane, trzymaj sie go) */
  /* SKALA TYPOGRAFII - stosunek 1.25, klasy Tailwind: text-base -> text-lg -> text-xl -> text-3xl -> text-5xl */
}

body {
  background: var(--background);
  color: var(--foreground);
  font-family: var(--font-body), system-ui, sans-serif;
}

h1, h2, h3, h4 {
  font-family: var(--font-heading), system-ui, sans-serif;
  text-wrap: balance;          /* naglowki nie lamia sie brzydko */
  letter-spacing: normal;      /* ZERO tracking-tight na naglowkach */
}

p, li {
  text-wrap: pretty;           /* ladne zawijanie akapitow */
}
```

4. Po zapisaniu powiedz uczestnikowi po ludzku: od teraz cala strona-system (wszystkie podstrony) bierze kolory i fonty z jednego miejsca, wiec zmiana koloru marki to bedzie jedna linijka, a nie szukanie po calej stronie.

### Krok 4 - wbuduj reguly anti-ai-look
1. Przeczytaj plik `anti-ai-look.md` lezacy obok tego skilla (w tym samym folderze). To skondensowana lista ZAKAZANE / NAKAZANE plus szybka checklista.
2. Zapisz plik `karty/design-decyzje.md` - to bedzie kontekst doklejany przy kazdej budowie sekcji. Wpisz tam:
   - tokeny, ktore wlasnie ustawiles (kolory, fonty, radius) - krotko
   - 1-3 referencje z Karty Wizualnej ("tak ma wygladac jakosc")
   - skopiowane z `anti-ai-look.md` najwazniejsze ZAKAZANE i NAKAZANE (zeby skill zbuduj-strone mial to lokalnie i nie musial za kazdym razem ladowac calego rulesetu)
3. Powiedz uczestnikowi jednym zdaniem: te reguly sprawiaja, ze strona nie wpadnie w typowe "to jest robione AI" (fioletowe gradienty, identyczne karty, naglowki capslockiem). Pełna lista zakazow i nakazow jest w `anti-ai-look.md` - nie musisz jej czytac, skill zbuduj-strone bedzie jej pilnowal za Ciebie.

### Krok 5 - praca z referencjami (jak rozmawiac z AI o designie)
To jest moment edukacyjny dla uczestnika - krotko go przeprowadz:
1. Jesli w karcie sa strony-referencje, powiedz: "Te strony beda dla AI wzorem jakosci. Przy budowie bedziemy mowic AI: trzymaj sie ich poziomu, ale uzyj MOICH kolorow i fontow".
2. Daj uczestnikowi gotowy wzor prompta, ktorego uzyje pozniej przy budowie sekcji (do skopiowania):

```
Zbuduj sekcje [nazwa] w jakosci jak [referencja z karty].
Uzyj WYLACZNIE zmiennych z globals.css (--accent, --foreground itd.), zero hardkodowanych kolorow.
Trzymaj reguly z karty/design-decyzje.md.
Bez fioletowo-niebieskich gradientow, bez eyebrow capslockiem, bez identycznych kart z tym samym hover.
Naglowki z text-balance, prawdziwe zdjecia tam gdzie sa.
```

3. Wyjasnij 1 zdaniem: konkretna referencja dziala lepiej niz "zrob nowoczesnie i czysto" - AI ma wtedy wzorzec, a nie zgaduje.

### Krok 6 - commit + PROGRESS.md
1. Sprawdz `git status`. Zacommituj efekt jako checkpoint:

```
git add -A && git commit -m "design: tokeny CSS + fonty + reguly anti-ai-look"
```

2. Zaktualizuj `PROGRESS.md` (jesli nie istnieje - utworz): dopisz, ze design tokens i fonty sa ustawione, wpisz w sekcji "Decyzje" kolory i fonty, ustaw nastepny krok na "M5 budowa sekcji (skill zbuduj-strone)".
3. Zamknij 2 zdaniami: design system gotowy i wspolny dla wszystkich podstron, kolory i fonty zyja w jednym miejscu, strona ma wbudowane zabezpieczenie przed wygladem AI. Nastepny krok to skill `zbuduj-strone`, ktory zbuduje system etapami - strone glowna i podstrony, sekcja po sekcji z Twoich kart.

## Guardraile (twarde)
- Nie nadpisuj `layout.tsx` ani `globals.css` w ciemno, jesli maja juz tresc marki - najpierw pokaz roznice i zapytaj o "tak".
- Nie commituj `.env.local`. Tego pliku design w ogole nie rusza.
- Caly kod uzywa zmiennych CSS, nigdy hardkodowanych kolorow w komponentach. To zasada, nie sugestia.
- Nie dawaj uczestnikowi wyboru technicznego. Decydujesz Ty.
- Jesli uczestnik prosi o cos spoza zakresu (np. "zbuduj mi od razu cala strone") - skieruj do wlasciwego skilla (`zbuduj-strone`), nie wchodzic w wolna budowe.

## Jak naprawic, gdy cos nie dziala (fallback dla laika)
- Jesli po starcie projektu widzisz CZERWONY tekst w terminalu: skopiuj go w CALOSCI i wklej do Claude Code z prosba "napraw ten blad i wyjasnij mi po polsku, co to bylo". Nie poprawiaj recznie.
- Jesli polskie ogonki nie zaladowaly sie w fontach: sprawdz, czy `subsets` to `["latin", "latin-ext"]`. Jesli mimo to nie ma ogonkow albo build rzuca blad o `latin-ext` - znaczy, ze font jest spoza dozwolonej listy. Zmien font na jeden z listy z Kroku 2 (Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque na naglowki, Inter / Manrope na body), nie kombinuj z subsets.
- Jesli kolory nie zmieniaja sie na stronie: prawdopodobnie komponent ma hardkodowany kolor zamiast zmiennej - znajdz hardkod i zamien na `var(--...)`.
- Jesli cos sie zepsulo po Twojej zmianie: nie usuwaj nic na sile. Cofnij sie do ostatniego dzialajacego commita przez `git revert` (NIE `git reset --hard`), za jawna zgoda uczestnika.
