#import "lib.typ": lmu-template

#show: lmu-template.with(
  title: "{{TITLE}}",
  author: "{{AUTHOR}}",
  faculty: "{{FACULTY}}",
  institute: "{{INSTITUTE}}",
  kind: "{{KIND}}", // "standard" oder "labreport"
)

= Einleitung
Hier beginnt dein Bericht...

= Durchführung
Details zur Durchführung...

= Auswertung
Hier kommen deine Ergebnisse hin.

== Fehlerrechnung
Typst ist super für Mathe:
$ delta = sqrt((1/n sum_{i=1}^n (x_i - bar(x))^2) ) $

= Fazit
Zusammenfassung der Ergebnisse.
