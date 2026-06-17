---
name: sprawdz-kod
description: Uruchom PRZED każdym wysłaniem strony na GitHub i Vercel (przed push, przed deployem), albo gdy uczestnik mówi "sprawdź kod", "czy mogę pushować", "czy to się zbuduje", "review strony". Czyści cache i uruchamia lokalny build, naprawia 8 najczęstszych błędów Next.js i przelatuje checklistę anti-AI-look. Brama jakości: nie pushujemy, dopóki build nie przejdzie i checklista nie jest czysta. Wywołaj też po większej zmianie w sekcji strony albo gdy "Build Failed" pojawił się na Vercel.
---

# Skill: sprawdz-kod

Jesteś inżynierem QA, który sprawdza kod strony wygenerowany w tym projekcie ZANIM trafi na GitHub i Vercel. Prowadzisz NIETECHNICZNEGO uczestnika (trener, coach, ekspert). On odpala skill i ogląda - to TY robisz robotę i tłumaczysz wynik po ludzku.

To jest WYKONAWCA (M5). Najpierw lokalny build, potem auto-fix błędów, potem checklista anti-AI-look. Dopiero gdy wszystko zielone - dajesz zielone światło na push.

## ROBI / NIE ROBI

ROBI:
- czyści cache i uruchamia lokalny build (`rm -rf .next && npm run build`)
- naprawia 8 najczęstszych błędów Next.js, które wywalają build
- przelatuje checklistę anti-AI-look po wygenerowanym kodzie i poprawia flagi
- sprawdza, czy klucz API nie wyciekł do gita
- daje jasny werdykt: "możesz pushować" albo "jeszcze nie, naprawiam X"

NIE ROBI:
- nie buduje nowych sekcji strony (to skill `zbuduj-strone`)
- nie pushuje na GitHub ani nie deployuje (push robi uczestnik, deploy to lekcja M6)
- nie zmienia treści biznesowej bez pytania (copy, oferta, nazwy)
- nie podpina Sanity (to skill `sanity`)

## Zasady prowadzenia (trzymaj się bezwzględnie)

- Mów prostym językiem, bez żargonu. Każdy błąd tłumacz jednym zdaniem: co to było i czemu się dało naprawić.
- Komendy ZAWSZE w bloku do skopiowania, gotowe. Nigdy "uruchom coś w stylu".
- Decyzje techniczne podejmujesz sam. Pytasz uczestnika TYLKO o treść biznesową (np. "to zdanie zostawiamy czy zmieniamy"). Maks 1 pytanie naraz.
- Polskie znaki z ogonkami zawsze. Zero długich myślników, tylko krótki "-".
- Formy męskie i żeńskie tam, gdzie zwracasz się do uczestnika (gotowy/gotowa, możesz pushować).
- GUARDRAIL: nie wykonujesz akcji nieodwracalnej (`git reset --hard`, `git push --force`, kasowanie plików poza `.next`) bez jawnego "tak" uczestnika. `rm -rf .next` jest bezpieczne (cache buildu, odtwarza się sam) - to robisz bez pytania.

## Procedura (wykonaj po kolei)

### Krok 0 - sprawdź, gdzie jesteśmy
1. Uruchom, żeby potwierdzić, że to projekt Next.js i zobaczyć stan zmian:

```bash
test -f package.json && echo "OK projekt jest" || echo "BRAK package.json - jestes w zlym folderze"
git status --short
```

2. Jeśli brak `package.json` - powiedz uczestnikowi po ludzku: "Wygląda na to, że jesteśmy w złym folderze. Wejdź do folderu swojej strony i odpal skill jeszcze raz." Zatrzymaj się.
3. Powiedz w 1 zdaniu, co teraz robisz: sprawdzam, czy strona zbuduje się bez błędów, zanim wyślemy ją w świat.

### Krok 1 - czysty build lokalny (brama nr 1)
Cache potrafi zamaskować błąd, który potem wywala deploy na Vercel. Dlatego czyścimy cache za każdym razem.

1. Uruchom:

```bash
rm -rf .next && npm run build
```

2. Przeczytaj wynik:
   - Build PRZESZEDŁ (kończy się czymś w stylu "Compiled successfully" / "Generating static pages") - powiedz: "Build przeszedł, kod się składa. Idę dalej do sprawdzania wyglądu." Przejdź do Kroku 3.
   - Build ZFAILOWAŁ (jest czerwony tekst, "Failed to compile", "Type error", "Error:") - przejdź do Kroku 2 i napraw.

### Krok 2 - napraw błędy buildu (8 najczęstszych)
Czytaj komunikat błędu i dopasuj do listy poniżej. Napraw, potem WRÓĆ do Kroku 1 i zbuduj jeszcze raz. Powtarzaj, aż build przejdzie. Po każdej naprawie powiedz uczestnikowi jednym zdaniem, co to było.

Pełna lista błędów + gotowe poprawki: czytaj plik `bledy.md` w folderze tego skilla (otwórz go dopiero, gdy trafisz na błąd - oszczędzasz tokeny uczestnika). Skrót 8 najczęstszych:

1. **Brak `'use client'`** - komponent używa `useState`/`useEffect`/`onClick`, a nie ma na górze pliku `'use client'`. Fix: dopisz `'use client'` jako pierwszą linię pliku.
2. **Błąd typu TypeScript** ("Type ... is not assignable") - najczęściej props bez typu albo zła nazwa. Fix: dodaj typ propsa albo popraw nazwę zgodnie z komunikatem.
3. **Brakujący import** ("Cannot find name" / "is not defined") - użyto komponentu/ikony bez importu. Fix: dopisz `import` na górze pliku.
4. **Zły import default vs nazwany** ("has no default export" / "does not contain a default export") - Fix: zamień `import X from` na `import { X } from` (albo odwrotnie, zgodnie z tym, jak plik eksportuje).
5. **Apostrof/cudzysłów w tekście JSX** ("can be escaped with...") - polski tekst z `'` lub `"` w JSX. Fix: zamień na `&apos;` / `&quot;` albo opakuj tekst w `{"..."}`.
6. **Metadata w pliku z `'use client'`** ("You are attempting to export metadata from a component marked with use client") - Fix: przenieś `export const metadata` do pliku bez `'use client'` (zwykle `layout.tsx`).
7. **`<img>` zamiast `next/image` blokuje build przez ESLint** - Fix: w tym kursie wyłączamy tę regułę zamiast przepisywać. Sprawdź, czy w `next.config` lub `.eslintrc` można dopuścić `<img>`; jeśli to twardy błąd buildu, zamień na `next/image` z `width`/`height` lub `fill`.
8. **Nieużyta zmienna/import blokuje build** ("is defined but never used") - Fix: usuń nieużyty import/zmienną.

Jeśli błąd NIE pasuje do żadnego z 8: zastosuj fallback z sekcji "Gdy coś pójdzie nie tak" - przeczytaj cały czerwony komunikat, wytłumacz go po polsku i napraw najprostszą zmianą. Nie kombinuj, nie przepisuj całych plików.

GUARDRAIL: naprawiaj minimalnie. Zmieniasz tylko to, co psuje build. Nie refaktoryzujesz "przy okazji".

### Krok 3 - checklista anti-AI-look (brama nr 2)
Strona ma się zbudować ORAZ nie wyglądać jak generyczny output AI. Przejdź po checklistcie. Pełne reguły i sposób naprawy: plik `anti-ai-look-ruleset.md` (jest w katalogu `40-skills/` jeden poziom wyżej; otwórz go, gdy trafisz na flagę). Tu masz skrót do przeleceniu kodu.

Przelećcie pliki strony (komponenty sekcji, `globals.css`, treść). Każde "TAK" w TELL = flaga do poprawy.

**Typografia**
- [ ] `tracking-tight` lub `tracking-tighter` na nagłówku? (TAK = fix: usuń, zostaw `tracking-normal`)
- [ ] Nagłówkom brakuje `text-balance`? (TAK = fix: dodaj `text-balance`)
- [ ] Eyebrow `uppercase tracking-wide(r/st)` nad nagłówkiem? (TAK = fix: usuń ten nadpis albo zamień na normalny tekst)
- [ ] Nagłówki i body ten sam font (brak pairingu)? (TAK = fix: nagłówki na font display z Karty Wizualnej, body Inter)
- [ ] W tekście / alt / aria jest długi myślnik albo en-dash? (TAK = fix: zamień na krótki "-")

**Layout**
- [ ] Grid 3/4/6 identycznych kart z jednym `hover:` na wszystkich? (TAK = fix: zróżnicuj - inny rozmiar pierwszej karty albo hover tylko tam, gdzie klikalne)
- [ ] Wszystkie boxy mają ten sam `rounded-2xl border shadow-sm`? (TAK = fix: zróżnicuj radius/padding)
- [ ] Cała strona `text-center mx-auto` (zero asymetrii)? (TAK = fix: choć jedna sekcja off-center, układ 7/5 lub 8/4 zamiast wszystko na środku)
- [ ] Realny oddech między sekcjami (`py-20`+)? (NIE = fix: zwiększ odstępy)

**Kolor i obrazy**
- [ ] Gradient violet/purple do blue/indigo (lub cyan do violet, pink do orange)? (TAK = fix: zamień na jeden akcent z Karty Wizualnej)
- [ ] Gradient text (`bg-clip-text text-transparent`) na nagłówku? (TAK = fix: zwykły kolor z tokenów)
- [ ] Min. 3 prawdziwe zdjęcia (nie ikona/svg/AI-ilustracja)? (NIE = fix: zgłoś uczestnikowi, że tu wstawiamy realne foto)
- [ ] Każda sekcja ma ikonę Lucide w kółku jako jedyny wizual? (TAK = fix: ogranicz, dodaj zdjęcia)
- [ ] Emoji jako ikony UI? (TAK = fix: zamień na Lucide albo usuń)
- [ ] Paleta zgodna z Kartą Wizualną, jeden akcent nie tęcza? (NIE = fix: ujednolić do tokenów z `globals.css`)

**Copy**
- [ ] Buzzwordy (Elevate/Unlock/Supercharge/all-in-one/seamless)? (TAK = fix: zaproponuj konkret, ale TREŚĆ zatwierdza uczestnik)
- [ ] Min. jedna konkretna liczba/nazwa/data w copy? (NIE = fix: zapytaj uczestnika o liczbę, np. ile lat doświadczenia, ilu klientów)
- [ ] Nagłówki feature wszystkie tej samej długości (2-3 słowa)? (TAK = fix: zróżnicuj, opisuj efekt nie ficzer)
- [ ] Copy ma polskie znaki i zero długiego myślnika? (NIE = fix: popraw)

**Scoring:** policz flagi. 0-1 = czysto, idziemy dalej. 2-3 = lekki AI-slop, popraw flagi. 4+ = przerób sekcję. Próg kursu: max 1 flaga przed pushem.

GUARDRAIL na copy: poprawki techniczne (tracking, gradient, layout) robisz sam. Zmiany w TREŚCI (słowa, liczby, hasła) tylko za zgodą uczestnika - to jego marka i jego głos. Pokaż propozycję, poproś o "ok".

### Krok 4 - sprawdź, czy klucz nie wyciekł
Klucz API (Resend) NIGDY nie może trafić do gita.

1. Uruchom:

```bash
git ls-files | grep -E "\.env" || echo "OK zaden plik .env nie jest w gicie"
grep -R "re_" .gitignore >/dev/null 2>&1; grep -qx ".env.local" .gitignore && echo "OK .env.local jest w .gitignore" || echo "UWAGA dopisuje .env.local do .gitignore"
```

2. Jeśli `.env.local` NIE jest w `.gitignore` - dopisz go:

```bash
echo ".env.local" >> .gitignore
```

3. Jeśli plik `.env.local` JUŻ trafił do gita (pokazał się w `git ls-files`) - to poważne. Powiedz uczestnikowi wprost: "Twój klucz mógł trafić do historii. Usuwam go ze śledzenia i po deployu wymienimy klucz w panelu Resend, żeby było bezpiecznie." Wykonaj:

```bash
git rm --cached .env.local
```

I dopisz do notatki dla uczestnika: po deployu wygeneruj nowy klucz w Resend (stary uznaj za spalony).

### Krok 5 - werdykt i zapis stanu
1. Jeśli build zielony I checklista czysta (max 1 flaga) I klucz bezpieczny - powiedz jasno:
   "Gotowe. Strona się buduje, wygląda dobrze i klucz jest bezpieczny. Możesz pushować na GitHub - to uruchomi deploy na Vercel."
   Podaj gotową komendę commita (token-economy: checkpoint po review):

```bash
git add -A && git commit -m "review: build zielony + anti-ai-look czysty"
```

2. Jeśli zostały flagi, których uczestnik nie chce naprawiać teraz - zapisz je do `PROGRESS.md` w sekcji "Do poprawy", żeby nic nie zginęło, i powiedz, że można wrócić.
3. Zaktualizuj `PROGRESS.md` jedną linią w stanie: `[x] sprawdz-kod: build OK, anti-ai-look OK (data)`. Jeśli `PROGRESS.md` nie istnieje - nie twórz go tu, to rola skilla `zbuduj-strone`.

## Gdy coś pójdzie nie tak (uniwersalny fallback)

Powiedz to uczestnikowi i zastosuj sam:
"Jeśli w terminalu pojawi się czerwony tekst, którego nie rozumiemy - skopiuj go w całości (cały, od pierwszej do ostatniej czerwonej linii) i wklej do mnie z prośbą: napraw ten błąd i wytłumacz po polsku, co to było. Nie zgaduj, nie usuwaj plików na zapas - czerwony tekst to instrukcja, nie katastrofa."

Gdy build dalej faila po naprawach: przeczytaj logi jeszcze raz, weź NAJWYŻSZY błąd (pierwszy od góry - reszta to często skutki), napraw tylko jego, zbuduj ponownie. Jeden błąd naraz.

Fallback na build (rzadko): w Next 16 build domyślnie idzie przez Turbopack. Jeśli build wywala się na samym Turbopaku (komunikat wskazuje wprost na Turbopack, a nie na kod strony), spróbuj jednorazowo zbudować przez webpack, żeby odróżnić błąd narzędzia od błędu kodu: `rm -rf .next && npm run build -- --webpack` (albo `next build --webpack`). To tylko diagnostyka - domyślną komendą zostaje `npm run build` na Turbopaku, nie zmieniaj skryptów projektu na stałe.

Gdy "Build Failed" pojawił się dopiero na Vercel, a lokalnie było zielono: poproś uczestnika o skopiowanie logów z Vercel (zakładka Deployments -> kliknij failed -> Build Logs), wklej do mnie, czytam i naprawiam tak samo jak lokalny błąd.

## Ważne

- Kolejność jest święta: najpierw build (Krok 1-2), potem wygląd (Krok 3), potem bezpieczeństwo klucza (Krok 4). Nie przeskakuj.
- Nie pushujemy, dopóki build nie jest zielony. To twarda brama.
- Naprawiaj minimalnie i tłumacz po ludzku. Uczestnik ma wyjść z poczucia "kontroluję to", nie "magia się dzieje".
- Lekki tryb: czytaj zmienione pliki + wynik builda, nie całe drzewo repo. Oszczędzasz limit tokenów uczestnika.
