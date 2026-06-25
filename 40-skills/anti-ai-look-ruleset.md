# Anti-AI-Look Ruleset

Dokument bazowy pod skill Claude Code w kursie. Cel: strona zbudowana z AI ma NIE wyglądać jak generyczny output v0/Lovable/Bolt/Claude. Połączone obserwacje Bartka (priorytet, oko praktyka) + research designerów (925studios, developersdigest/Adrian Krebs n=1590 Show HN, prg.sh, bolt.new blog, publishd, dev.to).

Legenda: [BARTEK] = obserwacja Bartka, [POTW] = potwierdzona researchem, [+] = research dorzuca.

---

## 1. 10-15 najważniejszych tellów "to jest AI"

1. **Eyebrow/badge CAPSLOCKIEM nad headingiem** [BARTEK][POTW] - mały tag pisany wersalikami (`text-xs uppercase tracking-widest`) wciśnięty nad każdym H1/H2. Krebs nazywa to wprost "Badge above H1" i "All-caps labels" - jeden z 16 sygnatur AI. Diagnoza: szukaj `uppercase` + `tracking-wider/widest` w małym tekście nad nagłówkiem, często z kropką/gradientem.

2. **Ciasny tracking na nagłówkach** [BARTEK][POTW] - Claude domyślnie wrzuca `tracking-tight` / `tracking-tighter` na duże headingi, litery sklejone. Diagnoza: `letter-spacing` ujemny przy `font-size` 32px+. To "tak generuje Claude" - potwierdzone, działa bo model uczył się na tysiącach landingów SaaS.

3. **Headingi łamią się do nowej linii mimo miejsca** [BARTEK][POTW] - brak `text-wrap: balance`/`pretty` + zły `max-width`, więc 4-wyrazowy nagłówek łamie się 3+1 albo 2+2 brzydko, mimo że jest miejsce na jedną linię. Diagnoza: nagłówek łamie się, a obok jest pusta przestrzeń w kontenerze.

4. **Em-dash (długi myślnik) w tekście** [BARTEK][POTW] - "-" to najsilniejszy tell tekstu AI, designerzy nazywają go odpowiednikiem tellu wizualnego (left-border card "almost as reliable as em-dashes"). Diagnoza: grep na `-` i `-` w copy.

5. **Grid 2x2 / 3x2 identycznych kart + ten sam hover** [BARTEK][POTW] - 3 kolumny kart "icon-top" (ikona u góry, nagłówek, 2 zdania), wszystkie ten sam rozmiar, ten sam `hover`. Krebs: "Icon-top cards" + "icon-card grids 22%". Bartek dorzuca kluczowe: **identyczny hover w każdej komórce** = martwy rytm. Diagnoza: `grid-cols-3` z `.map()` po identycznym komponencie + jeden `hover:` na wszystkich.

6. **Fioletowo-niebieski gradient ("VibeCode Purple")** [POTW] - cyan→violet w hero, pink→orange w CTA. To "Why your AI keeps building the same purple gradient website". Diagnoza: `from-violet-500 to-blue-500`, `from-purple-600 to-indigo-600` lub `#8b5cf6`/lavender jako akcent.

7. **Gradient text na headingu** [POTW] - `bg-clip-text text-transparent bg-gradient-to-r`. Tekst tęczowy na H1. Diagnoza: te klasy razem na nagłówku.

8. **Inter / Geist wszędzie, zero pairingu** [POTW] - jeden domyślny font (Inter body+heading) bez display-fontu na nagłówki. Geist to też tell ("one config line" - ale wszyscy go zmieniają na Geist, więc Geist też już krzyczy AI). Diagnoza: brak osobnego font-family na nagłówki.

9. **Mało zdjęć, mało przestrzeni** [BARTEK][POTW] - strona bez prawdziwych fotografii (ludzi/produktu), zamiast tego ikony Lucide, blobs, ilustracje "za gładkie, plastikowe". Bartek: trzeba więcej zdjęć i więcej oddechu. Diagnoza: policz realne media (foto/video, nie ikona/svg) - 0-2 = blokada, 3-4 = minimum, 5-7 = docelowa jakość dla dłuższej strony.

10. **Stockowe ikony Lucide tak samo wszędzie** [POTW][+] - każda sekcja ma ikonkę Lucide w kółku/kwadracie, ten sam styl, ten sam akcent. Plus emoji jako ikony. Diagnoza: powtarzalny wrapper `rounded-lg bg-X/10 p-3` z ikoną Lucide.

11. **Stała kolejność sekcji: hero → 3 karty features → testimoniale z avatarami → CTA gradient** [POTW] - "everyone ships the defaults". Krebs i bolt.new opisują dokładnie ten szkielet. Diagnoza: ta sama sekwencja co każdy inny landing.

12. **Jednolite karty: border + rounded-2xl + shadow-sm wszędzie** [POTW] - 925studios: "identyczne 16px border radius i 24px padding wszędzie". Diagnoza: każdy box ma `rounded-2xl border shadow-sm`, zero wariacji rozmiaru/wagi.

13. **Wszystko wycentrowane i symetryczne** [POTW] - hero `text-center max-w-Xl mx-auto`, sekcje idealnie symetryczne, zero asymetrii i napięcia. Krebs: "Centered hero" #9. Diagnoza: dominuje `text-center` + `mx-auto` na sekcjach contentowych.

14. **Copy-buzzword bez konkretów** [POTW] - "Elevate your...", "Unlock/Unleash/Supercharge", "Build the future of work", "all-in-one platform". Nagłówki feature po 2-3 słowa, wszystkie tej samej długości. Brak liczb. Diagnoza: nagłówek pasuje do dowolnej branży, zero cyfr/nazw/dat.

15. **Glassmorphism + dark hero z neonowym akcentem + colored glow** [POTW] - permanentny dark mode, szary tekst, świecące cienie w kolorze akcentu. Krebs: dark theme 34% (najczęstszy tell). Diagnoza: `backdrop-blur` + `bg-white/5` + `shadow-[0_0_X_color]`.

Duplikaty/wzmocnienia: #1+#15 (CAPS labels), #2+#3 (typografia nagłówków razem tworzą "ciasny złamany nagłówek"), #5+#10+#12 (karty), #6+#7 (gradienty).

---

## 2. ZAKAZANE (czego skill ma pilnować, żeby NIE robić)

**Typografia**
- ZERO `tracking-tight` / `tracking-tighter` na headingach. Domyślnie `tracking-normal`, dla bardzo dużych (60px+) raczej `tracking-[-0.01em]` max, nie mniej.
- ZERO eyebrow/kicker CAPSLOCKIEM nad headingami. Żaden `uppercase tracking-widest text-xs` jako nadpis sekcji.
- ZERO headingów bez `text-wrap: balance`. Nigdy nagłówka, który łamie się brzydko przy wolnym miejscu.
- ZERO jednego fontu na wszystko (Inter+Inter). Nie zostawiaj domyślnego stacku bez decyzji.
- ZERO em-dash "-" i en-dash "-" w jakimkolwiek tekście (copy, alt, aria). Tylko krótki "-".

**Layout**
- ZERO 3 (lub 4/6) identycznych kart w gridzie z **tym samym** hover na każdej.
- ZERO `rounded-2xl border shadow-sm` jako domyślny "każdy box". Nie ten sam radius+padding wszędzie.
- ZERO wszystko `text-center mx-auto`. Nie centruj całej strony.
- ZERO hero strony głównej jako sam wycentrowany nagłówek + podtytuł + przycisk na pustym albo gradientowym tle, niski na pół ekranu. To najczęstszy hero AI-slop.
- ZERO domyślnej sekwencji hero→3 features→testimoniale→CTA bez przerwania jej własną sekcją.
- ZERO bento-grid "bo modnie", jak nie wynika z treści.

**Kolor i obrazy**
- ZERO fioletowo-niebieskich gradientów (`violet→blue`, `purple→indigo`, cyan→violet, pink→orange). Żaden "VibeCode Purple"/lavender jako akcent.
- ZERO gradient text na headingach (`bg-clip-text text-transparent`).
- ZERO strony bez prawdziwych zdjęć. Nie zastępuj fotografii ikonami/blobami/glassmorphism.
- ZERO Lucide w kółku przy każdej sekcji jako jedyny "wizual". ZERO emoji jako ikon UI.
- ZERO dark hero + neon glow + `backdrop-blur` jako default estetyka.

**Copy**
- ZERO "Elevate/Unlock/Unleash/Supercharge/Empower/Seamless/Revolutionize/Transform", "all-in-one", "in todays fast-paced world", "build the future of".
- ZERO nagłówków feature wszystkich tej samej długości (2-3 słowa każdy).
- ZERO copy bez ani jednej konkretnej liczby/nazwy/daty.

---

## 3. NAKAZANE (co skill ma robić zamiast tego)

**Typografia**
- `text-wrap: balance` na wszystkich headingach (Tailwind `text-balance`), `text-wrap: pretty` na akapitach (`text-pretty`).
- Kontroluj `max-width` nagłówka świadomie: hero `max-w-[18ch]`-`max-w-[24ch]`, body `max-w-[60ch]`-`max-w-[72ch]` (czytelność).
- `line-height` zależnie od wielkości: duże headingi `leading-[1.05]`-`leading-tight`, body `leading-relaxed` (1.6).
- Tracking naturalny: headingi `tracking-normal` (max `-0.01em` przy 60px+), body bez zmian.
- Własny font pairing z Karty Wizualnej: osobny display-font na headingi + czytelny body-font (np. Satoshi 300 headingi + Inter body - zgodnie z brandem Bartka). Monospace na liczby/ceny/staty dla tekstury.

**Layout**
- HERO strony głównej (najważniejszy ekran): pełny pierwszy ekran (`min-h-[85vh]` do `min-h-screen`), z mocnym wizualem (realne zdjęcie/video na tło albo obok tekstu, albo jeden autorski element typograficzny) + jedno mocne zdanie + jedno CTA. Buduj go z sekcji "Hero strony głównej" Karty Wizualnej (inspiracje, układ, przekaz potwierdzone z uczestnikiem). To miejsce, po którym ocenia się całą stronę - tu craft ma być najwyższy. NIE sam wycentrowany tekst na gradiencie.
- Asymetria i oddech: choć jedna sekcja off-center, kontent czasem 7/5 albo 8/4 kolumny zamiast 50/50. Hojny whitespace (sekcje `py-24`+).
- Różnicuj karty: różne rozmiary (jedna szeroka + dwie węższe), różny content, różny hover albo hover tylko tam gdzie klikalne. Łam grid: pierwsza karta `col-span-2`.
- Rytm pionowy: różne wysokości sekcji, naprzemiennie obraz-lewo/tekst-prawo i odwrotnie.
- Wstaw min. 3 prawdziwe zdjęcia jako bramkę wejścia, a docelowo 5-7 realnych mediów na dłuższej stronie (foto/video Bartka/produktu/pracy, NIE plastikowa AI-illustration). Hero z prawdziwym zdjęciem lub video tła.

**Kolor i obrazy**
- Paleta z Karty Wizualnej (Bartek: tło #0b0b0d, złoto #D4A017). Jeden akcent brandowy, NIE tęczowy gradient. Jak gradient, to subtelny ton-w-ton albo off-brand stop, nie violet→blue.
- Kolor semantyczny przez CSS vars: `--color-accent`, `--color-action`, nie dekoracyjne gradienty.
- Realne fotografie > ikony. Jak ikony, to spójny jeden zestaw + własny akcent, nie domyślny Lucide-w-kółku.

**Copy**
- Konkrety i liczby: "39 newsletterów", "7 dni", "od 2997 zł", realne nazwy klientów/wyników. Głos założyciela, nie modelu.
- Nagłówki feature różnej długości, opisują efekt nie ficzer. Specyfika branżowa zamiast uniwersalnego buzzwordu.
- Polskie copy: polskie znaki z ogonkami, zero em-dash, ton ludzki, formy m/ż gdzie pasuje.

---

## 4. CHECKLISTA dla skilla "sprawdz-kod" (tak/nie)

Skill przebiega po wygenerowanym kodzie/stronie i odpowiada TAK/NIE. Każde "TAK" w sekcji TELL = flaga do poprawy.

**Typografia**
- [ ] Czy gdzieś jest `tracking-tight`/`tracking-tighter` na headingu? (TAK = fix)
- [ ] Czy headingom brakuje `text-balance` / `text-wrap: balance`? (TAK = fix)
- [ ] Czy istnieje eyebrow `uppercase tracking-wide(r/st)` nad nagłówkiem? (TAK = fix)
- [ ] Czy heading i body używają tego samego font-family (brak pairingu)? (TAK = fix)
- [ ] Czy w tekście/alt/aria jest "-" lub "-"? (TAK = fix)
- [ ] Czy nagłówki mają sensowny `max-w-[ch]` i nie łamią się przy wolnym miejscu? (NIE = fix)

**Layout**
- [ ] Czy jest grid 3/4/6 identycznych kart z jednym `hover:` na wszystkich? (TAK = fix)
- [ ] Czy wszystkie boxy mają ten sam `rounded-2xl border shadow-sm`? (TAK = fix)
- [ ] Czy strona jest w całości `text-center mx-auto` (zero asymetrii)? (TAK = fix)
- [ ] Czy układ to dokładnie hero→3 features→testimoniale→CTA bez własnej sekcji? (TAK = fix)
- [ ] Czy jest realny whitespace (`py-20`+ między sekcjami)? (NIE = fix)

**Kolor i obrazy**
- [ ] Czy jest gradient violet/purple→blue/indigo (lub cyan→violet, pink→orange)? (TAK = fix)
- [ ] Czy jest gradient text (`bg-clip-text text-transparent`) na headingu? (TAK = fix)
- [ ] Czy na stronie są min. 3 prawdziwe zdjęcia/media, a na dłuższej stronie docelowo 5-7 (nie ikona/svg/AI-illustration)? (0-2 = fix blokujący, 3-4 = minimum, 5+ = dobrze)
- [ ] Czy każda sekcja ma ikonę Lucide w kółku jako jedyny wizual? (TAK = fix)
- [ ] Czy użyto emoji jako ikon UI? (TAK = fix)
- [ ] Czy paleta zgodna z Kartą Wizualną (jeden akcent, nie tęcza)? (NIE = fix)

**Copy**
- [ ] Czy są buzzwordy (Elevate/Unlock/Supercharge/all-in-one/seamless...)? (TAK = fix)
- [ ] Czy jest min. jedna konkretna liczba/nazwa/data w copy? (NIE = fix)
- [ ] Czy nagłówki feature są wszystkie tej samej długości (2-3 słowa)? (TAK = fix)
- [ ] Czy copy ma polskie znaki i zero em-dash? (NIE = fix)

**Ruch / animacje**
- [ ] Czy strona jest całkowicie statyczna (sekcje bez żadnego reveal, nic nie wjeżdża przy scrollu)? (TAK = fix: martwa strona czyta się jak szablon AI - owiń sekcje w `Reveal`)
- [ ] Czy jest ruch w pętli (`animate-pulse`/`animate-bounce`, floating blob, animowany gradient w tle)? (TAK = fix)
- [ ] Czy import animacji idzie z `framer-motion` zamiast `motion/react`? (TAK = fix)
- [ ] Czy jest więcej niż jeden mocny akcent WOW na stronę? (TAK = fix: zostaw jeden)
- [ ] Czy brak `<MotionConfig reducedMotion="user">` (dostępność)? (NIE = fix)

**Scoring (za Krebsem):** policz flagi (typografia + layout + kolor + copy + ruch). 0-1 = czysto, 2-3 = lekki AI-slop (popraw), 4+ = ciężki AI-slop (przerób sekcje). Próg akceptacji kursu: max 1 flaga.

---

## 5. PREMIUM CRAFT - co DODAĆ, żeby wyglądało jak projekt, nie szablon

Sekcje 2-4 mówią, czego NIE robić. Ale stronę można przejść przez wszystkie zakazy i nadal być nijaką, bo nic jej nie wyróżnia. Brak AI-tellów to nie to samo co dobry design. To jest lista pozytywnych ruchów - tego, co świadomie DODAJESZ, żeby strona czytała się jak robota agencji, a nie domyślny output. Cel: każdy z tych elementów świadomie zaprojektowany przynajmniej raz na stronie.

**1. Warstwa ruchu (najmocniejsza dźwignia "premium vs szablon").** Statyczna strona = płaska = AI. Subtelny reveal sekcji przy wejściu w viewport + JEDEN mocniejszy akcent na całą stronę robi 80% wrażenia premium. Pełny system: `40-skills/zbuduj-strone/animacje.md` (biblioteka `motion`, klocki `Reveal`/`StaggerList`, akcent WOW, mikro-interakcje). Reguła: subtelność, nie cyrk - jeden spokojny reveal wszędzie, jeden mocny moment raz.

**2. Hierarchia i skala typografii z napięciem.** Nie trzy rozmiary tekstu po sąsiedzku. Duży kontrast: hero `text-5xl`-`text-7xl`, nagłówek sekcji `text-3xl`-`text-4xl`, body `text-base`-`text-lg`, podpis `text-sm`. Skok robi rytm. Monospace na liczbach/cenach/statach dla tekstury. Jeden "manifest" zdaniem większym niż reszta = punkt skupienia.

**3. Głębia zamiast płaskich ramek.** Karty i sekcje dostają warstwę: subtelny cień wielopoziomowy (nie domyślny `shadow-sm` wszędzie), delikatny gradient tła sekcji ton-w-ton (nie tęcza), linia/separator o niskim kontraście, czasem nakładające się elementy (zdjęcie wchodzące na sąsiednią sekcję). Płaskie białe karty z `border` = sygnał szablonu.

**4. Edytorialny rytm i asymetria.** Naprzemiennie obraz-lewo/tekst-prawo, kolumny 7/5 lub 8/4 zamiast 50/50, jedna sekcja celowo off-center, szeroki margines z jednej strony. Hojny whitespace między sekcjami (`py-24`+). Strona ma "oddychać" i mieć kierunek czytania, nie być siatką równych boxów.

**5. Stany interakcji (hover/focus/active), nie martwy interfejs.** Przyciski, linki, karty klikalne reagują: mikro-podniesienie, podkreślenie wjeżdżające, zmiana tła o jeden ton. Spójnie w całej stronie. Brak stanów = wrażenie makiety, nie produktu. Tylko tam, gdzie naprawdę klikalne.

**6. Jeden element-sygnatura na stronę.** Coś, co zapamiętujesz: nietypowy układ hero, autorski znak graficzny, jedno duże zdjęcie pełnoekranowe, charakterystyczny akcent koloru w jednym miejscu, jeden mocny cytat-manifest. Strona bez ani jednego "swojego" momentu jest wymienna z każdą inną.

**7. Realne, kadrowane media (nie ikony-zapychacze).** Prawdziwe zdjęcia osoby/pracy/efektu, dobrze skadrowane, spójne kolorystycznie (jeden filtr/temperatura). 3 to bramka, 5-7 to jakość na dłuższej stronie. Zdjęcie z twarzą i konkretem bije dziesięć ikon Lucide w kółkach.

**8. Konkret w treści jako element designu.** Liczby, nazwy, daty, krótkie cytaty klientów rozbijają ścianę tekstu i budują wiarygodność. "39 newsletterów", "od 2997 zł", "7 dni" - to też wizualne kotwice, nie tylko copy.

Mini-test premium: przejrzyj gotową stronę i policz, ile z tych 8 elementów jest świadomie obecnych. 0-2 = poprawny szablon bez charakteru (dodaj craft). 3-5 = strona wygląda jak marka. 6-8 = poziom agencji.

---

## 6. Dobre referencje (wzorzec jakości dla AI i dla uczestnika)

Konkretna referencja działa lepiej niż "zrób nowocześnie i czysto" - AI dostaje wzorzec zamiast zgadywać, a uczestnik ma pasek jakości przed oczami. Zasada: bierzemy POZIOM RZEMIOSŁA (typografia, ruch, oddech, głębia), a kolory i fonty zawsze swoje, z Karty Wizualnej. Nie kopiujemy układu 1:1.

Gdzie szukać wzorców (kategorie, nie konkretne marki do podrobienia):
- **Galerie dobrego rzemiosła:** Godly (godly.website), Awwwards (Sites of the Day), Land-book, Httpster, Minimal.gallery, One Page Love. Tu widać, jak wygląda strona zaprojektowana, nie wygenerowana.
- **Komponenty premium gotowe do użycia:** Aceternity UI, Magic UI, React Bits - efekty WOW, które instalujesz, zamiast pisać słaby zamiennik ręcznie.
- **Animacje/ikony na wolnej licencji:** LottieFiles (free), Rive Community.
- **3D bez ciężaru:** Spline (`@splinetool/react-spline`).

Jak rozmawiać z AI o referencji (wzór dla uczestnika, do skopiowania):

```
Zbuduj sekcje [nazwa] na poziomie rzemiosla jak [referencja - link albo nazwa].
Bierz z niej JAKOSC: typografie z napieciem, oddech, subtelny ruch, glebie.
Uzyj WYLACZNIE moich kolorow i fontow ze zmiennych globals.css. Nie kopiuj jej ukladu 1:1.
Trzymaj reguly anti-ai-look. Sekcje owin w Reveal.
```

Gdy uczestnik wskaże konkretną stronę z efektem, który mu się podoba -> komenda `/skopiuj-animacje <link>` odtworzy ten efekt na jego stronie, przepuszczając przez reguły subtelności (sekcja 5, punkt 1).

---

## 7. Jak to wpiąć w kurs

- **M3 / Karta Wizualna** - ruleset z sekcji 3 (NAKAZANE) i 5 (PREMIUM CRAFT) staje się inputem Karty: kursant definiuje font pairing (display+body), jeden akcent brandowy zamiast gradientu, min. liczbę realnych zdjęć, ton copy i 1-3 referencje jakości (sekcja 6). Karta = kontekst doklejany do każdego prompta, żeby AI nie szło w defaulty.
- **M4 / skill design** - sekcje 2 (ZAKAZANE) i 3 (NAKAZANE) lądują do system-promptu skilla budującego stronę jako twarde reguły. Tu też skill `design` zakłada warstwę ruchu (sekcja 5, punkt 1): paczka `motion`, `<MotionConfig reducedMotion="user">`, komponenty `Reveal`/`StaggerList` - fundament premium, zanim powstaną sekcje.
- **M5 / skill zbuduj-strone** - nakłada ruch na sekcje (owija w `Reveal`, listy w `StaggerList`, jeden akcent WOW) i egzekwuje sekcje 5-6. Pełne wzorce ruchu: `40-skills/zbuduj-strone/animacje.md`.
- **M5 / skill sprawdz-kod** - checklista z sekcji 4 (z blokiem "Ruch / animacje") to gotowe kryteria review: skill po wygenerowaniu strony przelata TAK/NIE, liczy flagi, zwraca raport i auto-fix dla flag. Egzekwujemy progiem "max 1 flaga" przed deployem - to brama jakości kursu.

Plik gotowy do zapisania jako `anti-ai-look.md` w katalogu skilla (`~/.claude/skills/` lub w pakiecie kursu `~/Downloads/kurs-strona-ai-v2/`).

Źródła weryfikacji: 925studios.co (AI Slop Web Design Guide 2026), developersdigest.tech (Adrian Krebs, analiza 1590 Show HN - 16 patternów), prg.sh (Why Your AI Keeps Building the Same Purple Gradient Website), bolt.new/blog (2026 stunning websites without looking like AI), publishd.app, dev.to (AI Purple Problem).
