# Animacje strony-systemu (motion/react) - warstwa ruchu, zero cyrku

Plik on-demand dla skilla `zbuduj-strone`. Otwierasz go RAZ, gdy zaczynasz nakładać ruch (Krok 3.5). Fundament (paczka `motion`, `<MotionConfig>`, komponenty `Reveal` i `StaggerList`) zrobil juz skill `design` w M4 - tu tylko APLIKUJESZ ten ruch na sekcje i, opcjonalnie, dokladasz jeden akcent WOW.

Cel: strona ma oddychac. Subtelny ruch przy wejsciu sekcji w viewport czyta sie jak premium agencja. Brak ruchu = plaski szablon = jeden z tellow "to AI". Nadmiar ruchu = tanio. Celujemy w srodek: spokojny reveal wszedzie + JEDEN mocniejszy moment na cala strone.

Biblioteka: `motion` (nastepca framer-motion). Import ZAWSZE `motion/react`, NIGDY `framer-motion` (legacy, ciezszy bundle). Instalacja: `npm install motion` (robi to skill `design`; jesli paczki brak - doinstaluj raz).

## Regula nadrzedna: subtelnosc (trzymaj sie bezwzglednie)

- Tylko transform + opacity + filter (GPU). NIGDY nie animuj layoutu (width/height/top/left/margin) - jank.
- Reveal raz, przy wejsciu w viewport. `viewport={{ once: true }}`. Nic nie pulsuje w petli.
- Hero: max JEDEN element w ruchu naraz. CTA jest widoczny i klikalny od pierwszej klatki - animacja nie moze opozniac odczytania tresci ani klikniecia.
- Reduced motion: aplikacja owinieta w `<MotionConfig reducedMotion="user">` (zrobil to `design` w layout.tsx). Kto ma "ogranicz ruch" w systemie, dostaje czyste opacity bez przesuniec. To dostepnosc, nie opcja - nie usuwaj tego.
- Zakaz: bounce/spring na duzych blokach, rotacje, fly-in z daleka (x/y > 60), liczniki-cyrk, parallax na czytanym tekscie, animowany gradient/floating blob w tle.

## Co juz istnieje po skillu design (nie tworz drugi raz)

Skill `design` utworzyl w `src/components/motion/`:
- `Reveal.tsx` - fade-up raz przy wejsciu w viewport (do KAZDEJ sekcji),
- `StaggerList.tsx` - kaskada elementow listy (korzysci, program, FAQ).

Oraz owinal `{children}` w `layout.tsx` w `<MotionConfig reducedMotion="user">`. Jesli ktoregos z tych elementow brak (np. ktos pominal `design`) - utworz je z kodu nizej, raz.

### Reveal.tsx (gdyby trzeba odtworzyc)

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

Wartosci premium (nie ruszaj bez powodu): y: 24 (subtelnie, nie 100), duration 0.6, ease cubic `[0.17,0.55,0.55,1]`, trigger przy 35% widocznosci.

### StaggerList.tsx (gdyby trzeba odtworzyc)

```tsx
"use client";
import { motion } from "motion/react";

const list = { hidden: {}, show: { transition: { staggerChildren: 0.08, delayChildren: 0.1 } } };
const item = {
  hidden: { opacity: 0, y: 16 },
  show: { opacity: 1, y: 0, transition: { duration: 0.5, ease: [0.17, 0.55, 0.55, 1] } },
};

export function StaggerList({ children, className }: { children: React.ReactNode[]; className?: string }) {
  return (
    <motion.ul className={className} variants={list} initial="hidden" whileInView="show" viewport={{ once: true, amount: 0.3 }}>
      {children.map((c, i) => (<motion.li key={i} variants={item}>{c}</motion.li>))}
    </motion.ul>
  );
}
```

Stagger 0.08s (subtelna kaskada, nie 0.3 = wleczenie). To moment WOW na liscie korzysci - elementy wjezdzaja jeden po drugim, szybko.

## Jak aplikowac na sekcje (to robisz w Kroku 3.5)

Owijanie kosztuje jedna linie - to jest token-cheap, dlatego robimy to dla calego systemu. Mapa:

- **Kazda sekcja na kazdej podstronie** -> owin tresc w `<Reveal>`. Sasiednie elementy w jednej sekcji rozsuwaj recznie `delay={0.08}`, `delay={0.16}` (max 3-4 kroki - czytelniejsze niz staggerChildren dla laika).
- **Listy** (co dostajesz, program, zakres, kroki, FAQ) -> `<StaggerList>`.
- **CTA i karty klikalne** -> mikro-interakcje (nizej).
- **Hero strony glownej** -> JEDEN akcent: albo zwykly `Reveal` z `delay`, albo (jesli chcesz mocniej) `WordsReveal` na samym H1 - ale tylko TU, raz na cala strone (kod nizej).

Przyklad sekcji:

```tsx
import { Reveal } from "@/components/motion/Reveal";

export function Oferta() {
  return (
    <section className="py-24">
      <Reveal>
        <h2 className="text-balance ...">Naglowek sekcji</h2>
      </Reveal>
      <Reveal delay={0.08}>
        <p className="text-pretty ...">Akapit...</p>
      </Reveal>
    </section>
  );
}
```

## Akcent WOW: JEDEN na cala strone (opcjonalny)

Wybierz JEDEN, nie wszystkie. Piec efektow = cyrk i spadek wydajnosci. Najlepiej na hero strony glownej.

### Opcja 1: WordsReveal - maskowane slowa na H1 hero

Tylko na H1 hero albo jednym naglowku-manifescie. NIGDY na kazdym naglowku.

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

Maskowane slowa wjezdzajace od dolu (`overflow-hidden` na wrapperze + `y:100%`) = sygnatura premium.

### Opcja 2: ParallaxImage - subtelny parallax na ZDJECIU (nie na tekscie)

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

Zakres parallaxu ZALEDWIE 6% (nie 1000px z tutoriali). `scale-110` zeby przesuniecie nie odslonilo krawedzi.

### Opcja 3: gotowy efekt z biblioteki (gdy chcesz "wow" z landingow)

Swiecace belki, aurora, meteory, marquee, karty 3D -> NIE pisz tego recznie. Zainstaluj gotowiec:
`npx shadcn@latest add "https://magicui.design/r/..."` (Magic UI), albo Aceternity UI / React Bits. Wybierz JEDEN i tylko na hero. Sprawdz, czy nie wprowadza fioletowego gradientu domyslnie (anti-ai-look) - jak tak, podmien kolor na akcent z tokenow.

### Opcja 4: skopiuj konkretny efekt ze strony, ktora podoba sie uczestnikowi

Jak uczestnik mowi "chce taka animacje jak na tej stronie" -> uzyj komendy `/skopiuj-animacje <link>`. Ona otworzy strone, rozpozna efekt i odtworzy go najblizej oryginalu, przepuszczajac przez te same reguly subtelnosci. To najlepsza droga na jeden mocny, autorski akcent.

## Mikro-interakcje (premium, nie cyrk)

- Przyciski CTA: `transition-transform hover:-translate-y-0.5 active:translate-y-0` + `transition-colors`. Zaden glow, zaden scale-110.
- Karty klikalne: `hover:-translate-y-1 transition-transform` TYLKO tam, gdzie naprawde klikalne (link/CTA). Karta nieklikalna nie reaguje na hover.
- Linki w nawigacji: podkreslenie wjezdzajace (`after:` z `scale-x-0 -> scale-x-100 transition-transform`), nie zmiana koloru na fiolet.
- Bez `animate-pulse`, `animate-bounce`, tlowych floating blobs, ciaglych gradient-animacji.

## ANTI-AI-LOOK ruchu (twarde, sprawdzaj przy KAZDEJ sekcji)

ZAKAZ:
- import z `framer-motion` (ma byc `motion/react`)
- ruch w petli (pulse/bounce/floating blob/animowany gradient w tle)
- reveal bez `once: true` (re-trigger przy scrollu w gore = tandeta)
- spring-bounce na duzych sekcjach, rotacje, fly-in z duzej odleglosci (x/y > 60)
- WordsReveal / akcent WOW na wiecej niz JEDNYM miejscu na stronie
- parallax na czytanym tekscie; licznik "od 0 do X" jako efekt
- animacja, ktora opoznia odczytanie tresci albo klikniecie CTA

NAKAZ:
- `<MotionConfig reducedMotion="user">` w layout.tsx (dostepnosc) - musi zostac
- transform/opacity/filter only, `viewport once`, duration 0.5-0.8s, ease `[0.17,0.55,0.55,1]`
- jeden klocek `Reveal` do calej strony zamiast 10 roznych improwizacji
- hero: jeden element w ruchu, CTA stabilne i klikalne od pierwszej klatki
- maksymalnie JEDEN akcent WOW na cala strone

## Token-economy

- Klocki `Reveal`/`StaggerList` istnieja juz po `design`. Aplikacja = jedna linia owijajaca tresc -> tanio, robisz dla calego systemu.
- Akcent WOW: jeden komponent, jeden raz. Nie generuj piec wariantow.
- Po nalozeniu ruchu na podstrone: commit ("ruch: <podstrona>") + PROGRESS.md, jak przy kazdej sekcji.
