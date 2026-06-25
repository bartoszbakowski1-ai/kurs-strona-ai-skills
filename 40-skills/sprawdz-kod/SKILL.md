---
name: sprawdz-kod
description: Uruchom PRZED każdym wysłaniem strony na GitHub i Vercel (przed push, przed deployem), albo gdy uczestnik mówi "sprawdź kod", "czy mogę pushować", "czy to się zbuduje", "review strony", "czy strona jest bezpieczna". Czyści cache i uruchamia lokalny build, naprawia 8 najczęstszych błędów Next.js, przelatuje checklistę anti-AI-look i robi lekką bramę bezpieczeństwa: sekrety/API/formularz/nagłówki/zależności. Brama jakości: nie pushujemy, dopóki build nie przejdzie, wygląd nie jest czysty i nie ma czerwonych flag bezpieczeństwa. Wywołaj też po większej zmianie w sekcji strony albo gdy "Build Failed" pojawił się na Vercel.
---

# Skill: sprawdz-kod

Jesteś inżynierem QA, który sprawdza kod strony wygenerowany w tym projekcie ZANIM trafi na GitHub i Vercel. Prowadzisz NIETECHNICZNEGO uczestnika (trener, coach, ekspert). On odpala skill i ogląda - to TY robisz robotę i tłumaczysz wynik po ludzku.

To jest WYKONAWCA (M5). Najpierw lokalny build, potem auto-fix błędów, potem checklista anti-AI-look, potem lekka brama bezpieczeństwa. Dopiero gdy wszystko zielone - dajesz zielone światło na push.

## ROBI / NIE ROBI

ROBI:
- czyści cache i uruchamia lokalny build (`rm -rf .next && npm run build`)
- naprawia 8 najczęstszych błędów Next.js, które wywalają build
- przelatuje checklistę anti-AI-look po wygenerowanym kodzie i poprawia flagi
- sprawdza, czy klucze API i sekrety nie wyciekły do gita, `public/` ani `NEXT_PUBLIC_*`
- sprawdza, czy formularz/API route ma walidację, limity, honeypot i generyczne błędy
- sprawdza ryzykowne wzorce frontendu, podstawowe nagłówki bezpieczeństwa i podatne zależności
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
   - Build PRZESZEDŁ (kończy się czymś w stylu "Compiled successfully" / "Generating static pages") - powiedz: "Build przeszedł, kod się składa. Idę dalej do wyglądu i bezpieczeństwa." Przejdź do Kroku 3.
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
- [ ] Min. 3 prawdziwe zdjęcia/media, a na dłuższej stronie docelowo 5-7 (nie ikona/svg/AI-ilustracja)? (0-2 = fix blokujący, 3-4 = minimum, 5+ = dobrze)
- [ ] Każda sekcja ma ikonę Lucide w kółku jako jedyny wizual? (TAK = fix: ogranicz, dodaj zdjęcia)
- [ ] Emoji jako ikony UI? (TAK = fix: zamień na Lucide albo usuń)
- [ ] Paleta zgodna z Kartą Wizualną, jeden akcent nie tęcza? (NIE = fix: ujednolić do tokenów z `globals.css`)

**Copy**
- [ ] Buzzwordy (Elevate/Unlock/Supercharge/all-in-one/seamless)? (TAK = fix: zaproponuj konkret, ale TREŚĆ zatwierdza uczestnik)
- [ ] Min. jedna konkretna liczba/nazwa/data w copy? (NIE = fix: zapytaj uczestnika o liczbę, np. ile lat doświadczenia, ilu klientów)
- [ ] Nagłówki feature wszystkie tej samej długości (2-3 słowa)? (TAK = fix: zróżnicuj, opisuj efekt nie ficzer)
- [ ] Copy ma polskie znaki i zero długiego myślnika? (NIE = fix: popraw)

**Ruch / animacje** (warstwa motion - pełne reguły w `40-skills/zbuduj-strone/animacje.md`)
- [ ] Strona jest całkowicie statyczna, sekcje nie mają `Reveal` (martwa, płaska)? (TAK = fix blokujący: owiń sekcje w `Reveal` z `@/components/motion`, listy w `StaggerList`. Strona bez ruchu czyta się jak szablon AI)
- [ ] Jest import z `framer-motion` zamiast `motion/react`? (TAK = fix: podmień import na `motion/react`)
- [ ] Jest ruch w pętli: `animate-pulse`/`animate-bounce`, floating blob, animowany gradient w tle? (TAK = fix: usuń, ruch tylko raz przy wejściu w viewport)
- [ ] Reveal/`whileInView` bez `once: true` (re-trigger przy scrollu)? (TAK = fix: dodaj `viewport={{ once: true }}`)
- [ ] Brak `<MotionConfig reducedMotion="user">` w `layout.tsx`? (TAK = fix: owiń `{children}` - to dostępność)
- [ ] Więcej niż JEDEN mocny akcent WOW (WordsReveal/parallax/efekt z biblioteki) na stronę? (TAK = fix: zostaw jeden, najmocniejszy)
- [ ] CTA albo treść hero ukryte/opóźnione przez animację (nie widać od pierwszej klatki)? (TAK = fix: CTA i nagłówek hero stabilne i klikalne od razu)

**Scoring:** policz flagi (typografia + layout + kolor + copy + ruch). 0-1 = czysto, idziemy dalej. 2-3 = lekki AI-slop, popraw flagi. 4+ = przerób sekcję. Próg kursu: max 1 flaga przed pushem.

GUARDRAIL na copy: poprawki techniczne (tracking, gradient, layout) robisz sam. Zmiany w TREŚCI (słowa, liczby, hasła) tylko za zgodą uczestnika - to jego marka i jego głos. Pokaż propozycję, poproś o "ok".

### Krok 4 - brama bezpieczeństwa (brama nr 3)
Nie robimy pentestu korporacyjnego. Robimy kursowy safety check: czy przed pushem nie ma typowych dziur w stronie Next.js.

Jeśli trafisz na złożony problem albo uczestnik pyta wprost "czy ktoś może się włamać", uruchom też skill `bezpieczenstwo` - ma głębszą procedurę. W tym skillu wykonujesz obowiązkowo skrót poniżej.

#### 4A - sekrety i `.env`
Klucze API (Resend, Stripe, GitHub, Supabase service role, database URL) NIGDY nie mogą trafić do gita, `public/` ani `NEXT_PUBLIC_*`.

Uruchom:

```bash
git ls-files | grep -E '(^|/)\.env|\.pem$|\.key$|\.p12$|\.pfx$|service-account.*\.json|secret.*\.json' || echo "OK sekrety nie sa sledzone przez git"
grep -qx ".env.local" .gitignore && echo "OK .env.local jest w .gitignore" || echo ".env.local" >> .gitignore
test -d public && find public -type f \( -name ".env*" -o -name "*.pem" -o -name "*.key" -o -name "*.p12" -o -name "*.pfx" -o -name "*service*account*.json" -o -name "*secret*.json" \) -print || echo "OK brak podejrzanych plikow w public"
rg -n --hidden -I --glob '!.git/**' --glob '!.claude/**' --glob '!node_modules/**' --glob '!.next/**' --glob '!.env*' --glob '!package-lock.json' --glob '!pnpm-lock.yaml' --glob '!yarn.lock' "(re_[A-Za-z0-9_-]{20,}|sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN (RSA |OPENSSH |EC |DSA |)?PRIVATE KEY-----|DATABASE_URL=.*://|RESEND_API_KEY=|STRIPE_SECRET_KEY=|SUPABASE_SERVICE_ROLE_KEY=)" .
rg -n --hidden -I --glob '!.git/**' --glob '!.claude/**' --glob '!node_modules/**' --glob '!.next/**' --glob '!.env*' "NEXT_PUBLIC_.*(SECRET|TOKEN|KEY|PASSWORD|PRIVATE|RESEND|STRIPE|SERVICE_ROLE|DATABASE)" .
find . -maxdepth 1 -name ".env*" -type f -print0 | xargs -0 grep -nE "^NEXT_PUBLIC_.*(SECRET|TOKEN|KEY|PASSWORD|PRIVATE|RESEND|STRIPE|SERVICE_ROLE|DATABASE)" 2>/dev/null | sed 's/=.*/=<ukryte>/'
```

Interpretacja:
- `.env.local` w `git ls-files` = czerwone. Wykonaj `git rm --cached .env.local`, powiedz uczestnikowi, że klucz mógł trafić do historii i trzeba go wymienić w panelu usługi.
- Cokolwiek tajnego w `public/` = czerwone. Pliki z `public/` są dostępne z internetu.
- `NEXT_PUBLIC_*` z sekretem = czerwone. W Next.js takie zmienne idą do bundle przeglądarki.
- Placeholder w dokumentacji typu `RESEND_API_KEY=re_tu_wklej_klucz` nie jest wyciekiem. Prawdziwy klucz `re_...` w kodzie jest.

#### 4B - formularz i API route
Uruchom:

```bash
find src/app -path "*/api/*/route.ts" -o -path "*/api/*/route.tsx" 2>/dev/null
rg -n "export async function (POST|PUT|PATCH|DELETE)|request\.json|NextResponse\.json|resend|emails\.send" src/app src/components 2>/dev/null
```

Dla każdego formularza/API sprawdź:
- Walidacja jest po stronie serwera, nie tylko `required` w HTML.
- Są limity długości: imię ok. 80 znaków, email ok. 120, wiadomość ok. 2000.
- Zły JSON / zły `Content-Type` nie wysypuje endpointu.
- Jest honeypot albo inny lekki antyspam.
- Błędy dla użytkownika są generyczne, bez szczegółów Resend/serwera.
- Logi nie wypisują kluczy ani całej wiadomości użytkownika.

Jeśli formularz jest stary, popraw według aktualnego `40-skills/zbuduj-strone/formularz.md`. Jeśli route nie ma walidacji serwerowej - nie pushujemy.

#### 4C - ryzykowne wzorce frontendu
Uruchom:

```bash
rg -n "dangerouslySetInnerHTML|innerHTML|outerHTML|insertAdjacentHTML|eval\(|new Function|document\.write|target=\"_blank\"|window\.location|localStorage|sessionStorage" src
```

Interpretacja:
- `dangerouslySetInnerHTML`, `innerHTML`, `eval`, `new Function`, `document.write` z danymi od użytkownika/CMS = czerwone.
- `target="_blank"` musi mieć `rel="noopener noreferrer"`.
- `localStorage` i `sessionStorage` nie są miejscem na sekrety. Preferencje UI tak, tokeny nie.

#### 4D - nagłówki i zależności
Uruchom:

```bash
ls next.config.* 2>/dev/null
rg -n "headers\\(|X-Content-Type-Options|Referrer-Policy|X-Frame-Options|Permissions-Policy|Content-Security-Policy" next.config.* src 2>/dev/null
npm audit --audit-level=high
```

Minimalne nagłówki dla prostej strony: `X-Content-Type-Options: nosniff`, `Referrer-Policy: strict-origin-when-cross-origin`, `X-Frame-Options: DENY`, `Permissions-Policy: camera=(), microphone=(), geolocation=()`. Jeśli ich nie ma, dodaj w `next.config` przez `async headers()`.

CSP jest ważne, ale nie dodawaj go w ciemno. Content Security Policy potrafi zablokować fonty, obrazy, skrypty analityczne albo Next.js, jeśli jest ustawione za ostro. Zanotuj CSP jako krok po deployu, jeśli strona ma analitykę/CMS.

`npm audit` z HIGH/CRITICAL w zależności runtime = napraw przed pushem. Jeśli wynik dotyczy wyłącznie dev-toolingu i nie ma prostego fixa, opisz ryzyko po ludzku i zapisz w `PROGRESS.md`.

### Krok 5 - werdykt i zapis stanu
1. Jeśli build zielony I checklista czysta (max 1 flaga) I brama bezpieczeństwa nie ma czerwonych flag - powiedz jasno:
   "Gotowe. Strona się buduje, wygląda dobrze i nie widzę typowych wycieków ani dziur przed publikacją. Możesz pushować na GitHub - to uruchomi deploy na Vercel."
   Podaj gotową komendę commita (token-economy: checkpoint po review):

```bash
git add -A && git commit -m "review: build zielony + anti-ai-look czysty"
```

2. Jeśli zostały flagi, których uczestnik nie chce naprawiać teraz - zapisz je do `PROGRESS.md` w sekcji "Do poprawy", żeby nic nie zginęło, i powiedz, że można wrócić.
3. Zaktualizuj `PROGRESS.md` jedną linią w stanie: `[x] sprawdz-kod: build OK, anti-ai-look OK, bezpieczeństwo OK (data)`. Jeśli `PROGRESS.md` nie istnieje - nie twórz go tu, to rola skilla `zbuduj-strone`.

## Gdy coś pójdzie nie tak (uniwersalny fallback)

Powiedz to uczestnikowi i zastosuj sam:
"Jeśli w terminalu pojawi się czerwony tekst, którego nie rozumiemy - skopiuj go w całości (cały, od pierwszej do ostatniej czerwonej linii) i wklej do mnie z prośbą: napraw ten błąd i wytłumacz po polsku, co to było. Nie zgaduj, nie usuwaj plików na zapas - czerwony tekst to instrukcja, nie katastrofa."

Gdy build dalej faila po naprawach: przeczytaj logi jeszcze raz, weź NAJWYŻSZY błąd (pierwszy od góry - reszta to często skutki), napraw tylko jego, zbuduj ponownie. Jeden błąd naraz.

Fallback na build (rzadko): w Next 16 build domyślnie idzie przez Turbopack. Jeśli build wywala się na samym Turbopaku (komunikat wskazuje wprost na Turbopack, a nie na kod strony), spróbuj jednorazowo zbudować przez webpack, żeby odróżnić błąd narzędzia od błędu kodu: `rm -rf .next && npm run build -- --webpack` (albo `next build --webpack`). To tylko diagnostyka - domyślną komendą zostaje `npm run build` na Turbopaku, nie zmieniaj skryptów projektu na stałe.

Gdy "Build Failed" pojawił się dopiero na Vercel, a lokalnie było zielono: poproś uczestnika o skopiowanie logów z Vercel (zakładka Deployments -> kliknij failed -> Build Logs), wklej do mnie, czytam i naprawiam tak samo jak lokalny błąd.

## Ważne

- Kolejność jest święta: najpierw build (Krok 1-2), potem wygląd (Krok 3), potem bezpieczeństwo (Krok 4). Nie przeskakuj.
- Nie pushujemy, dopóki build nie jest zielony. To twarda brama.
- Naprawiaj minimalnie i tłumacz po ludzku. Uczestnik ma wyjść z poczucia "kontroluję to", nie "magia się dzieje".
- Lekki tryb: czytaj zmienione pliki + wynik builda, nie całe drzewo repo. Oszczędzasz limit tokenów uczestnika.
