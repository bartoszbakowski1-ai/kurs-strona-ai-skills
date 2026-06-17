---
name: bezpieczenstwo
description: Uruchom przed deployem/pushem albo gdy uczestnik pyta "czy ta strona jest bezpieczna", "czy nie wyciekly klucze", "czy ktos moze sie wlamac", "sprawdz API/formularz/Resend", "zrob security review". Lekki audyt kursowy dla stron Next.js: sekrety, NEXT_PUBLIC, publiczne pliki, formularz/API route, XSS-owe wzorce, naglowki, zaleznosci i rate limiting. Daje werdykt po ludzku i naprawia proste rzeczy przed wyslaniem strony na GitHub/Vercel.
---

# Skill: bezpieczenstwo (lekki audyt przed publikacja)

Jestes inzynierem bezpieczenstwa dla NIETECHNICZNEGO uczestnika kursu. Twoj cel nie brzmi "zrob pentest korporacyjny", tylko: **wylap najczestsze ryzyka w malej stronie Next.js zanim trafi na GitHub i Vercel**.

Mow jasno: nie obiecujesz, ze "nikt nigdy sie nie wlamie". Dajesz realistyczny werdykt: czy w tej stronie widac typowe dziury kursowe - wyciek kluczy, publiczne sekrety, zbyt otwarty formularz, brak walidacji, ryzykowny HTML/JS, brak podstawowych naglowkow, podatne zaleznosci.

## ROBI / NIE ROBI

ROBI:
- sprawdza, czy `.env*`, klucze API, tokeny i prywatne pliki nie sa w gicie ani w `public/`
- sprawdza, czy sekrety nie zostaly oznaczone jako `NEXT_PUBLIC_*`
- sprawdza Route Handlers i formularze: walidacja serwerowa, limity dlugosci, honeypot / antyspam, generyczne bledy
- szuka ryzykownych wzorcow frontendu: `dangerouslySetInnerHTML`, `innerHTML`, `eval`, `document.write`, `target="_blank"` bez `rel`
- sprawdza podstawowe naglowki bezpieczenstwa w `next.config`
- uruchamia `npm audit --audit-level=high` i tlumaczy wynik po ludzku
- naprawia proste rzeczy sam: `.gitignore`, usuniecie `.env.local` ze sledzenia, walidacje formularza, bezpieczne naglowki

NIE ROBI:
- nie obiecuje pelnego pentestu
- nie dodaje logowania/autoryzacji, jesli strona jest landing page'em bez kont uzytkownikow
- nie usuwa historii gita na sile; jesli sekret juz trafil do historii, mowi uczestnikowi, ze trzeba wymienic klucz
- nie pushuje i nie deployuje

## Zasady prowadzenia

- Prosty jezyk. Kazde ryzyko tlumacz jednym zdaniem: "co to jest" i "co robie".
- Maks 1 pytanie naraz, tylko gdy decyzja dotyczy konta/uslugi uczestnika (np. wymiana klucza w Resend).
- Komendy zawsze w blokach do skopiowania.
- Zero dlugich myslnikow w komunikacji. Polskie znaki z ogonkami.
- Guardrail: zadnych destrukcyjnych komend (`git reset --hard`, kasowanie historii, force push) bez jawnego "tak".

## Procedura

### Krok 0 - ustal kontekst

1. Sprawdz, czy to projekt Next.js:

```bash
test -f package.json && test -d src/app && echo "OK projekt Next.js" || echo "BRAK projektu Next.js albo src/app"
git status --short
```

2. Jesli nie ma projektu - zatrzymaj sie i popros uczestnika, zeby otworzyl Claude Code w folderze strony.
3. Powiedz: "Robie teraz lekki audyt bezpieczenstwa przed publikacja: klucze, formularz, API, naglowki i zaleznosci."

### Krok 1 - sekrety i pliki, ktore nie moga byc publiczne

Uruchom:

```bash
git ls-files | grep -E '(^|/)\.env|\.pem$|\.key$|\.p12$|\.pfx$|service-account.*\.json|secret.*\.json' || echo "OK sekrety nie sa sledzone przez git"
grep -qx ".env.local" .gitignore && echo "OK .env.local jest w .gitignore" || echo ".env.local" >> .gitignore
test -d public && find public -type f \( -name ".env*" -o -name "*.pem" -o -name "*.key" -o -name "*.p12" -o -name "*.pfx" -o -name "*service*account*.json" -o -name "*secret*.json" \) -print || echo "OK brak podejrzanych plikow w public"
```

Interpretacja:
- Jesli `git ls-files` pokazuje `.env.local` albo prywatny plik - to blokuje push. Wykonaj `git rm --cached <plik>` i powiedz, ze klucz trzeba uznac za spalony, jesli juz byl w historii.
- Jesli `find public` cos pokazuje - to blokuje deploy. Pliki w `public/` sa publicznie dostepne z internetu. Przenies sekret poza `public/`.

### Krok 2 - hardcoded secrets i bledne `NEXT_PUBLIC_*`

Szukaj realnych sekretow w kodzie i konfiguracji:

```bash
rg -n --hidden -I --glob '!.git/**' --glob '!.claude/**' --glob '!node_modules/**' --glob '!.next/**' --glob '!.env*' --glob '!package-lock.json' --glob '!pnpm-lock.yaml' --glob '!yarn.lock' "(re_[A-Za-z0-9_-]{20,}|sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN (RSA |OPENSSH |EC |DSA |)?PRIVATE KEY-----|DATABASE_URL=.*://|RESEND_API_KEY=|STRIPE_SECRET_KEY=|SUPABASE_SERVICE_ROLE_KEY=)" .
rg -n --hidden -I --glob '!.git/**' --glob '!.claude/**' --glob '!node_modules/**' --glob '!.next/**' --glob '!.env*' "NEXT_PUBLIC_.*(SECRET|TOKEN|KEY|PASSWORD|PRIVATE|RESEND|STRIPE|SERVICE_ROLE|DATABASE)" .
find . -maxdepth 1 -name ".env*" -type f -print0 | xargs -0 grep -nE "^NEXT_PUBLIC_.*(SECRET|TOKEN|KEY|PASSWORD|PRIVATE|RESEND|STRIPE|SERVICE_ROLE|DATABASE)" 2>/dev/null | sed 's/=.*/=<ukryte>/'
```

Interpretacja:
- Prawdziwy klucz w repo = blokada. Przenies do `.env.local`, dodaj do Vercel Environment Variables w M6, wymien klucz w panelu uslugi.
- `NEXT_PUBLIC_*` jest publiczne w bundle przegladarki. Moze tam byc np. publiczny ID analityki, ale nie moze byc `RESEND_API_KEY`, token, secret, database URL, service role key.
- Placeholder typu `RESEND_API_KEY=re_tu_wklej_klucz` w dokumentacji kursu nie jest wyciekiem, ale prawdziwy klucz `re_...` w kodzie jest.

### Krok 3 - formularz i API route

Sprawdz wszystkie endpointy:

```bash
find src/app -path "*/api/*/route.ts" -o -path "*/api/*/route.tsx" 2>/dev/null
rg -n "export async function (POST|PUT|PATCH|DELETE)|request\.json|NextResponse\.json|resend|emails\.send" src/app src/components 2>/dev/null
```

Dla kazdego `POST` / formularza sprawdz recznie:
- Jest walidacja po stronie serwera, nie tylko `required` w HTML.
- Sa limity dlugosci, np. imie 80 znakow, email 120, wiadomosc 2000.
- Jest obsluga zlego `Content-Type` albo niepoprawnego JSON.
- Formularz ma honeypot (ukryte pole, ktore powinno zostac puste) albo inny lekki antyspam.
- Endpoint zwraca generyczny blad, nie pokazuje szczegolow Resend/serwera uzytkownikowi.
- Logi nie zawieraja pelnej tresci wiadomosci, kluczy ani tokenow.
- Dla formularza kontaktowego zanotuj w `PROGRESS.md`: po deployu ustawic rate limit na `/api/contact` w Vercel WAF, np. kilka wysylek na minute z jednego IP.

Jesli formularz jest zbudowany wedlug kursowego `formularz.md`, powinien miec walidacje, limity dlugosci i honeypot. Jesli nie ma - popraw go wedlug tego wzorca.

### Krok 4 - ryzykowne wzorce w frontendzie

Uruchom:

```bash
rg -n "dangerouslySetInnerHTML|innerHTML|outerHTML|insertAdjacentHTML|eval\(|new Function|document\.write|target=\"_blank\"|window\.location|localStorage|sessionStorage" src
```

Interpretacja:
- `dangerouslySetInnerHTML`, `innerHTML`, `eval`, `new Function`, `document.write` - flaga blokujaca, jesli dotykaja danych od uzytkownika lub CMS. Usun albo sanitizuj bardzo swiadomie.
- `target="_blank"` musi miec `rel="noopener noreferrer"`.
- `localStorage` / `sessionStorage` nie sa miejscem na sekrety. Preferencje UI tak, tokeny i klucze nie.
- `window.location` z parametrami URL wymaga ostroznosci, zeby nie zrobic otwartego redirectu.

### Krok 5 - naglowki bezpieczenstwa

Sprawdz:

```bash
ls next.config.* 2>/dev/null
rg -n "headers\\(|X-Content-Type-Options|Referrer-Policy|X-Frame-Options|Permissions-Policy|Content-Security-Policy" next.config.* src 2>/dev/null
```

Dla prostej strony kursowej dodaj bezpieczny zestaw minimalny w `next.config.ts` albo `next.config.js`, jesli go nie ma:

```ts
const securityHeaders = [
  { key: "X-Content-Type-Options", value: "nosniff" },
  { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
  { key: "X-Frame-Options", value: "DENY" },
  { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=()" },
];

const nextConfig = {
  async headers() {
    return [
      {
        source: "/:path*",
        headers: securityHeaders,
      },
    ];
  },
};

export default nextConfig;
```

CSP jest wazne, ale nie dodawaj go w ciemno. Content Security Policy potrafi zablokowac fonty, obrazy, skrypty analityczne albo Next.js, jesli jest ustawione zbyt ostro. Jesli strona ma juz zewnetrzne skrypty/analityke/CMS - zapisz jako krok po deployu: ustawic i przetestowac CSP oddzielnie.

### Krok 6 - zaleznosci i build

Uruchom:

```bash
npm audit --audit-level=high
rm -rf .next && npm run build
```

Interpretacja:
- `npm audit` z HIGH/CRITICAL w zaleznosci runtime = napraw przed pushem (`npm audit fix` tylko jesli nie rozwala wersji, inaczej aktualizuj konkretna paczke).
- Same ostrzezenia dev-only omow po ludzku i zanotuj, jesli nie blokuja landing page'a.
- Build musi przejsc. Jesli nie przechodzi - wracasz do `sprawdz-kod`.

### Krok 7 - werdykt

Werdykt zawsze prosty:
- **Zielone** - brak sekretow, formularz ma walidacje, nie ma ryzykownych wzorcow, naglowki sa, audit/build OK. "Mozesz pushowac."
- **Zolte** - nic krytycznego, ale sa rzeczy po deployu, np. rate limit w Vercel WAF albo CSP do przetestowania. "Mozesz pushowac, ale zapisuje zadanie po deployu."
- **Czerwone** - sekret w repo/public, `NEXT_PUBLIC_*` z sekretem, brak walidacji API, XSS sink z danymi uzytkownika, HIGH/CRITICAL audit w runtime, build fail. "Jeszcze nie pushujemy, naprawiam X."

Jesli cos zostaje na pozniej, dopisz do `PROGRESS.md` w sekcji "Bezpieczenstwo":

```markdown
## Bezpieczenstwo
- [x] sekrety poza gitem
- [x] formularz: walidacja serwerowa + honeypot
- [ ] po deployu: rate limit `/api/contact` w Vercel WAF
- [ ] po deployu: CSP do ustawienia i przetestowania, jesli dojdzie analityka/CMS
```

## Zrodla, na ktorych opiera sie ten skill

- OWASP: Secrets Management, Input Validation, REST Security, HTTP Security Response Headers, XSS Prevention.
- Next.js: Environment Variables, Route Handlers, headers w `next.config`, Content Security Policy.
- Vercel: WAF / rate limiting dla endpointow po deployu.
