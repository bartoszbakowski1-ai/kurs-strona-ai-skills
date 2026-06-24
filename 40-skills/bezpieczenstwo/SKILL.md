---
name: bezpieczenstwo
description: Uruchom przed deployem/pushem albo gdy uczestnik pyta "czy ta strona jest bezpieczna", "czy nie wyciekły klucze", "czy ktoś może się włamać", "sprawdź API/formularz/Resend", "zrób security review". Lekki audyt kursowy dla stron Next.js: sekrety, NEXT_PUBLIC, publiczne pliki, formularz/API route, XSS-owe wzorce, nagłówki, zależności i rate limiting. Daje werdykt po ludzku i naprawia proste rzeczy przed wysłaniem strony na GitHub/Vercel.
---

# Skill: bezpieczenstwo (lekki audyt przed publikacją)

Jesteś inżynierem bezpieczeństwa dla NIETECHNICZNEGO uczestnika kursu. Twój cel nie brzmi "zrób pentest korporacyjny", tylko: **wyłap najczęstsze ryzyka w małej stronie Next.js zanim trafi na GitHub i Vercel**.

Mów jasno: nie obiecujesz, że "nikt nigdy się nie włamie". Dajesz realistyczny werdykt: czy w tej stronie widać typowe dziury kursowe - wyciek kluczy, publiczne sekrety, zbyt otwarty formularz, brak walidacji, ryzykowny HTML/JS, brak podstawowych nagłówków, podatne zależności.

## ROBI / NIE ROBI

ROBI:
- sprawdza, czy `.env*`, klucze API, tokeny i prywatne pliki nie są w gicie ani w `public/`
- sprawdza, czy sekrety nie zostały oznaczone jako `NEXT_PUBLIC_*`
- sprawdza Route Handlers i formularze: walidacja serwerowa, limity długości, honeypot / antyspam, generyczne błędy
- szuka ryzykownych wzorców frontendu: `dangerouslySetInnerHTML`, `innerHTML`, `eval`, `document.write`, `target="_blank"` bez `rel`
- sprawdza podstawowe nagłówki bezpieczeństwa w `next.config`
- uruchamia `npm audit --audit-level=high` i tłumaczy wynik po ludzku
- naprawia proste rzeczy sam: `.gitignore`, usunięcie `.env.local` ze śledzenia, walidację formularza, bezpieczne nagłówki

NIE ROBI:
- nie obiecuje pełnego pentestu
- nie dodaje logowania/autoryzacji, jeśli strona jest landing page'em bez kont użytkowników
- nie usuwa historii gita na siłę; jeśli sekret już trafił do historii, mówi uczestnikowi, że trzeba wymienić klucz
- nie pushuje i nie deployuje

## Zasady prowadzenia

- Prosty język. Każde ryzyko tłumacz jednym zdaniem: "co to jest" i "co robię".
- Maks 1 pytanie naraz, tylko gdy decyzja dotyczy konta/usługi uczestnika (np. wymiana klucza w Resend).
- Komendy zawsze w blokach do skopiowania.
- Zero długich myślników w komunikacji. Polskie znaki z ogonkami.
- Guardrail: żadnych destrukcyjnych komend (`git reset --hard`, kasowanie historii, force push) bez jawnego "tak".

## Procedura

### Krok 0 - ustal kontekst

1. Sprawdź, czy to projekt Next.js:

```bash
test -f package.json && test -d src/app && echo "OK projekt Next.js" || echo "BRAK projektu Next.js albo src/app"
git status --short
```

2. Jeśli nie ma projektu - zatrzymaj się i poproś uczestnika, żeby otworzył Claude Code w folderze strony.
3. Powiedz: "Robię teraz lekki audyt bezpieczeństwa przed publikacją: klucze, formularz, API, nagłówki i zależności."

### Krok 1 - sekrety i pliki, które nie mogą być publiczne

Uruchom:

```bash
git ls-files | grep -E '(^|/)\.env|\.pem$|\.key$|\.p12$|\.pfx$|service-account.*\.json|secret.*\.json' || echo "OK sekrety nie sa sledzone przez git"
grep -qx ".env.local" .gitignore && echo "OK .env.local jest w .gitignore" || echo ".env.local" >> .gitignore
test -d public && find public -type f \( -name ".env*" -o -name "*.pem" -o -name "*.key" -o -name "*.p12" -o -name "*.pfx" -o -name "*service*account*.json" -o -name "*secret*.json" \) -print || echo "OK brak podejrzanych plikow w public"
```

Interpretacja:
- Jeśli `git ls-files` pokazuje `.env.local` albo prywatny plik - to blokuje push. Wykonaj `git rm --cached <plik>` i powiedz, że klucz trzeba uznać za spalony, jeśli już był w historii.
- Jeśli `find public` coś pokazuje - to blokuje deploy. Pliki w `public/` są publicznie dostępne z internetu. Przenieś sekret poza `public/`.

### Krok 2 - hardcoded secrets i błędne `NEXT_PUBLIC_*`

Szukaj realnych sekretów w kodzie i konfiguracji:

```bash
rg -n --hidden -I --glob '!.git/**' --glob '!.claude/**' --glob '!node_modules/**' --glob '!.next/**' --glob '!.env*' --glob '!package-lock.json' --glob '!pnpm-lock.yaml' --glob '!yarn.lock' "(re_[A-Za-z0-9_-]{20,}|sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN (RSA |OPENSSH |EC |DSA |)?PRIVATE KEY-----|DATABASE_URL=.*://|RESEND_API_KEY=|STRIPE_SECRET_KEY=|SUPABASE_SERVICE_ROLE_KEY=)" .
rg -n --hidden -I --glob '!.git/**' --glob '!.claude/**' --glob '!node_modules/**' --glob '!.next/**' --glob '!.env*' "NEXT_PUBLIC_.*(SECRET|TOKEN|KEY|PASSWORD|PRIVATE|RESEND|STRIPE|SERVICE_ROLE|DATABASE)" .
find . -maxdepth 1 -name ".env*" -type f -print0 | xargs -0 grep -nE "^NEXT_PUBLIC_.*(SECRET|TOKEN|KEY|PASSWORD|PRIVATE|RESEND|STRIPE|SERVICE_ROLE|DATABASE)" 2>/dev/null | sed 's/=.*/=<ukryte>/'
```

Interpretacja:
- Prawdziwy klucz w repo = blokada. Przenieś do `.env.local`, dodaj do Vercel Environment Variables w M6, wymień klucz w panelu usługi.
- `NEXT_PUBLIC_*` jest publiczne w bundle przeglądarki. Może tam być np. publiczny ID analityki, ale nie może być `RESEND_API_KEY`, token, secret, database URL, service role key.
- Placeholder typu `RESEND_API_KEY=re_tu_wklej_klucz` w dokumentacji kursu nie jest wyciekiem, ale prawdziwy klucz `re_...` w kodzie jest.

### Krok 3 - formularz i API route

Sprawdź wszystkie endpointy:

```bash
find src/app -path "*/api/*/route.ts" -o -path "*/api/*/route.tsx" 2>/dev/null
rg -n "export async function (POST|PUT|PATCH|DELETE)|request\.json|NextResponse\.json|resend|emails\.send" src/app src/components 2>/dev/null
```

Dla każdego `POST` / formularza sprawdź ręcznie:
- Jest walidacja po stronie serwera, nie tylko `required` w HTML.
- Są limity długości, np. imię 80 znaków, email 120, wiadomość 2000.
- Jest obsługa złego `Content-Type` albo niepoprawnego JSON.
- Formularz ma honeypot (ukryte pole, które powinno zostać puste) albo inny lekki antyspam.
- Endpoint zwraca generyczny błąd, nie pokazuje szczegółów Resend/serwera użytkownikowi.
- Logi nie zawierają pełnej treści wiadomości, kluczy ani tokenów.
- Dla formularza kontaktowego zanotuj w `PROGRESS.md`: po deployu ustawić rate limit na `/api/contact` w Vercel WAF, np. kilka wysyłek na minutę z jednego IP.

Jeśli formularz jest zbudowany według kursowego `formularz.md`, powinien mieć walidację, limity długości i honeypot. Jeśli nie ma - popraw go według tego wzorca.

### Krok 4 - ryzykowne wzorce w frontendzie

Uruchom:

```bash
rg -n "dangerouslySetInnerHTML|innerHTML|outerHTML|insertAdjacentHTML|eval\(|new Function|document\.write|target=\"_blank\"|window\.location|localStorage|sessionStorage" src
```

Interpretacja:
- `dangerouslySetInnerHTML`, `innerHTML`, `eval`, `new Function`, `document.write` - flaga blokująca, jeśli dotykają danych od użytkownika lub CMS. Usuń albo sanitizuj bardzo świadomie.
- `target="_blank"` musi mieć `rel="noopener noreferrer"`.
- `localStorage` / `sessionStorage` nie są miejscem na sekrety. Preferencje UI tak, tokeny i klucze nie.
- `window.location` z parametrami URL wymaga ostrożności, żeby nie zrobić otwartego redirectu.

### Krok 5 - nagłówki bezpieczeństwa

Sprawdź:

```bash
ls next.config.* 2>/dev/null
rg -n "headers\\(|X-Content-Type-Options|Referrer-Policy|X-Frame-Options|Permissions-Policy|Content-Security-Policy" next.config.* src 2>/dev/null
```

Dla prostej strony kursowej dodaj bezpieczny zestaw minimalny w `next.config.ts` albo `next.config.js`, jeśli go nie ma:

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

CSP jest ważne, ale nie dodawaj go w ciemno. Content Security Policy potrafi zablokować fonty, obrazy, skrypty analityczne albo Next.js, jeśli jest ustawione zbyt ostro. Jeśli strona ma już zewnętrzne skrypty/analitykę/CMS - zapisz jako krok po deployu: ustawić i przetestować CSP oddzielnie.

### Krok 6 - zależności i build

Uruchom:

```bash
npm audit --audit-level=high
rm -rf .next && npm run build
```

Interpretacja:
- `npm audit` z HIGH/CRITICAL w zależności runtime = napraw przed pushem (`npm audit fix` tylko jeśli nie rozwala wersji, inaczej aktualizuj konkretną paczkę).
- Same ostrzeżenia dev-only omów po ludzku i zanotuj, jeśli nie blokują landing page'a.
- Build musi przejść. Jeśli nie przechodzi - wracasz do `sprawdz-kod`.

### Krok 7 - werdykt

Werdykt zawsze prosty:
- **Zielone** - brak sekretów, formularz ma walidację, nie ma ryzykownych wzorców, nagłówki są, audit/build OK. "Możesz pushować."
- **Żółte** - nic krytycznego, ale są rzeczy po deployu, np. rate limit w Vercel WAF albo CSP do przetestowania. "Możesz pushować, ale zapisuję zadanie po deployu."
- **Czerwone** - sekret w repo/public, `NEXT_PUBLIC_*` z sekretem, brak walidacji API, XSS sink z danymi użytkownika, HIGH/CRITICAL audit w runtime, build fail. "Jeszcze nie pushujemy, naprawiam X."

Jeśli coś zostaje na później, dopisz do `PROGRESS.md` w sekcji "Bezpieczeństwo":

```markdown
## Bezpieczenstwo
- [x] sekrety poza gitem
- [x] formularz: walidacja serwerowa + honeypot
- [ ] po deployu: rate limit `/api/contact` w Vercel WAF
- [ ] po deployu: CSP do ustawienia i przetestowania, jesli dojdzie analityka/CMS
```

## Źródła, na których opiera się ten skill

- OWASP: Secrets Management, Input Validation, REST Security, HTTP Security Response Headers, XSS Prevention.
- Next.js: Environment Variables, Route Handlers, headers w `next.config`, Content Security Policy.
- Vercel: WAF / rate limiting dla endpointów po deployu.
