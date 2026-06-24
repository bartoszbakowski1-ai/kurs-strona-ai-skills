# Kod trackingu - gotowe snippety (dla skilla analityka)

Otwieraj ten plik DOPIERO przy konkretnym kroku, nie cały na raz (oszczędność tokenów). Cały kod używa zmiennych środowiskowych, nigdy nie wpisuj prawdziwych ID do plików, które idą do gita.

ZASADA KRYTYCZNA: w jednym renderze (np. root layout) może być TYLKO JEDEN `next/script` z `dangerouslySetInnerHTML`. Tym jednym jest GTM. GA4 i Meta Pixel idą przez panel GTM jako tagi, nie jako osobne skrypty w kodzie. Vercel Analytics to komponent, nie liczy się do tego limitu.

---

## 1. Vercel Analytics (licznik ruchu)

```bash
npm install @vercel/analytics
```

W `src/app/layout.tsx` - import na górze i komponent tuż przed zamknięciem `</body>`:

```tsx
import { Analytics } from "@vercel/analytics/next";

// ...wewnątrz <body>, na końcu:
        {children}
        <Analytics />
      </body>
```

To wszystko. Po deployu ruch widać w panelu Vercel -> zakładka Analytics. Zero ID, zero konfiguracji.

---

## 2. GTM (jeden inline skrypt) - GA4 i Pixel pojdą przez panel GTM

W `.env.local` (plik jest w `.gitignore`, NIE commitujemy):

```
NEXT_PUBLIC_GTM_ID=GTM-XXXXXXX
```

Ta sama zmienna musi trafić RĘCZNIE do Vercel (Settings -> Environment Variables), inaczej tracking nie zadziała na żywo.

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

GA4 w panelu GTM (uczestnik klika, zero kodu): tagmanager.google.com -> Tagi -> Nowy -> Google Analytics: konfiguracja GA4 -> wklej Measurement ID `G-XXXX` -> Trigger: All Pages -> Zapisz -> Wyślij (Submit). Bez Submit tag nie działa.

---

## 3. Google Search Console (weryfikacja przez znacznik)

W `src/app/layout.tsx`, w eksportowanym obiekcie `metadata` (to NIE jest inline skrypt, więc nie koliduje z GTM):

```tsx
export const metadata = {
  // ...reszta metadata
  verification: {
    google: "TWOJ_KOD_WERYFIKACYJNY_Z_GSC",
  },
};
```

Kod bierze się z search.google.com/search-console -> dodaj zasób -> weryfikacja "znacznik HTML" -> skopiuj wartość atrybutu `content`. Po deployu wróć do GSC i kliknij Zweryfikuj. Alternatywa bez kodu: weryfikacja przez DNS (rekord TXT u operatora domeny).

---

## 4. sitemap.ts + robots.ts (natywne Next.js App Router)

`src/app/sitemap.ts` - wypisz realnie istniejące podstrony (dostosuj listę do mapy systemu uczestnika):

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

Podmień `TWOJA-DOMENA.pl` na realną domenę uczestnika.

---

## 5. Self-canonical (żeby Google nie widział duplikatów)

W `src/app/layout.tsx` ustaw `metadataBase`, a w KAŻDEJ stronie (`page.tsx`) jej własny canonical. Samo `metadataBase` NIE generuje tagu canonical - trzeba `alternates.canonical` jawnie.

Layout:

```tsx
export const metadata = {
  metadataBase: new URL("https://TWOJA-DOMENA.pl"),
  // ...
};
```

Strona główna `src/app/page.tsx` i każda podstrona:

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

Strona z komponentem klienckim bez własnego `metadata`: dodaj mały `layout.tsx` w jej folderze z samym `alternates`.

---

## 6. Mini baner zgody na cookies + notka prywatności

Lekki baner (bez zewnętrznych bibliotek). `src/components/CookieBaner.tsx`:

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
          Używam plików cookies do analizy ruchu na stronie. Więcej w <a href="/prywatnosc" style={{ color: "inherit", textDecoration: "underline" }}>notce o prywatności</a>.
        </p>
        <button
          onClick={() => { localStorage.setItem("zgoda-cookies", "tak"); setWidoczny(false); }}
          style={{ padding: "0.5rem 1.25rem", background: "var(--accent)", color: "var(--accent-foreground)", border: "none", borderRadius: "0.5rem", cursor: "pointer" }}
        >
          Akceptuję
        </button>
      </div>
    </div>
  );
}
```

Wepnij `<CookieBaner />` w `layout.tsx` tuż przed `<Analytics />`. Dodaj prostą stronę `src/app/prywatnosc/page.tsx` z krótką notką: kto zbiera dane (imię/firma uczestnika), jakie narzędzia (Google Analytics, ewentualnie Meta Pixel), w jakim celu (statystyka ruchu), oraz kontakt mailowy. To wersja minimum. Pełny Consent Mode v2 i kompletna polityka prywatności to materiał rozszerzony.

---

## 7. ZAAWANSOWANE - Meta Pixel jako kod (tylko na wyraźną potrzebę)

Domyślnie Pixel idzie przez GTM jako tag (sekcja 2). Wersji kodowej użyj TYLKO, gdy uczestnik świadomie potrzebuje eventów w kodzie (np. precyzyjny Purchase). Wtedy jako OSOBNY client component (osobny render), nigdy jako drugi inline skrypt w layoucie.

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

Użycie: `<MetaPixel pixelId={process.env.NEXT_PUBLIC_META_PIXEL_ID!} />`, `NEXT_PUBLIC_META_PIXEL_ID` w `.env.local` + Vercel. OSTRZEŻENIE: to jest drugi inline skrypt obok GTM. Bezpiecznie działa tylko jako osobny `'use client'` komponent (inny render niż server layout). Jeśli pojawi się błąd `appendChild` / hydration - wróć do wariantu "Pixel jako tag w GTM" i usuń ten komponent. Eventy sprzedażowe (Purchase z deduplikacją, CAPI server-side) to już pakiet rozszerzony, nie ten skill.
