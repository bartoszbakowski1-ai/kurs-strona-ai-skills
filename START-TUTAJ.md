# Start tutaj

Jeśli właśnie kupiłeś/kupiłaś kurs, zacznij od tej strony.

W tym kursie budujesz całą stronę-system: stronę główną plus podstrony (oferta, o mnie, blog/wiedza, realizacje, kontakt), które razem prowadzą przez lejek i zbierają kontakty. To nie pojedynczy landing - system powstaje etapami, najpierw rdzeń, potem kolejne podstrony.

## Co dostajesz

Masz dwa miejsca:

1. **Notion** - panel kursu i lekcje:
   https://app.notion.com/p/382156016bef810382feca3d25fe2610

2. **GitHub Course Kit** - paczka do Claude Code:
   https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

Notion pokazuje ścieżkę. GitHub daje pliki, skille, szablony i prompty, z którymi Claude Code ma pracować.

## Najprostsza ścieżka

1. Otwórz Notion i przeczytaj M0.
2. Pobierz repozytorium z GitHuba przez `Code` -> `Download ZIP`.
3. Rozpakuj ZIP.
4. Otwórz folder swojej strony w Claude Code.
5. Wklej prompt z sekcji poniżej.

## Prompt do Claude Code

```plain text
Pracujemy w kursie "Stworz strone z AI".

Mam pobrana paczke kursowa z GitHuba. Pomoz mi ja zainstalowac w moim projekcie strony.

Najpierw sprawdz:
- czy jestem w folderze projektu strony,
- czy jest package.json,
- czy istnieje folder .claude/.

Potem zainstaluj:
- skille z folderu 40-skills/ do .claude/skills/, z pominieciem folderu 40-skills/strona,
- komende 40-skills/strona/COMMAND.md jako .claude/commands/strona.md,
- szablony 30-szablony-md/ do .claude/materialy/30-szablony-md/,
- folder kurs/ do .claude/materialy/kurs/,
- folder prompty/ do .claude/materialy/prompty/.

Nie buduj jeszcze strony.
Po instalacji powiedz mi, jaki jest pierwszy krok kursu.
```

## Jeśli nie masz jeszcze projektu strony

Wklej:

```plain text
Zaczynam kurs "Stworz strone z AI" i nie mam jeszcze projektu strony.
Poprowadz mnie spokojnie przez utworzenie folderu projektu, instalacje paczki kursowej i pierwszy skill kontekst.
Nie pytaj mnie o decyzje techniczne. Pytaj tylko o rzeczy biznesowe i tresciowe.
```

## Po instalacji

Pierwszy realny krok kursu:

```plain text
Uruchom skill kontekst.
```

Nie przeskakuj od razu do budowania strony. Najpierw Claude Code musi poznać Twój kontekst i stworzyć 3 karty całej strony-systemu (mapa podstron, lejek, design system).

## Co po zbudowaniu rdzenia systemu

Gdy masz już działający rdzeń systemu, paczka daje Ci też skille do dokładania pojedynczych stron pod konkretny cel:

```plain text
Uruchom skill lp.
```

Do stworzenia jednego landing page pod webinar, kampanię, lead magnet, konsultacje albo sprzedaż - jako podstrona dokładana do systemu.

```plain text
Uruchom skill oferta.
```

Do stworzenia spersonalizowanej strony oferty na podstawie rozmowy, briefu albo notatek klienta.
