# Stwórz stronę z AI - Course Kit dla Claude Code

To jest robocza paczka dla uczestnika kursu. Pobierasz ją, otwierasz w Claude Code i przechodzisz kurs razem z AI.

W tym kursie budujesz całą stronę-system: stronę główną plus podstrony (oferta, o mnie, blog/wiedza, realizacje, kontakt), które razem prowadzą odwiedzającego przez lejek i zbierają kontakty, z częścią treści edytowalną w przeglądarce (CMS). To nie jest pojedynczy landing page. System powstaje etapami: najpierw rdzeń, potem kolejne podstrony.

W środku są:

- `START-TUTAJ.md` - najprostsza ścieżka po zakupie,
- `kurs/` - moduły M0-M9 jako pliki Markdown,
- `40-skills/` - skille do Claude Code,
- `30-szablony-md/` - szablony kontekstu i 3 kart strony,
- `prompty/` - prompty startowe i ratunkowe,
- `examples/` - przykładowe pliki projektu,
- `INSTALL.md` - instalacja ręczna, gdy Claude Code nie pobierze paczki automatycznie.

## Najszybszy start

1. Otwórz panel kursu w Notion:

   https://app.notion.com/p/382156016bef810382feca3d25fe2610

2. Pobierz to repozytorium:

   https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

   Możesz kliknąć `Code` -> `Download ZIP` albo sklonować przez git.

3. Otwórz folder swojej strony w Claude Code i wklej:

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

## Co ma powstać w Twoim projekcie

Po instalacji w folderze Twojej strony powinno być:

```plain text
.claude/
  skills/
    analityka/
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

## Jak zacząć kurs w Claude Code

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

Gdy masz już kontekst, karty i rdzeń systemu, możesz dokładać do niego pojedyncze strony pod konkretny cel:

```plain text
Uruchom skill lp. Zrob landing page pod jeden cel: zapis na webinar, lead magnet albo sprzedaz.
```

```plain text
Uruchom skill oferta. Zrob spersonalizowana strone oferty na podstawie rozmowy z klientem.
```

## Skille w paczce

- `kontekst` - tworzy Twój osobisty i zawodowy kontekst do pracy z AI,
- `karty` - tworzy 3 karty Twojej strony-systemu: strategiczną (lejek), architektury treści (mapa podstron) i wizualną (design system),
- `design` - zamienia kartę wizualną w spójny design system i pilnuje anti-ai-look,
- `obrazy` - pomaga dodać realne zdjęcia i assety,
- `zbuduj-strone` - buduje stronę-system etapami: strona główna i podstrony, sekcja po sekcji,
- `lp` - buduje konwertujący landing page pod jeden cel, np. webinar, lead magnet albo sprzedaż,
- `oferta` - tworzy spersonalizowaną stronę oferty z rozmowy, briefu albo notatek klienta,
- `sprawdz-kod` - sprawdza build, mobile, jakość, anti-ai-look i bezpieczeństwo,
- `bezpieczenstwo` - robi lekki audyt sekretów, API, formularza i deployu,
- `analityka` - po publikacji wpina prosty pomiar: Vercel Analytics, GA4 przez GTM, Search Console, sitemap i pixel,
- `sanity` - opcjonalnie podpina panel edycji treści,
- `/strona` - komenda-dyrygent do statusu, wznowienia i rozwoju strony.

## Najważniejsza zasada

Ty mówisz Claude Code, **co** ma powstać i **dlaczego**.

Claude Code robi **jak**: pliki, kod, komendy, build, formularz, GitHub, Vercel.

Nie zaczynaj od budowy strony. Najpierw przejdź `kontekst` i `karty` - tam projektujesz cały system (mapę podstron, lejek, design system), zanim cokolwiek powstanie w kodzie.
