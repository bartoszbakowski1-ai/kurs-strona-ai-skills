# Conversion framework dla `/lp`

Ten plik czytaj przed projektowaniem landing page. Traktuj go jak checklistę senior product/conversion designera.

## 1. Zasada główna

Landing page ma jeden cel i jedną główną akcję. Wszystko, co nie wspiera tej akcji, usuń albo przenieś niżej.

Dobre LP odpowiada szybko:

- Czy to jest dla mnie?
- Co dostanę?
- Dlaczego mam zaufać?
- Co mam zrobić teraz?
- Ile mnie to kosztuje: pieniędzy, czasu, uwagi albo ryzyka?

## 2. Above the fold

Pierwszy ekran ma sprzedawać dalsze czytanie i dawać możliwość konwersji. Nie zakładaj, że użytkownik przewinie.

### Webinar / live / zapis

Above the fold musi zawierać:

- temat wydarzenia,
- dla kogo jest wydarzenie,
- konkretną obietnicę lub rezultat,
- datę i godzinę, jeśli są znane,
- CTA zapisu albo formularz,
- pierwszy trust signal: prowadzący, doświadczenie, liczba osób, proof, demo, marka, konkret procesu,
- delikatny sygnał, że niżej jest więcej treści, żeby ekran nie wyglądał jak koniec strony.

Przykład CTA:

- "Zapisz się na live"
- "Chcę dostęp do replaya"
- "Odbierz link do webinaru"

Nie używaj CTA typu "Start", "Get started", "Dowiedz się więcej", jeśli można powiedzieć konkretnie, co stanie się po kliknięciu.

### Sprzedaż / kurs / usługa

Above the fold musi zawierać:

- co jest sprzedawane,
- dla kogo,
- jaki rezultat albo zmiana,
- cena lub wejście do zakupu, jeśli cena jest publiczna,
- CTA zakupu albo rozmowy,
- proof albo proof substitute.

Jeśli cena nie jest znana, nie wymyślaj jej. Użyj "Cena do potwierdzenia" albo CTA do rozmowy.

### Lead magnet / lista oczekujących

Above the fold musi zawierać:

- nazwę materiału albo listy,
- komu pomaga,
- co osoba dostanie po zapisie,
- minimalny formularz,
- informację, kiedy materiał przyjdzie albo co wydarzy się dalej.

## 3. Układ

Projektuj od mobile:

- na mobile hero ma szybko dojść do CTA, bez gigantycznego pustego obrazu,
- na desktopie używaj silnej hierarchii: treść + akcja + media/proof,
- unikaj układu "same identyczne karty po 3 w rzędzie",
- unikaj pełnej symetrii w każdej sekcji,
- hero może być split, ale CTA musi być widoczne bez przewijania,
- nie wkładaj całego hero do dekoracyjnej karty,
- nie dodawaj rozbudowanej nawigacji na LP z reklamy.

## 4. Sekwencja sprzedażowa

Najczęściej użyj takiej kolejności:

1. Hero z obietnicą, CTA i trust signal.
2. Problem lub sytuacja odbiorcy.
3. Co dostajesz i dlaczego to jest konkretne.
4. Mechanizm: jak to działa, dlaczego to nie jest kolejna obietnica.
5. Program, zakres albo agenda.
6. Proof: opinie, screeny, portfolio, liczby, doświadczenie.
7. CTA / formularz.
8. FAQ i obiekcje.
9. Finalne CTA.

Nie każda strona potrzebuje wszystkich sekcji, ale każda potrzebuje jasnej drogi do akcji.

## 5. Proof i proof substitute

Nie wymyślaj dowodów. Jeśli brakuje opinii albo liczb, użyj:

- konkretnych deliverables,
- procesu krok po kroku,
- doświadczenia prowadzącego,
- screenów z produktu lub materiału,
- fragmentu demo,
- realnych ograniczeń i warunków,
- precyzyjnego "dla kogo / nie dla kogo".

Oznacz braki jako `[do potwierdzenia]`, jeśli użytkownik musi dostarczyć dane.

## 6. Anti-AI-look

Flagi do poprawy:

- generyczny gradient fiolet-niebieski,
- nagłówki typu "Unlock your potential",
- CTA bez konkretu,
- identyczne karty i identyczne ikony w każdej sekcji,
- brak realnych zdjęć, screenów albo assetów,
- puste proofy typu "100% satysfakcji",
- zbyt wielki hero, który spycha CTA poza pierwszy ekran,
- desktop wygląda dobrze, ale mobile ukrywa akcję.

Dobre media dla LP:

- twarz prowadzącego,
- screen produktu, kursu, panelu, Notion, GitHuba, aplikacji,
- zdjęcia z warsztatu lub pracy,
- screen opinii,
- zdjęcie materiału, który osoba dostaje,
- realny mockup tylko wtedy, gdy pokazuje prawdziwy produkt.

## 7. Formularz i bezpieczeństwo

Formularz ma zbierać tylko to, co potrzebne. Dla webinaru zwykle wystarczy imię i email.

Sprawdź:

- walidację po stronie serwera,
- honeypot albo lekki antyspam,
- generyczny komunikat błędu,
- brak logowania kluczy i pełnych danych użytkownika,
- brak prawdziwych sekretów w kodzie,
- brak `NEXT_PUBLIC_*` dla sekretów,
- `.env.local` w `.gitignore`.

## 8. Końcowa checklista LP

Przed raportem końcowym odpowiedz:

- Czy jest dokładnie jeden główny cel?
- Czy CTA albo formularz jest above the fold na desktopie?
- Czy CTA albo formularz jest above the fold albo bardzo blisko pierwszego ekranu na mobile?
- Czy CTA mówi konkretnie, co osoba zrobi lub dostanie?
- Czy nie ma rozpraszającej nawigacji?
- Czy proof jest realny albo uczciwie zastąpiony konkretem?
- Czy strona ma realne media albo listę konkretnych assetów do podmiany?
- Czy formularz/link działa?
- Czy build przechodzi?
- Czy nie ma publicznych sekretów, kluczy API ani ryzykownych env vars?

## Źródła zasad

Framework opiera się na praktykach z NN/g dotyczących uwagi użytkownika i znaczenia pierwszego ekranu, NN/g dotyczących konkretnych CTA zamiast generycznego "Get started", CXL dotyczących skupionych landing pages pod jedną akcję oraz dokumentacji Claude Skills dotyczącej progressive loading.
