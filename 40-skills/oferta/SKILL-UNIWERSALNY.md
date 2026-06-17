---
name: oferta
description: Użyj po zbudowaniu podstawowej strony, gdy użytkownik chce stworzyć JEDNĄ spersonalizowaną stronę oferty dla konkretnego klienta na podstawie transkrypcji rozmowy, notatek, briefu albo maila. Wywołaj na hasła "zrób ofertę z rozmowy", "oferta z transkrypcji", "stwórz ofertę dla klienta", "strona oferty dla [klient]", "/oferta". Czyta materiał źródłowy, wyciąga sytuację klienta jego słowami, oznacza braki jako [do potwierdzenia], buduje route `/oferta/[slug]` lub inny uzgodniony adres w istniejącym projekcie Next.js, używa design systemu, jednego CTA i anti-ai-look. NIE zmyśla liczb, wyników, zakresu ani ceny.
---

# Skill: oferta

Buduj JEDNĄ spersonalizowaną stronę oferty dla konkretnego klienta. Materiałem źródłowym jest transkrypcja rozmowy, notatki, brief, mail od klienta albo mieszanka tych rzeczy.

Najważniejsza zasada: **oferta ma brzmieć, jakby użytkownik naprawdę usłyszał klienta**. Używaj słów klienta. Nie zmyślaj.

## Zakres

ROBI:
- czyta materiał źródłowy w całości,
- wyciąga sytuację klienta, problem, cel, zakres, ograniczenia, termin, budżet i cytaty,
- układa spersonalizowaną stronę oferty,
- buduje route w istniejącym projekcie Next.js,
- używa design systemu i anti-ai-look,
- dodaje jedno CTA,
- może dodać formularz kontaktu/akceptacji, jeśli projekt ma skonfigurowany formularz,
- aktualizuje `PROGRESS.md`, jeśli projekt go używa,
- uruchamia albo rekomenduje kontrolę przez `sprawdz-kod`.

NIE ROBI:
- nie wymyśla ceny, jeśli nie została podana,
- nie wymyśla case studies, wyników ani referencji,
- nie obiecuje rezultatów, których nie ma w materiale źródłowym,
- nie robi CRM, podpisu elektronicznego ani panelu klienta,
- nie deployuje bez zgody,
- nie commituje `.env.local` ani sekretów.

## Krok 0 - samodiagnoza

Sprawdź:

1. Czy to projekt Next.js (`package.json`, `app/` albo `src/app/`).
2. Czy istnieje design system albo `globals.css`.
3. Czy masz materiał źródłowy: transkrypcję, notatki, brief albo mail.
4. Czy `git status` jest bezpieczny i nie nadpisujesz cudzych zmian.

Jeśli brakuje materiału źródłowego, poproś jednym zdaniem:

```plain text
Podaj ścieżkę do transkrypcji/notatek albo wklej materiał rozmowy, z którego mam zrobić ofertę.
```

## Krok 1 - czytanie materiału

Przeczytaj materiał w całości. Potem pokaż użytkownikowi krótki wyciąg:

- klient: imię, firma, branża,
- sytuacja teraz,
- główny problem,
- cel,
- oczekiwany zakres,
- ograniczenia i ryzyka,
- budżet/termin, tylko jeśli padły,
- 2-3 cytaty klienta,
- braki oznaczone jako `[do potwierdzenia]`.

Nie przechodź do kodu, jeśli nie wiadomo, co jest ofertą. Zapytaj maksymalnie o 3 najważniejsze braki:

- cena albo model rozliczenia,
- zakres,
- główne CTA.

## Krok 2 - jedna decyzja: CTA

Ustal jedno CTA:

- "Akceptuję ofertę",
- "Umówmy wdrożenie",
- "Chcę zacząć",
- "Porozmawiajmy o zakresie",
- inne, jeśli użytkownik poda.

Jedna oferta = jedna główna akcja. Nie dawaj kilku równorzędnych dróg typu "kup", "umów call", "napisz maila", "zobacz portfolio" w tym samym poziomie hierarchii.

## Krok 3 - plan strony

Domyślna route:

```plain text
/oferta/[slug-klienta]
```

Przykład:

```plain text
/oferta/anna-kowalczyk
```

Jeśli projekt ma inną strukturę, dopasuj się do niej. Nie wpisuj żadnej stałej domeny w skillu. Domena jest decyzją projektu i deploya, nie skilla.

Domyślne sekcje:

1. **Hero personalizowane** - dla kogo jest oferta, jaki rezultat ma dowieźć i jedno CTA.
2. **Co zrozumiałem z rozmowy** - echo sytuacji klienta jego słowami.
3. **Diagnoza** - dlaczego obecny problem blokuje cel klienta.
4. **Proponowane rozwiązanie** - co robimy i dlaczego to pasuje do rozmowy.
5. **Zakres prac** - konkretne deliverables.
6. **Proces i terminy** - etapy, jeśli są znane.
7. **Cena / model współpracy** - tylko gdy podane; inaczej `[do potwierdzenia]`.
8. **Dlaczego my / dlaczego ja** - realne dowody albo krótka wiarygodność.
9. **FAQ / obiekcje** - 3-5 realnych wątpliwości.
10. **Finalne CTA** - ta sama akcja co w hero.

## Krok 4 - implementacja

Zasady:

- Ustal `app/` vs `src/app/` i trzymaj się projektu.
- Użyj istniejących komponentów i stylów.
- Nie hardkoduj sekretów.
- Nie dodawaj wielu wariantów oferty naraz.
- Oznacz braki w treści jako `[do potwierdzenia]`, ale ogranicz je do minimum.
- Jeśli oferta ma być prywatna, dodaj ostrzeżenie w raporcie: publiczny URL nie jest zabezpieczeniem. Prywatność wymaga ochrony hasłem, auth, ograniczenia dostępu albo świadomego wysłania linku tylko do klienta.
- Jeśli dodajesz formularz akceptacji, sprawdź walidację serwerową, honeypot, generyczne błędy i brak sekretów w kodzie.

Po większym kroku aktualizuj `PROGRESS.md`, jeśli istnieje. Commituj dopiero po działającym checkpointcie albo po wyraźnej zgodzie użytkownika.

## Krok 5 - język

Oferta ma być:

- konkretna,
- spokojna,
- oparta na słowach klienta,
- bez przesadnych obietnic,
- bez żargonu, którego klient nie użył,
- z jasnym zakresem i następnym krokiem.

Unikaj:

- "kompleksowo", "innowacyjnie", "szyte na miarę" bez konkretu,
- sztucznego tonu korporacyjnego,
- dopisywania problemów, których klient nie powiedział,
- obietnic gwarantowanego wyniku,
- cen i terminów wymyślonych "bo pasują".

## Krok 6 - kontrola

Na koniec uruchom albo zaproponuj:

```plain text
Uruchom skill sprawdz-kod dla strony oferty. Sprawdź build, mobile, anti-ai-look, brak sekretów i czy oferta nie zawiera zmyślonych danych.
```

Raport końcowy:

- adres lokalny oferty,
- jakie dane pochodzą z rozmowy,
- co jest `[do potwierdzenia]`,
- jakie pliki zmieniono,
- czy można wysłać link klientowi,
- czy oferta wymaga zabezpieczenia przed publicznym dostępem.

## Tryb demo na live

Jeśli użytkownik mówi, że to demo na live:

1. Użyj przykładowych notatek albo pliku `examples/rozmowa-klient-przyklad.md`, jeśli istnieje.
2. Pokaż najpierw wyciąg z rozmowy w 5 punktach.
3. Zbuduj route `/oferta/anna-kowalczyk` albo slug z materiału.
4. Oznacz cenę i zakres jako `[do potwierdzenia]`, jeśli nie są jasne.
5. Pokaż, że oferta powstaje z rozmowy, a nie z pustego promptu.
6. Nie wpisuj stałej domeny prowadzącego do kodu.

Przykład promptu:

```plain text
Uruchom skill oferta. To demo na live. Na podstawie pliku examples/rozmowa-klient-przyklad.md zrób spersonalizowaną stronę oferty dla Anny. Nie zmyślaj danych. Użyj obecnego designu, route /oferta/anna-kowalczyk i jedno CTA "Porozmawiajmy o wdrożeniu".
```
