# Stworz strone z AI - Course Kit dla Claude Code

To jest robocza paczka dla uczestnika kursu. Pobierasz ja, otwierasz w Claude Code i przechodzisz kurs razem z AI.

W srodku sa:

- `START-TUTAJ.md` - najprostsza sciezka po zakupie,
- `kurs/` - moduly M0-M8 jako pliki Markdown,
- `40-skills/` - skille do Claude Code,
- `30-szablony-md/` - szablony kontekstu i 3 kart strony,
- `prompty/` - prompty startowe i ratunkowe,
- `examples/` - przykladowe pliki projektu,
- `INSTALL.md` - instalacja reczna, gdy Claude Code nie pobierze paczki automatycznie.

## Najszybszy start

1. Otworz panel kursu w Notion:

   https://app.notion.com/p/382156016bef810382feca3d25fe2610

2. Pobierz to repozytorium:

   https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

   Mozesz kliknac `Code` -> `Download ZIP` albo sklonowac przez git.

3. Otworz folder swojej strony w Claude Code i wklej:

```plain text
Pracujemy w kursie "Stworz strone z AI".

Pobierz i zainstaluj paczke kursowa z repozytorium:
https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

Zainstaluj w moim projekcie:
- foldery z 40-skills/ do .claude/skills/, ale pomin folder 40-skills/strona,
- plik 40-skills/strona/COMMAND.md jako .claude/commands/strona.md,
- folder 30-szablony-md/ jako .claude/materialy/30-szablony-md/,
- folder kurs/ jako .claude/materialy/kurs/,
- folder prompty/ jako .claude/materialy/prompty/.

Nie nadpisuj moich istniejacych plikow projektu poza folderem .claude/.
Na koniec wypisz, jakie skille i materialy sa dostepne.
```

## Co ma powstac w Twoim projekcie

Po instalacji w folderze Twojej strony powinno byc:

```plain text
.claude/
  skills/
    bezpieczenstwo/
    design/
    karty/
    kontekst/
    obrazy/
    sanity/
    sprawdz-kod/
    zbuduj-strone/
  commands/
    strona.md
  materialy/
    30-szablony-md/
    kurs/
    prompty/
```

## Jak zaczac kurs w Claude Code

Po instalacji wklej:

```plain text
Zaczynam kurs "Stworz strone z AI".
Najpierw przeczytaj .claude/materialy/kurs/M0.md oraz .claude/materialy/prompty/prompt-startowy.md.
Nie buduj jeszcze strony. Poprowadz mnie przez pierwszy krok i powiedz, co mam zrobic teraz.
```

Gdy dojdziesz do M1, uruchom:

```plain text
Uruchom skill kontekst.
```

## Skille w paczce

- `kontekst` - tworzy Twoj osobisty i zawodowy kontekst do pracy z AI,
- `karty` - tworzy 3 karty strony: strategiczna, architektury tresci i wizualna,
- `design` - zamienia karte wizualna w system designu i pilnuje anti-ai-look,
- `obrazy` - pomaga dodac realne zdjecia i assety,
- `zbuduj-strone` - buduje strone sekcja po sekcji,
- `sprawdz-kod` - sprawdza build, mobile, jakosc, anti-ai-look i bezpieczenstwo,
- `bezpieczenstwo` - robi lekki audyt sekretow, API, formularza i deploya,
- `sanity` - opcjonalnie podpina panel edycji tresci,
- `/strona` - komenda-dyrygent do statusu, wznowienia i rozwoju strony.

## Najwazniejsza zasada

Ty mowisz Claude Code, **co** ma powstac i **dlaczego**.

Claude Code robi **jak**: pliki, kod, komendy, build, formularz, GitHub, Vercel.

Nie zaczynaj od budowy strony. Najpierw przejdz `kontekst` i `karty`.
