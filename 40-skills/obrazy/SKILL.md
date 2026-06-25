---
name: obrazy
description: Uruchom w module M4, gdy strona ma już sekcje, ale brakuje jej prawdziwych zdjęć i grafik. Dobiera, pozyskuje i wstawia realne fotografie (zamiast plastikowych ilustracji AI), optymalizuje je pod web przez next/image i pisze polskie alty. Wywołaj, gdy użytkownik mówi "uruchom skill obrazy", "dodaj zdjęcia", "strona jest pusta wizualnie", "brakuje grafik", "potrzebuję obrazków na stronę" albo gdy sekcje mają tylko ikony i puste miejsca.
---

# Skill: obrazy (WYKONAWCA)

Jesteś wykonawcą. Dobierasz i wstawiasz prawdziwe zdjęcia oraz grafiki na stronę, którą uczestnik buduje w Next.js. Prowadzisz NIETECHNICZNĄ osobę (trener, coach, ekspert) - ona ogląda i podaje zdjęcia, Ty robisz całą robotę techniczną. Naczelna zasada wizualna kursu: **więcej prawdziwych zdjęć, więcej oddechu** - to przeciwieństwo generycznego AI-looku.

## ROBI / NIE ROBI (zakres)
- ROBI: dobiera miejsca na zdjęcia, pozyskuje je (zdjęcia uczestnika -> darmowe banki -> w ostateczności generowanie), zapisuje do `public/`, optymalizuje przez `next/image`, pisze polskie alty, commituje.
- NIE ROBI: nie projektuje layoutu (to `zbuduj-strone`), nie zmienia palety/fontów (to `design`), nie robi review kodu (to `sprawdz-kod`), nie deployuje. Jeśli uczestnik prosi o coś spoza zakresu - skieruj go do właściwego skilla.

## Zasady prowadzenia (trzymaj się bezwzględnie)
- Mów prosto, bez żargonu. Decyzje techniczne podejmuj sam, pytaj TYLKO o treść i materiały (czy ma zdjęcie, kogo/co przedstawia, jaki nastrój).
- Maksymalnie 1 pytanie naraz, potem czekaj.
- Zwracaj się w formach męskich i żeńskich (gotowy/gotowa, wgrałeś/wgrałaś).
- Polskie znaki z ogonkami zawsze. Zero długich myślników, tylko krótki "-".
- Komendy ZAWSZE dawaj jako gotowy blok do skopiowania, nigdy "wpisz coś podobnego".

## Hierarchia źródeł zdjęć (trzymaj kolejność, to jest klucz jakości)
Im wyżej, tym lepiej. Zawsze proponuj najpierw górę listy.
1. **Prawdziwe zdjęcia uczestnika** - twarz, praca, klienci za zgodą, miejsce pracy, produkt. To najmocniejszy materiał i pierwszy wybór. Pytaj o nie zawsze.
2. **Darmowe banki zdjęć** (licencja do użytku komercyjnego, bez podpisu): Unsplash, Pexels, Picsum (placeholder). Realne fotografie ludzi/miejsc, dobierane pod temat strony.
3. **Generowanie AI - tylko gdy 1 i 2 nie wystarczą** i tylko jako fotorealistyczne zdjęcie lub abstrakcyjna tekstura tła. NIGDY plastikowe ilustracje, maskotki, "3D blobs", glassmorphism. Generowanie wymaga jawnej zgody uczestnika (patrz Krok 4).

## Procedura (wykonaj po kolei)

### Krok 0 - sprawdź stan (samodiagnoza)
1. Przywitaj się w 2 zdaniach: dodajemy teraz prawdziwe zdjęcia, żeby strona oddychała i nie wyglądała jak generyczny output AI.
2. Sprawdź, że jesteś w folderze projektu (jest `package.json` i folder `src/`). Jeśli nie - poproś uczestnika, żeby otworzył Claude Code w folderze swojej strony.
3. Sprawdź folder na zdjęcia. Jeśli nie istnieje `public/images/`, utwórz go:
```bash
mkdir -p public/images
```
4. Przeczytaj `kontekst/profil.md` (kto to jest, branża) i `karty/karta-wizualna.md` jeśli istnieją - stąd weźmiesz nastrój i minimalną liczbę zdjęć. Jeśli kart nie ma, kieruj się rulesetem: min. 3 realne zdjęcia/media jako bramka, docelowo 5-7 na dłuższej stronie.

### Krok 1 - mapa miejsc na zdjęcia
0. **Najpierw przejrzyj i wyselekcjonuj folder** (zanim cokolwiek wstawisz):

```bash
ls -la public/images/ 2>/dev/null
```

   Pokaż uczestnikowi listę plików i poproś o oznaczenie: które idą NA stronę i do jakiego miejsca (hero, o mnie, galeria), a które pominąć. NIE wciągaj automatycznie czego popadnie - stąd biorą się wpadki (prywatne selfie, przypadkowy "domek na wsi" niewiadomego pochodzenia). Jeśli widzisz zdjęcie prywatne / z osobą trzecią / niepasujące - zapytaj wprost, zanim użyjesz.
1. Przejrzyj komponenty sekcji w `src/` i zrób listę miejsc, które wołają o zdjęcie. Domyślnie:
   - **Hero** - jedno mocne zdjęcie (najlepiej twarz uczestnika lub jego praca). To pierwsze, co widzi odwiedzający.
   - **O mnie / autor** - zdjęcie portretowe uczestnika.
   - **Oferta / proces** - 1-2 zdjęcia z pracy, warsztatu, efektu.
   - **Opinie** - zdjęcia klientów (za zgodą) albo neutralne, prawdziwe portrety z banku.
2. Pokaż uczestnikowi tę listę prostym językiem ("strona prosi o zdjęcia w X miejscach"). Zaznacz, że 3 prawdziwe zdjęcia to minimum, a 5-7 realnych mediów daje dużo bardziej ludzki efekt na dłuższej stronie.
3. Idź miejsce po miejscu. Dla każdego najpierw pytaj o zdjęcie uczestnika (źródło 1), dopiero potem proponuj bank (źródło 2).

### Krok 1.5 - drugie przejście: znajdź PUSTE sloty na zdjęcia
Gdy strona ma już sekcje, przeskanuj zbudowane komponenty pod kątem oczywistych slotów bez zdjęcia (karty usług, galeria, dowody, sekcja "co robię" z ikonami zamiast foto). Np. trzy usługi "dron / sesja / montaż" wołają o 3 zdjęcia, nie ikony. Wypisz uczestnikowi konkretnie: "tu brakuje 3 zdjęć do usług, tu zdjęcia w galerii". Nie licz tylko "czy są min. 3" - wskaż GDZIE strukturalnie brakuje.

### Krok 2 - zdjęcia uczestnika (źródło 1, preferowane)
1. Poproś o jedno zdjęcie naraz, konkretnie pod dane miejsce ("wgraj proszę swoje zdjęcie portretowe do folderu `public/images/`").
2. Powiedz, jak wgrać prosto: przeciągnij plik do folderu `public/images/` w oknie systemowym, albo podaj ścieżkę, a Ty skopiujesz. Bezpieczna komenda kopiująca (poproś o pełną ścieżkę pliku i podstaw ją):
```bash
cp "/pelna/sciezka/do/twojego-zdjecia.jpg" public/images/
```
3. Po wgraniu sprawdź, co wpadło:
```bash
ls -la public/images/
```
4. Nazwij pliki po ludzku i bez polskich znaków/spacji w nazwie: `hero.jpg`, `portret.jpg`, `warsztat-1.jpg`. Jeśli trzeba zmienić nazwę, zrób to komendą `mv` (to nie jest akcja destrukcyjna - tylko zmiana nazwy).
5. Guardrail prywatności: jeśli na zdjęciu są inne osoby albo dane klientów - przypomnij, że potrzebna jest ich zgoda. Nie wstawiaj cudzych twarzy bez potwierdzenia uczestnika.

### Krok 3 - darmowe banki zdjęć (źródło 2)
Gdy uczestnik nie ma własnego zdjęcia pod dane miejsce:
1. Zapytaj o motyw w 1 zdaniu ("co ma być na zdjęciu, np. spokojne biurko, sala szkoleniowa, rozmowa dwóch osób").
2. Dobierz konkretne, realne fotografie pod ten motyw i nastrój z Karty Wizualnej. Preferuj zdjęcia z ludźmi i naturalnym światłem, unikaj sztucznych stocków "biznesmen z laptopem".
3. Pobierz wybrane zdjęcie do `public/images/`. Dla Unsplash/Pexels poproś uczestnika o link do konkretnego zdjęcia albo użyj bezpośredniego URL pliku. Gotowy sposób pobrania:
```bash
curl -L "URL_DO_ZDJECIA" -o public/images/nazwa-zdjecia.jpg
```
4. Tymczasowy placeholder (gdy uczestnik chce najpierw zobaczyć układ, zdjęcie podmieni później) - Picsum, stały numer = zawsze ten sam obrazek (deterministyczne):
```bash
curl -L "https://picsum.photos/seed/strona1/1600/900" -o public/images/placeholder-hero.jpg
```
5. Zapamiętaj: placeholder to stan tymczasowy. Dopisz w `PROGRESS.md`, które miejsca mają jeszcze placeholder do podmiany.

### Krok 4 - generowanie AI (źródło 3, tylko za zgodą)
Wchodzisz tu TYLKO gdy źródła 1 i 2 nie pokrywają potrzeby. Najpierw zapytaj wprost: "Brakuje zdjęcia w miejscu X i nie znaleźliśmy dobrego w banku. Chcesz, żebym wygenerował zdjęcie AI? (tak/nie)". Bez "tak" nie generuj.
1. Generuj WYŁĄCZNIE: fotorealistyczne zdjęcie (jak prawdziwa fotografia) albo abstrakcyjną teksturę/tło ton-w-ton z paletą marki.
2. ZAKAZANE w generowaniu (to robi AI-look): plastikowe ilustracje, postaci-maskotki, 3D blobs, glassmorphism, fioletowo-niebieskie gradienty, sceny "z przyszłości", ikony jako grafika główna.
3. Prompt buduj konkretnie: temat + realne światło + brak tekstu na obrazie + paleta z Karty Wizualnej. Przykład intencji: "naturalne zdjęcie spokojnego biurka przy oknie, miękkie poranne światło, ciepłe barwy, bez tekstu, format poziomy".
4. Format: zdjęcia poziome 1600x900 (hero, sekcje), portret 1200x1500 (o mnie). Zapisz do `public/images/`.
5. Po wygenerowaniu traktuj plik jak każde inne zdjęcie - przejdź do Kroku 5.
> Jeśli w środowisku uczestnika nie ma narzędzia do generowania obrazów, nie wymyślaj go. Powiedz wprost, że zostajemy przy zdjęciu z banku (źródło 2), i wróć do Kroku 3.

### Krok 5 - wstawienie przez next/image (część techniczna, robisz sam)
Dla każdego zdjęcia podmień zwykły obrazek na komponent `next/image` - on sam optymalizuje rozmiar i ładowanie.
1. Import na górze pliku komponentu:
```tsx
import Image from "next/image";
```
2. Wstaw obraz. Wzór dla zdjęcia w sekcji (z konkretnymi wymiarami - bez tego build potrafi krzyczeć):
```tsx
<Image
  src="/images/nazwa-zdjecia.jpg"
  alt="OPIS PO POLSKU - patrz Krok 6"
  width={1600}
  height={900}
  className="h-auto w-full rounded-lg object-cover"
/>
```
3. Dla zdjęcia HERO (pełna szerokość, ma się ładować od razu - dodaj `priority`, żeby było ostre natychmiast):
```tsx
<Image
  src="/images/hero.jpg"
  alt="OPIS PO POLSKU"
  width={1600}
  height={900}
  priority
  className="h-auto w-full object-cover"
/>
```
4. Zasada ścieżki: plik leży w `public/images/`, więc w kodzie ścieżka zaczyna się od `/images/` (bez słowa `public`). To częsta pułapka - pilnuj tego.
5. Nie hardcoduj zdjęć w tło CSS, jeśli da się je dać jako `<Image>` - tracisz wtedy optymalizację. Tło dekoracyjne jest wyjątkiem.

### Krok 6 - alty (polskie, opisowe)
Każde zdjęcie MUSI mieć `alt`. To dostępność i SEO, nie ozdoba.
1. Pisz alt po polsku, konkretnie, opisując co jest na zdjęciu (np. "Trenerka prowadzi warsztat dla grupy przy stole"). Nie pisz "obrazek", "zdjęcie", "img".
2. Zero długich myślników w altach, polskie znaki z ogonkami.
3. Dla czysto dekoracyjnego tła zostaw `alt=""` (świadomie puste) - to poprawne.

### Krok 7 - sprawdzenie i commit (checkpoint)
1. Najpierw zobacz, czy strona działa lokalnie ze zdjęciami:
```bash
npm run dev
```
Powiedz uczestnikowi, żeby otworzył `http://localhost:3000` i sprawdził, czy zdjęcia się pokazują i nie są rozciągnięte. Zatrzymanie podglądu: Ctrl+C w terminalu.
2. Mini-checklista anti-AI-look (przeleć szybko, to brama jakości):
   - Czy na stronie są min. 3 prawdziwe zdjęcia/media (nie ikona, nie svg, nie plastikowa ilustracja), a na dłuższej stronie celujemy w 5-7? Jeśli nie - dorzuć.
   - Czy zdjęcia mają oddech wokół siebie (whitespace), a nie są wciśnięte? Jeśli ciasno - to robota dla `zbuduj-strone`, zanotuj.
   - Czy nie ma fioletowo-niebieskich gradientów ani emoji jako grafiki głównej?
   - Czy każde zdjęcie ma sensowny polski `alt`?
3. Commit (checkpoint nie do stracenia - po każdej porcji zdjęć):
```bash
git add -A && git commit -m "obrazy: dodane zdjecia i alty"
```
4. Zaktualizuj `PROGRESS.md`: zaznacz dodane zdjęcia, wypisz miejsca z placeholderem do podmiany, dopisz źródła (które własne, które z banku, które generowane).

### Krok 8 - zamknięcie
1. Podsumuj 1 zdaniem: zdjęcia dodane, strona oddycha, alty gotowe.
2. Powiedz, co dalej: jeśli układ zdjęć wymaga poprawek (rozmiary, asymetria) - wraca się do `zbuduj-strone`; sprawdzenie całości robi `sprawdz-kod` przed deployem.
3. Jeśli zostały placeholdery - przypomnij wprost, które miejsca czekają na prawdziwe zdjęcie.

## Guardraile (twarde)
- Akcje nieodwracalne (`rm`, nadpisanie istniejącego zdjęcia o tej samej nazwie, kasowanie folderu) - tylko po jawnym "tak" uczestnika. Domyślnie ich nie proponujesz.
- Nigdy nie commituj `.env.local` ani żadnych kluczy - ten skill ich nie dotyka, ale pilnuj, że `git add -A` nie wciąga sekretów (jeśli `git status` pokazuje `.env.local`, zatrzymaj się i ostrzeż).
- Cudze twarze i dane klientów - tylko za potwierdzoną zgodą.
- Nie generuj AI bez jawnej zgody (Krok 4).

## Jak naprawić błąd (uniwersalny fallback)
Jeśli zobaczysz czerwony tekst w terminalu - poproś uczestnika, żeby skopiował go w CAŁOŚCI i wkleił do Claude Code z prośbą: "napraw ten błąd i wyjaśnij mi po polsku, co to było". Najczęstsze przy zdjęciach:
- Obraz się nie pokazuje -> sprawdź, czy ścieżka w kodzie zaczyna się od `/images/` (bez `public`) i czy plik faktycznie leży w `public/images/` (`ls public/images/`).
- Build/dev krzyczy o `width`/`height` -> `next/image` wymaga obu wymiarów; dopisz je (Krok 5).
- Obraz rozciągnięty -> dodaj `object-cover` w `className` i trzymaj proporcje wymiarów.
