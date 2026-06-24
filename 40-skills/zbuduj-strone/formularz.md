# Formularz kontaktowy przez Resend (plik towarzyszący skilla zbuduj-strone)

Ładowany on-demand z Kroku 4 skilla `zbuduj-strone`. Otwórz go DOPIERO przy budowie formularza - oszczędzasz tokeny uczestnika. To golden path: Resend + Next.js API route. NIE n8n, NIE Formspree. Klucz w `.env.local`, NIGDY w gicie, w Vercel ta sama nazwa zmiennej.

Tu masz: (1) skąd uczestnik bierze klucz Resend, (2) zależność do instalacji, (3) `.env.local` + `.gitignore`, (4) gotowy `route.ts`, (5) gotowy komponent formularza, (6) wpięcie do strony, (7) co powiedzieć o deployu, (8) najczęstsze problemy. Wykonaj po kolei.

---

## 1. Skąd wziąć klucz Resend (poprowadź uczestnika, prostym językiem)

Powiedz mniej więcej tak (po jednym kroku, czekaj aż zrobi):
1. "Wejdź na resend.com i załóż darmowe konto (można przez Google/GitHub). Darmowy plan to 100 maili dziennie - na formularz kontaktowy z naddatkiem."
2. "Po zalogowaniu w menu po lewej kliknij **API Keys**, potem **Create API Key**. Nazwa dowolna, np. `moja-strona`, uprawnienia zostaw domyślne (Full access / Sending)."
3. "Skopiuj klucz - zaczyna się od `re_...`. Pokaże się TYLKO RAZ, więc skopiuj od razu. Najbezpieczniej wklej go samodzielnie do pliku `.env.local` (za chwilę go utworzę). Jeśli wkleisz go tutaj, wpiszę go do `.env.local` i dopilnuję, żeby nie trafił do gita."

Adres nadawcy (`from`) - wytłumacz laikowi prosto:
- Na start `from` = `onboarding@resend.dev`. To adres testowy Resend - działa BEZ własnej domeny, ale TYLKO do testów: na darmowym koncie bez zweryfikowanej domeny maile mogą dojść wyłącznie na adres właściciela konta Resend (ten, którym uczestnik zakładał konto). To wystarczy, żeby zobaczyć, że formularz działa.
- Do produkcji (gdy strona ma realnie zbierać kontakty od obcych osób): trzeba w Resend dodać i ZWERYFIKOWAĆ własną domenę (zakładka **Domains**) i wtedy `from` = `kontakt@twojadomena.pl`. To krok na potem (po M6), nie teraz - ale powiedz uczestnikowi 1 zdaniem, że bez własnej domeny formularz nadaje się tylko do testu na własną skrzynkę.

Adres odbiorcy (`to`, czyli `KONTAKT_TO`) - to najważniejszy szczegół, bo tu laik najczęściej cicho utyka:
- Na DARMOWYM koncie bez własnej domeny `KONTAKT_TO` MUSI być dokładnie tym adresem e-mail, którym uczestnik zakładał konto Resend. Inny adres = mail po cichu nie dojdzie (w przeglądarce nie będzie błędu).
- Dlatego zapytaj o JEDNO: "Na jaki adres e-mail mają przychodzić wiadomości z formularza? Na start podaj ten sam e-mail, którym zakładasz konto Resend - inaczej testowy mail nie dojdzie." - to będzie `KONTAKT_TO`.

---

## 2. Zainstaluj Resend

```bash
npm install resend
```

---

## 3. .env.local + .gitignore (guardrail bezpieczeństwa)

1. Utwórz `.env.local` w głównym folderze projektu z treścią (wklej tu klucz uczestnika w miejsce `re_...`). WAŻNE: na darmowym Resend `KONTAKT_TO` = ten sam e-mail, którym uczestnik zakładał konto Resend (inaczej mail nie dojdzie). `KONTAKT_FROM` zostaw `onboarding@resend.dev` aż do momentu zweryfikowania własnej domeny:

```bash
RESEND_API_KEY=re_tu_wklej_klucz
# KONTAKT_TO na start = e-mail, ktorym zalozono konto Resend (darmowy plan wysle tylko tam)
KONTAKT_TO=adres@uczestnika.pl
# KONTAKT_FROM = adres testowy Resend; do produkcji podmien na adres z wlasnej, zweryfikowanej domeny
KONTAKT_FROM=onboarding@resend.dev
```

2. OD RAZU upewnij się, że `.env.local` jest w `.gitignore` (Next.js dodaje go domyślnie, ale sprawdź):

```bash
grep -qx ".env.local" .gitignore && echo "OK .env.local jest w .gitignore" || echo ".env.local" >> .gitignore
```

3. GUARDRAIL: `.env.local` NIGDY nie trafia do gita. Nie dodawaj go do commita. Jeśli `git status` pokazuje `.env.local` jako śledzony - zatrzymaj się i napraw (`git rm --cached .env.local`), zanim cokolwiek zacommitujesz.

---

## 4. API route - src/app/api/contact/route.ts

Utwórz plik `src/app/api/contact/route.ts` z dokładnie taką treścią. Ma serwerową walidację, limity długości, honeypot antyspamowy i generyczne błędy:

```ts
import { NextResponse } from "next/server";
import { Resend } from "resend";

const resend = new Resend(process.env.RESEND_API_KEY);

const MAX_NAME_LENGTH = 80;
const MAX_EMAIL_LENGTH = 120;
const MAX_MESSAGE_LENGTH = 2000;
const MAX_REQUEST_BYTES = 10_000;

type ContactPayload = {
  imie?: unknown;
  email?: unknown;
  wiadomosc?: unknown;
  firma?: unknown;
  startedAt?: unknown;
};

function readText(value: unknown, maxLength: number) {
  if (typeof value !== "string") {
    return "";
  }

  return value.trim().replace(/\s+/g, " ").slice(0, maxLength);
}

function readMessage(value: unknown) {
  if (typeof value !== "string") {
    return "";
  }

  return value.trim().slice(0, MAX_MESSAGE_LENGTH);
}

function isEmail(value: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
}

export async function POST(request: Request) {
  const contentType = request.headers.get("content-type") || "";
  if (!contentType.includes("application/json")) {
    return NextResponse.json(
      { error: "Nieprawidlowy format formularza." },
      { status: 415 }
    );
  }

  const contentLength = Number(request.headers.get("content-length") || "0");
  if (contentLength > MAX_REQUEST_BYTES) {
    return NextResponse.json(
      { error: "Wiadomosc jest za dluga." },
      { status: 413 }
    );
  }

  try {
    const body = (await request.json()) as ContactPayload;

    const honeypot = readText(body.firma, 120);
    if (honeypot) {
      return NextResponse.json({ ok: true });
    }

    const submitTime =
      typeof body.startedAt === "number" ? Date.now() - body.startedAt : null;
    if (submitTime !== null && submitTime >= 0 && submitTime < 2500) {
      return NextResponse.json({ ok: true });
    }

    const imie = readText(body.imie, MAX_NAME_LENGTH).replace(/[\r\n]/g, " ");
    const email = readText(body.email, MAX_EMAIL_LENGTH).toLowerCase();
    const wiadomosc = readMessage(body.wiadomosc);

    if (!imie || !email || !wiadomosc) {
      return NextResponse.json(
        { error: "Uzupelnij imie, e-mail i wiadomosc." },
        { status: 400 }
      );
    }
    if (!isEmail(email)) {
      return NextResponse.json(
        { error: "Podaj poprawny adres e-mail." },
        { status: 400 }
      );
    }
    if (wiadomosc.length < 10) {
      return NextResponse.json(
        { error: "Napisz prosze kilka slow wiecej." },
        { status: 400 }
      );
    }
    if (!process.env.RESEND_API_KEY || !process.env.KONTAKT_TO) {
      console.error("Contact route missing env configuration");
      return NextResponse.json(
        { error: "Formularz nie jest jeszcze skonfigurowany." },
        { status: 500 }
      );
    }

    const { error } = await resend.emails.send({
      from: process.env.KONTAKT_FROM || "onboarding@resend.dev",
      to: process.env.KONTAKT_TO!,
      replyTo: email,
      subject: `Nowa wiadomosc ze strony od ${imie}`,
      text: `Imie: ${imie}\nE-mail: ${email}\n\nWiadomosc:\n${wiadomosc}`,
    });

    if (error) {
      console.error(
        "Resend send failed:",
        error instanceof Error ? error.message : "unknown error"
      );
      return NextResponse.json(
        { error: "Nie udalo sie wyslac wiadomosci. Sprobuj ponownie." },
        { status: 502 }
      );
    }

    return NextResponse.json({ ok: true });
  } catch (error) {
    if (error instanceof SyntaxError) {
      return NextResponse.json(
        { error: "Nieprawidlowy format formularza." },
        { status: 400 }
      );
    }

    console.error(
      "Contact route failed:",
      error instanceof Error ? error.message : "unknown error"
    );
    return NextResponse.json(
      { error: "Cos poszlo nie tak po stronie serwera." },
      { status: 500 }
    );
  }
}
```

Uwaga: `replyTo` ustawia adres nadawcy z formularza, więc uczestnik może odpowiedzieć na maila wprost do osoby, która go napisała. Honeypot `firma` i `startedAt` nie są idealnym antyspamem, ale mocno ograniczają najprostsze boty. Po deployu w M6 dodamy jeszcze rate limit dla `/api/contact` w Vercel WAF, jeśli będzie dostępny na planie uczestnika.

---

## 5. Komponent formularza - src/components/sections/Kontakt.tsx

Utwórz `src/components/sections/Kontakt.tsx`. Używa shadcn (`input`, `button`) i WYŁĄCZNIE zmiennych z `globals.css`. Nagłówek z `text-balance`, zero eyebrow CAPSEM, zero hardkodowanych kolorów.

```tsx
"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

type Stan = "bezczynny" | "wysylanie" | "ok" | "blad";

export function Kontakt() {
  const [stan, setStan] = useState<Stan>("bezczynny");
  const [blad, setBlad] = useState("");
  const [startedAt] = useState(() => Date.now());

  async function onSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setStan("wysylanie");
    setBlad("");

    const form = e.currentTarget;
    const dane = {
      imie: (form.elements.namedItem("imie") as HTMLInputElement).value,
      email: (form.elements.namedItem("email") as HTMLInputElement).value,
      wiadomosc: (form.elements.namedItem("wiadomosc") as HTMLTextAreaElement)
        .value,
      firma: (form.elements.namedItem("firma") as HTMLInputElement).value,
      startedAt,
    };

    try {
      const res = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(dane),
      });
      const json = await res.json();
      if (!res.ok) {
        setStan("blad");
        setBlad(json.error || "Nie udalo sie wyslac. Sprobuj ponownie.");
        return;
      }
      setStan("ok");
      form.reset();
    } catch {
      setStan("blad");
      setBlad("Brak polaczenia. Sprawdz internet i sprobuj ponownie.");
    }
  }

  return (
    <section id="kontakt" className="w-full py-24">
      <div className="mx-auto grid max-w-[1100px] gap-12 px-6 md:grid-cols-[5fr_7fr]">
        <div>
          <h2 className="text-3xl font-[family-name:var(--font-heading)] text-balance md:text-4xl">
            Napisz do mnie
          </h2>
          <p className="mt-4 max-w-[48ch] text-pretty text-[var(--muted)]">
            Zostaw wiadomosc, odpowiadam zwykle w ciagu jednego dnia roboczego.
          </p>
        </div>

        <form onSubmit={onSubmit} className="flex flex-col gap-4">
          <Input name="imie" placeholder="Imie" required maxLength={80} />
          <Input
            name="email"
            type="email"
            placeholder="Twoj e-mail"
            required
            maxLength={120}
          />
          <textarea
            name="wiadomosc"
            required
            rows={5}
            minLength={10}
            maxLength={2000}
            placeholder="W czym moge pomoc?"
            className="rounded-[var(--radius)] border border-[var(--border)] bg-transparent px-4 py-3 text-[var(--foreground)] outline-none focus:border-[var(--accent)]"
          />
          <div className="hidden" aria-hidden="true">
            <label>
              Firma
              <input name="firma" tabIndex={-1} autoComplete="off" />
            </label>
          </div>
          <Button type="submit" disabled={stan === "wysylanie"}>
            {stan === "wysylanie" ? "Wysylam..." : "Wyslij wiadomosc"}
          </Button>

          {stan === "ok" && (
            <p className="text-[var(--accent)]">
              Dziekuje, wiadomosc poszla. Odezwe sie wkrotce.
            </p>
          )}
          {stan === "blad" && <p className="text-red-500">{blad}</p>}
        </form>
      </div>
    </section>
  );
}
```

---

## 6. Wepnij formularz do strony

W `src/app/page.tsx` zaimportuj i wstaw `<Kontakt />` w miejscu sekcji kontaktu (według kolejności z Karty Architektury Treści, zwykle przed stopką):

```tsx
import { Kontakt } from "@/components/sections/Kontakt";

// ...w JSX strony, na właściwym miejscu:
<Kontakt />
```

---

## 7. Co powiedzieć o deployu (jedno zdanie teraz, reszta w M6)

Powiedz uczestnikowi: "Formularz działa już lokalnie. Żeby działał na żywo, w M6 przy deployu na Vercel wkleimy ten sam klucz w panelu Vercel pod tą samą nazwą - `RESEND_API_KEY` (oraz `KONTAKT_TO` i `KONTAKT_FROM`). Plik `.env.local` zostaje na Twoim komputerze, nie idzie do gita - i o to chodzi."

Zanotuj w `PROGRESS.md` w sekcji "Klucze": zmienne `RESEND_API_KEY`, `KONTAKT_TO`, `KONTAKT_FROM` są w `.env.local` (NIE w git), w Vercel trzeba wpisać te same nazwy. W sekcji "Bezpieczeństwo" dopisz: po deployu ustawić rate limit dla `/api/contact` w Vercel WAF, jeśli plan to umożliwia.

---

## 8. Gdy formularz nie działa (fallback dla laika)

Najpierw uniwersalna zasada: jeśli w terminalu jest czerwony tekst - skopiuj go w całości i wklej do mnie z prośbą "napraw i wyjaśnij po polsku". Najczęstsze przyczyny po kolei:

- **Nie przychodzi mail, brak błędu w przeglądarce.** Najczęściej brak klucza albo serwer dev nie został zrestartowany po dodaniu `.env.local`. Zatrzymaj serwer (Ctrl+C) i uruchom `npm run dev` jeszcze raz - zmienne z `.env.local` ładują się tylko przy starcie.
- **Błąd "Missing API key" / `RESEND_API_KEY is undefined`.** Klucza nie ma w `.env.local` albo jest literówka w nazwie zmiennej. Sprawdź, że linia to dokładnie `RESEND_API_KEY=re_...` bez spacji wokół `=`.
- **Mail nie dochodzi, a w logach jest błąd Resend o adresie.** Na darmowym koncie bez własnej domeny `to` musi być adresem właściciela konta Resend. Ustaw `KONTAKT_TO` na e-mail, którym uczestnik zakładał konto Resend.
- **404 na `/api/contact`.** Plik jest w złym miejscu. Ma być dokładnie `src/app/api/contact/route.ts` (folder `api`, podfolder `contact`, plik `route.ts`).
- **Build/dev krzyczy o `"use client"`.** Komponent `Kontakt.tsx` musi mieć `"use client"` w pierwszej linii (używa `useState`) - jest w szkielecie wyżej, nie usuwaj go.

GUARDRAIL: jeśli miał(a)by wyciec klucz (np. trafił do gita) - po naprawie wygeneruj NOWY klucz w Resend (zakładka API Keys), stary uznaj za spalony i usuń. Stare klucze w historii gita są niebezpieczne.
