# Start tutaj

Jesli wlasnie kupiles/kupilas kurs, zacznij od tej strony.

## Co dostajesz

Masz dwa miejsca:

1. **Notion** - panel kursu i lekcje:
   https://app.notion.com/p/382156016bef810382feca3d25fe2610

2. **GitHub Course Kit** - paczka do Claude Code:
   https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

Notion pokazuje sciezke. GitHub daje pliki, skille, szablony i prompty, z ktorymi Claude Code ma pracowac.

## Najprostsza sciezka

1. Otworz Notion i przeczytaj M0.
2. Pobierz repozytorium z GitHuba przez `Code` -> `Download ZIP`.
3. Rozpakuj ZIP.
4. Otworz folder swojej strony w Claude Code.
5. Wklej prompt z sekcji ponizej.

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

## Jesli nie masz jeszcze projektu strony

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

Nie przeskakuj od razu do budowania strony. Najpierw Claude Code musi poznac Twoj kontekst i stworzyc 3 karty strony.
