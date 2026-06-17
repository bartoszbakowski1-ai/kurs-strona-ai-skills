# Live demo - LP i oferta

Ten plik jest dla prowadzącego live. Nie jest wymagany do przejścia kursu.

## Teza demo

Po kursie uczestnik nie ma tylko jednej strony. Ma system, w którym może prosić Claude Code o kolejne rzeczy:

- nowy landing page pod kampanię,
- spersonalizowaną ofertę dla klienta,
- nową podstronę,
- szybką zmianę tekstu,
- kontrolę przed publikacją.

Najważniejsze zdanie:

```text
Nie kupujesz tylko lekcji. Dostajesz system pracy z Claude Code: dokumenty, skille, prompty i proces, który pozwala zbudować stronę, a potem robić kolejne landing page'e i oferty bez zaczynania od zera.
```

## Skille pokazowe

Aktywne skille są tutaj:

- `40-skills/lp/SKILL.md`
- `40-skills/oferta/SKILL.md`

Kopie robocze są zsynchronizowane obok:

- `40-skills/lp/SKILL-UNIWERSALNY.md`
- `40-skills/oferta/SKILL-UNIWERSALNY.md`

Do kursu i GitHuba idą aktywne `SKILL.md`.

## Demo 1 - nowy landing page

Cel: pokazać, że z istniejącej strony można szybko zrobić LP pod konkretną kampanię.

Plik pomocniczy:

```plain text
examples/brief-lp-live.md
```

Prompt:

```plain text
Uruchom skill lp.

To demo na live. Na podstawie pliku examples/brief-lp-live.md zrób landing page pod zapis na live "Stwórz stronę z AI".

Cel: pokazać uczestnikom, że po kursie mogę szybko stworzyć nowy landing pod kampanię.

Wymagania:
- jeden route: /live-strona-ai
- jeden główny cel: zapis na live albo replay
- jedno CTA: "Chcę dostęp"
- CTA albo formularz musi być above the fold na desktopie i mobile
- above the fold ma zawierać: temat, dla kogo, obietnicę, termin, CTA i pierwszy trust signal
- formularz: imię + email, jeśli w projekcie jest już wzorzec formularza
- użyj obecnego designu
- nie przebudowuj całej strony
- nie dodawaj rozbudowanej nawigacji
- oznacz brakujące dane jako [do potwierdzenia]
- na końcu pokaż, jakie pliki zmieniłeś i co trzeba sprawdzić przed publikacją
```

Co mówisz na live:

```text
To nie jest nowy projekt od zera. To jest ten sam system strony. Mam już design, kontekst i skille, więc teraz proszę tylko o nowy landing pod jeden cel.
```

```text
Zwróć uwagę, że landing ma od razu akcję w pierwszym ekranie. Nie chowamy zapisu pod pięcioma sekcjami, bo to ma sprzedawać albo zbierać leady.
```

## Demo 2 - oferta z rozmowy

Cel: pokazać, że z transkrypcji/notatek można zrobić spersonalizowaną stronę oferty.

Plik pomocniczy:

```plain text
examples/rozmowa-klient-przyklad.md
```

Prompt:

```plain text
Uruchom skill oferta.

To demo na live. Na podstawie pliku examples/rozmowa-klient-przyklad.md zrób spersonalizowaną stronę oferty dla Anny Kowalczyk.

Cel: pokazać uczestnikom, że z transkrypcji rozmowy można zrobić stronę oferty dla klienta.

Wymagania:
- route: /oferta/anna-kowalczyk
- jedno CTA: "Porozmawiajmy o wdrożeniu"
- użyj słów klientki z transkrypcji
- pokaż sekcję "Co zrozumiałem z rozmowy"
- zaproponuj rozwiązanie jako ofertę stworzenia strony/systemu strony dla klientki
- nie zmyślaj ceny, wyników ani case studies
- braki oznacz jako [do potwierdzenia]
- użyj obecnego designu
- na końcu pokaż, jakie dane wziąłeś z rozmowy i co trzeba potwierdzić przed wysłaniem klientce
```

Co mówisz na live:

```text
Najważniejsze jest to, że Claude Code nie wymyśla oferty z powietrza. On czyta rozmowę, łapie słowa klienta i buduje stronę, która brzmi jak odpowiedź na realną rozmowę.
```

```text
To jest mega praktyczne dla freelancerów, konsultantów i ekspertów. Po spotkaniu można zamienić notatki w stronę oferty, a nie pisać PDF od zera.
```

## Kolejność pokazywania

1. Pokaż Notion: ścieżka kursu.
2. Pokaż GitHub Course Kit: skille, prompty, karty.
3. Powiedz: "To jest wersja robocza do Claude Code, nie kurs do biernego oglądania".
4. Pokaż prompt startowy.
5. Pokaż demo LP.
6. Pokaż demo oferty.
7. Wróć do oferty cenowej: kupujący dostaje Notion + GitHub Course Kit + wideo później bez dopłaty.

## Mini checklista przed live

- Repo GitHub zawiera `lp` i `oferta`.
- Installer kopiuje `lp` i `oferta` do `.claude/skills/`.
- Demo LP ma CTA above the fold.
- Demo oferty nie wpisuje zmyślonej ceny.
- W przykładzie oferty jasno widać słowa klientki.
- W finalnej sprzedaży mówisz, że wideo dojdzie później, a niższa cena jest za early access.
