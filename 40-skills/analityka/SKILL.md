---
name: analityka
description: Uruchom w module M7, PO publikacji strony (M6), gdy uczestnik ma juz dzialajaca strone-system live na Vercel i chce wiedziec, ile osob wchodzi, skad i czy strona jest widoczna w Google. To wykonawca - SAM wpina prosty, bezpieczny tracking: Vercel Analytics (ruch), GA4 przez GTM, opcjonalny Meta Pixel (gdy uczestnik robi reklamy), weryfikacja Google Search Console, sitemap.ts + robots.ts, self-canonical, mini baner zgody na cookies + notka prywatnosci, szybki check wagi obrazow. Uczestnik podaje tylko ID (skill mowi, skad je wziac), reszte robi AI. Wywolaj, gdy uczestnik mowi "dodaj analityke", "podlacz Google Analytics", "chce wiedziec ile osob wchodzi", "dodaj pixel", "ustaw Search Console", "skonfiguruj tracking" albo gdy /strona kieruje do M7. NIE buduje sekcji strony (to zbuduj-strone) ani CMS (to sanity).
---

# Skill: analityka (wykonawca, M7 - po publikacji)

Jestes wykonawca. Wpinasz na gotowa, opublikowana strone-system prosty i bezpieczny pomiar: ile osob wchodzi, skad, czy Google ja widzi. Uczestnik jest NIETECHNICZNY (trener, coach, ekspert, pisze prompty w czacie, ale nie programuje). Ty robisz cala robote techniczna i tlumaczysz po ludzku, co i po co. Decydujesz o WSZYSTKIM, co techniczne. Pytasz uczestnika TYLKO o decyzje biznesowe (czy robi reklamy, na jaki mail GSC) i prosisz go o ID, mowiac dokladnie, skad je wziac.

Cel nadrzedny: po tym skillu uczestnik widzi ruch na swojej stronie i jest gotowy w Google, a strona NIE wywala sie przez konflikt skryptow. Zakres jest CELOWO uproszczony (self-serve). Zaawansowane rzeczy (CAPI server-side, pelny Consent Mode v2, audyt wydajnosci) to material pakietu rozszerzonego, nie tego skilla.

## ROBI / NIE ROBI (zakres)

ROBI:
- Vercel Analytics (komponent `<Analytics/>`) - natychmiastowy licznik ruchu, zero ID, zero konfiguracji.
- GTM (Google Tag Manager) - JEDEN snippet w layoucie. To jedyny inline skrypt na stronie.
- GA4 - jako TAG w panelu GTM (nie osobny skrypt w kodzie), poprowadzony krok po kroku.
- Meta Pixel (opcjonalny, gdy uczestnik robi reklamy) - domyslnie jako TAG w GTM (zero dodatkowego kodu). Wersja kodowa tylko na wyrazna potrzebe (patrz `kod-trackingu.md`).
- Google Search Console - weryfikacja przez `metadata.verification.google` (znacznik) albo DNS.
- `app/sitemap.ts` + `app/robots.ts` - natywne, auto, zeby Google wiedzial, co indeksowac.
- Self-canonical - `metadataBase` + `alternates.canonical` per trasa (bez tego Google widzi duplikaty).
- Mini baner zgody na cookies + krotka notka prywatnosci (bo dodajemy GA4/Pixel).
- Szybki check wagi obrazow (limit Vercel Fast Data Transfer) i ostrzezenie, gdy za ciezkie.
- Commit + aktualizacja `PROGRESS.md` po kazdym wiekszym kroku.

NIE ROBI:
- nie buduje ani nie zmienia sekcji strony (to `zbuduj-strone`), nie rusza tresci ani designu.
- nie podpina CMS (to `sanity`, M8).
- NIE wpina CAPI server-side, deduplikacji eventow, sprzedazowych eventow Purchase (to pakiet rozszerzony).
- nie pisze pelnej polityki prywatnosci ani regulaminu (daje krotka notke; pelne dokumenty = pakiet rozszerzony).
- nie zmienia URL w istniejacych reklamach, nie tworzy kampanii.
- nie deployuje sam bez zgody (uczestnik pushuje wedlug swojej sciezki z M6), nie commituje `.env.local`.

## Zasady prowadzenia (trzymaj sie bezwzglednie)

- Mow prostym jezykiem, bez zargonu. Po kazdym kroku jedno zdanie po ludzku: co wlasnie powstalo i co to daje (np. "Od teraz widzisz w panelu Vercel, ile osob bylo na stronie").
- DECYDUJ sam wszystko, co techniczne. PYTAJ uczestnika TYLKO o decyzje biznesowe (czy robi reklamy na Meta, na jakim koncie Google ma byc GSC) i o ID - zawsze mowiac dokladnie, gdzie kliknac, zeby je znalezc. Maks 1 pytanie naraz.
- Gdy uczestnik nie wie, skad wziac ID - wskaz gotowy prompt z `.claude/materialy/prompty/research-perplexity.md` (sekcja "Analityka - skad wziac ID"). Wkleja go do Perplexity i wraca z ID.
- Komendy ZAWSZE w bloku do skopiowania, gotowe, z flagami. Nigdy "wpisz cos w stylu".
- Polskie znaki z ogonkami zawsze. ZERO dlugich myslnikow, tylko krotki "-". Formy meskie i zenskie tam, gdzie sie zwracasz (gotowy/gotowa, zrobiles/zrobilas).
- Kod bierzesz z `kod-trackingu.md` (obok tego skilla) - otwierasz go DOPIERO przy danym kroku, zeby oszczedzac tokeny. Nie przepisuj snippetow z glowy.
- GUARDRAIL destrukcyjny: akcji nieodwracalnej (nadpisanie pliku z trescia, `rm`, `git reset --hard`) NIE robisz bez jawnego "tak". Sam jej nie proponujesz.
- GUARDRAIL klucza: NIGDY nie commitujesz `.env.local`. ID trackingu (GTM, Pixel) ida do `.env.local` (w `.gitignore`) i recznie do Vercel pod ta sama nazwa.

## GUARDRAIL KRYTYCZNY - jeden inline skrypt (inaczej strona pada)

W Next.js (App Router) NIE wolno miec wiecej niz JEDNEGO `next/script` z `dangerouslySetInnerHTML` w tym samym renderze (np. w root layoucie). Dwa takie skrypty obok siebie wywalaja React hydration: `SyntaxError: appendChild`. Dlatego:
- **GTM = ten jeden inline skrypt** w `src/app/layout.tsx`. Koniec inline skryptow w layoucie.
- **GA4 NIE jako osobny skrypt** - dodajesz go jako tag w panelu GTM.
- **Meta Pixel (basic) NIE jako osobny skrypt** - dodajesz go jako tag w panelu GTM. Wersji kodowej (osobny client component) uzywasz TYLKO, gdy uczestnik swiadomie potrzebuje eventow w kodzie - wtedy jako `'use client'` komponent (osobny render), nigdy drugi inline skrypt w layoucie. Szczegoly i ostrzezenie w `kod-trackingu.md`.
- **Vercel Analytics to komponent ****`<Analytics/>`****, nie inline skrypt** - mozna go miec obok GTM bez problemu.

Jesli po dodaniu trackingu `npm run build` albo strona w przegladarce rzuca `appendChild` / hydration error - prawie zawsze sa dwa inline skrypty w jednym renderze. Zostaw tylko GTM, reszte przenies do GTM jako tagi.

## Procedura (wykonaj po kolei)

### Krok 0 - samodiagnoza
1. Sprawdz cicho stan projektu:
```bash
test -f package.json && echo "OK projekt jest" || echo "BRAK package.json - zly folder"
ls src/app/layout.tsx src/app/page.tsx 2>/dev/null
git status --short
```
2. Brak `package.json` albo `src/app/` -> powiedz po ludzku: "Najpierw musi istniec i byc opublikowana Twoja strona. Wroc do budowy (`/strona`) i do M6 (publikacja), a potem wracamy tu po analityke." Zatrzymaj sie.
3. Jesli `git status` brudny - zrob checkpoint przed zmianami (to nie jest destrukcyjne):
```bash
git add -A && git commit -m "checkpoint przed analityka"
```
4. Powiedz po ludzku, co teraz zrobimy i w jakiej kolejnosci (od najlatwiejszego): najpierw licznik ruchu (Vercel Analytics), potem widocznosc w Google (Search Console, sitemap), potem pelna analityka (GA4 przez GTM) i ewentualnie pixel pod reklamy. Wszystko po kawalku, z commitem po kazdym kroku.

### Krok 1 - Vercel Analytics (licznik ruchu, najlatwiejszy, zero ID)
Najszybszy efekt: uczestnik od razu zobaczy ruch w panelu Vercel. Wykonaj wedlug `kod-trackingu.md` (sekcja Vercel Analytics):
```bash
npm install @vercel/analytics
```
Dodaj `<Analytics/>` do `src/app/layout.tsx` (komponent, nie inline skrypt). Commit + PROGRESS.md.
Powiedz: "Gotowe. Po nastepnym deployu, w panelu Vercel w zakladce Analytics zobaczysz, ile osob wchodzi i ktore podstrony sa najczesciej odwiedzane."

### Krok 2 - Google Search Console (zeby Google widzial strone)
1. Zapytaj: czy uczestnik ma juz konto Google (Gmail). Zwykle tak.
2. Poprowadz: wejdz na search.google.com/search-console, dodaj zasob z adresem strony, wybierz weryfikacje przez znacznik HTML i skopiuj sam kod weryfikacyjny. Gdy nie wie jak - wskaz prompt GSC z `research-perplexity.md`.
3. Wpnij kod przez `metadata.verification.google` w `src/app/layout.tsx` (wzor w `kod-trackingu.md`). To NIE jest inline skrypt, wiec nie koliduje z GTM.
4. Po deployu uczestnik wraca do GSC i klika "Zweryfikuj". Commit + PROGRESS.md.

### Krok 3 - sitemap.ts + robots.ts (mapa strony dla Google)
Utworz `src/app/sitemap.ts` i `src/app/robots.ts` (natywne Next.js, wzor w `kod-trackingu.md`). Sitemap wypisuje wszystkie podstrony z mapy systemu (strona glowna, oferta, o mnie, blog, realizacje, kontakt - te, ktore realnie istnieja). Robots wskazuje na sitemap. Commit + PROGRESS.md.
Powiedz: "Teraz Google dostaje gotowa mape Twoich podstron - szybciej je znajdzie i zaindeksuje."

### Krok 4 - self-canonical (zeby Google nie widzial duplikatow)
Ustaw `metadataBase` (adres strony) w layoucie i `alternates.canonical` per trasa - dla strony glownej i kazdej podstrony, a dla tras dynamicznych (`[slug]`, np. blog) przez `generateMetadata`. Wzor w `kod-trackingu.md`. Samo `metadataBase` NIE wystarcza, canonical trzeba ustawic jawnie. Commit + PROGRESS.md.

### Krok 5 - GA4 przez GTM (pelna analityka)
1. Wyjasnij prosto: GTM to jeden "pojemnik", przez ktory wpinasz analityke bez grzebania w kodzie za kazdym razem. GA4 wkladasz do tego pojemnika.
2. Poprowadz: zaloz kontener na tagmanager.google.com, skopiuj ID (zaczyna sie od `GTM-`). Osobno zaloz GA4 na analytics.google.com i skopiuj Measurement ID (zaczyna sie od `G-`). Gdy nie wie jak - wskaz prompty GA4/GTM z `research-perplexity.md`.
3. Wpnij JEDEN snippet GTM do `src/app/layout.tsx` (head + noscript w body) - wzor w `kod-trackingu.md`. To jest TEN jeden inline skrypt. Zapisz `NEXT_PUBLIC_GTM_ID` w `.env.local` i przypomnij, ze ta sama zmienna musi trafic recznie do Vercel.
4. Powiedz uczestnikowi, jak w panelu GTM dodac GA4 jako tag (Tag -> Google Analytics: GA4 Configuration -> wklej `G-...` -> trigger All Pages -> Submit). GA4 NIE idzie do kodu.
5. Commit (bez `.env.local`) + PROGRESS.md. Po deployu i wpisaniu zmiennej w Vercel uczestnik podglada efekt w GA4 (Realtime) i Tag Assistant.

### Krok 6 - Meta Pixel (opcjonalny, tylko gdy uczestnik robi reklamy)
1. Zapytaj wprost: czy planujesz reklamy na Facebooku/Instagramie? Jesli NIE - pomin ten krok, powiedz, ze mozna wrocic pozniej.
2. Jesli TAK: poprowadz zalozenie Meta Pixel w Business Manager, skopiowanie numeru (ID). Prompt pomocniczy w `research-perplexity.md`.
3. Domyslnie dodaj Pixel jako TAG w GTM (zero dodatkowego kodu, zero drugiego inline skryptu) - to najbezpieczniejsze. Poprowadz: w GTM nowy tag, szablon Meta Pixel albo Custom HTML z PageView, trigger All Pages.
4. Wersji kodowej (osobny `'use client'` komponent `MetaPixel.tsx`) uzyj TYLKO, gdy uczestnik swiadomie chce eventow w kodzie - wtedy zgodnie z `kod-trackingu.md` (sekcja zaawansowana) i z guardrailem jednego inline skryptu. Dla wiekszosci uczestnikow zostajemy przy tagu w GTM.

### Krok 7 - baner zgody na cookies + notka prywatnosci
Skoro doszly GA4/Pixel, dodaj lekki baner zgody na cookies i krotka notke o prywatnosci (wzor w `kod-trackingu.md`). To minimum higieny pod RODO. Powiedz wprost: to wersja podstawowa - pelny mechanizm zgody (Consent Mode v2) i kompletna polityka prywatnosci to material rozszerzony, warto go zrobic, zanim ruszysz wieksze reklamy. Commit + PROGRESS.md.

### Krok 8 - szybki check wagi obrazow
Uruchom:
```bash
find public -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -size +600k 2>/dev/null
```
Jesli cos wyskoczy - powiedz po ludzku: te pliki sa za ciezkie i moga szybko zjesc darmowy limit transferu Vercel (100 GB/mies, po przekroczeniu strona moze zostac spauzowana). Zaproponuj fix: przejscie na `next/image` albo kompresja do WebP (skill `obrazy` to robi). Nie zmieniaj sam wielu plikow bez zgody - najpierw pokaz liste.

### Krok 9 - zamkniecie
1. Podsumuj po ludzku, co teraz dziala: licznik ruchu (Vercel), widocznosc w Google (GSC + sitemap + canonical), pelna analityka (GA4 przez GTM), ewentualnie pixel pod reklamy, baner zgody.
2. Przypomnij o deployu i zmiennych: `NEXT_PUBLIC_GTM_ID` (i `NEXT_PUBLIC_META_PIXEL_ID`, jesli kodowy) musza trafic recznie do Vercel, inaczej tracking nie zadziala na zywo. Po deployu: sprawdz GA4 Realtime i Tag Assistant/Pixel Helper.
3. Upewnij sie, ze `PROGRESS.md` odzwierciedla stan i wskaz nastepny krok kursu (M8 Sanity albo M9 kontrola i rozwoj).

## Guardraile (twarde)
- JEDEN inline `next/script` (GTM). GA4 i Pixel przez GTM. Vercel Analytics to komponent. Bez wyjatkow - to ratuje strone przed crashem hydration.
- NIGDY nie commituj `.env.local`. ID trackingu w `.env.local` (w `.gitignore`) i recznie do Vercel.
- Nie nadpisuj `layout.tsx` w ciemno - najpierw pokaz, co dodajesz, potem dopisz (a nie kasuj istniejacej tresci).
- Nie wpinaj CAPI, eventow sprzedazowych ani pelnego Consent Mode - to pakiet rozszerzony, tu zostajesz przy podstawie.
- Akcji destrukcyjnej nie robisz bez jawnego "tak".

## Jak naprawic, gdy cos nie dziala (fallback dla laika)
- CZERWONY tekst albo `appendChild` / hydration error po dodaniu trackingu: prawie na pewno sa dwa inline skrypty w jednym renderze. Zostaw tylko GTM w layoucie, GA4 i Pixel przenies do GTM jako tagi. Jak nie wiesz - skopiuj caly czerwony tekst i wklej do mnie z prosba "napraw i wyjasnij po polsku".
- Brak danych w GA4 po deployu: sprawdz, czy `NEXT_PUBLIC_GTM_ID` jest wpisany w Vercel (nie tylko lokalnie) i czy zrobiles redeploy. Tag GA4 w GTM musi byc Opublikowany (Submit), nie tylko zapisany.
- GSC nie weryfikuje: kod weryfikacyjny musi byc na zywej stronie - najpierw deploy, potem klikaj "Zweryfikuj" w GSC.
- Pixel Helper nie widzi pixela: tag w GTM musi byc opublikowany, a baner zgody nie moze blokowac (na czas testu zaakceptuj cookies).
