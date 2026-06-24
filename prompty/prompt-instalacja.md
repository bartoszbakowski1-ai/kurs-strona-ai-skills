# Prompt instalacyjny

Użyj, gdy masz już projekt strony i chcesz wgrać paczkę kursową.

```plain text
Pobierz i zainstaluj paczkę kursową "Stwórz stronę z AI" z repozytorium:
https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

Zrób to w aktualnym projekcie strony.

Zasady:
- nie nadpisuj plików strony poza folderem .claude/,
- skopiuj skille z 40-skills/ do .claude/skills/, ale pomiń 40-skills/strona,
- skopiuj 40-skills/strona/COMMAND.md do .claude/commands/strona.md,
- skopiuj 30-szablony-md/ do .claude/materialy/30-szablony-md/,
- skopiuj kurs/ do .claude/materialy/kurs/,
- skopiuj prompty/ do .claude/materialy/prompty/.

Po instalacji sprawdź wynik komendą find .claude -maxdepth 3 -type f | sort.
Na końcu powiedz mi, jak zacząć M0/M1.
```
