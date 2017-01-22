---
layout: post
title: handle long parameter lists in java
---

# Handling langer Parameterlisten

## Agenda
0. Allgemeines & Finden bei uns
1. Custom Types
2. Parameter-Objekt
3. Builder Pattern
4. Overloading
5. Method Naming
6. Method returns
7. Mutable State

## Allgemeines & Finden bei uns
http://pmd.sourceforge.net/pmd-4.3.0/rules/codesize.html

dort ExcessiveParameterList

So findet man die bei uns

=> Ant-Script#pmd mit entsprechendem RuleSet

==> dann suchen nach "Avoid long Parameter"


[Java World Artikel Serie](http://www.javaworld.com/article/2074932/core-java/too-many-parameters-in-java-methods-part-1-custom-types.html)

## Custom Types
http://www.javaworld.com/article/2074932/core-java/too-many-parameters-in-java-methods-part-1-custom-types.html

JVM max 65000 Parameter in einer Parameterliste

Custom Types, z.B.:
    - statt "boolean isFemale" "enum Gender"
    - StreetAddress in Wrapper-Klasse

Beispiel:

`Human#addGender(GenderEnum gender);`
VS
`Human#addGender(String gender);`

Pro:
- Signatur besser lesbar
- erhöhte Typsicherheit
    - Stelle einzelner Parameter weniger verwechselbar
    - IDE-Unterstützung
    - Überprüfung zur Kompilierzeit( VS Runtime)

Contra:
- erhöhter Aufwand:
    - mehr Objekte (PermGen-Space)
    - mehr Klassen für die Wartung(Tests, Anpassungen, ...)

Mein Fazit:
- (Overhead meist vernachlässigbar)
- wichtige Hilfestellung, aber noch keine Reduktion der eigentlichen Paramter

Wann:
  - immer

## Parameter-Objekt
http://www.javaworld.com/article/2074935/core-java/too-many-parameters-in-java-methods--part-2--parameters-object.html

Zusammenfassung zu einem Parameter-Objekt

Vorsicht: Zusammenfassung unkorrelierter Daten

Empfehlung:
- Package-Scope und/oder Nested
- Kombination mit Custom Types

Beispiel:
- `Human#new(String firstName, String secondName, String streetName, String houseNumber, String zip, String city=`

Pro:
- echte Reduzierung der Parameter
- Typ-Sicherheit
- leichte Wartung
- IDE-Unterstützung
- Überprüfung zur Kompilierzeit( VS Runtime)

Contra:
- erhöhte Aufwand (siehe oben)
- eventuell Kapselung unkorrelierter Daten
- keine bessere Lesbarkeit (eher Verstecken)

Mein Fazit:
- in Kombination mit Custom Types schon viel besser,
- aber die Komplexität wird eher versteckt

Wann:
- Wenn für die Domäne sinnvoll
- Wenn viele Änderungen zu erwarten sind und die Werte durchgeschliefen werden

## Builder Pattern
http://www.javaworld.com/article/2074938/core-java/too-many-parameters-in-java-methods-part-3-builder-pattern.html

Konstructor private und eine Eingebettete Klasse für Initialisierung

Empfehlung von Josh Bloch(Java Guru):
- Nested Class

Beispiel:
- `GoogleCalendarAPI#authorize`
  - `new Calendar.Builder(..)....build()`
  - `new GoogleAuthorizationCodeFlow.Builder() ... .build();`
- aus dem Spring Framework mit `MockMvcBuilders.webAppContextSetup(...).build()`

Pro:
- keine "null"-Parameter
- sehr Lesbarkeit
- gute Trennung zwischen optionalen und Pflichtparametern(per Parameter)
- bei richtiger Anwendung erhöhte Thread-Sicherheit(bei Trennung von veränderbaren und unveränderbaren Daten)
- IDE-Unterstützung
- Sicherheit des Inhalts (das eigentliche Objekt ist immer valide)

Contra:
- erhöhter Aufwand (siehe oben)
- praktisch doppelte Anzahl Code-Zeilen
- verboser Code

Mein Fazit:
- Schöne Trennung
- Sinnvoll bei vielen "null"-/optionalen und/oder Default-Parametern
- Bitte mit Custom Types
- Beispielprojekte:
  - https://github.com/immutables/immutables
  - https://github.com/OpenFeign/feign
  - https://github.com/square/okhttp
  - https://github.com/docker-java/docker-java

Wann:
  - viele mögliche "null"-Parameter und/oder Standardwerte + Thread-Sicherheit

## Overloading
http://www.javaworld.com/article/2074941/core-java/too-many-parameters-in-java-methods-part-4-overloading.html

Java-Sprachmittel "overloading"

In der Regel eine Version der Methode/des Konstruktors mit Pflichtparameter und
dann je nach Bedarf weitere mit den optionalen Parametern

Beispiele
- Java's `Date`-Klasse
- JUnit asserts
    - `assertTrue(expected, actual)`
    - `assertTrue(message, expected, actual)`

Pro:
- in vielen anderen Sprachen gebräuchlich (C/C++/C#) (Transferwissen)
- Klassen leicht zu Benutzen mit IDE

Contra:
- erhöhter Aufwand (siehe oben)
- schnell unübersichtlich (innerhalb der Klasse)

Mein Fazit:
- In Ordnung, aber bitte nur wenige

Wann:
- nur wenige Abweichungen (JUnit Beispiel mit nur 2 Varianten)

## Method Naming
http://www.javaworld.com/article/2074960/core-java/too-many-parameters-in-java-methods-part-5-method-naming.html

Problem bei Overloading:
- Parameterlisten mit gleichen Parametertypen und deren Stellen
- Beispiel Mittelname optional:
    - setzeNamen(String vorname, String nachName)
    - ↯ setzeNamen(String vorname, String mittelName, String nachName)
    - setzeNamen(String titel, String vorname, String mittelName, String nachName)
    - ↯ setzeNamen(String titel, String vorname, String nachName)
    - ...

    => setzeNamenOhneMittelNamenAberMitTitel(...)

Beim Konstruktor empfiehlt Josh Bloch statische Initialisierungsmethoden

Beispiel:
//TODO

Pro:
- Möglichkeit im Methoden-Namen Einheiten zu definieren( setDurationInMillis(int), setLengthInMeters(int))
Contra:
- erhöhter Aufwand (siehe oben)
- eigentlich für alle Permutationen der Parameter
- alle Nachteile von Overloading( hauptsächlich Lesbarkeit)

Mein Fazit:
- Naja, praktisch wie Overloading

Wann:
- Wie Overloading, aber die Parameter sind irgendwie verwirrend

## Method returns
http://www.javaworld.com/article/2074943/core-java/too-many-parameters-in-java-methods--part-6--method-returns.html

Rückgabewerte über die Parameterliste transportieren

Im Artikel über eine Seite
 - warum es schlecht ist,
 - welche Design Prinzipien verletzt,
 - warum es gegen die Java Philosophie ist,
 - wer sich schon alles dagegen ausgesprochen hat,
 - ... (ist halt einfach sch...lecht)

Problem: nur einen Rückgabewert für Funktionen

Lösung:
- Tuples, Listen, Arrays, Maps, ... als Return Werte
- eigene Klasse/Typ

Beispiel:
//TODO

Pro:
- bei eigener Klasse
  - leichter wartbar
  - wenig Mehraufwand
  - technisch "sauberer"
  - IDE-Unterstützung
  - Überprüfung zur Kompilierzeit
- bei generischen Typen
  - ... eigentlich nichts

Contra:
- erhöhter Aufwand (siehe oben)
- generische Typen
    - schlecht wartbar
    - unhandlich
    - nicht selbsterklärend
    - keine Domainen-Repräsentation, kein explizites Wissen
    - erfordert (ungewöhnlich mehr) Einarbeitung vom Nutzer
- bei eigenen Typen
    - ... eigentlich nichts

Mein Fazit:
- einfach machen (eigene Typen!!!)

Wann:
- immer

## Mutable State
http://www.javaworld.com/article/2074945/core-java/too-many-parameters-in-java-methods-part-7-mutable-state.html

Benutzung von Objekten die veränderbaren Zustand beinhalten, z.B. Singletons, JavaBeans (Setter!)

Artikel eigentlich nur 2 Seiten, warum das schlecht ist.

Beispiel:
//TODO

Pro:
- "Gets the job done"
- Performance

Contra:
- einfach zu viele; bitte einfach Artikel lesen
- nicht nur Concurrency!
- wirklich nur für Pros

Mein Fazit:
- wirklich nur für Pros

Wann:
- alle anderen Möglichkeiten haben Performance oder anderwertige Probleme
