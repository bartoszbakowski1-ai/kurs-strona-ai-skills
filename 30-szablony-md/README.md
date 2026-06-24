# Szablony Markdown do kursu "Stworz strone z AI"

Te pliki sa dla uczestnika, ktory chce zobaczyc i uzupelnic fundament strony jako zwykle dokumenty `.md`.

W kursie podstawowa sciezka jest prowadzona przez skille:

- M1: skill `kontekst` tworzy folder `kontekst/`
- M3: skill `karty` tworzy folder `karty/`

Szablony z tego folderu sa materialem pomocniczym. Mozna je pobrac z GitHub, skopiowac do folderu swojego projektu i przegadac z Claude Code.

## Rekomendowany uklad w projekcie uczestnika

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

## Jak uzyc z Claude Code

Po skopiowaniu szablonow do projektu powiedz Claude Code:

```plain text
Przeczytaj pliki w folderach kontekst/ i karty/. Przeprowadz mnie krok po kroku przez ich uzupelnienie. Zadawaj maksymalnie 2-3 pytania naraz. Jesli odpowiem "nie wiem", zaproponuj mi 2-3 konkretne opcje. Nie zmieniaj nic poza tymi plikami bez mojego potwierdzenia.
```

## Dwie warstwy, ktorych nie mieszamy

`kontekst/` opisuje Ciebie, Twoja prace, klientow, oferte i proces. To jest pamiec robocza Claude o Tobie.

`karty/` opisuje cala Twoja strone-system, ktora budujesz: jej cel i lejek, mape podstron, tresc i wyglad.

Dlatego odpowiedz brzmi: tak, uczestnik powinien miec personalny i zawodowy kontekst w Claude Code, ale nie jako czwarta karta strony. To osobny fundament z M1. Trzy karty z M3 sa juz dokumentami o calej stronie-systemie.
