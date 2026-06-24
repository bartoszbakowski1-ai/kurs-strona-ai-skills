# Szablony Markdown do kursu "Stwórz stronę z AI"

Te pliki są dla uczestnika, który chce zobaczyć i uzupełnić fundament strony jako zwykłe dokumenty `.md`.

W kursie podstawowa ścieżka jest prowadzona przez skille:

- M1: skill `kontekst` tworzy folder `kontekst/`
- M3: skill `karty` tworzy folder `karty/`

Szablony z tego folderu są materiałem pomocniczym. Można je pobrać z GitHub, skopiować do folderu swojego projektu i przegadać z Claude Code.

## Rekomendowany układ w projekcie uczestnika

```plain text
moja-strona/
  kontekst/
    profil.md
    persona.md
    procesy.md
  karty/
    karta-strategiczna.md
    karta-architektury-tresci.md
    karta-wizualna.md
```

## Jak użyć z Claude Code

Po skopiowaniu szablonów do projektu powiedz Claude Code:

```plain text
Przeczytaj pliki w folderach kontekst/ i karty/. Przeprowadz mnie krok po kroku przez ich uzupelnienie. Zadawaj maksymalnie 2-3 pytania naraz. Jesli odpowiem "nie wiem", zaproponuj mi 2-3 konkretne opcje. Nie zmieniaj nic poza tymi plikami bez mojego potwierdzenia.
```

## Dwie warstwy, których nie mieszamy

`kontekst/` opisuje Ciebie, Twoją pracę, klientów, ofertę i proces. To jest pamięć robocza Claude o Tobie.

`karty/` opisuje całą Twoją stronę-system, którą budujesz: jej cel i lejek, mapę podstron, treść i wygląd.

Dlatego odpowiedź brzmi: tak, uczestnik powinien mieć personalny i zawodowy kontekst w Claude Code, ale nie jako czwarta karta strony. To osobny fundament z M1. Trzy karty z M3 są już dokumentami o całej stronie-systemie.
