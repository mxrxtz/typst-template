#import "lib.typ": lmu-template

#show: lmu-template.with(
  title: "Physikalisches Fortgeschrittenenpraktikum",
  subtitle: "{{SUBTITLE}}",
  author: "Max Mustermann",
  faculty: "{{FACULTY}}",
  institute: "{{INSTITUTE}}",
  advisor: "{{ADVISOR}}",
)

= Einleitung
Hier beginnt deine Arbeit...

= Durchführung
Details zur Durchführung...

= Auswertung
Hier kommen deine Ergebnisse hin.

== Fehlerrechnung
Typst ist super für Mathe:
$ delta = sqrt((1/n sum_{i=1}^n (x_i - bar(x))^2) ) $

= Fazit
Zusammenfassung der Ergebnisse.
