# Prompt instalacyjny

Uzyj, gdy masz juz projekt strony i chcesz wgrac paczke kursowa.

```plain text
Pobierz i zainstaluj paczke kursowa "Stworz strone z AI" z repozytorium:
https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills

Zrob to w aktualnym projekcie strony.

Zasady:
- nie nadpisuj plikow strony poza folderem .claude/,
- skopiuj skille z 40-skills/ do .claude/skills/, ale pomin 40-skills/strona,
- skopiuj 40-skills/strona/COMMAND.md do .claude/commands/strona.md,
- skopiuj 30-szablony-md/ do .claude/materialy/30-szablony-md/,
- skopiuj kurs/ do .claude/materialy/kurs/,
- skopiuj prompty/ do .claude/materialy/prompty/.

Po instalacji sprawdz wynik komenda find .claude -maxdepth 3 -type f | sort.
Na koniec powiedz mi, jak zaczac M0/M1.
```
