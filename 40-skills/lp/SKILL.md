---
name: lp
description: 'Użyj po zbudowaniu rdzenia strony-systemu, gdy użytkownik chce dodać do systemu JEDEN konwertujący landing page (podstronę) pod jeden cel: zapis na webinar/live, sprzedaż kursu lub usługi, lista oczekujących, lead magnet, konsultacja, przedsprzedaż albo kampania reklamowa. Wywołaj na hasła "zrób landing", "nowy LP", "landing pod webinar", "landing pod sprzedaż", "strona zapisu", "LP pod kampanię", "/lp". Buduje jedną skupioną stronę konwersyjną w istniejącym projekcie Next.js, używa istniejącego design systemu, pilnuje CTA/formularza above the fold, jednego celu, jednego CTA, anti-ai-look, mobile, formularza/Resend gdy potrzebny, braku sekretów/API keys i kontroli sprawdz-kod. NIE buduje całego serwisu i NIE wymyśla dowodów.'
---

# Skill: lp

Buduj JEDEN landing page pod JEDEN cel. Użytkownik jest nietechniczny. Ma powiedzieć, po co jest landing i dla kogo. Ty decydujesz o route, komponentach, formularzu, strukturze kodu, responsywności i kontroli jakości.

Najważniejsza zasada: **jeden cel, jedno CTA, zero rozpraszaczy**.

Przed projektowaniem LP przeczytaj `references/conversion-framework.md`. To jest obowiązkowy brief jakościowy dla układu, above the fold, proofów, CTA, mobile i checklisty antygenerycznej.

## Zakres

ROBI:
- tworzy pojedynczy landing page w istniejącym projekcie Next.js,
- dobiera typ LP: webinar/live, sprzedaż, lead magnet, waitlist, konsultacja,
- używa istniejących kart, kontekstu i design tokenów,
- prowadzi użytkownika krótkim wywiadem biznesowym,
- projektuje hero z CTA albo formularzem above the fold,
- dodaje formularz zapisu/kontaktu, jeśli cel tego wymaga,
- aktualizuje `PROGRESS.md`, jeśli projekt go używa,
- uruchamia albo rekomenduje kontrolę przez `sprawdz-kod`.

NIE ROBI:
- nie przebudowuje całej strony,
- nie zmienia globalnego design systemu bez wyraźnej potrzeby,
- nie tworzy wielu równorzędnych CTA,
- nie zmyśla opinii, liczb, wyników, terminów ani obietnic,
- nie publikuje na Vercel bez jasnej zgody,
- nie commituje `.env.local` ani żadnych sekretów.

## Krok 0 - samodiagnoza

Najpierw sprawdź:

1. Czy to projekt Next.js (`package.json`, `app/` albo `src/app/`).
2. Czy istnieje `kontekst/`, `karty/` albo inne materiały strategiczne.
3. Czy istnieje system designu w `globals.css` albo inny jasny plik stylów.
4. Czy jest `PROGRESS.md`.
5. Czy `git status` jest bezpieczny i nie nadpisujesz cudzych zmian.

Jeśli brakuje fundamentu, nie buduj w ciemno. Powiedz po ludzku, co trzeba uzupełnić. Minimalnie do LP wystarcza: cel, grupa docelowa, oferta/wydarzenie/materiał, CTA i styl strony.

## Krok 1 - wywiad minimalny

Zadaj pytania pojedynczo. Nie dawaj ankiety na 20 punktów.

Wymagane:

1. Jaki jest jeden cel landing page?
2. Dla kogo jest ten landing?
3. Co osoba dostaje po kliknięciu, zapisie albo zakupie?
4. Jak ma brzmieć jedno CTA?
5. Jaki adres podstrony ma mieć LP, jeśli użytkownik ma preferencję?

Dla webinaru/live dopytaj też o temat, datę, godzinę i czy będzie replay. Jeśli brakuje godziny, oznacz ją jako `[do potwierdzenia]`, ale nie usuwaj informacji o terminie z hero.

Dla sprzedaży dopytaj o ofertę, cenę albo model płatności, główny rezultat i najważniejszy dowód zaufania. Nie wymyślaj proofów.

Jeśli użytkownik nie wie, zaproponuj 2-3 opcje i poproś o wybór.

## Krok 2 - plan przed kodem

Zanim napiszesz kod, pokaż krótki plan:

- route, np. `/webinar`, `/live`, `/ebook`, `/konsultacja`, `/waitlist`,
- jeden cel i jedno CTA,
- typ LP,
- układ above the fold,
- sekcje,
- czy będzie formularz,
- jakie dane zbiera formularz,
- jakie pliki prawdopodobnie zmienisz.

Jeśli landing jest demo na live, przyjmij rozsądne domysły, nazwij je jasno i przejdź do działania.

## Krok 3 - struktura landing page

Domyślna kolejność:

1. **Hero konwersyjne** - konkretna obietnica, dla kogo, termin/cena jeśli dotyczy, pierwszy trust signal i CTA albo formularz above the fold.
2. **Problem / sytuacja** - 2-3 zdania językiem odbiorcy.
3. **Co dostajesz** - 3-5 konkretnych punktów.
4. **Program / przebieg** - obowiązkowe dla webinaru/live/warsztatu.
5. **Mechanizm / dlaczego to działa** - pokaż proces, nie tylko obietnicę.
6. **Dowody** - tylko realne: opinie, liczby, screeny, case, doświadczenie, portfolio, demo.
7. **Formularz albo CTA** - minimalne pola, jasny komunikat sukcesu.
8. **FAQ / obiekcje** - 3-5 realnych wątpliwości.
9. **Finalne CTA** - ta sama akcja co w hero.

Nie wszystkie sekcje są obowiązkowe. Usuń te, dla których nie ma materiału, ale nie usuwaj hero, CTA, proofu zastępczego i finalnego CTA.

## Krok 4 - implementacja

Zasady:

- Ustal, czy projekt ma `app/` czy `src/app/`, i trzymaj się istniejącego wzorca.
- Stwórz route jako folder, np. `src/app/webinar/page.tsx`.
- Jeśli projekt ma komponenty UI, użyj ich zamiast pisać wszystko od zera.
- Używaj zmiennych z `globals.css` / design systemu.
- Nie hardkoduj sekretów.
- Jeśli dodajesz formularz, bazuj na wzorcu z `40-skills/zbuduj-strone/formularz.md`.
- Jeśli formularz ma wysyłać maile, wymagaj env vars i przygotuj `.env.local.example`, ale nie wpisuj prawdziwych wartości.
- Nie dodawaj rozbudowanej nawigacji na kampanijnym LP, jeśli nie ma mocnego powodu.
- Nie chowaj CTA pod długą sekcją hero ani wielkim obrazem.

Po większym kroku aktualizuj `PROGRESS.md`, jeśli istnieje. Commituj dopiero po działającym checkpointcie albo po wyraźnej zgodzie użytkownika.

## Krok 5 - anti-ai-look i media

Przed końcem sprawdź:

- Czy hero ma konkret, a nie ogólne hasło?
- Czy jest jeden dominujący CTA?
- Czy CTA albo formularz jest above the fold na desktopie i mobile?
- Czy strona ma realne media albo jasne placeholdery do wymiany?
- Czy nie ma fioletowo-niebieskiego generycznego gradientu?
- Czy nie ma samych ikon zamiast dowodów?
- Czy tekst pasuje do grupy docelowej?
- Czy mobile nie rozjeżdża layoutu?

Jeśli brakuje mediów, zaproponuj minimum 3 konkretne assety do dodania. Dla LP sprzedażowego lub webinarowego preferuj realne zdjęcia osoby, produktu, warsztatu, screeny narzędzia, screeny opinii albo kadry z materiału.

## Krok 6 - kontrola

Na koniec uruchom albo zaproponuj:

```plain text
Uruchom skill sprawdz-kod dla nowego landing page. Sprawdź build, mobile, formularz, anti-ai-look, brak sekretów/API keys i podstawowe bezpieczeństwo.
```

Raport końcowy ma być prosty:

- co powstało,
- pod jakim adresem lokalnym,
- jakie pliki zmieniono,
- co trzeba uzupełnić przed publikacją,
- czy można deployować.

## Tryb demo na live

Jeśli użytkownik mówi, że to demo na live:

1. Nie zadawaj długiego wywiadu.
2. Weź cel z jednego zdania albo z pliku `examples/brief-lp-live.md`, jeśli istnieje.
3. Domyślnie zrób LP pod webinar/live/zapis.
4. Stwórz szybko route i 5-6 sekcji.
5. Użyj obecnego designu.
6. W hero pokaż CTA albo formularz above the fold.
7. Zostaw miejsca `[do potwierdzenia]` tylko tam, gdzie brakuje realnych danych.
8. Na końcu pokaż, jak łatwo później wymienić treść, datę, CTA albo formularz.

Przykład promptu:

```plain text
Uruchom skill lp. To demo na live. Na podstawie pliku examples/brief-lp-live.md zrób landing pod live "Stwórz stronę z AI". Celem jest zapis na listę zainteresowanych kursem. Użyj obecnego designu, jednego CTA "Chcę dostęp", formularza imię + email, jeśli projekt ma wzorzec formularza, i sekcji: hero z CTA above the fold, dla kogo, co zbudujesz, co jest w pakiecie, FAQ, finalne CTA.
```
