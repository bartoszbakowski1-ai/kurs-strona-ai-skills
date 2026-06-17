# Instalacja reczna

Te kroki wykonujesz w folderze swojego projektu strony, czyli tam, gdzie masz `package.json`.

## 1. Pobierz repo

```bash
git clone https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills.git /tmp/kurs-strona-ai-skills
```

## 2. Utworz foldery Claude

```bash
mkdir -p .claude/skills .claude/commands
```

## 3. Skopiuj skille

```bash
cp -R /tmp/kurs-strona-ai-skills/40-skills/* .claude/skills/
```

## 4. Skopiuj komende `/strona`

```bash
cp /tmp/kurs-strona-ai-skills/40-skills/strona/COMMAND.md .claude/commands/strona.md
```

## 5. Sprawdz wynik

```bash
find .claude -maxdepth 3 -type f | sort
```

Powinienes/powinnas widziec m.in.:

```plain text
.claude/commands/strona.md
.claude/skills/kontekst/SKILL.md
.claude/skills/karty/SKILL.md
.claude/skills/design/SKILL.md
.claude/skills/obrazy/SKILL.md
.claude/skills/zbuduj-strone/SKILL.md
.claude/skills/sprawdz-kod/SKILL.md
.claude/skills/sanity/SKILL.md
```

## 6. Pierwszy krok w kursie

W Claude Code powiedz:

```plain text
Uruchom skill kontekst.
```

Po M1 powinien powstac folder:

```plain text
kontekst/
  profil.md
  persona.md
  procesy.md
```

Po M3 powinien powstac folder:

```plain text
karty/
  karta-strategiczna.md
  karta-architektury-tresci.md
  karta-wizualna.md
```
