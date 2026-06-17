# anti-ai-look (skondensowane reguly do skilla design)

Ten plik ladujesz on-demand w Kroku 4 skilla `design`. Zrodlo pelne: `../anti-ai-look-ruleset.md`. Tu jest skrocona wersja operacyjna - tyle, ile trzeba wpisac do `karty/design-decyzje.md` i czego skill `zbuduj-strone` ma pilnowac.

## ZAKAZANE (nigdy tego nie generuj)

Typografia:
- ZERO `tracking-tight` / `tracking-tighter` na naglowkach.
- ZERO eyebrow/kicker CAPSLOCKIEM nad naglowkiem (`uppercase tracking-widest text-xs`).
- ZERO naglowkow bez `text-balance`.
- ZERO jednego fontu na wszystko (Inter+Inter, Geist+Geist).
- ZERO dlugiego myslnika "-" i "-" w copy, alt, aria. Tylko krotki "-".

Layout:
- ZERO 3/4/6 identycznych kart w gridzie z TYM SAMYM hover na kazdej.
- ZERO `rounded-2xl border shadow-sm` jako jedyny "kazdy box" (ten sam radius+padding wszedzie).
- ZERO calej strony w `text-center mx-auto`.
- ZERO domyslnej sekwencji hero -> 3 karty -> testimoniale -> CTA gradient bez przerwania jej wlasna sekcja.

Kolor i obrazy:
- ZERO fioletowo-niebieskich gradientow (violet->blue, purple->indigo, cyan->violet, pink->orange).
- ZERO gradient text na naglowku (`bg-clip-text text-transparent`).
- ZERO strony bez prawdziwych zdjec (zastapionej ikonami/blobami/glassmorphism).
- ZERO Lucide-w-kolku przy kazdej sekcji jako jedyny wizual. ZERO emoji jako ikon UI.
- ZERO dark hero + neon glow + `backdrop-blur` jako domyslna estetyka, jesli nie wynika z marki.

Copy:
- ZERO buzzwordow: Elevate/Unlock/Unleash/Supercharge/Empower/Seamless/Revolutionize/Transform, "all-in-one", "in todays fast-paced world", "build the future of".
- ZERO naglowkow feature wszystkich tej samej dlugosci (2-3 slowa kazdy).
- ZERO copy bez ani jednej konkretnej liczby/nazwy/daty.

## NAKAZANE (rob to zamiast)

Typografia:
- `text-balance` na wszystkich naglowkach, `text-pretty` na akapitach.
- Swiadomy `max-width`: naglowek hero `max-w-[18ch]`-`max-w-[24ch]`, body `max-w-[60ch]`-`max-w-[72ch]`.
- `leading`: duze naglowki `leading-tight`, body `leading-relaxed`.
- Tracking naturalny: naglowki `tracking-normal` (max `-0.01em` przy 60px+).
- Para fontow z dozwolonej listy (latin-ext, polskie ogonki): naglowki Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque, body Inter / Manrope. Osobny display na naglowki + czytelny body. Monospace tylko na liczby/ceny/staty (bez polskich znakow) dla tekstury.

Layout:
- Asymetria i oddech: min. jedna sekcja off-center, kolumny czasem 7/5 albo 8/4 zamiast 50/50. Sekcje `py-24`+.
- Roznicuj karty: rozne rozmiary (jedna szeroka + dwie wezsze), rozny content, hover tylko tam gdzie klikalne. Lam grid (`col-span-2` na pierwszej).
- Rytm pionowy: naprzemiennie obraz-lewo/tekst-prawo i odwrotnie.
- Min. 3 prawdziwe zdjecia/media jako bramka, docelowo 5-7 na dluzszej stronie (realne foto uczestnika/pracy, NIE plastikowa AI-illustration).
- Zero pustych komorek w gridach: liczba elementow wypelnia siatke (2 kol = parzysta, 3 kol = wielokrotnosc 3).

Kolor i obrazy:
- Paleta z Karty Wizualnej, jeden akcent marki. Jak gradient, to subtelny ton-w-ton, nie violet->blue.
- Kolor zawsze przez zmienne CSS (`var(--accent)` itd.), nie dekoracyjne gradienty.
- Realne fotografie > ikony. Jak ikony, to jeden spojny zestaw z wlasnym akcentem.

Copy:
- Konkrety i liczby, realne nazwy i wyniki. Glos zalozyciela, nie modelu.
- Naglowki feature roznej dlugosci, opisuja efekt nie ficzer.
- Polskie znaki z ogonkami, zero em-dash, ton ludzki, formy m/z gdzie pasuje.

## SZYBKA CHECKLISTA (wpisz do design-decyzje.md jako bramka)

Strona przechodzi, jesli na te pytania odpowiedz brzmi dobrze:
1. Naglowki maja `text-balance` i normalny tracking? (ma byc TAK)
2. Brak eyebrow capslockiem nad naglowkami? (ma byc TAK)
3. Brak fioletowo-niebieskich gradientow i gradient-text na H? (ma byc TAK)
4. Karty sa zroznicowane, nie 3 identyczne z tym samym hover? (ma byc TAK)
5. Sa min. 3 prawdziwe zdjecia/media, a nie same ikony? Przy dluzszej stronie cel to 5-7. (ma byc TAK)
6. Wszystkie kolory ida ze zmiennych CSS, zero hardkodu? (ma byc TAK)
7. Copy ma min. jedna konkretna liczbe/nazwe i zero em-dash? (ma byc TAK)
8. Layout ma oddech i odrobine asymetrii, nie wszystko wycentrowane? (ma byc TAK)

Prog akceptacji kursu: max 1 odpowiedz "nie". Wiecej = przerob sekcje. Pelna checklista TAK/NIE i scoring sa w `../anti-ai-look-ruleset.md` (sekcja 4) - tego pilnuje skill `sprawdz-kod` przed deployem.
