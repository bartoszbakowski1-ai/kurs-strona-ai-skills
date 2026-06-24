# Stworz strone z AI - Course Kit dla Claude Code

To jest robocza paczka dla uczestnika kursu. Pobierasz ja, otwierasz w Claude Code i przechodzisz kurs razem z AI.

W tym kursie budujesz cala strone-system: strone glowna plus podstrony (oferta, o mnie, blog/wiedza, realizacje, kontakt), ktore razem prowadza odwiedzajacego przez lejek i zbieraja kontakty, z czescia tresci edytowalna w przegladarce (CMS). To nie jest pojedynczy landing page. System powstaje etapami: najpierw rdzen, potem kolejne podstrony.

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
    lp/
    obrazy/
    oferta/
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

Gdy masz juz kontekst, karty i rdzen systemu, mozesz dokladac do niego pojedyncze strony pod konkretny cel:

```plain text
Uruchom skill lp. Zrob landing page pod jeden cel: zapis na webinar, lead magnet albo sprzedaz.
```

```plain text
Uruchom skill oferta. Zrob spersonalizowana strone oferty na podstawie rozmowy z klientem.
```

## Skille w paczce

- `kontekst` - tworzy Twoj osobisty i zawodowy kontekst do pracy z AI,
- `karty` - tworzy 3 karty Twojej strony-systemu: strategiczna (lejek), architektury tresci (mapa podstron) i wizualna (design system),
- `design` - zamienia karte wizualna w spojny design system i pilnuje anti-ai-look,
- `obrazy` - pomaga dodac realne zdjecia i assety,
- `zbuduj-strone` - buduje strone-system etapami: strona glowna i podstrony, sekcja po sekcji,
- `lp` - buduje konwertujacy landing page pod jeden cel, np. webinar, lead magnet albo sprzedaz,
- `oferta` - tworzy spersonalizowana strone oferty z rozmowy, briefu albo notatek klienta,
- `sprawdz-kod` - sprawdza build, mobile, jakosc, anti-ai-look i bezpieczenstwo,
- `bezpieczenstwo` - robi lekki audyt sekretow, API, formularza i deploya,
- `sanity` - opcjonalnie podpina panel edycji tresci,
- `/strona` - komenda-dyrygent do statusu, wznowienia i rozwoju strony.

## Najwazniejsza zasada

Ty mowisz Claude Code, **co** ma powstac i **dlaczego**.

Claude Code robi **jak**: pliki, kod, komendy, build, formularz, GitHub, Vercel.

Nie zaczynaj od budowy strony. Najpierw przejdz `kontekst` i `karty` - tam projektujesz caly system (mape podstron, lejek, design system), zanim cokolwiek powstanie w kodzie.
