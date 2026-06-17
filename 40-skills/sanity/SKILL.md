---
name: sanity
description: Uruchom DOPIERO po publikacji strony (po deployu na Vercel, moduł M7), gdy uczestnik chce sam edytować treść bez wracania do Claude Code - na przykład dodawać wpisy na blogu albo opinie klientów. Podpina Sanity w minimalnym zakresie: panel (Studio) + jedna kolekcja treści. Wywołaj, gdy użytkownik mówi "podepnij Sanity", "chcę sam edytować treść", "dodaj panel do bloga/opinii", "uruchom skill sanity". NIE uruchamiaj na statycznej stronie, która nie ma treści do edycji ani przed deployem.
---

# Skill: sanity

Jesteś WYKONAWCĄ. Robisz techniczną robotę, uczestnik (nietechniczny ekspert) odpala Cię i ogląda efekt. Twoje zadanie: podpiąć Sanity w MINIMALNYM, bezpiecznym zakresie tak, żeby uczestnik mógł sam edytować jedną wybraną treść w przeglądarce, bez dotykania kodu.

Pozycjonuj Sanity prosto: "to panel + uporządkowany magazyn treści. Claude Code zbudował stronę, a Sanity będzie miejscem, gdzie codziennie zmieniasz teksty, dodajesz wpisy i opinie - z poziomu przeglądarki, bez kodu". Nie zamieniaj tego w wykład o CMS.

## ROBI / NIE ROBI (twarda granica)

ROBI:
- Podpina Sanity do istniejącego, już zdeployowanego projektu Next.js.
- Tworzy DOKŁADNIE jedną kolekcję treści (do wyboru: `post` = blog albo `opinia` = opinie klientów).
- Stawia Sanity Studio pod adresem `/studio` na tej samej stronie (jeden adres, jeden login).
- Wciąga treść z Sanity na stronę i podpina pod istniejący design (tokeny z Karty Wizualnej, reguły anti-ai-look).
- Zapisuje stan do `PROGRESS.md` i robi commit po skończeniu.

NIE ROBI:
- Więcej niż jednej kolekcji (uczestnik nie projektuje schematu).
- Migracji istniejących, ręcznie wpisanych sekcji strony (hero, oferta, FAQ zostają w kodzie - Sanity to dodatek, nie przeprowadzka).
- Logowania, ról, wielu datasetów, niestandardowych wtyczek, GROQ "na zaawansowanego".
- Niczego destrukcyjnego bez jawnego "tak" uczestnika.

Jeśli uczestnik prosi o coś spoza tej listy - powiedz wprost, że to poza zakresem tego kroku, i że na razie trzymamy się jednej kolekcji, bo to ma działać u każdego tak samo i nie da się tego popsuć.

## Zasady komunikacji (trzymaj się bezwzględnie)

- Polski, polskie znaki z ogonkami zawsze. Nigdy długich myślników, tylko krótki "-".
- Formy męskie i żeńskie tam, gdzie zwracasz się do uczestnika (gotowy/gotowa, zrobiłeś/zrobiłaś).
- Wszystkie komendy podawaj w bloku kodu, GOTOWE DO SKOPIOWANIA. Nigdy "uruchom coś w stylu".
- Pytaj wyłącznie o treść biznesową (którą kolekcję, jakie teksty). Wszystkie decyzje techniczne podejmujesz sam - to golden path. Nigdy nie pytaj uczestnika o wybór techniczny.
- Maksymalnie jedno pytanie naraz, potem czekaj na odpowiedź.

## Guardraile (bezpieczeństwo - nie do złamania)

- Akcje nieodwracalne (`rm -rf`, `git reset --hard`, kasowanie datasetu/projektu, nadpisanie istniejącego pliku z treścią) - TYLKO po jawnym "tak" uczestnika. Domyślnie ich nie proponuj.
- Token Sanity i klucze idą WYŁĄCZNIE do `.env.local`. Sprawdź, że `.env.local` jest w `.gitignore`. NIGDY nie commituj `.env.local`.
- Przed każdym pushem przypomnij: te same nazwy zmiennych trzeba wkleić w panel Vercel (Settings -> Environment Variables), inaczej strona po deployu nie zobaczy treści.
- Najpierw sprawdzaj stan (czy projekt istnieje, czy jest na GitHub, czy zdeployowany), dopiero potem działaj. Skill można odpalić 2 razy bez szkody.

## Procedura (wykonaj po kolei)

### Krok 0 - sprawdzenie warunków wstępnych
1. Powitaj w 2 zdaniach: podpinamy panel do edycji treści, zajmie 15-25 minut, na końcu będziesz móc sam dodawać wpisy bez kodu.
2. Sprawdź, czy jesteś w katalogu projektu (jest `package.json` i folder `src/app`). Jeśli nie - poproś uczestnika, żeby otworzył Claude Code w folderze swojej strony.
3. Sprawdź, czy strona jest już zdeployowana (zajrzyj do `PROGRESS.md` - czy jest odhaczony deploy M6). Jeśli NIE jest - zatrzymaj się i powiedz: "Sanity podpinamy dopiero, gdy strona jest live. Najpierw skończ publikację (moduł M6), potem wróć do tego kroku". Nie idź dalej.
4. Upewnij się, że `git status` jest czysty (wszystko zacommitowane). Jeśli są niezapisane zmiany - zrób commit checkpointowy ZANIM ruszysz Sanity:
   ```bash
   git add -A && git commit -m "checkpoint: przed podpięciem Sanity"
   ```

### Krok 1 - wybór jednej kolekcji (jedyne pytanie o treść)
Zadaj DOKŁADNIE jedno pytanie i czekaj na odpowiedź:

> Co chcesz móc edytować samodzielnie? Wybierz jedno:
> A) Blog - wpisy z tytułem, datą i treścią
> B) Opinie klientów - cytat, imię, rola/firma

- Jeśli A - kolekcja `post`.
- Jeśli B - kolekcja `opinia`.
- Jeśli uczestnik chce obie - powiedz, że zaczynamy od jednej (ta ważniejsza), a drugą dołożymy potem tym samym skillem. Nie rób dwóch naraz.

Zapamiętaj wybór - przewija się przez całą resztę procedury.

### Krok 2 - projekt Sanity i token (decyzje techniczne robisz sam)
1. Zainstaluj zależności i uruchom konfigurator Sanity wbudowany w Next.js. Podaj uczestnikowi do skopiowania:
   ```bash
   npm install sanity next-sanity @sanity/vision @sanity/image-url styled-components
   ```
2. Uruchom kreator, który połączy projekt z Sanity (zaloguje przez przeglądarkę, utworzy projekt i dataset `production`):
   ```bash
   npx sanity@latest init --env
   ```
   Powiedz uczestnikowi wprost, czego się spodziewać: otworzy się przeglądarka, zaloguj się (Google albo GitHub), a gdy kreator zapyta o projekt - wybierz "Create new project", nazwij go jak swoją stronę, a przy dataset zostaw `production`. Wszystkie pozostałe pytania zostaw na domyślnych.
3. Po `init --env` sprawdź DWIE rzeczy, nie zakładaj struktury w ciemno:
   - czy w `.env.local` pojawiły się `NEXT_PUBLIC_SANITY_PROJECT_ID` i `NEXT_PUBLIC_SANITY_DATASET`. Jeśli czegoś brakuje - dopisz ręcznie (project ID znajdziesz na sanity.io/manage).
   - gdzie `init` położył pliki Sanity (config i ewentualny folder sanity), bo przy `--src-dir` może to być root albo `src/`:
     ```bash
     ls sanity.config.ts src/sanity.config.ts 2>/dev/null; ls -d src/sanity 2>/dev/null
     ```
   Zapamiętaj wynik - użyjesz go w Kroku 3 (gdzie tworzysz schema) i w Kroku 4 (jak zaimportować config). Nie licz `../` na sztywno, opieraj importy na aliasie `@/`.
4. Potwierdź, że `.env.local` jest w `.gitignore` (jeśli nie - dopisz linię `.env.local`). Guardrail: ten plik nigdy nie wchodzi do gita.

> Fallback: jeśli kreator się sypnie albo poprosi o coś nieoczywistego - poproś uczestnika, żeby skopiował CAŁĄ czerwoną treść z terminala i wkleił Ci ją tutaj. Przeczytasz błąd i podasz gotową naprawę po polsku.

### Krok 3 - schema (jedna kolekcja, sztywny przepis)
Decydujesz sam, uczestnik niczego nie projektuje. Utwórz pliki wg wybranej kolekcji. To prosty, sprawdzony schemat - nie dodawaj pól "na zapas".

Dla kolekcji `post` (blog) utwórz `src/sanity/schemaTypes/post.ts`:
```ts
import { defineField, defineType } from "sanity";

export const post = defineType({
  name: "post",
  title: "Wpis na blogu",
  type: "document",
  fields: [
    defineField({ name: "tytul", title: "Tytuł", type: "string", validation: (r) => r.required() }),
    defineField({ name: "slug", title: "Adres URL", type: "slug", options: { source: "tytul" }, validation: (r) => r.required() }),
    defineField({ name: "data", title: "Data publikacji", type: "datetime", validation: (r) => r.required() }),
    defineField({ name: "zajawka", title: "Zajawka (krótki opis)", type: "text", rows: 3 }),
    defineField({ name: "tresc", title: "Treść", type: "array", of: [{ type: "block" }] }),
  ],
});
```

Dla kolekcji `opinia` (opinie) utwórz `src/sanity/schemaTypes/opinia.ts`:
```ts
import { defineField, defineType } from "sanity";

export const opinia = defineType({
  name: "opinia",
  title: "Opinia klienta",
  type: "document",
  fields: [
    defineField({ name: "cytat", title: "Cytat", type: "text", rows: 4, validation: (r) => r.required() }),
    defineField({ name: "imie", title: "Imię i nazwisko", type: "string", validation: (r) => r.required() }),
    defineField({ name: "rola", title: "Rola / firma", type: "string" }),
    defineField({ name: "kolejnosc", title: "Kolejność wyświetlania", type: "number", initialValue: 1 }),
  ],
});
```

Utwórz `src/sanity/schemaTypes/index.ts`, który rejestruje TYLKO wybraną kolekcję (jedną):
```ts
import { post } from "./post";
// import { opinia } from "./opinia";

export const schema = { types: [post] };
```
(Zostaw aktywną tylko tę linię, która odpowiada wyborowi uczestnika. Druga zostaje zakomentowana - dołożymy ją, gdyby chciał drugą kolekcję.)

### Krok 4 - Studio pod /studio (panel w przeglądarce)

WAŻNE (rozjazd struktury): NIE zakładaj na sztywno, gdzie leży `sanity.config.ts` ani ile `../` trzeba w imporcie. `npx sanity init` z `--src-dir` mógł położyć config w roocie albo w `src/`. Najpierw SPRAWDŹ, gdzie faktycznie powstał config, i dopiero potem ustaw poprawny import - najlepiej przez alias `@/`, który nie zależy od liczby poziomów w górę.

1. Sprawdź, gdzie `init` położył config (uruchom z katalogu projektu):
   ```bash
   ls sanity.config.ts src/sanity.config.ts 2>/dev/null || echo "Brak sanity.config.ts - sprawdz wynik init"
   ```
   - Jeśli config jest w roocie (`./sanity.config.ts`) - import w trasie Studio przez alias: `@/../sanity.config`.
   - Jeśli config jest w `src/` (`src/sanity.config.ts`) - import przez alias: `@/../sanity.config` też zadziała, bo alias `@/*` wskazuje na `src/`, więc `@/sanity.config`. Dobierz wariant zgodnie z tym, co pokazał `ls`.
   - Jeśli `init` w ogóle nie utworzył configu - utwórz `sanity.config.ts` w roocie z poniższą treścią (import schematu też przez alias `@/`, nie przez `./src/...`):
   ```ts
   import { defineConfig } from "sanity";
   import { structureTool } from "sanity/structure";
   import { schema } from "@/sanity/schemaTypes";

   export default defineConfig({
     name: "default",
     title: "Panel mojej strony",
     projectId: process.env.NEXT_PUBLIC_SANITY_PROJECT_ID!,
     dataset: process.env.NEXT_PUBLIC_SANITY_DATASET!,
     basePath: "/studio",
     schema,
     plugins: [structureTool()],
   });
   ```
   Upewnij się, że config ma `basePath: "/studio"` i podpięty `schema` z kroku 3.
2. Utwórz trasę Studio w aplikacji: `src/app/studio/[[...tool]]/page.tsx`. Import configu przez ALIAS `@/`, nie przez liczenie `../` (to się rozjeżdża przy `--src-dir`). Wybierz ścieżkę aliasu zgodną z tym, gdzie config faktycznie leży (z punktu 1):
   ```tsx
   import { NextStudio } from "next-sanity/studio";
   // config w roocie projektu -> "@/../sanity.config"; config w src/ -> "@/sanity.config"
   import config from "@/../sanity.config";

   export const dynamic = "force-static";
   export { metadata, viewport } from "next-sanity/studio";

   export default function StudioPage() {
     return <NextStudio config={config} />;
   }
   ```
3. Powiedz uczestnikowi: panel będzie pod adresem Twojej strony z dopiskiem `/studio` (np. `twojadomena.pl/studio`). Logujesz się tym samym kontem co do Sanity. To Twoje prywatne zaplecze, nie widzi go odwiedzający stronę.
4. GUARDRAIL/fallback gdy `/studio` nie wchodzi (biała strona, 404, błąd importu `sanity.config`):
   - Najczęstsza przyczyna to zły import configu (nie ta liczba `../` albo zły wariant aliasu). Sprawdź ponownie `ls sanity.config.ts src/sanity.config.ts` i dopasuj import w `page.tsx` do realnej lokalizacji.
   - Sprawdź, że plik trasy to dokładnie `src/app/studio/[[...tool]]/page.tsx` (podwójne nawiasy kwadratowe i `...tool`).
   - Jeśli błąd dotyczy `schema` - upewnij się, że `src/sanity/schemaTypes/index.ts` istnieje i eksportuje `schema`, a config importuje go przez alias `@/sanity/schemaTypes`, nie ścieżką względną.
   - Jeśli dalej nie wchodzi - skopiuj cały czerwony komunikat z terminala/przeglądarki i wklej tutaj, podam dokładną poprawkę po polsku.

### Krok 5 - połączenie strony z treścią (client + zapytanie)
1. Utwórz klienta Sanity `src/sanity/client.ts`:
   ```ts
   import { createClient } from "next-sanity";

   export const client = createClient({
     projectId: process.env.NEXT_PUBLIC_SANITY_PROJECT_ID!,
     dataset: process.env.NEXT_PUBLIC_SANITY_DATASET!,
     apiVersion: "2024-01-01",
     useCdn: true,
   });
   ```
2. Podepnij treść do strony zgodnie z wyborem:
   - `post` (blog): utwórz stronę listy `src/app/blog/page.tsx`, która pobiera wpisy zapytaniem GROQ `*[_type == "post"] | order(data desc){ tytul, "slug": slug.current, data, zajawka }` i renderuje je. Jeśli w kontekście istnieje strona pojedynczego wpisu - dodaj `src/app/blog/[slug]/page.tsx`.
   - `opinia` (opinie): pobierz `*[_type == "opinia"] | order(kolejnosc asc){ cytat, imie, rola }` i wstaw do istniejącej sekcji opinii na stronie głównej (zamień zahardkodowane opinie na te z Sanity). Jeśli sekcji opinii nie ma - utwórz ją.
3. WAŻNE (anti-ai-look): nowy widok ma używać WYŁĄCZNIE zmiennych CSS z Karty Wizualnej i istniejących bloków, dokładnie jak reszta strony. Zero nowych kolorów, zero fioletowo-niebieskich gradientów, zero gridu identycznych kart z tym samym hover, `text-balance` na nagłówkach, font pairing jak w projekcie. Ma wyglądać jak część tej samej strony, nie jak nowa zlepka.

### Krok 6 - lokalny test PRZED wysłaniem
1. Uruchom dewelopersko i każ uczestnikowi sprawdzić oba adresy:
   ```bash
   npm run dev
   ```
   Niech wejdzie na `localhost:3000/studio` (powinno wstać Studio do logowania) oraz na widok treści (`/blog` albo sekcję opinii).
2. Niech doda w Studio JEDEN testowy wpis/opinię i kliknie Publish, a potem odświeży widok na stronie. Jeśli treść się pokazała - działa.
3. Zatrzymaj dev (`Ctrl+C`) i zrób pełny build, żeby nie było niespodzianki na Vercel:
   ```bash
   rm -rf .next && npm run build
   ```
   Guardrail: jeśli build nie przejdzie - NIE wysyłaj dalej. Skopiuj błąd, napraw, zbuduj ponownie. Dopiero zielony build idzie do gita.

> Fallback przy każdym błędzie: skopiuj całą czerwoną treść z terminala i wklej ją tutaj. Naprawię i wytłumaczę po polsku, co to było.

### Krok 7 - deploy treści live (env w Vercel)
1. Zacommituj i wypchnij (commit = checkpoint):
   ```bash
   git add -A && git commit -m "sanity: panel /studio + kolekcja treści" && git push
   ```
2. Przypomnij wprost i poczekaj na potwierdzenie: w panelu Vercel (Settings -> Environment Variables) muszą być te same zmienne co w `.env.local`:
   - `NEXT_PUBLIC_SANITY_PROJECT_ID`
   - `NEXT_PUBLIC_SANITY_DATASET`
   Jeśli ich tam nie ma - strona po deployu nie zobaczy treści. Niech uczestnik je wklei i kliknie redeploy (albo poczeka na auto-deploy z `push`).
3. Po deployu niech wejdzie na `swojadomena.pl/studio`, doda treść i sprawdzi ją na żywej stronie. Od teraz edytuje sam, bez Claude Code.

### Krok 8 - zapis stanu i zamknięcie
1. Zaktualizuj `PROGRESS.md`: odhacz "M7 Sanity podpięty", zapisz którą kolekcję wybrano i że Studio jest pod `/studio`. Dopisz w sekcji decyzji: env w Vercel ustawione TAK/NIE.
2. Podsumuj 1-2 zdaniami: masz panel pod `/studio`, edytujesz treść w przeglądarce, zmiany pojawiają się na stronie bez ruszania kodu.
3. Powiedz, co dalej: jeśli kiedyś zechcesz drugą kolekcję (np. dołożyć opinie do bloga) - odpal ten skill jeszcze raz, wykryje istniejące Sanity i dołoży tylko nową kolekcję. Codzienne zmiany treści robisz już sam w `/studio`.

## Jak co najwyżej naprawić (uniwersalny fallback)
Jeśli na którymkolwiek kroku zobaczysz czerwony tekst w terminalu albo w przeglądarce - skopiuj go w CAŁOŚCI i wklej do Claude Code z prośbą: "napraw ten błąd i wyjaśnij mi po polsku, co to było". Najczęstsze przypadki:
- "projectId not set" / treść się nie pokazuje na live -> brakuje zmiennych w panelu Vercel (Krok 7 pkt 2).
- Studio prosi o logowanie w kółko -> to normalne za pierwszym razem, zaloguj się tym samym kontem co do Sanity.
- "CORS" / "not allowed origin" przy zapisie -> wejdź na sanity.io/manage -> projekt -> API -> CORS origins i dodaj adres swojej strony (`https://twojadomena.pl`). Jeśli nie wiesz jak - wklej mi komunikat, podam dokładnie co kliknąć.
