# LMU Typst Template

Ein modulares Typst-Template für wissenschaftliche Arbeiten und Versuchsauswertungen an der Ludwig-Maximilians-Universität München.

## Installation

Nutze einfach `npx` oder `bun x`, um ein neues Projekt zu starten:

```bash
npx create-typst-lmu
# oder
bun x create-typst-lmu
```

Der Installer fragt dich nach:
- Deinem Namen
- Titel der Arbeit
- Fakultät & Institut
- Betreuer

## Features

- **LMU Layout:** Entspricht den gängigen Standards für Physik-Praktika und Hausarbeiten.
- **Modular:** Getrennte Logik (`lib.typ`) und Inhalt (`main.typ`).
- **Mathe-Support:** Vorkonfigurierte Formeln und Symbole.
- **Automatische Verzeichnisse:** Inhaltsverzeichnis und Metadaten werden automatisch generiert.

## Benutzung

Nach der Installation kannst du das Dokument mit Typst kompilieren:

```bash
cd mein-versuch
typst watch main.typ
```

## Struktur

- `lib.typ`: Enthält das Design-Regelwerk.
- `main.typ`: Hier schreibst du deinen Inhalt.
