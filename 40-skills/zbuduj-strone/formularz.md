# Formularz kontaktowy przez Resend (plik towarzyszacy skilla zbuduj-strone)

Ladowany on-demand z Kroku 4 skilla `zbuduj-strone`. Otworz go DOPIERO przy budowie formularza - oszczedzasz tokeny uczestnika. To golden path: Resend + Next.js API route. NIE n8n, NIE Formspree. Klucz w `.env.local`, NIGDY w gicie, w Vercel ta sama nazwa zmiennej.

Tu masz: (1) skad uczestnik bierze klucz Resend, (2) zaleznosc do instalacji, (3) `.env.local` + `.gitignore`, (4) gotowy `route.ts`, (5) gotowy komponent formularza, (6) wpiecie do strony, (7) co powiedziec o deployu, (8) najczestsze problemy. Wykonaj po kolei.

---

## 1. Skad wziac klucz Resend (poprowadz uczestnika, prostym jezykiem)

Powiedz mniej wiecej tak (po jednym kroku, czekaj az zrobi):
1. "Wejdz na resend.com i zaloz darmowe konto (mozna przez Google/GitHub). Darmowy plan to 100 maili dziennie - na formularz kontaktowy z naddatkiem."
2. "Po zalogowaniu w menu po lewej kliknij **API Keys**, potem **Create API Key**. Nazwa dowolna, np. `moja-strona`, uprawnienia zostaw domyslne (Full access / Sending)."
3. "Skopiuj klucz - zaczyna sie od `re_...`. Pokaze sie TYLKO RAZ, wiec skopiuj od razu. Wklej mi go tutaj albo wklej samodzielnie do pliku `.env.local` (za chwile go utworze)."

Adres nadawcy (`from`) - wytlumacz laikowi prosto:
- Na start `from` = `onboarding@resend.dev`. To adres testowy Resend - dziala BEZ wlasnej domeny, ale TYLKO do testow: na darmowym koncie bez zweryfikowanej domeny maile moga dojsc wylacznie na adres wlasciciela konta Resend (ten, ktorym uczestnik zakladal konto). To wystarczy, zeby zobaczyc, ze formularz dziala.
- Do produkcji (gdy strona ma realnie zbierac kontakty od obcych osob): trzeba w Resend dodac i ZWERYFIKOWAC wlasna domene (zakladka **Domains**) i wtedy `from` = `kontakt@twojadomena.pl`. To krok na potem (po M6), nie teraz - ale powiedz uczestnikowi 1 zdaniem, ze bez wlasnej domeny formularz nadaje sie tylko do testu na wlasna skrzynke.

Adres odbiorcy (`to`, czyli `KONTAKT_TO`) - to najwazniejszy szczegol, bo tu laik najczesciej cicho utyka:
- Na DARMOWYM koncie bez wlasnej domeny `KONTAKT_TO` MUSI byc dokladnie tym adresem e-mail, ktorym uczestnik zakladal konto Resend. Inny adres = mail po cichu nie dojdzie (w przegladarce nie bedzie bledu).
- Dlatego zapytaj o JEDNO: "Na jaki adres e-mail maja przychodzic wiadomosci z formularza? Na start podaj ten sam e-mail, ktorym zakladasz konto Resend - inaczej testowy mail nie dojdzie." - to bedzie `KONTAKT_TO`.

---

## 2. Zainstaluj Resend

```bash
npm install resend
```

---

## 3. .env.local + .gitignore (guardrail bezpieczenstwa)

1. Utworz `.env.local` w glownym folderze projektu z trescia (wklej tu klucz uczestnika w miejsce `re_...`). WAZNE: na darmowym Resend `KONTAKT_TO` = ten sam e-mail, ktorym uczestnik zakladal konto Resend (inaczej mail nie dojdzie). `KONTAKT_FROM` zostaw `onboarding@resend.dev` az do momentu zweryfikowania wlasnej domeny:

```bash
RESEND_API_KEY=re_tu_wklej_klucz
# KONTAKT_TO na start = e-mail, ktorym zalozono konto Resend (darmowy plan wysle tylko tam)
KONTAKT_TO=adres@uczestnika.pl
# KONTAKT_FROM = adres testowy Resend; do produkcji podmien na adres z wlasnej, zweryfikowanej domeny
KONTAKT_FROM=onboarding@resend.dev
```

2. OD RAZU upewnij sie, ze `.env.local` jest w `.gitignore` (Next.js dodaje go domyslnie, ale sprawdz):

```bash
grep -qx ".env.local" .gitignore && echo "OK .env.local jest w .gitignore" || echo ".env.local" >> .gitignore
```

3. GUARDRAIL: `.env.local` NIGDY nie trafia do gita. Nie dodawaj go do commita. Jesli `git status` pokazuje `.env.local` jako sledzony - zatrzymaj sie i napraw (`git rm --cached .env.local`), zanim cokolwiek zacommitujesz.

---

## 4. API route - src/app/api/contact/route.ts

Utworz plik `src/app/api/contact/route.ts` z dokladnie taka trescia (to dziala out-of-the-box):

```ts
import { NextResponse } from "next/server";
import { Resend } from "resend";

const resend = new Resend(process.env.RESEND_API_KEY);

export async function POST(request: Request) {
  try {
    const { imie, email, wiadomosc } = await request.json();

    // Walidacja - proste, ale wystarczajace
    if (!imie || !email || !wiadomosc) {
      return NextResponse.json(
        { error: "Uzupelnij imie, e-mail i wiadomosc." },
        { status: 400 }
      );
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      return NextResponse.json(
        { error: "Podaj poprawny adres e-mail." },
        { status: 400 }
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
      console.error("Resend error:", error);
      return NextResponse.json(
        { error: "Nie udalo sie wyslac wiadomosci. Sprobuj ponownie." },
        { status: 502 }
      );
    }

    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error("Contact route error:", err);
    return NextResponse.json(
      { error: "Cos poszlo nie tak po stronie serwera." },
      { status: 500 }
    );
  }
}
```

Uwaga: `replyTo` ustawia adres nadawcy z formularza, wiec uczestnik moze odpowiedziec na maila wprost do osoby, ktora go napisala.

---

## 5. Komponent formularza - src/components/sections/Kontakt.tsx

Utworz `src/components/sections/Kontakt.tsx`. Uzywa shadcn (`input`, `button`) i WYLACZNIE zmiennych z `globals.css`. Naglowek z `text-balance`, zero eyebrow CAPSEM, zero hardkodowanych kolorow.

```tsx
"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

type Stan = "bezczynny" | "wysylanie" | "ok" | "blad";

export function Kontakt() {
  const [stan, setStan] = useState<Stan>("bezczynny");
  const [blad, setBlad] = useState("");

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
          <Input name="imie" placeholder="Imie" required />
          <Input name="email" type="email" placeholder="Twoj e-mail" required />
          <textarea
            name="wiadomosc"
            required
            rows={5}
            placeholder="W czym moge pomoc?"
            className="rounded-[var(--radius)] border border-[var(--border)] bg-transparent px-4 py-3 text-[var(--foreground)] outline-none focus:border-[var(--accent)]"
          />
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

W `src/app/page.tsx` zaimportuj i wstaw `<Kontakt />` w miejscu sekcji kontaktu (wedlug kolejnosci z Karty Architektury Tresci, zwykle przed stopka):

```tsx
import { Kontakt } from "@/components/sections/Kontakt";

// ...w JSX strony, na wlasciwym miejscu:
<Kontakt />
```

---

## 7. Co powiedziec o deployu (jedno zdanie teraz, reszta w M6)

Powiedz uczestnikowi: "Formularz dziala juz lokalnie. Zeby dzialal na zywo, w M6 przy deployu na Vercel wkleimy ten sam klucz w panelu Vercel pod ta sama nazwa - `RESEND_API_KEY` (oraz `KONTAKT_TO` i `KONTAKT_FROM`). Plik `.env.local` zostaje na Twoim komputerze, nie idzie do gita - i o to chodzi."

Zanotuj w `PROGRESS.md` w sekcji "Klucze": zmienne `RESEND_API_KEY`, `KONTAKT_TO`, `KONTAKT_FROM` sa w `.env.local` (NIE w git), w Vercel trzeba wpisac te same nazwy.

---

## 8. Gdy formularz nie dziala (fallback dla laika)

Najpierw uniwersalna zasada: jesli w terminalu jest czerwony tekst - skopiuj go w calosci i wklej do mnie z prosba "napraw i wyjasnij po polsku". Najczestsze przyczyny po kolei:

- **Nie przychodzi mail, brak bledu w przegladarce.** Najczesciej brak klucza albo serwer dev nie zostal zrestartowany po dodaniu `.env.local`. Zatrzymaj serwer (Ctrl+C) i uruchom `npm run dev` jeszcze raz - zmienne z `.env.local` laduja sie tylko przy starcie.
- **Blad "Missing API key" / `RESEND_API_KEY is undefined`.** Klucza nie ma w `.env.local` albo jest literowka w nazwie zmiennej. Sprawdz, ze linia to dokladnie `RESEND_API_KEY=re_...` bez spacji wokol `=`.
- **Mail nie dochodzi, a w logach jest blad Resend o adresie.** Na darmowym koncie bez wlasnej domeny `to` musi byc adresem wlasciciela konta Resend. Ustaw `KONTAKT_TO` na e-mail, ktorym uczestnik zakladal konto Resend.
- **404 na `/api/contact`.** Plik jest w zlym miejscu. Ma byc dokladnie `src/app/api/contact/route.ts` (folder `api`, podfolder `contact`, plik `route.ts`).
- **Build/dev krzyczy o `"use client"`.** Komponent `Kontakt.tsx` musi miec `"use client"` w pierwszej linii (uzywa `useState`) - jest w szkielecie wyzej, nie usuwaj go.

GUARDRAIL: jesli mial(a)by wyciec klucz (np. trafil do gita) - po naprawie wygeneruj NOWY klucz w Resend (zakladka API Keys), stary uznaj za spalony i usun. Stare klucze w historii gita sa niebezpieczne.
