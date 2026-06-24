# Podłącz Claude "oczy" (jednorazowy setup, 5 minut)

Domyślnie Claude Code jest **ślepy na żywe strony** - widzi tylko surowy kod, nie widzi wyrenderowanej strony ani animacji. Żeby mógł sam otwierać strony, oglądać animacje i kopiować ich kod, dajemy mu "oczy" - czyli przeglądarkę.

Robisz to **raz**. Potem działa zawsze.

---

## Co to są "oczy"

To darmowy dodatek o nazwie **Playwright MCP** (od Microsoftu). Po podłączeniu Claude potrafi sam otworzyć dowolną stronę w przeglądarce, zobaczyć ją i wyciągnąć z niej kod animacji.

---

## Krok 1 - Sprawdź czy masz Node.js

Otwórz **Terminal** (na Macu: Cmd+Spacja, wpisz "Terminal", Enter. Na Windows: wpisz "cmd" w menu Start).

Wklej i naciśnij Enter:

```
node -v
```

- Jeśli zobaczysz coś typu `v20.11.0` (jakakolwiek liczba 18 lub wyżej) - masz Node, idź do Kroku 2.
- Jeśli zobaczysz "command not found" albo błąd - zainstaluj Node.js ze strony **nodejs.org** (kliknij duży przycisk LTS, zainstaluj, zrestartuj terminal) i spróbuj ponownie.

---

## Krok 2 - Podłącz oczy (jedna komenda)

Wklej do terminala i naciśnij Enter:

```
claude mcp add playwright npx @playwright/mcp@latest
```

Powinieneś zobaczyć potwierdzenie, że "playwright" został dodany.

---

## Krok 3 - Zrestartuj Claude Code

Zamknij Claude Code i otwórz ponownie (żeby zobaczył nowe oczy).

---

## Krok 4 - Sprawdź, że działa

W Claude Code napisz:

```
otwórz stronę example.com i powiedz mi co widzisz
```

Jeśli Claude opisze zawartość strony - **oczy działają.** Gotowe na zawsze.

---

## Jak coś nie działa

Napisz Claude wprost: **"nie mogę podłączyć oczu, pomóż mi krok po kroku"** - przeprowadzi Cię przez to. Możesz też wkleić mu błąd z terminala, a on powie co zrobić.

> Uwaga: pierwszy raz, gdy Claude użyje oczu, może chwilę pobierać przeglądarkę w tle. To normalne, poczekaj.
