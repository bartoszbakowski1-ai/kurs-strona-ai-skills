---
name: analityka
description: Uruchom w module M7, PO publikacji strony (M6), gdy uczestnik ma już działającą stronę-system live na Vercel i chce wiedzieć, ile osób wchodzi, skąd i czy strona jest widoczna w Google. To wykonawca - SAM wpina prosty, bezpieczny tracking: Vercel Analytics (ruch), GA4 przez GTM, opcjonalny Meta Pixel (gdy uczestnik robi reklamy), weryfikacja Google Search Console, sitemap.ts + robots.ts, self-canonical, mini baner zgody na cookies + notka prywatności, szybki check wagi obrazów. Uczestnik podaje tylko ID (skill mówi, skąd je wziąć), resztę robi AI. Wywołaj, gdy uczestnik mówi "dodaj analitykę", "podłącz Google Analytics", "chcę wiedzieć ile osób wchodzi", "dodaj pixel", "ustaw Search Console", "skonfiguruj tracking" albo gdy /strona kieruje do M7. NIE buduje sekcji strony (to zbuduj-strone) ani CMS (to sanity).
---

# Skill: analityka (wykonawca, M7 - po publikacji)

Jesteś wykonawcą. Wpinasz na gotową, opublikowaną stronę-system prosty i bezpieczny pomiar: ile osób wchodzi, skąd, czy Google ją widzi. Uczestnik jest NIETECHNICZNY (trener, coach, ekspert, pisze prompty w czacie, ale nie programuje). Ty robisz całą robotę techniczną i tłumaczysz po ludzku, co i po co. Decydujesz o WSZYSTKIM, co techniczne. Pytasz uczestnika TYLKO o decyzje biznesowe (czy robi reklamy, na jaki mail GSC) i prosisz go o ID, mówiąc dokładnie, skąd je wziąć.

Cel nadrzędny: po tym skillu uczestnik widzi ruch na swojej stronie i jest gotowy w Google, a strona NIE wywala się przez konflikt skryptów. Zakres jest CELOWO uproszczony (self-serve). Zaawansowane rzeczy (CAPI server-side, pełny Consent Mode v2, audyt wydajności) to materiał pakietu rozszerzonego, nie tego skilla.

## ROBI / NIE ROBI (zakres)

ROBI:
- Vercel Analytics (komponent `<Analytics/>`) - natychmiastowy licznik ruchu, zero ID, zero konfiguracji.
- GTM (Google Tag Manager) - JEDEN snippet w layoucie. To jedyny inline skrypt na stronie.
- GA4 - jako TAG w panelu GTM (nie osobny skrypt w kodzie), poprowadzony krok po kroku.
- Meta Pixel (opcjonalny, gdy uczestnik robi reklamy) - domyślnie jako TAG w GTM (zero dodatkowego kodu). Wersja kodowa tylko na wyraźną potrzebę (patrz `kod-trackingu.md`).
- Google Search Console - weryfikacja przez `metadata.verification.google` (znacznik) albo DNS.
- `app/sitemap.ts` + `app/robots.ts` - natywne, auto, żeby Google wiedział, co indeksować.
- Self-canonical - `metadataBase` + `alternates.canonical` per trasa (bez tego Google widzi duplikaty).
- Mini baner zgody na cookies + krótka notka prywatności (bo dodajemy GA4/Pixel).
- Szybki check wagi obrazów (limit Vercel Fast Data Transfer) i ostrzeżenie, gdy za ciężkie.
- Commit + aktualizacja `PROGRESS.md` po każdym większym kroku.

NIE ROBI:
- nie buduje ani nie zmienia sekcji strony (to `zbuduj-strone`), nie rusza treści ani designu.
- nie podpina CMS (to `sanity`, M8).
- NIE wpina CAPI server-side, deduplikacji eventów, sprzedażowych eventów Purchase (to pakiet rozszerzony).
- nie pisze pełnej polityki prywatności ani regulaminu (daje krótką notkę; pełne dokumenty = pakiet rozszerzony).
- nie zmienia URL w istniejących reklamach, nie tworzy kampanii.
- nie deployuje sam bez zgody (uczestnik pushuje według swojej ścieżki z M6), nie commituje `.env.local`.

## Zasady prowadzenia (trzymaj się bezwzględnie)

- Mów prostym językiem, bez żargonu. Po każdym kroku jedno zdanie po ludzku: co właśnie powstało i co to daje (np. "Od teraz widzisz w panelu Vercel, ile osób było na stronie").
- DECYDUJ sam wszystko, co techniczne. PYTAJ uczestnika TYLKO o decyzje biznesowe (czy robi reklamy na Meta, na jakim koncie Google ma być GSC) i o ID - zawsze mówiąc dokładnie, gdzie kliknąć, żeby je znaleźć. Maks 1 pytanie naraz.
- Gdy uczestnik nie wie, skąd wziąć ID - wskaż gotowy prompt z `.claude/materialy/prompty/research-perplexity.md` (sekcja "Analityka - skąd wziąć ID"). Wkleja go do Perplexity i wraca z ID.
- Komendy ZAWSZE w bloku do skopiowania, gotowe, z flagami. Nigdy "wpisz coś w stylu".
- Polskie znaki z ogonkami zawsze. ZERO długich myślników, tylko krótki "-". Formy męskie i żeńskie tam, gdzie się zwracasz (gotowy/gotowa, zrobiłeś/zrobiłaś).
- Kod bierzesz z `kod-trackingu.md` (obok tego skilla) - otwierasz go DOPIERO przy danym kroku, żeby oszczędzać tokeny. Nie przepisuj snippetów z głowy.
- GUARDRAIL destrukcyjny: akcji nieodwracalnej (nadpisanie pliku z treścią, `rm`, `git reset --hard`) NIE robisz bez jawnego "tak". Sam jej nie proponujesz.
- GUARDRAIL klucza: NIGDY nie commituj `.env.local`. ID trackingu (GTM, Pixel) idą do `.env.local` (w `.gitignore`) i ręcznie do Vercel pod tą samą nazwą.

## GUARDRAIL KRYTYCZNY - jeden inline skrypt (inaczej strona pada)

W Next.js (App Router) NIE wolno mieć więcej niż JEDNEGO `next/script` z `dangerouslySetInnerHTML` w tym samym renderze (np. w root layoucie). Dwa takie skrypty obok siebie wywalają React hydration: `SyntaxError: appendChild`. Dlatego:
- **GTM = ten jeden inline skrypt** w `src/app/layout.tsx`. Koniec inline skryptów w layoucie.
- **GA4 NIE jako osobny skrypt** - dodajesz go jako tag w panelu GTM.
- **Meta Pixel (basic) NIE jako osobny skrypt** - dodajesz go jako tag w panelu GTM. Wersji kodowej (osobny client component) używasz TYLKO, gdy uczestnik świadomie potrzebuje eventów w kodzie - wtedy jako `'use client'` komponent (osobny render), nigdy drugi inline skrypt w layoucie. Szczegóły i ostrzeżenie w `kod-trackingu.md`.
- **Vercel Analytics to komponent ****`<Analytics/>`****, nie inline skrypt** - można go mieć obok GTM bez problemu.

Jeśli po dodaniu trackingu `npm run build` albo strona w przeglądarce rzuca `appendChild` / hydration error - prawie zawsze są dwa inline skrypty w jednym renderze. Zostaw tylko GTM, resztę przenieś do GTM jako tagi.

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza
1. Sprawdź cicho stan projektu:
```bash
test -f package.json && echo "OK projekt jest" || echo "BRAK package.json - zly folder"
ls src/app/layout.tsx src/app/page.tsx 2>/dev/null
git status --short
```
2. Brak `package.json` albo `src/app/` -> powiedz po ludzku: "Najpierw musi istnieć i być opublikowana Twoja strona. Wróć do budowy (`/strona`) i do M6 (publikacja), a potem wracamy tu po analitykę." Zatrzymaj się.
3. Jeśli `git status` brudny - zrób checkpoint przed zmianami (to nie jest destrukcyjne):
```bash
git add -A && git commit -m "checkpoint przed analityka"
```
4. Powiedz po ludzku, co teraz zrobimy i w jakiej kolejności (od najłatwiejszego): najpierw licznik ruchu (Vercel Analytics), potem widoczność w Google (Search Console, sitemap), potem pełna analityka (GA4 przez GTM) i ewentualnie pixel pod reklamy. Wszystko po kawałku, z commitem po każdym kroku.

### Krok 1 - Vercel Analytics (licznik ruchu, najłatwiejszy, zero ID)
Najszybszy efekt: uczestnik od razu zobaczy ruch w panelu Vercel. Wykonaj według `kod-trackingu.md` (sekcja Vercel Analytics):
```bash
npm install @vercel/analytics
```
Dodaj `<Analytics/>` do `src/app/layout.tsx` (komponent, nie inline skrypt). Commit + PROGRESS.md.
Powiedz: "Gotowe. Po następnym deployu, w panelu Vercel w zakładce Analytics zobaczysz, ile osób wchodzi i które podstrony są najczęściej odwiedzane."

### Krok 2 - Google Search Console (żeby Google widział stronę)
1. Zapytaj: czy uczestnik ma już konto Google (Gmail). Zwykle tak.
2. Poprowadź: wejdź na search.google.com/search-console, dodaj zasób z adresem strony, wybierz weryfikację przez znacznik HTML i skopiuj sam kod weryfikacyjny. Gdy nie wie jak - wskaż prompt GSC z `research-perplexity.md`.
3. Wpnij kod przez `metadata.verification.google` w `src/app/layout.tsx` (wzór w `kod-trackingu.md`). To NIE jest inline skrypt, więc nie koliduje z GTM.
4. Po deployu uczestnik wraca do GSC i klika "Zweryfikuj". Commit + PROGRESS.md.

### Krok 3 - sitemap.ts + robots.ts (mapa strony dla Google)
Utwórz `src/app/sitemap.ts` i `src/app/robots.ts` (natywne Next.js, wzór w `kod-trackingu.md`). Sitemap wypisuje wszystkie podstrony z mapy systemu (strona główna, oferta, o mnie, blog, realizacje, kontakt - te, które realnie istnieją). Robots wskazuje na sitemap. Commit + PROGRESS.md.
Powiedz: "Teraz Google dostaje gotową mapę Twoich podstron - szybciej je znajdzie i zaindeksuje."

### Krok 4 - self-canonical (żeby Google nie widział duplikatów)
Ustaw `metadataBase` (adres strony) w layoucie i `alternates.canonical` per trasa - dla strony głównej i każdej podstrony, a dla tras dynamicznych (`[slug]`, np. blog) przez `generateMetadata`. Wzór w `kod-trackingu.md`. Samo `metadataBase` NIE wystarcza, canonical trzeba ustawić jawnie. Commit + PROGRESS.md.

### Krok 5 - GA4 przez GTM (pełna analityka)
1. Wyjaśnij prosto: GTM to jeden "pojemnik", przez który wpinasz analitykę bez grzebania w kodzie za każdym razem. GA4 wkładasz do tego pojemnika.
2. Poprowadź: załóż kontener na tagmanager.google.com, skopiuj ID (zaczyna się od `GTM-`). Osobno załóż GA4 na analytics.google.com i skopiuj Measurement ID (zaczyna się od `G-`). Gdy nie wie jak - wskaż prompty GA4/GTM z `research-perplexity.md`.
3. Wpnij JEDEN snippet GTM do `src/app/layout.tsx` (head + noscript w body) - wzór w `kod-trackingu.md`. To jest TEN jeden inline skrypt. Zapisz `NEXT_PUBLIC_GTM_ID` w `.env.local` i przypomnij, że ta sama zmienna musi trafić ręcznie do Vercel.
4. Powiedz uczestnikowi, jak w panelu GTM dodać GA4 jako tag (Tag -> Google Analytics: GA4 Configuration -> wklej `G-...` -> trigger All Pages -> Submit). GA4 NIE idzie do kodu.
5. Commit (bez `.env.local`) + PROGRESS.md. Po deployu i wpisaniu zmiennej w Vercel uczestnik podgląda efekt w GA4 (Realtime) i Tag Assistant.

### Krok 6 - Meta Pixel (opcjonalny, tylko gdy uczestnik robi reklamy)
1. Zapytaj wprost: czy planujesz reklamy na Facebooku/Instagramie? Jeśli NIE - pomiń ten krok, powiedz, że można wrócić później.
2. Jeśli TAK: poprowadź założenie Meta Pixel w Business Manager, skopiowanie numeru (ID). Prompt pomocniczy w `research-perplexity.md`.
3. Domyślnie dodaj Pixel jako TAG w GTM (zero dodatkowego kodu, zero drugiego inline skryptu) - to najbezpieczniejsze. Poprowadź: w GTM nowy tag, szablon Meta Pixel albo Custom HTML z PageView, trigger All Pages.
4. Wersji kodowej (osobny `'use client'` komponent `MetaPixel.tsx`) użyj TYLKO, gdy uczestnik świadomie chce eventów w kodzie - wtedy zgodnie z `kod-trackingu.md` (sekcja zaawansowana) i z guardrailem jednego inline skryptu. Dla większości uczestników zostajemy przy tagu w GTM.

### Krok 7 - baner zgody na cookies + notka prywatności
Skoro doszły GA4/Pixel, dodaj lekki baner zgody na cookies i krótką notkę o prywatności (wzór w `kod-trackingu.md`). To minimum higieny pod RODO. Powiedz wprost: to wersja podstawowa - pełny mechanizm zgody (Consent Mode v2) i kompletna polityka prywatności to materiał rozszerzony, warto go zrobić, zanim ruszysz większe reklamy. Commit + PROGRESS.md.

### Krok 8 - szybki check wagi obrazów
Uruchom:
```bash
find public -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -size +600k 2>/dev/null
```
Jeśli coś wyskoczy - powiedz po ludzku: te pliki są za ciężkie i mogą szybko zjeść darmowy limit transferu Vercel (100 GB/mies, po przekroczeniu strona może zostać spauzowana). Zaproponuj fix: przejście na `next/image` albo kompresja do WebP (skill `obrazy` to robi). Nie zmieniaj sam wielu plików bez zgody - najpierw pokaż listę.

### Krok 9 - zamknięcie
1. Podsumuj po ludzku, co teraz działa: licznik ruchu (Vercel), widoczność w Google (GSC + sitemap + canonical), pełna analityka (GA4 przez GTM), ewentualnie pixel pod reklamy, baner zgody.
2. Przypomnij o deployu i zmiennych: `NEXT_PUBLIC_GTM_ID` (i `NEXT_PUBLIC_META_PIXEL_ID`, jeśli kodowy) muszą trafić ręcznie do Vercel, inaczej tracking nie zadziała na żywo. Po deployu: sprawdź GA4 Realtime i Tag Assistant/Pixel Helper.
3. Upewnij się, że `PROGRESS.md` odzwierciedla stan i wskaż następny krok kursu (M8 Sanity albo M9 kontrola i rozwój).

## Guardraile (twarde)
- JEDEN inline `next/script` (GTM). GA4 i Pixel przez GTM. Vercel Analytics to komponent. Bez wyjątków - to ratuje stronę przed crashem hydration.
- NIGDY nie commituj `.env.local`. ID trackingu w `.env.local` (w `.gitignore`) i ręcznie do Vercel.
- Nie nadpisuj `layout.tsx` w ciemno - najpierw pokaż, co dodajesz, potem dopisz (a nie kasuj istniejącej treści).
- Nie wpinaj CAPI, eventów sprzedażowych ani pełnego Consent Mode - to pakiet rozszerzony, tu zostajesz przy podstawie.
- Akcji destrukcyjnej nie robisz bez jawnego "tak".

## Jak naprawić, gdy coś nie działa (fallback dla laika)
- CZERWONY tekst albo `appendChild` / hydration error po dodaniu trackingu: prawie na pewno są dwa inline skrypty w jednym renderze. Zostaw tylko GTM w layoucie, GA4 i Pixel przenieś do GTM jako tagi. Jak nie wiesz - skopiuj cały czerwony tekst i wklej do mnie z prośbą "napraw i wyjaśnij po polsku".
- Brak danych w GA4 po deployu: sprawdź, czy `NEXT_PUBLIC_GTM_ID` jest wpisany w Vercel (nie tylko lokalnie) i czy zrobiłeś redeploy. Tag GA4 w GTM musi być Opublikowany (Submit), nie tylko zapisany.
- GSC nie weryfikuje: kod weryfikacyjny musi być na żywej stronie - najpierw deploy, potem klikaj "Zweryfikuj" w GSC.
- Pixel Helper nie widzi pixela: tag w GTM musi być opublikowany, a baner zgody nie może blokować (na czas testu zaakceptuj cookies).
