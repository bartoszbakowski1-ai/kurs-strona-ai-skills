# anti-ai-look (skondensowane reguły do skilla design)

Ten plik ładujesz on-demand w Kroku 4 skilla `design`. Źródło pełne: `../anti-ai-look-ruleset.md`. Tu jest skrócona wersja operacyjna - tyle, ile trzeba wpisać do `karty/design-decyzje.md` i czego skill `zbuduj-strone` ma pilnować.

## ZAKAZANE (nigdy tego nie generuj)

Typografia:
- ZERO `tracking-tight` / `tracking-tighter` na nagłówkach.
- ZERO eyebrow/kicker CAPSLOCKIEM nad nagłówkiem (`uppercase tracking-widest text-xs`).
- ZERO nagłówków bez `text-balance`.
- ZERO jednego fontu na wszystko (Inter+Inter, Geist+Geist).
- ZERO długiego myślnika "-" i "-" w copy, alt, aria. Tylko krótki "-".

Layout:
- ZERO 3/4/6 identycznych kart w gridzie z TYM SAMYM hover na każdej.
- ZERO `rounded-2xl border shadow-sm` jako jedyny "każdy box" (ten sam radius+padding wszędzie).
- ZERO całej strony w `text-center mx-auto`.
- ZERO domyślnej sekwencji hero -> 3 karty -> testimoniale -> CTA gradient bez przerwania jej własną sekcją.

Kolor i obrazy:
- ZERO fioletowo-niebieskich gradientów (violet->blue, purple->indigo, cyan->violet, pink->orange).
- ZERO gradient text na nagłówku (`bg-clip-text text-transparent`).
- ZERO strony bez prawdziwych zdjęć (zastąpionej ikonami/blobami/glassmorphism).
- ZERO Lucide-w-kółku przy każdej sekcji jako jedyny wizual. ZERO emoji jako ikon UI.
- ZERO dark hero + neon glow + `backdrop-blur` jako domyślna estetyka, jeśli nie wynika z marki.

Copy:
- ZERO buzzwordów: Elevate/Unlock/Unleash/Supercharge/Empower/Seamless/Revolutionize/Transform, "all-in-one", "in todays fast-paced world", "build the future of".
- ZERO nagłówków feature wszystkich tej samej długości (2-3 słowa każdy).
- ZERO copy bez ani jednej konkretnej liczby/nazwy/daty.

## NAKAZANE (rób to zamiast)

Typografia:
- `text-balance` na wszystkich nagłówkach, `text-pretty` na akapitach.
- Świadomy `max-width`: nagłówek hero `max-w-[18ch]`-`max-w-[24ch]`, body `max-w-[60ch]`-`max-w-[72ch]`.
- `leading`: duże nagłówki `leading-tight`, body `leading-relaxed`.
- Tracking naturalny: nagłówki `tracking-normal` (max `-0.01em` przy 60px+).
- Para fontów z dozwolonej listy (latin-ext, polskie ogonki): nagłówki Sora / Space Grotesk / Manrope / Plus Jakarta Sans / Bricolage Grotesque, body Inter / Manrope. Osobny display na nagłówki + czytelny body. Monospace tylko na liczby/ceny/staty (bez polskich znaków) dla tekstury.

Layout:
- HERO strony głównej: pełny pierwszy ekran (`min-h-[85vh]`-`min-h-screen`), mocny wizual (realne zdjęcie/video albo autorski układ typograficzny) + jedno zdanie + jedno CTA. Buduj z sekcji "Hero strony głównej" Karty Wizualnej. NIE sam wycentrowany tekst na gradiencie - to po hero ocenia się całą stronę.
- Asymetria i oddech: min. jedna sekcja off-center, kolumny czasem 7/5 albo 8/4 zamiast 50/50. Sekcje `py-24`+.
- Różnicuj karty: różne rozmiary (jedna szeroka + dwie węższe), różny content, hover tylko tam gdzie klikalne. Łam grid (`col-span-2` na pierwszej).
- Rytm pionowy: naprzemiennie obraz-lewo/tekst-prawo i odwrotnie.
- Min. 3 prawdziwe zdjęcia/media jako bramka, docelowo 5-7 na dłuższej stronie (realne foto uczestnika/pracy, NIE plastikowa AI-illustration).
- Zero pustych komórek w gridach: liczba elementów wypełnia siatkę (2 kol = parzysta, 3 kol = wielokrotność 3).

Kolor i obrazy:
- Paleta z Karty Wizualnej, jeden akcent marki. Jak gradient, to subtelny ton-w-ton, nie violet->blue.
- Kolor zawsze przez zmienne CSS (`var(--accent)` itd.), nie dekoracyjne gradienty.
- Realne fotografie > ikony. Jak ikony, to jeden spójny zestaw z własnym akcentem.

Copy:
- Konkrety i liczby, realne nazwy i wyniki. Głos założyciela, nie modelu.
- Nagłówki feature różnej długości, opisują efekt nie ficzer.
- Polskie znaki z ogonkami, zero em-dash, ton ludzki, formy m/ż gdzie pasuje.

Ruch (warstwa motion - zakłada ją skill design, nakłada zbuduj-strone):
- Każda sekcja owinięta w `Reveal` (subtelny fade-up raz przy wejściu w viewport), listy w `StaggerList`. Statyczna strona = płaska = AI.
- Tylko transform/opacity, `viewport once`, `<MotionConfig reducedMotion="user">` w layout. Zero pętli (pulse/bounce/floating blob). Max JEDEN akcent WOW na stronę. Import `motion/react`, nigdy `framer-motion`.

Premium craft (co DODAĆ, nie tylko czego unikać - pełne w `../anti-ai-look-ruleset.md` sekcja 5):
- Warstwa ruchu, kontrast skali typografii, głębia zamiast płaskich ramek, edytorialna asymetria, stany hover, jeden element-sygnatura, realne kadrowane media, konkret w treści. Brak AI-tellów to nie to samo co dobry design.

## SZYBKA CHECKLISTA (wpisz do design-decyzje.md jako bramka)

Strona przechodzi, jeśli na te pytania odpowiedź brzmi dobrze:
1. Nagłówki mają `text-balance` i normalny tracking? (ma być TAK)
2. Brak eyebrow capslockiem nad nagłówkami? (ma być TAK)
3. Brak fioletowo-niebieskich gradientów i gradient-text na H? (ma być TAK)
4. Karty są zróżnicowane, nie 3 identyczne z tym samym hover? (ma być TAK)
5. Są min. 3 prawdziwe zdjęcia/media, a nie same ikony? Przy dłuższej stronie cel to 5-7. (ma być TAK)
6. Wszystkie kolory idą ze zmiennych CSS, zero hardkodu? (ma być TAK)
7. Copy ma min. jedną konkretną liczbę/nazwę i zero em-dash? (ma być TAK)
8. Layout ma oddech i odrobinę asymetrii, nie wszystko wycentrowane? (ma być TAK)
9. Sekcje mają warstwę ruchu (Reveal), nie są martwe i statyczne, i nie ma ruchu w pętli? (ma być TAK)

Próg akceptacji kursu: max 1 odpowiedź "nie". Więcej = przeróbka sekcji. Pełna checklista TAK/NIE i scoring są w `../anti-ai-look-ruleset.md` (sekcja 4) - tego pilnuje skill `sprawdz-kod` przed deployem.
