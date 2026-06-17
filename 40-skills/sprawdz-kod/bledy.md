# bledy.md - pełna lista błędów buildu Next.js + gotowe poprawki

Otwierasz ten plik, gdy `npm run build` zfailował i trzeba dopasować błąd do poprawki. Czytaj komunikat, znajdź wzorzec, napraw minimalnie, zbuduj ponownie. Jeden błąd naraz - bierz pierwszy od góry, reszta to często skutki uboczne.

Po każdej naprawie powiedz uczestnikowi jednym zdaniem, co to było.

---

## 1. Brak `'use client'`
**Komunikat:** "You're importing a component that needs `useState`/`useEffect`/`onClick`... mark the file with `'use client'`" albo "useState is not a function" w komponencie serwerowym.
**Czemu:** w Next.js App Router komponent jest domyślnie serwerowy. Interaktywność (stan, kliknięcia, hooki) wymaga komponentu klienckiego.
**Fix:** dodaj jako PIERWSZĄ linię pliku (przed importami):
```tsx
'use client'
```
**Po ludzku:** "Ta sekcja jest klikalna, więc musi działać po stronie przeglądarki. Dopisałem jedną linię, która to włącza."

## 2. Błąd typu TypeScript
**Komunikat:** "Type 'X' is not assignable to type 'Y'" / "Property 'X' does not exist on type".
**Czemu:** props bez typu, zła nazwa pola albo wartość niezgodna z oczekiwanym typem.
**Fix:** dodaj typ propsa lub popraw nazwę zgodnie z komunikatem. Przykład typu propsów:
```tsx
type Props = { title: string; href: string }
export function CTA({ title, href }: Props) { /* ... */ }
```
Nie używaj `any` na siłę - popraw realny typ. `any` tylko gdy nic innego nie ratuje builda w terminie.

## 3. Brakujący import
**Komunikat:** "Cannot find name 'X'" / "'X' is not defined".
**Czemu:** użyto komponentu, ikony albo funkcji bez zaimportowania.
**Fix:** dopisz import na górze pliku. Przykłady:
```tsx
import { ArrowRight } from "lucide-react"
import { Button } from "@/components/ui/button"
```

## 4. Default vs nazwany eksport
**Komunikat:** "Module has no default export" / "does not contain a default export" / "Attempted import error".
**Czemu:** importujesz `import X from "..."`, a plik eksportuje nazwany (`export function X`) - albo odwrotnie.
**Fix:** dopasuj import do eksportu:
```tsx
// gdy plik ma: export function Hero() {...}
import { Hero } from "@/components/Hero"
// gdy plik ma: export default function Hero() {...}
import Hero from "@/components/Hero"
```

## 5. Apostrof / cudzysłów w tekście JSX
**Komunikat:** "`'` can be escaped with `&apos;`" / "react/no-unescaped-entities".
**Czemu:** polski tekst z `'` lub `"` wpisany wprost w JSX.
**Fix:** najprościej opakuj tekst w nawias klamrowy ze stringiem:
```tsx
<p>{"Twórca, który nie chce \"gadać z czatem\", tylko mieć system"}</p>
```
albo zamień znak na encję: `&apos;` (apostrof), `&quot;` (cudzysłów).

## 6. `metadata` w pliku z `'use client'`
**Komunikat:** "You are attempting to export metadata from a component marked with 'use client'".
**Czemu:** `export const metadata` działa tylko w komponencie serwerowym.
**Fix:** przenieś `export const metadata` do pliku BEZ `'use client'` (zwykle `layout.tsx` albo `page.tsx` serwerowy). Interaktywną część zostaw w osobnym komponencie klienckim.

## 7. `<img>` blokowany przez ESLint w buildzie
**Komunikat:** "Do not use `<img>`. Use `<Image />` from `next/image`" (`@next/next/no-img-element`).
**Czemu:** Next.js woli `next/image`.
**Fix (kurs):** najpewniejsze - zamień na `next/image` z wymiarami:
```tsx
import Image from "next/image"
<Image src="/foto.jpg" alt="Opis po polsku" width={1200} height={800} />
// albo w kontenerze z position relative:
<Image src="/foto.jpg" alt="Opis" fill className="object-cover" />
```
Jeśli to tylko ostrzeżenie (warning), a nie błąd - build przejdzie, zostaw.

## 8. Nieużyta zmienna / import blokuje build
**Komunikat:** "'X' is defined but never used" (`@typescript-eslint/no-unused-vars`).
**Czemu:** zaimportowano coś, czego sekcja ostatecznie nie używa.
**Fix:** usuń nieużyty import lub zmienną. Nie dopisuj kodu "żeby coś użyć".

---

## Błędy spoza listy (fallback)

Jeśli komunikat nie pasuje do żadnego z 8:
1. Weź NAJWYŻSZY błąd z logów (pierwszy od góry). Reszta to często skutki.
2. Przeczytaj go w całości i wytłumacz uczestnikowi po polsku, co znaczy.
3. Zastosuj NAJMNIEJSZĄ możliwą zmianę, która go usuwa. Nie przepisuj całych plików.
4. Zbuduj ponownie: `rm -rf .next && npm run build`. Powtarzaj aż zielono.
5. Jeśli utknąłeś - poproś uczestnika o skopiowanie całego czerwonego tekstu i czytaj go dosłownie. Czerwony tekst to instrukcja, nie katastrofa.

GUARDRAIL: żadnych `git reset --hard`, `rm -rf` poza `.next`, ani nadpisywania całych plików bez jawnego "tak" uczestnika. Naprawiamy chirurgicznie.
