# Kurs "Stworz strone z AI" - skille i szablony dla uczestnikow

To repo zawiera materialy, ktore uczestnik kursu pobiera do swojego projektu w Claude Code.

W srodku sa:

- `40-skills/` - komplet skilli kursu oraz komenda `/strona`
- `30-szablony-md/` - pomocnicze szablony Markdown: kontekst i trzy karty strony

## Najprostsza instalacja w Claude Code

W folderze swojego projektu strony powiedz Claude Code:

```plain text
Pobierz skille i szablony tego kursu z repozytorium https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills i zainstaluj je w moim projekcie: skopiuj zawartosc folderu 40-skills/ do .claude/skills/, komendę ze ścieżki 40-skills/strona/COMMAND.md do .claude/commands/strona.md, a folder 30-szablony-md/ do .claude/materialy/30-szablony-md/. Zrób to bezpiecznie, nie nadpisuj niczego poza folderem .claude/. Na koniec wypisz, jakie skille są teraz dostępne i gdzie są szablony.
```

Claude Code powinien utworzyc:

```plain text
.claude/
  skills/
    kontekst/
    karty/
    design/
    obrazy/
    zbuduj-strone/
    sprawdz-kod/
    sanity/
    strona/
  commands/
    strona.md
  materialy/
    30-szablony-md/
```

## Co robia skille

- `kontekst` - tworzy `kontekst/profil.md`, `kontekst/persona.md`, `kontekst/procesy.md`
- `karty` - tworzy `karty/karta-strategiczna.md`, `karty/karta-architektury-tresci.md`, `karty/karta-wizualna.md`
- `design` - zamienia karte wizualna na design tokens i kierunek wygladu
- `obrazy` - pomaga przygotowac prawdziwe zdjecia i assety
- `zbuduj-strone` - buduje strone sekcja po sekcji
- `sprawdz-kod` - sprawdza build, jakosc i reguly anti-ai-look
- `sanity` - opcjonalny panel edycji tresci
- `/strona` - komenda-dyrygent do statusu, wznowienia i rozwoju strony

## Szablony Markdown

`30-szablony-md/` jest materialem pomocniczym. Glowne flow kursu prowadza skille, ale szablony pokazuja, jak wygladaja pliki `.md`, ktore powstana w projekcie. Przy instalacji trafiaja do `.claude/materialy/30-szablony-md/`.

Sa dwie warstwy:

- `kontekst/` - personalny i zawodowy kontekst o uczestniku, ofercie, klientach i procesie
- `karty/` - dokumenty o konkretnej stronie: strategia, architektura tresci i wizual

To wazne: kontekst nie jest czwarta karta strony. Kontekst powstaje w M1, a trzy karty strony powstaja w M3.

## Instalacja reczna

Jesli Claude Code ma problem z automatycznym pobraniem repo, uzyj instrukcji z [INSTALL.md](INSTALL.md).
