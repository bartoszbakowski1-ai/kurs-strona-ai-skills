# Anti-AI-Look Ruleset

Dokument bazowy pod skill Claude Code w kursie. Cel: strona zbudowana z AI ma NIE wygladac jak generyczny output v0/Lovable/Bolt/Claude. Polaczone obserwacje Bartka (priorytet, oko praktyka) + research designerow (925studios, developersdigest/Adrian Krebs n=1590 Show HN, prg.sh, bolt.new blog, publishd, dev.to).

Legenda: [BARTEK] = obserwacja Bartka, [POTW] = potwierdzona researchem, [+] = research dorzuca.

---

## 1. 10-15 najwazniejszych tellow "to jest AI"

1. **Eyebrow/badge CAPSLOCKIEM nad headingiem** [BARTEK][POTW] - maly tag pisany wersalikami (`text-xs uppercase tracking-widest`) wcisnięty nad kazdym H1/H2. Krebs nazywa to wprost "Badge above H1" i "All-caps labels" - jeden z 16 sygnatur AI. Diagnoza: szukaj `uppercase` + `tracking-wider/widest` w malym tekscie nad naglowkiem, czesto z kropka/gradientem.

2. **Ciasny tracking na naglowkach** [BARTEK][POTW] - Claude domyslnie wrzuca `tracking-tight` / `tracking-tighter` na duze headingi, litery sklejone. Diagnoza: `letter-spacing` ujemny przy `font-size` 32px+. To "tak generuje Claude" - potwierdzone, dziala bo model uczyl sie na tysiacach landingow SaaS.

3. **Headingi lamia sie do nowej linii mimo miejsca** [BARTEK][POTW] - brak `text-wrap: balance`/`pretty` + zly `max-width`, wiec 4-wyrazowy naglowek lamie sie 3+1 albo 2+2 brzydko, mimo ze jest miejsce na jedna linie. Diagnoza: naglowek lamie sie, a obok jest pusta przestrzen w kontenerze.

4. **Em-dash (dlugi myslnik) w tekscie** [BARTEK][POTW] - "-" to najsilniejszy tell tekstu AI, designerzy nazywaja go odpowiednikiem tellu wizualnego (left-border card "almost as reliable as em-dashes"). Diagnoza: grep na `-` i `-` w copy.

5. **Grid 2x2 / 3x2 identycznych kart + ten sam hover** [BARTEK][POTW] - 3 kolumny kart "icon-top" (ikona u gory, naglowek, 2 zdania), wszystkie ten sam rozmiar, ten sam `hover`. Krebs: "Icon-top cards" + "icon-card grids 22%". Bartek dorzuca kluczowe: **identyczny hover w kazdej komorce** = martwy rytm. Diagnoza: `grid-cols-3` z `.map()` po identycznym komponencie + jeden `hover:` na wszystkich.

6. **Fioletowo-niebieski gradient ("VibeCode Purple")** [POTW] - cyan→violet w hero, pink→orange w CTA. To "Why your AI keeps building the same purple gradient website". Diagnoza: `from-violet-500 to-blue-500`, `from-purple-600 to-indigo-600` lub `#8b5cf6`/lavender jako akcent.

7. **Gradient text na headingu** [POTW] - `bg-clip-text text-transparent bg-gradient-to-r`. Tekst teczowy na H1. Diagnoza: te klasy razem na naglowku.

8. **Inter / Geist wszedzie, zero pairingu** [POTW] - jeden domyslny font (Inter body+heading) bez display-fontu na naglowki. Geist to tez tell ("one config line" - ale wszyscy go zmieniaja na Geist, wiec Geist tez juz krzyczy AI). Diagnoza: brak osobnego font-family na headingi.

9. **Malo zdjec, malo przestrzeni** [BARTEK][POTW] - strona bez prawdziwych fotografii (ludzi/produktu), zamiast tego ikony Lucide, blobs, ilustracje "za gladkie, plastikowe". Bartek: trzeba wiecej zdjec i wiecej oddechu. Diagnoza: policz realne media (foto/video, nie ikona/svg) - 0-2 = blokada, 3-4 = minimum, 5-7 = docelowa jakosc dla dluzszej strony.

10. **Stockowe ikony Lucide tak samo wszedzie** [POTW][+] - kazda sekcja ma ikonke Lucide w kolku/kwadracie, ten sam styl, ten sam akcent. Plus emoji jako ikony. Diagnoza: powtarzalny wrapper `rounded-lg bg-X/10 p-3` z ikona Lucide.

11. **Stala kolejnosc sekcji: hero → 3 karty features → testimoniale z avatarami → CTA gradient** [POTW] - "everyone ships the defaults". Krebs i bolt.new opisuja dokladnie ten szkielet. Diagnoza: ta sama sekwencja co kazdy inny landing.

12. **Jednolite karty: border + rounded-2xl + shadow-sm wszedzie** [POTW] - 925studios: "identyczne 16px border radius i 24px padding wszedzie". Diagnoza: kazdy box ma `rounded-2xl border shadow-sm`, zero wariacji rozmiaru/wagi.

13. **Wszystko wycentrowane i symetryczne** [POTW] - hero `text-center max-w-Xl mx-auto`, sekcje idealnie symetryczne, zero asymetrii i napiecia. Krebs: "Centered hero" #9. Diagnoza: dominuje `text-center` + `mx-auto` na sekcjach contentowych.

14. **Copy-buzzword bez konkretow** [POTW] - "Elevate your...", "Unlock/Unleash/Supercharge", "Build the future of work", "all-in-one platform". Naglowki feature po 2-3 slowa, wszystkie tej samej dlugosci. Brak liczb. Diagnoza: naglowek pasuje do dowolnej branzy, zero cyfr/nazw/dat.

15. **Glassmorphism + dark hero z neonowym akcentem + colored glow** [POTW] - permanentny dark mode, szary tekst, swiecace cienie w kolorze akcentu. Krebs: dark theme 34% (najczestszy tell). Diagnoza: `backdrop-blur` + `bg-white/5` + `shadow-[0_0_X_color]`.

Duplikaty/wzmocnienia: #1+#15 (CAPS labels), #2+#3 (typografia naglowkow razem tworza "ciasny zlamany naglowek"), #5+#10+#12 (karty), #6+#7 (gradienty).

---

## 2. ZAKAZANE (czego skill ma pilnowac, zeby NIE robic)

**Typografia**
- ZERO `tracking-tight` / `tracking-tighter` na headingach. Domyslnie `tracking-normal`, dla bardzo duzych (60px+) raczej `tracking-[-0.01em]` max, nie mniej.
- ZERO eyebrow/kicker CAPSLOCKIEM nad headingami. Zaden `uppercase tracking-widest text-xs` jako nadpis sekcji.
- ZERO headingow bez `text-wrap: balance`. Nigdy naglowka, ktory lamie sie brzydko przy wolnym miejscu.
- ZERO jednego fontu na wszystko (Inter+Inter). Nie zostawiaj domyslnego stacku bez decyzji.
- ZERO em-dash "-" i en-dash "-" w jakimkolwiek tekscie (copy, alt, aria). Tylko krotki "-".

**Layout**
- ZERO 3 (lub 4/6) identycznych kart w gridzie z **tym samym** hover na kazdej.
- ZERO `rounded-2xl border shadow-sm` jako domyslny "kazdy box". Nie ten sam radius+padding wszedzie.
- ZERO wszystko `text-center mx-auto`. Nie centruj calej strony.
- ZERO domyslnej sekwencji hero→3 features→testimoniale→CTA bez przerwania jej wlasna sekcja.
- ZERO bento-grid "bo modnie", jak nie wynika z tresci.

**Kolor i obrazy**
- ZERO fioletowo-niebieskich gradientow (`violet→blue`, `purple→indigo`, cyan→violet, pink→orange). Zaden "VibeCode Purple"/lavender jako akcent.
- ZERO gradient text na headingach (`bg-clip-text text-transparent`).
- ZERO strony bez prawdziwych zdjec. Nie zastepuj fotografii ikonami/blobami/glassmorphism.
- ZERO Lucide w kolku przy kazdej sekcji jako jedyny "wizual". ZERO emoji jako ikon UI.
- ZERO dark hero + neon glow + `backdrop-blur` jako default estetyka.

**Copy**
- ZERO "Elevate/Unlock/Unleash/Supercharge/Empower/Seamless/Revolutionize/Transform", "all-in-one", "in todays fast-paced world", "build the future of".
- ZERO naglowkow feature wszystkich tej samej dlugosci (2-3 slowa kazdy).
- ZERO copy bez ani jednej konkretnej liczby/nazwy/daty.

---

## 3. NAKAZANE (co skill ma robic zamiast tego)

**Typografia**
- `text-wrap: balance` na wszystkich headingach (Tailwind `text-balance`), `text-wrap: pretty` na akapitach (`text-pretty`).
- Kontroluj `max-width` naglowka swiadomie: hero `max-w-[18ch]`-`max-w-[24ch]`, body `max-w-[60ch]`-`max-w-[72ch]` (czytelnosc).
- `line-height` zaleznie od wielkosci: duze headingi `leading-[1.05]`-`leading-tight`, body `leading-relaxed` (1.6).
- Tracking naturalny: headingi `tracking-normal` (max `-0.01em` przy 60px+), body bez zmian.
- Wlasny font pairing z Karty Wizualnej: osobny display-font na headingi + czytelny body-font (np. Satoshi 300 headingi + Inter body - zgodnie z brandem Bartka). Monospace na liczby/ceny/staty dla tekstury.

**Layout**
- Asymetria i oddech: choc jedna sekcja off-center, kontent czasem 7/5 albo 8/4 kolumny zamiast 50/50. Hojny whitespace (sekcje `py-24`+).
- Roznicuj karty: rozne rozmiary (jedna szeroka + dwie wezsze), rozny content, rozny hover albo hover tylko tam gdzie klikalne. Lam grid: pierwsza karta `col-span-2`.
- Rytm pionowy: rozne wysokosci sekcji, naprzemiennie obraz-lewo/tekst-prawo i odwrotnie.
- Wstaw min. 3 prawdziwe zdjecia jako bramke wejscia, a docelowo 5-7 realnych mediow na dluzszej stronie (foto/video Bartka/produktu/pracy, NIE plastikowa AI-illustration). Hero z prawdziwym zdjeciem lub video tla.

**Kolor i obrazy**
- Paleta z Karty Wizualnej (Bartek: tlo #0b0b0d, zloto #D4A017). Jeden akcent brandowy, NIE teczowy gradient. Jak gradient, to subtelny ton-w-ton albo off-brand stop, nie violet→blue.
- Kolor semantyczny przez CSS vars: `--color-accent`, `--color-action`, nie dekoracyjne gradienty.
- Realne fotografie > ikony. Jak ikony, to spojny jeden zestaw + wlasny akcent, nie domyslny Lucide-w-kolku.

**Copy**
- Konkrety i liczby: "39 newsletterow", "7 dni", "od 2997 zl", realne nazwy klientow/wynikow. Glos zalozyciela, nie modelu.
- Naglowki feature roznej dlugosci, opisuja efekt nie ficzer. Specyfika branzowa zamiast uniwersalnego buzzwordu.
- Polskie copy: polskie znaki z ogonkami, zero em-dash, ton ludzki, formy m/z gdzie pasuje.

---

## 4. CHECKLISTA dla skilla "sprawdz-kod" (tak/nie)

Skill przebiega po wygenerowanym kodzie/stronie i odpowiada TAK/NIE. Kazde "TAK" w sekcji TELL = flaga do poprawy.

**Typografia**
- [ ] Czy gdzies jest `tracking-tight`/`tracking-tighter` na headingu? (TAK = fix)
- [ ] Czy headingom brakuje `text-balance` / `text-wrap: balance`? (TAK = fix)
- [ ] Czy istnieje eyebrow `uppercase tracking-wide(r/st)` nad naglowkiem? (TAK = fix)
- [ ] Czy heading i body uzywaja tego samego font-family (brak pairingu)? (TAK = fix)
- [ ] Czy w tekscie/alt/aria jest "-" lub "-"? (TAK = fix)
- [ ] Czy naglowki maja sensowny `max-w-[ch]` i nie lamia sie przy wolnym miejscu? (NIE = fix)

**Layout**
- [ ] Czy jest grid 3/4/6 identycznych kart z jednym `hover:` na wszystkich? (TAK = fix)
- [ ] Czy wszystkie boxy maja ten sam `rounded-2xl border shadow-sm`? (TAK = fix)
- [ ] Czy strona jest w calosci `text-center mx-auto` (zero asymetrii)? (TAK = fix)
- [ ] Czy uklad to dokladnie hero→3 features→testimoniale→CTA bez wlasnej sekcji? (TAK = fix)
- [ ] Czy jest realny whitespace (`py-20`+ miedzy sekcjami)? (NIE = fix)

**Kolor i obrazy**
- [ ] Czy jest gradient violet/purple→blue/indigo (lub cyan→violet, pink→orange)? (TAK = fix)
- [ ] Czy jest gradient text (`bg-clip-text text-transparent`) na headingu? (TAK = fix)
- [ ] Czy na stronie sa min. 3 prawdziwe zdjecia/media, a na dluzszej stronie docelowo 5-7 (nie ikona/svg/AI-illustration)? (0-2 = fix blokujacy, 3-4 = minimum, 5+ = dobrze)
- [ ] Czy kazda sekcja ma ikone Lucide w kolku jako jedyny wizual? (TAK = fix)
- [ ] Czy uzyto emoji jako ikon UI? (TAK = fix)
- [ ] Czy paleta zgodna z Karta Wizualna (jeden akcent, nie tecza)? (NIE = fix)

**Copy**
- [ ] Czy sa buzzwordy (Elevate/Unlock/Supercharge/all-in-one/seamless...)? (TAK = fix)
- [ ] Czy jest min. jedna konkretna liczba/nazwa/data w copy? (NIE = fix)
- [ ] Czy naglowki feature sa wszystkie tej samej dlugosci (2-3 slowa)? (TAK = fix)
- [ ] Czy copy ma polskie znaki i zero em-dash? (NIE = fix)

**Scoring (za Krebsem):** policz flagi. 0-1 = czysto, 2-3 = lekki AI-slop (popraw), 4+ = ciezki AI-slop (przerob sekcje). Próg akceptacji kursu: max 1 flaga.

---

## 5. Jak to wpiac w kurs

- **M3 / Karta Wizualna** - ruleset z sekcji 3 (NAKAZANE) staje sie inputem Karty: kursant definiuje font pairing (display+body), jeden akcent brandowy zamiast gradientu, min. liczbe realnych zdjec i ton copy. Karta = kontekst doklejany do kazdego prompta, zeby AI nie szlo w defaulty.
- **M4 / skill design** - sekcje 2 (ZAKAZANE) i 3 (NAKAZANE) laduja do system-promptu skilla budujacego strone, jako twarde reguly generowania (model dostaje liste czego nie robic + co robic zamiast).
- **M5 / skill sprawdz-kod** - checklista z sekcji 4 to gotowe kryteria review: skill po wygenerowaniu strony przelatuje TAK/NIE, liczy flagi, zwraca raport i auto-fix dla flag. Egzekwujemy progiem "max 1 flaga" przed deployem - to brama jakosci kursu.

Plik gotowy do zapisania jako `anti-ai-look.md` w katalogu skilla (`~/.claude/skills/` lub w pakiecie kursu `~/Downloads/kurs-strona-ai-v2/`).

Zrodla weryfikacji: 925studios.co (AI Slop Web Design Guide 2026), developersdigest.tech (Adrian Krebs, analiza 1590 Show HN - 16 patternow), prg.sh (Why Your AI Keeps Building the Same Purple Gradient Website), bolt.new/blog (2026 stunning websites without looking like AI), publishd.app, dev.to (AI Purple Problem).
