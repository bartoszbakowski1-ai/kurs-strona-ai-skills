# Animacje premium (motion/react) - jeden wzorzec, zero cyrku

Wspolny plik dla skilli `lp` i `oferta`. Daje efekt WOW przez subtelny ruch, ktory wyglada jak premium agencja, a nie jak generyczny output AI.

Biblioteka: `motion` (nastepca framer-motion). Import ZAWSZE `motion/react`, NIGDY `framer-motion` (legacy, ciezszy bundle).
Instalacja raz: `npm install motion`.

## Regula nadrzedna: subtelnosc

- Tylko transform + opacity + filter (GPU). NIGDY nie animuj layoutu (width/height/top/left/margin) - jank.
- Reveal raz, przy wejsciu w viewport. `viewport={{ once: true }}`. Nic nie pulsuje w petli.
- Hero: max JEDEN element w ruchu naraz (naglowek fade-up), reszta czeka. Nadmiar ruchu = tanio.
- Zakaz: bounce/spring na duzych blokach, rotacje, fly-in z daleka (x: -200), liczniki-cyrk, parallax na tekscie czytanym.
- Reduced motion: owin aplikacje w `<MotionConfig reducedMotion="user">` (w layout.tsx). Kto ma wlaczone "ogranicz ruch" w systemie, dostaje czyste opacity bez przesuniec. To dostepnosc, nie opcja.

## Klocek 1: Reveal (uzywaj do KAZDEJ sekcji)

Plik `src/components/Reveal.tsx`:

```tsx
"use client";
import { motion } from "motion/react";

type Props = { children: React.ReactNode; delay?: number; className?: string };

export function Reveal({ children, delay = 0, className }: Props) {
  return (
    <motion.div
      className={className}
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, amount: 0.35, margin: "-80px" }}
      transition={{ duration: 0.6, ease: [0.17, 0.55, 0.55, 1], delay }}
    >
      {children}
    </motion.div>
  );
}
```

Wartosci premium (nie ruszaj bez powodu): y: 24 (subtelnie, nie 100), duration 0.6, ease cubic `[0.17,0.55,0.55,1]`, trigger przy 35% widocznosci. Sekcje owijaj `<Reveal>`, sasiednie elementy w jednej sekcji rozsuwaj `delay={0.08}`, `delay={0.16}` (recznie, max 3-4 kroki - czytelniejsze niz staggerChildren dla laika).

## Klocek 2: StaggerList (punkty "co dostajesz", program, zakres, FAQ)

Plik `src/components/StaggerList.tsx`:

```tsx
"use client";
import { motion } from "motion/react";

const list = { hidden: {}, show: { transition: { staggerChildren: 0.08, delayChildren: 0.1 } } };
const item = {
  hidden: { opacity: 0, y: 16 },
  show: { opacity: 1, y: 0, transition: { duration: 0.5, ease: [0.17, 0.55, 0.55, 1] } },
};

export function StaggerList({ children }: { children: React.ReactNode[] }) {
  return (
    <motion.ul variants={list} initial="hidden" whileInView="show" viewport={{ once: true, amount: 0.3 }}>
      {children.map((c, i) => (<motion.li key={i} variants={item}>{c}</motion.li>))}
    </motion.ul>
  );
}
```

Stagger 0.08s (subtelna kaskada, nie 0.3 = wleczenie). To moment WOW na liscie korzysci - elementy wjezdzaja jeden po drugim, szybko.

## Klocek 3 (opcjonalny, JEDEN na strone): WordsReveal - maskowane slowa na glownym naglowku

Tylko na H1 hero albo jednym naglowku-manifescie. NIGDY na kazdym naglowku - traci sile. W ofercie B2B NIE uzywaj (za sprzedazowe).

Plik `src/components/WordsReveal.tsx`:

```tsx
"use client";
import { motion } from "motion/react";

export function WordsReveal({ text, className }: { text: string; className?: string }) {
  const words = text.split(" ");
  return (
    <span className={className}>
      {words.map((w, i) => (
        <span key={i} className="inline-block overflow-hidden align-bottom">
          <motion.span
            className="inline-block"
            initial={{ y: "100%" }}
            whileInView={{ y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, ease: [0.33, 1, 0.68, 1], delay: i * 0.05 }}
          >
            {w}&nbsp;
          </motion.span>
        </span>
      ))}
    </span>
  );
}
```

Maskowane slowa wjezdzajace od dolu (`overflow-hidden` na wrapperze + `y:100%`) = sygnatura premium. delay i*0.05 (szybko). Jeden naglowek = wow, piec naglowkow = cyrk.

## Klocek 4 (opcjonalny): ParallaxImage - subtelny parallax na ZDJECIU (nie na tekscie)

Plik `src/components/ParallaxImage.tsx`:

```tsx
"use client";
import { useRef } from "react";
import { motion, useScroll, useTransform } from "motion/react";

export function ParallaxImage({ src, alt }: { src: string; alt: string }) {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({ target: ref, offset: ["start end", "end start"] });
  const y = useTransform(scrollYProgress, [0, 1], ["-6%", "6%"]); // subtelnie, nie -50%
  return (
    <div ref={ref} className="overflow-hidden rounded-[var(--radius)]">
      <motion.img src={src} alt={alt} style={{ y }} className="w-full object-cover scale-110" />
    </div>
  );
}
```

Zakres parallaxu ZALEDWIE 6% (nie 1000px z tutoriali - to wygladaloby jak slajdy). `scale-110` zeby przesuniecie nie odslonilo krawedzi. Tylko /lp, nie /oferta.

## Mikro-interakcje (premium, nie cyrk)

- Przyciski CTA: `transition-transform hover:-translate-y-0.5 active:translate-y-0` + `transition-colors`. Zaden glow, zaden scale-110.
- Karty klikalne: `hover:-translate-y-1 transition-transform` TYLKO tam, gdzie naprawde klikalne.
- Bez `animate-pulse`, `animate-bounce`, tlowych floating blobs, ciaglych gradient-animacji.

## Setup w layout.tsx (raz)

```tsx
import { MotionConfig } from "motion/react";
// w <body>:
<MotionConfig reducedMotion="user">{children}</MotionConfig>
```

## ANTI-AI-LOOK animacji (twarde, sprawdzaj przy KAZDEJ sekcji)

ZAKAZ:
- import z `framer-motion` (ma byc `motion/react`)
- ruch w petli (pulse/bounce/floating blob/animowany gradient w tle)
- reveal bez `once: true` (re-trigger przy scrollu w gore = tandeta)
- spring-bounce na duzych sekcjach, rotacje, fly-in z duzej odleglosci (x/y > 60)
- WordsReveal na wiecej niz JEDNYM naglowku
- parallax na czytanym tekscie; licznik "od 0 do X" jako efekt
- animacja, ktora opoznia odczytanie tresci (CTA musi byc widoczny i klikalny od pierwszej klatki)

NAKAZ:
- `<MotionConfig reducedMotion="user">` w layout.tsx (dostepnosc)
- transform/opacity/filter only, `viewport once`, duration 0.5-0.8s, ease `[0.17,0.55,0.55,1]`
- jeden klocek `Reveal` do calej strony zamiast 10 roznych improwizacji
- hero: jeden element w ruchu, CTA stabilne i klikalne od pierwszej klatki

## Mapowanie WOW

- /lp: H1 hero = WordsReveal (jedyne uzycie maski); korzysci + program = StaggerList; KAZDA sekcja = Reveal; zdjecie hero = ParallaxImage 6% (opcjonalnie).
- /oferta: hero = zwykly Reveal (spokojnie, NIE WordsReveal); cytat klienta w "Co zrozumialem" = Reveal z lekkim delay (jedyny akcent); zakres + proces = StaggerList; zero parallaxu.
