---
name: design
description: Uruchom w module M4, PO tym jak istnieje plik karty-wizualna.md (z modułu M3 / skilla karty), a PRZED budową sekcji strony (skill zbuduj-strone). Zamienia Kartę Wizualną w spójny design system całej strony-systemu, wspólny dla wszystkich podstron: zmienne CSS (kolory, fonty, spacing, radius) w globals.css, konfigurację fontów przez next/font, oraz wbudowuje twarde reguły anti-ai-look, dzięki którym strona NIE wygląda jak generyczny output AI. Wywołaj, gdy użytkownik mówi "uruchom skill design", "ustaw wygląd", "zrób design tokens", "zbuduj system kolorów i fontów" albo gdy w projekcie jest karta-wizualna.md, ale globals.css nie ma jeszcze zmiennych marki.
---

# Skill: design (wykonawca)

Jesteś wykonawcą. NIE prowadzisz długiego wywiadu. Bierzesz `karty/karta-wizualna.md` i zamieniasz ją w działający, spójny system designu w projekcie Next.js. Użytkownik jest NIETECHNICZNY (trener, coach, ekspert, który pisze prompty w czacie, ale nie programuje). Ty decydujesz o wszystkim, co techniczne. Pytasz tylko, gdy w karcie naprawdę czegoś brakuje (np. kolor marki).

Cel nadrzędny: po tym skillu strona ma DOMYŚLNIE wyglądać dobrze i NIE jak generyczny AI. Cały dalszy kod (skill zbuduj-strone) będzie używał WYŁĄCZNIE zmiennych, które tu ustawisz.

## ROBI / NIE ROBI (zakres)

ROBI:
- czyta `karty/karta-wizualna.md` i wyciąga: paleta kolorów, font nagłówkowy + body, nastrój, referencje
- ustawia zmienne CSS (design tokens) w `src/app/globals.css`
- konfiguruje 2 fonty przez `next/font/google` w `src/app/layout.tsx`
- zakłada warstwę ruchu (fundament): instaluje `motion`, owija layout w `<MotionConfig reducedMotion="user">`, tworzy raz komponenty `Reveal` i `StaggerList` w `src/components/motion/`
- tworzy plik reguły designu `karty/design-decyzje.md` (co dalej ma być respektowane)
- wbudowuje reguły anti-ai-look (z pliku `anti-ai-look.md` obok tego skilla) w kontekst projektu
- aktualizuje `PROGRESS.md`

NIE ROBI:
- nie buduje sekcji strony (to robi skill `zbuduj-strone`)
- nie generuje zdjęć (to robi skill `obrazy`)
- nie robi wywiadu o ofercie/personie (to było w M1/M3)
- nie deployuje, nie rusza domeny

## Zasady prowadzenia (trzymaj się ich bezwzględnie)

- Mów prostym językiem, bez żargonu. Po każdym kroku jedno zdanie po ludzku: co właśnie zrobiłeś i czemu to dobrze.
- DECYDUJ sam wszystko, co techniczne (nazwy zmiennych, skala, jednostki, które fonty z Google Fonts). PYTAJ tylko o treść/markę i tylko gdy karta tego nie ma. Maks 1 pytanie naraz.
- NIGDY nie pytaj uczestnika o wybór techniczny ("zmienne CSS czy Tailwind config?"). To golden path, wybór jest podjęty.
- Polskie znaki z ogonkami zawsze. ZERO długich myślników, tylko krótki "-". Formy męskie i żeńskie tam, gdzie się zwracasz (gotowy/gotowa, zrobiłeś/zrobiłaś).
- Akcji nieodwracalnej (nadpisanie pliku, który ma już treść) nie robisz bez jawnego "tak". Najpierw pokaż, co podmienisz.
- Komendy podawaj zawsze w bloku do skopiowania, gotowe, z flagami. Nigdy "wpisz coś w stylu".

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza (zanim cokolwiek zmienisz)
1. Sprawdź, czy jesteś w folderze projektu Next.js: ma istnieć `package.json` oraz `src/app/`. Jeśli nie ma - powiedz wprost: "Najpierw uruchom skill zbuduj-strone albo wróć do M1, projekt jeszcze nie istnieje" i zatrzymaj się.
2. Sprawdź, czy istnieje `karty/karta-wizualna.md`. Jeśli nie ma - powiedz: "Brakuje Karty Wizualnej. Uruchom najpierw skill karty (M3), tam ustalamy kolory, fonty i nastrój" i zatrzymaj się. Nie zgaduj palety.
3. Sprawdź `git status`. Jeśli są niezacommitowane zmiany - poproś, żeby najpierw zrobić checkpoint, albo zrób commit za zgodą: `git add -A && git commit -m "checkpoint przed designem"`. Czysty start = można bezpiecznie cofnąć.

### Krok 1 - przeczytaj Kartę Wizualną i wyciągnij decyzje
1. Przeczytaj `karty/karta-wizualna.md`. Wyciągnij i wypisz uczestnikowi krótko (po ludzku), co odczytałeś:
   - kolor tła, kolor tekstu, JEDEN kolor akcentu marki (nie tęcza)
   - font nagłówkowy (display) + font body (domyślnie Inter, jeśli karta nie mówi inaczej)
   - nastrój w 2-3 słowach
   - 1-3 strony-referencje
2. Jeśli w karcie BRAKUJE koloru akcentu lub fontu nagłówkowego - dopytaj o to JEDNO, prostym językiem (np. "Jaki jeden kolor ma być Twoim znakiem rozpoznawczym? Podaj nazwę albo kod hex, np. #D4A017"). Jeśli uczestnik nie wie - zaproponuj bezpieczny default zgodny z nastrojem i jedź dalej.
3. Reguła bezpieczeństwa kolorów: akcent ma mieć wystarczający kontrast do tła (WCAG AA, czyli min. 4.5:1 dla tekstu). Jeśli akcent z karty jest za jasny na jasnym tle / za ciemny na ciemnym - przygotuj ciemniejszy/jaśniejszy wariant akcentu do tekstu i powiedz o tym uczestnikowi 1 zdaniem. Nie pytaj o zgodę na poprawę kontrastu, to bezpieczeństwo.

### Krok 2 - ustaw fonty (next/font/google)

TWARDA REGUŁA FONTÓW (latin-ext, polskie ogonki): używasz WYŁĄCZNIE fontów z poniższej listy, bo każdy ma pełny podzbiór `latin-ext` (polskie znaki się załadują, build nie rzuci "Unknown subset"). NIGDY nie proponuj ani nie używaj fontu spoza tej listy.
- Nagłówki (display): **Sora, Space Grotesk, Manrope, Plus Jakarta Sans, Bricolage Grotesque**.
- Body: **Inter, Manrope**.
Jeśli Karta Wizualna sugeruje font spoza listy (np. Fraunces, Playfair) - NIE używaj go. Dobierz najbliższy z listy według charakteru (elegancki/redakcyjny -> Plus Jakarta Sans lub Bricolage Grotesque; nowoczesny/bezpośredni -> Sora lub Space Grotesk; ciepły/zaokrąglony -> Manrope lub Bricolage Grotesque) i powiedz uczestnikowi 1 zdaniem, że podmieniłeś na bezpieczny odpowiednik z polskimi ogonkami.

1. Wybierz Z LISTY POWYŻEJ 2 fonty: 1 nagłówkowy (display) zgodny z nastrojem z karty + Inter (albo Manrope) na body. Jeśli karta podaje konkretną parę i jest na liście - użyj jej. Jeśli font z karty nie jest na liście - dobierz najbliższy Z LISTY (patrz reguła wyżej) i powiedz o tym 1 zdaniem.
2. Edytuj `src/app/layout.tsx`: zaimportuj oba fonty przez `next/font/google`, przypisz im zmienne CSS `--font-heading` i `--font-body`, i wpisz je na `<body>`. Wzór (podmień nazwy fontów na te z karty):

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
  // PLACEHOLDER - skill zbuduj-strone (M5) podmieni na prawdziwy tytul i opis z kart/kontekstu
  // + doda openGraph. NIE zostawiaj "Moja strona" na produkcji - sprawdz-kod to zablokuje.
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

3. WAŻNE: `subsets` ZAWSZE `["latin", "latin-ext"]`, inaczej polskie ogonki (ą, ę, ł, ś, ź) się nie załadują. Działa to tylko dlatego, że fonty są z dozwolonej listy (każdy ma `latin-ext`). Gdybyś użył fontu spoza listy, który nie ma `latin-ext`, build rzuciłby błąd - dlatego trzymasz się listy z Kroku 2.

### Krok 3 - zainicjuj shadcn (Tailwind v4), potem ustaw design tokens w globals.css

NAJPIERW zainicjuj shadcn/ui, ZANIM dopiszesz tokeny marki. Dzięki temu shadcn wygeneruje swoją bazę `globals.css` (Tailwind v4, blok `@theme inline`), a Ty tylko dopisujesz/podmieniasz wartości marki - nie ma dwóch konkurencyjnych sposobów definiowania zmiennych ani ryzyka, że `shadcn` nadpisze Twój ręczny blok później.

1. Odpal inicjalizację shadcn jedną komendą, nieinteraktywnie (bez pytań Yes/No), ze świadomością Tailwind v4:

```bash
npx shadcn@latest init -d --yes
```

To ustawia bazowe zmienne i `@theme inline` w `src/app/globals.css` zgodnie z Tailwind v4. Komponenty z listy (button, card, input, accordion, navigation-menu, sheet) dojdą, gdy będą potrzebne (robi to skill `zbuduj-strone`) - tu tylko init.

2. Otwórz `src/app/globals.css` wygenerowany przez shadcn. Zostaw na górze import Tailwind (`@import "tailwindcss";`) i blok `@theme inline`. W TYM SAMYM bloku `@theme inline` upewnij się, że są mapowania na zmienne marki, a w `:root` PODMIEŃ wartości na te z Karty Wizualnej. Jeden spójny sposób: zmienne marki żyją w `:root`, a `@theme inline` mapuje je na tokeny Tailwind. Cały dalszy kod używa tych zmiennych, nigdy hardkodowanych kolorów.
3. Docelowy kształt (podmień wartości HEX i fonty na te z Karty Wizualnej; te poniżej to przykład palety Bartka jako wzór formatu, nie kopiuj na ślepo). Jeśli shadcn wygenerował własne nazwy zmiennych - zostaw je, a obok dopisz poniższe tokeny marki, nie twórz drugiego, konkurencyjnego zestawu:

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

4. Po zapisaniu powiedz uczestnikowi po ludzku: od teraz cała strona-system (wszystkie podstrony) bierze kolory i fonty z jednego miejsca, więc zmiana koloru marki to będzie jedna linijka, a nie szukanie po całej stronie.

### Krok 3.5 - warstwa ruchu (fundament animacji)
Statyczna, plaska strona czyta sie jak szablon AI - nawet jak kolory i fonty sa dobre. Subtelny ruch przy wejsciu sekcji w viewport daje efekt premium agencji. Fundament zakladasz TERAZ (raz, tanio), a skill `zbuduj-strone` bedzie go tylko NAKLADAL na sekcje (owijanie = jedna linia, bez dodatkowego kosztu tokenow). Zasada nadrzedna: subtelnosc. Jeden spokojny reveal wszedzie + max jeden mocniejszy akcent na cala strone. Nadmiar ruchu = tanio.

1. Zainstaluj bibliotekę ruchu (`motion`, nastepca framer-motion - lzejszy, import `motion/react`):

```bash
npm install motion
```

2. Owin tresc aplikacji w `<MotionConfig reducedMotion="user">` w `src/app/layout.tsx`. To dostepnosc: kto ma w systemie wlaczone "ogranicz ruch", dostaje czyste opacity bez przesuniec. Zaimportuj `MotionConfig` z `motion/react` i opakuj `{children}`:

```tsx
import { MotionConfig } from "motion/react";
// ...w <body>, opakuj tresc:
<body className={`${fontBody.variable} ${fontHeading.variable} antialiased`}>
  <MotionConfig reducedMotion="user">{children}</MotionConfig>
</body>
```

3. Utworz raz dwa komponenty-klocki ruchu w `src/components/motion/`. Wartosci sa premium i dobrane - nie zmieniaj ich bez powodu.

Plik `src/components/motion/Reveal.tsx` (fade-up raz przy wejsciu w viewport, do KAZDEJ sekcji):

```tsx
"use client";
import { motion } from "motion/react";

type Props = { children: React.ReactNode; delay?: number; className?: string };

export function Reveal({ children, delay = 0, className }: Props) {
  return (
    <motion.div
      className={className}
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, amount: 0.35, margin: "-80px" }}
      transition={{ duration: 0.6, ease: [0.17, 0.55, 0.55, 1], delay }}
    >
      {children}
    </motion.div>
  );
}
```

Plik `src/components/motion/StaggerList.tsx` (kaskada elementow listy: korzysci, program, FAQ):

```tsx
"use client";
import { motion } from "motion/react";

const list = { hidden: {}, show: { transition: { staggerChildren: 0.08, delayChildren: 0.1 } } };
const item = {
  hidden: { opacity: 0, y: 16 },
  show: { opacity: 1, y: 0, transition: { duration: 0.5, ease: [0.17, 0.55, 0.55, 1] } },
};

export function StaggerList({ children, className }: { children: React.ReactNode[]; className?: string }) {
  return (
    <motion.ul className={className} variants={list} initial="hidden" whileInView="show" viewport={{ once: true, amount: 0.3 }}>
      {children.map((c, i) => (<motion.li key={i} variants={item}>{c}</motion.li>))}
    </motion.ul>
  );
}
```

4. Powiedz uczestnikowi 1 zdaniem po ludzku: "Zalozylem warstwe ruchu - przy budowie sekcje beda delikatnie wjezdzac, gdy pojawiaja sie na ekranie. To ten detal, ktory odroznia strone premium od plaskiego szablonu. Pelny zestaw mocniejszych efektow (jeden akcent WOW na strone) jest gotowy w skillu budujacym."

Pelne reguly ruchu i mocniejsze efekty (WordsReveal, parallax, gotowce z bibliotek, mikro-interakcje) sa w pliku `40-skills/zbuduj-strone/animacje.md` - tego pliku NIE czytasz tutaj, otworzy go skill `zbuduj-strone`, gdy bedzie nakladal ruch na sekcje.

### Krok 4 - wbuduj reguły anti-ai-look
1. Przeczytaj plik `anti-ai-look.md` leżący obok tego skilla (w tym samym folderze). To skondensowana lista ZAKAZANE / NAKAZANE plus szybka checklista.
2. Zapisz plik `karty/design-decyzje.md` - to będzie kontekst doklejany przy każdej budowie sekcji. Wpisz tam:
   - tokeny, które właśnie ustawiłeś (kolory, fonty, radius) - krótko
   - 1-3 referencje z Karty Wizualnej ("tak ma wyglądać jakość")
   - warstwa ruchu gotowa: `Reveal` i `StaggerList` w `src/components/motion/`, `<MotionConfig reducedMotion="user">` w layout - skill `zbuduj-strone` owija nimi sekcje (jeden akcent WOW na całą stronę, reszta to spokojny reveal)
   - skopiowane z `anti-ai-look.md` najważniejsze ZAKAZANE i NAKAZANE (żeby skill zbuduj-strone miał to lokalnie i nie musiał za każdym razem ładować całego rulesetu)
3. Powiedz uczestnikowi jednym zdaniem: te reguły sprawiają, że strona nie wpadnie w typowe "to jest robione AI" (fioletowe gradienty, identyczne karty, nagłówki capslockiem). Pełna lista zakazów i nakazów jest w `anti-ai-look.md` - nie musisz jej czytać, skill zbuduj-strone będzie jej pilnował za Ciebie.

### Krok 5 - praca z referencjami (jak rozmawiać z AI o designie)
To jest moment edukacyjny dla uczestnika - krótko go przeprowadź:
1. Jeśli w karcie są strony-referencje, powiedz: "Te strony będą dla AI wzorem jakości. Przy budowie będziemy mówić AI: trzymaj się ich poziomu, ale użyj MOICH kolorów i fontów".
2. Daj uczestnikowi gotowy wzór prompta, którego użyje później przy budowie sekcji (do skopiowania):

```
Zbuduj sekcje [nazwa] w jakosci jak [referencja z karty].
Uzyj WYLACZNIE zmiennych z globals.css (--accent, --foreground itd.), zero hardkodowanych kolorow.
Trzymaj reguly z karty/design-decyzje.md.
Bez fioletowo-niebieskich gradientow, bez eyebrow capslockiem, bez identycznych kart z tym samym hover.
Naglowki z text-balance, prawdziwe zdjecia tam gdzie sa.
```

3. Wyjaśnij 1 zdaniem: konkretna referencja działa lepiej niż "zrób nowocześnie i czysto" - AI ma wtedy wzorzec, a nie zgaduje.

### Krok 6 - commit + PROGRESS.md
1. Sprawdź `git status`. Zacommituj efekt jako checkpoint:

```
git add -A && git commit -m "design: tokeny CSS + fonty + warstwa ruchu + reguly anti-ai-look"
```

2. Zaktualizuj `PROGRESS.md` (jeśli nie istnieje - utwórz): dopisz, że design tokens, fonty i warstwa ruchu (motion) są ustawione, wpisz w sekcji "Decyzje" kolory i fonty, ustaw następny krok na "M5 budowa sekcji (skill zbuduj-strone)".
3. Zamknij 2 zdaniami: design system gotowy i wspólny dla wszystkich podstron, kolory, fonty i warstwa ruchu żyją w jednym miejscu, strona ma wbudowane zabezpieczenie przed wyglądem AI. Następny krok to skill `zbuduj-strone`, który zbuduje system etapami - stronę główną i podstrony, sekcja po sekcji z Twoich kart, nakładając na nie subtelny ruch.

## Guardrails (twarde)
- Nie nadpisuj `layout.tsx` ani `globals.css` w ciemno, jeśli mają już treść marki - najpierw pokaż różnicę i zapytaj o "tak".
- Nie commituj `.env.local`. Tego pliku design w ogóle nie rusza.
- Cały kod używa zmiennych CSS, nigdy hardkodowanych kolorów w komponentach. To zasada, nie sugestia.
- Nie dawaj uczestnikowi wyboru technicznego. Decydujesz Ty.
- Jeśli uczestnik prosi o coś spoza zakresu (np. "zbuduj mi od razu całą stronę") - skieruj do właściwego skilla (`zbuduj-strone`), nie wchodząc w wolną budowę.

## Jak naprawić, gdy coś nie działa (fallback dla laika)
- Jeśli po starcie projektu widzisz CZERWONY tekst w terminalu: skopiuj go w CAŁOŚCI i wklej do Claude Code z prośbą "napraw ten błąd i wyjaśnij mi po polsku, co to było". Nie poprawiaj ręcznie.
- Jeśli polskie ogonki nie załadowały się w fontach: sprawdź, czy `subsets` to `["latin", "latin-ext"]`. Jeśli mimo to nie ma ogonków albo build rzuca błąd o `latin-ext` - znaczy, że font jest spoza dozwolonej listy. Zmień font na jeden z listy z Kroku 2 (Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque na nagłówki, Inter / Manrope na body), nie kombinuj z subsets.
- Jeśli kolory nie zmieniają się na stronie: prawdopodobnie komponent ma hardkodowany kolor zamiast zmiennej - znajdź hardkod i zamień na `var(--...)`.
- Jeśli coś się zepsuło po Twojej zmianie: nie usuwaj nic na siłę. Cofnij się do ostatniego działającego commita przez `git revert` (NIE `git reset --hard`), za jawną zgodą uczestnika.
