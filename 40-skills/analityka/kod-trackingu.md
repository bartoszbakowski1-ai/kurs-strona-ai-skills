# Kod trackingu - gotowe snippety (dla skilla analityka)

Otwieraj ten plik DOPIERO przy konkretnym kroku, nie caly na raz (oszczednosc tokenow). Caly kod uzywa zmiennych srodowiskowych, nigdy nie wpisuj prawdziwych ID do plikow, ktore ida do gita.

ZASADA KRYTYCZNA: w jednym renderze (np. root layout) moze byc TYLKO JEDEN `next/script` z `dangerouslySetInnerHTML`. Tym jednym jest GTM. GA4 i Meta Pixel ida przez panel GTM jako tagi, nie jako osobne skrypty w kodzie. Vercel Analytics to komponent, nie liczy sie do tego limitu.

---

## 1. Vercel Analytics (licznik ruchu)

```bash
npm install @vercel/analytics
```

W `src/app/layout.tsx` - import na gorze i komponent tuz przed zamknieciem `</body>`:

```tsx
import { Analytics } from "@vercel/analytics/next";

// ...wewnatrz <body>, na koncu:
        {children}
        <Analytics />
      </body>
```

To wszystko. Po deployu ruch widac w panelu Vercel -> zakladka Analytics. Zero ID, zero konfiguracji.

---

## 2. GTM (jeden inline skrypt) - GA4 i Pixel pojda przez panel GTM

W `.env.local` (plik jest w `.gitignore`, NIE commitujemy):

```
NEXT_PUBLIC_GTM_ID=GTM-XXXXXXX
```

Ta sama zmienna musi trafic RECZNIE do Vercel (Settings -> Environment Variables), inaczej tracking nie zadziala na zywo.

W `src/app/layout.tsx`. To jest TEN JEDEN inline skrypt. Nie dodawaj obok drugiego inline `next/script`.

```tsx
import Script from "next/script";

const GTM_ID = process.env.NEXT_PUBLIC_GTM_ID;

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pl">
      <head>
        {GTM_ID ? (
          <Script
            id="gtm"
            strategy="afterInteractive"
            dangerouslySetInnerHTML={{
              __html: `(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer','${GTM_ID}');`,
            }}
          />
        ) : null}
      </head>
      <body>
        {GTM_ID ? (
          <noscript>
            <iframe
              src={`https://www.googletagmanager.com/ns.html?id=${GTM_ID}`}
              height="0"
              width="0"
              style={{ display: "none", visibility: "hidden" }}
            />
          </noscript>
        ) : null}
        {children}
      </body>
    </html>
  );
}
```

GA4 w panelu GTM (uczestnik klika, zero kodu): tagmanager.google.com -> Tagi -> Nowy -> Google Analytics: konfiguracja GA4 -> wklej Measurement ID `G-XXXX` -> Trigger: All Pages -> Zapisz -> Wyslij (Submit). Bez Submit tag nie dziala.

---

## 3. Google Search Console (weryfikacja przez znacznik)

W `src/app/layout.tsx`, w eksportowanym obiekcie `metadata` (to NIE jest inline skrypt, wiec nie koliduje z GTM):

```tsx
export const metadata = {
  // ...reszta metadata
  verification: {
    google: "TWOJ_KOD_WERYFIKACYJNY_Z_GSC",
  },
};
```

Kod bierze sie z search.google.com/search-console -> dodaj zasob -> weryfikacja "znacznik HTML" -> skopiuj wartosc atrybutu `content`. Po deployu wroc do GSC i kliknij Zweryfikuj. Alternatywa bez kodu: weryfikacja przez DNS (rekord TXT u operatora domeny).

---

## 4. sitemap.ts + robots.ts (natywne Next.js App Router)

`src/app/sitemap.ts` - wypisz realnie istniejace podstrony (dostosuj liste do mapy systemu uczestnika):

```ts
import type { MetadataRoute } from "next";

const BASE = "https://TWOJA-DOMENA.pl";

export default function sitemap(): MetadataRoute.Sitemap {
  const sciezki = ["", "/oferta", "/o-mnie", "/kontakt"]; // dodaj /blog, /realizacje itd. gdy istnieja
  return sciezki.map((s) => ({
    url: `${BASE}${s}`,
    lastModified: new Date(),
    changeFrequency: "monthly",
    priority: s === "" ? 1 : 0.7,
  }));
}
```

`src/app/robots.ts`:

```ts
import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: { userAgent: "*", allow: "/" },
    sitemap: "https://TWOJA-DOMENA.pl/sitemap.xml",
  };
}
```

Podmien `TWOJA-DOMENA.pl` na realna domene uczestnika.

---

## 5. Self-canonical (zeby Google nie widzial duplikatow)

W `src/app/layout.tsx` ustaw `metadataBase`, a w KAZDEJ stronie (`page.tsx`) jej wlasny canonical. Samo `metadataBase` NIE generuje tagu canonical - trzeba `alternates.canonical` jawnie.

Layout:

```tsx
export const metadata = {
  metadataBase: new URL("https://TWOJA-DOMENA.pl"),
  // ...
};
```

Strona glowna `src/app/page.tsx` i kazda podstrona:

```tsx
export const metadata = {
  alternates: { canonical: "/" }, // dla /oferta -> "/oferta", dla /o-mnie -> "/o-mnie"
};
```

Trasa dynamiczna (np. `src/app/blog/[slug]/page.tsx`) - przez `generateMetadata`:

```tsx
export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  return { alternates: { canonical: `/blog/${slug}` } };
}
```

Strona z komponentem klienckim bez wlasnego `metadata`: dodaj maly `layout.tsx` w jej folderze z samym `alternates`.

---

## 6. Mini baner zgody na cookies + notka prywatnosci

Lekki baner (bez zewnetrznych bibliotek). `src/components/CookieBaner.tsx`:

```tsx
"use client";
import { useEffect, useState } from "react";

export function CookieBaner() {
  const [widoczny, setWidoczny] = useState(false);
  useEffect(() => {
    if (!localStorage.getItem("zgoda-cookies")) setWidoczny(true);
  }, []);
  if (!widoczny) return null;
  return (
    <div style={{ position: "fixed", bottom: 0, left: 0, right: 0, zIndex: 50, padding: "1rem", background: "var(--foreground)", color: "var(--background)" }}>
      <div style={{ maxWidth: "70rem", margin: "0 auto", display: "flex", gap: "1rem", alignItems: "center", flexWrap: "wrap" }}>
        <p style={{ margin: 0, flex: 1, minWidth: "16rem" }}>
          Uzywam plikow cookies do analizy ruchu na stronie. Wiecej w <a href="/prywatnosc" style={{ color: "inherit", textDecoration: "underline" }}>notce o prywatnosci</a>.
        </p>
        <button
          onClick={() => { localStorage.setItem("zgoda-cookies", "tak"); setWidoczny(false); }}
          style={{ padding: "0.5rem 1.25rem", background: "var(--accent)", color: "var(--accent-foreground)", border: "none", borderRadius: "0.5rem", cursor: "pointer" }}
        >
          Akceptuje
        </button>
      </div>
    </div>
  );
}
```

Wepnij `<CookieBaner />` w `layout.tsx` tuz przed `<Analytics />`. Dodaj prosta strone `src/app/prywatnosc/page.tsx` z krotka notka: kto zbiera dane (imie/firma uczestnika), jakie narzedzia (Google Analytics, ewentualnie Meta Pixel), w jakim celu (statystyka ruchu), oraz kontakt mailowy. To wersja minimum. Pelny Consent Mode v2 i kompletna polityka prywatnosci to material rozszerzony.

---

## 7. ZAAWANSOWANE - Meta Pixel jako kod (tylko na wyrazna potrzebe)

Domyslnie Pixel idzie przez GTM jako tag (sekcja 2). Wersji kodowej uzyj TYLKO, gdy uczestnik swiadomie potrzebuje eventow w kodzie (np. precyzyjny Purchase). Wtedy jako OSOBNY client component (osobny render), nigdy jako drugi inline skrypt w layoucie.

`src/components/analytics/MetaPixel.tsx`:

```tsx
"use client";
import Script from "next/script";

export function MetaPixel({ pixelId }: { pixelId: string }) {
  return (
    <Script
      id="meta-pixel"
      strategy="afterInteractive"
      dangerouslySetInnerHTML={{
        __html: `!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','https://connect.facebook.net/en_US/fbevents.js');fbq('init','${pixelId}');fbq('track','PageView');`,
      }}
    />
  );
}
```

Uzycie: `<MetaPixel pixelId={process.env.NEXT_PUBLIC_META_PIXEL_ID!} />`, `NEXT_PUBLIC_META_PIXEL_ID` w `.env.local` + Vercel. OSTRZEZENIE: to jest drugi inline skrypt obok GTM. Bezpiecznie dziala tylko jako osobny `'use client'` komponent (inny render niz server layout). Jesli pojawi sie blad `appendChild` / hydration - wroc do wariantu "Pixel jako tag w GTM" i usun ten komponent. Eventy sprzedazowe (Purchase z deduplikacja, CAPI server-side) to juz pakiet rozszerzony, nie ten skill.
