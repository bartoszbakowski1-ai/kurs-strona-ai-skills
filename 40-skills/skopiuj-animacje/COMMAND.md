---
name: skopiuj-animacje
description: Otwiera podaną stronę w przeglądarce, znajduje animację, kopiuje albo odtwarza ją i wstawia na stronę Next.js uczestnika. Uruchom, gdy uczestnik wpisze /skopiuj-animacje <link> albo poprosi "skopiuj animację z tej strony", "chcę taką animację jak tu", "przenieś ten efekt na moją stronę". Wymaga podłączonej przeglądarki (Playwright MCP) - jeśli jej brak, kieruje do instrukcji PODLACZ-OCZY.
---

# Komenda: /skopiuj-animacje

Twoim zadaniem jest przenieść animację ze strony podanej przez uczestnika na jego stronę Next.js. Argumenty (link do strony, opcjonalnie opis którego elementu szukać): $ARGUMENTS

Jeśli w argumentach nie ma linku (http...), poproś o link i zatrzymaj się. Uczestnik jest mało techniczny - prowadź go za rękę, tłumacz prostym językiem, zero żargonu.

Wykonaj DOKŁADNIE te kroki po kolei.

## Krok 0 - Sprawdź czy masz "oczy" (przeglądarkę)
Sprawdź, czy masz narzędzie przeglądarki (Playwright MCP - tool `browser_navigate`, albo Chrome DevTools MCP).
- Jeśli NIE masz: zatrzymaj się i napisz prostym językiem: "Żebym mógł zobaczyć tę stronę, potrzebuję podłączonej przeglądarki. To jednorazowy setup - otwórz plik `.claude/materialy/animacje/PODLACZ-OCZY.md`, albo poproś mnie: 'podłącz mi oczy'." Zaproponuj, że przeprowadzisz przez setup. NIE udawaj, że widzisz stronę.
- Jeśli masz: leć dalej.

## Krok 1 - Otwórz stronę i zrób auto-triaż
Wejdź na podany link przez `browser_navigate`. Potem przez `browser_evaluate` uruchom skrypt, który wykryje:
- biblioteki animacji (`window.gsap`, `data-framer*`, `lottie-player`, `window.THREE`, skrypty gsap/three/lottie/unicorn w `script[src]`),
- czy jest `<canvas>` z WebGL (`canvas.getContext('webgl')`) - to przypadek "czarna skrzynka",
- nazwane `@keyframes` (iteruj `document.styleSheets` -> `CSSRule.KEYFRAMES_RULE`),
- ile elementów ma CSS transition (`getComputedStyle(el).transitionDuration`).

## Krok 2 - Sklasyfikuj i powiedz prostym językiem
Powiedz uczestnikowi 1-2 zdaniami co znalazłeś. Wybierz ścieżkę (od najlepszej):
- **CSS (transitions, @keyframes, transform, gradient)** -> wyciągnij PRAWDZIWY kod (`@keyframes` z `cssRules`, computed styles z `getComputedStyle`). Skopiuj 1:1.
- **SVG animowane (SMIL/CSS)** -> SVG jest w DOM, skopiuj markup 1:1.
- **Lottie** (`<lottie-player>` albo plik .json/.lottie w Network) -> znajdź URL, pobierz do `public/`, osadź `@lottiefiles/dotlottie-react`. Cudza własność -> ostrzeż i zaproponuj darmowy odpowiednik z LottieFiles.
- **Wideo w tle / GIF / WebP** -> znajdź URL pliku, jeśli wolno - pobierz do `public/` i osadź. Cudza własność -> ostrzeż.
- **GSAP / Framer Motion / inna biblioteka JS** -> kodu nie da się skopiować 1:1 (zminifikowany). ODTWÓRZ efekt: obejrzyj zachowanie (scroll, hover, timing), nazwij efekt, napisz własny równoważny kod. Powiedz wprost, że to odtworzenie, nie kopia. W tym kursie używaj biblioteki `motion` (patrz skill `animacje-premium`).
- **Wygląda jak znany gotowy komponent** (świecące belki, karty 3D, meteory, aurora, marquee) -> zaproponuj gotowiec z Aceternity UI / Magic UI / React Bits przez `npx shadcn@latest add ...`. Najpewniejsza droga.
- **Canvas 2D / WebGL / shadery / 3D** -> NIE da się sklonować z linku. Powiedz uczciwie. Zaproponuj obejście: gotowy komponent (`react-three-fiber` + `drei`), scena ze Spline (`@splinetool/react-spline`), albo lekki zamiennik CSS (aurora, pole gwiazd). Ostrzeż o wadze/wydajności na mobile.

## Krok 3 - Wstaw na stronę (Next.js)
- Animacje "żywe" (Lottie, Rive, GSAP, motion, Canvas, WebGL) -> `'use client'`, a WebGL/3D dodatkowo `dynamic(() => import(...), { ssr: false })`.
- CSS Modules: `@keyframes` muszą być w tym samym module albo globalne.
- Zainstaluj potrzebne paczki i powiedz uczestnikowi co i po co.
- Zrób osobny, czytelny komponent. Wstaw na sensowne miejsce i pokaż.

## Krok 4 - Sprawdź, że działa (sam, nie pytaj uczestnika)
- Uruchom dev server, otwórz stronę w przeglądarce, zrób screenshot, porównaj z oryginałem. Odbiega -> popraw i sprawdź ponownie. Dopiero gdy działa - pokaż.

## Krok 5 - Podsumuj prostym językiem
Co skopiowałeś/odtworzyłeś, gdzie to jest, jak obejrzeć, i (jeśli dotyczy) czego nie dało się zrobić i jaki dałeś zamiennik. Max 3 zdania + 1 next step.

## Zasady
- Polskie znaki zawsze. Zero długich myślników.
- Czegoś nie da się zrobić -> powiedz wprost, nie udawaj. Uczciwe "to WebGL, dam gotowiec" > podróbka z głowy.
- Nigdy nie pobieraj cudzych assetów bez ostrzeżenia o prawach autorskich i zaproponowania darmowej alternatywy (LottieFiles free, Rive Community).
