# Ściąga: kopiowanie animacji ze stron przez Claude

## Jak to robisz (za każdym razem)

1. Zobaczyłeś gdzieś fajną animację -> skopiuj link do tej strony
2. W Claude Code napisz:

   ```
   /skopiuj-animacje <wklej tutaj link>
   ```

3. Claude sam otworzy stronę, znajdzie animację, skopiuje albo odtworzy kod i wstawi na Twoją stronę. Potem pokaże Ci efekt.

To wszystko. Nie musisz wiedzieć "co to za typ animacji" - Claude sam to rozpoznaje.

> Jednorazowo na starcie: podłącz Claude "oczy" (patrz **PODLACZ-OCZY.md**). Bez tego Claude nie widzi żywych stron.

---

## Co Claude potrafi (a czego nie) - dla Twojej świadomości

| Co widzisz na stronie | Czy Claude to przeniesie |
|---|---|
| Najazd myszką, podświetlenie, przesunięcie | TAK, kopiuje 1:1 |
| Element pojawia się przy przewijaniu (fade, slide) | TAK, kopiuje 1:1 |
| Animowana ikonka / loader (gładka, "rysunkowa") | TAK, pobiera gotowy plik (Lottie) |
| Wideo lub GIF w tle | TAK, pobiera plik |
| Efekt "wow" z landing page'a (świecące belki, karty 3D, aurora) | TAK, instaluje gotowy komponent |
| Płynne animacje sterowane scrollem (GSAP) | TAK, odtwarza efekt (nie kopia, ale blisko) |
| Pełnoekranowe 3D, cząsteczki, "żywe" płynne tło (WebGL) | NIE z linku - Claude da Ci podobny gotowiec (Spline / biblioteka 3D) |

**Jedyna rzecz, której Claude nie skopiuje 1:1, to ciężkie 3D/WebGL.** Ale wtedy nie zostawia Cię z niczym - sam mówi "tego nie da się skopiować" i proponuje gotowy zamiennik.

---

## Złota zasada (jakby Claude pytał Ciebie o decyzję)

- Lekka animacja (najazd, scroll, ikona, gotowy efekt) -> bierz śmiało.
- Ciężkie 3D na całą stronę -> przemyśl, czy warto. Na telefonie potrafi mulić i zżerać baterię. Często lepiej dać lekki akcent niż "wow", które spowalnia stronę.

---

## Prawa autorskie (ważne)

Nie podkradaj cudzych konkretnych plików (czyjeś wideo, czyjaś animacja Lottie z ich strony). Claude Cię ostrzeże. Bezpiecznie: bierz gotowce z darmowych bibliotek:
- **Animacje/ikony:** lottiefiles.com (sekcja free), rive.app (community)
- **Gotowe komponenty:** ui.aceternity.com, magicui.design, reactbits.dev
- **3D wizualnie:** spline.design

Inspiracją możesz się posiłkować zawsze. Kopiuj kod/pliki tylko swoje albo na wolnej licencji.
