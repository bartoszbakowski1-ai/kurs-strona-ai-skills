# Instalacja ręczna

Te kroki wykonujesz w folderze swojego projektu strony, czyli tam, gdzie masz `package.json`.

Jeśli nie wiesz, gdzie jest projekt, poproś Claude Code:

```plain text
Sprawdz, czy jestem w folderze projektu strony. Pokaz sciezke, package.json i aktualny status git. Jesli to nie ten folder, pomoz mi znalezc wlasciwy.
```

## 1. Pobierz repo

```bash
git clone https://github.com/bartoszbakowski1-ai/kurs-strona-ai-skills.git /tmp/kurs-strona-ai-skills
```

## 2. Utwórz foldery Claude

```bash
mkdir -p .claude/skills .claude/commands .claude/materialy
```

## 3. Skopiuj skille

```bash
for skill in analityka bezpieczenstwo design karty kontekst lp obrazy oferta sanity sprawdz-kod zbuduj-strone; do
  rm -rf ".claude/skills/$skill"
  cp -R "/tmp/kurs-strona-ai-skills/40-skills/$skill" ".claude/skills/$skill"
done
```

## 4. Skopiuj komendę `/strona`

```bash
cp /tmp/kurs-strona-ai-skills/40-skills/strona/COMMAND.md .claude/commands/strona.md
```

## 5. Skopiuj materiały kursowe

```bash
rm -rf .claude/materialy/30-szablony-md .claude/materialy/kurs .claude/materialy/prompty
cp -R /tmp/kurs-strona-ai-skills/30-szablony-md .claude/materialy/30-szablony-md
cp -R /tmp/kurs-strona-ai-skills/kurs .claude/materialy/kurs
cp -R /tmp/kurs-strona-ai-skills/prompty .claude/materialy/prompty
```

## 6. Sprawdź wynik

```bash
find .claude -maxdepth 3 -type f | sort
```

Powinieneś/powinnaś widzieć m.in.:

```plain text
.claude/commands/strona.md
.claude/materialy/kurs/M0.md
.claude/materialy/prompty/prompt-startowy.md
.claude/skills/kontekst/SKILL.md
.claude/skills/karty/SKILL.md
.claude/skills/design/SKILL.md
.claude/skills/obrazy/SKILL.md
.claude/skills/zbuduj-strone/SKILL.md
.claude/skills/lp/SKILL.md
.claude/skills/oferta/SKILL.md
.claude/skills/sprawdz-kod/SKILL.md
.claude/skills/bezpieczenstwo/SKILL.md
.claude/skills/sanity/SKILL.md
.claude/skills/analityka/SKILL.md
```

## 7. Pierwszy krok

W Claude Code powiedz:

```plain text
Zaczynam kurs "Stworz strone z AI". Najpierw przeczytaj .claude/materialy/kurs/M0.md i powiedz mi, co mam zrobic teraz.
```

Potem, gdy przejdziesz do setupu:

```plain text
Uruchom skill kontekst.
```
