# ABAP Portfolio: Urlaubsantragsverwaltung

Dieses Repository enthält die ABAP-Implementierung einer Anwendung zur Verwaltung von Urlaubsanträgen (Vacation Request Management System). Das Projekt wurde im Rahmen der Vorlesung als Prüfungsleistung erstellt.

## 👥 Projektteam

* **Chenmengxuan Liu**
* **Jan Kurzweil**


---

## 📋 Projektbeschreibung & Funktionalitäten

Die Anwendung ermöglicht es Mitarbeitern, Urlaubstage zu verwalten, neue Anträge zu stellen und den Status bestehender Anträge einzusehen. Die Umsetzung orientiert sich strikt an den funktionalen Anforderungen **A1.01 bis A1.18**.

### 1. Mitarbeiterübersicht & Suche
* **Übersicht:** Anzeige aller Mitarbeiter mit Name, Personalnummer und Eintrittsdatum. _(A1.01)_
* **Filter:** Filterung nach Mitarbeiternummer und Eintrittsdatum möglich. _(A1.02)_
* **Fuzzy Search:** Unscharfe Suche nach Vor- und Nachnamen (Schwellwert 0,7) ist implementiert. _(A1.03)_

### 2. Urlaubsdaten & Berechnung
* **Details:** Anzeige aller Urlaubsanträge und Ansprüche für den ausgewählten Mitarbeiter. _(A1.04)_
* **Urlaubskonto:** Automatische Berechnung und Anzeige der verfügbaren, geplanten und verbrauchten Urlaubstage. _(A1.05)_
* **Tageberechnung:** Beim Speichern werden die benötigten Tage basierend auf Start- und Enddatum berechnet. _(A1.10)_
* **Feiertage:** Wochenenden und gesetzliche Feiertage in **Baden-Württemberg** werden bei der Berechnung automatisch ausgeschlossen. _(A1.11)_

### 3. Antragsstellung (Erstellen & Validierung)
* **Eingabeformular:** Vollständige Maske zum Anlegen neuer Anträge. _(A1.06)_
* **Automatisierung:**
    * Automatische Generierung der Antrags-ID. _(A1.07)_
    * Der aktuelle Nutzer wird automatisch als Antragssteller gesetzt. _(A1.08)_
    * Initialstatus wird automatisch auf **"B" (Beantragt)** gesetzt. _(A1.09)_
* **Validierung (Plausibilitätsprüfung):**
    * **Urlaubsanspruch:** Es wird geprüft, ob genügend Resturlaub vorhanden ist. Falls nicht, wird das Speichern verhindert und eine Fehlermeldung ausgegeben. _(A1.12)_
    * **Datumslogik:** Es wird verhindert, dass das Enddatum vor dem Startdatum liegt. _(A1.13)_
* **Pflichtfelder:** Genehmigender, Start- und Enddatum sind Pflichtfelder. ID, Antragssteller und Status sind schreibgeschützt (Read-only). _(A1.14)_

### 4. UI-Komponenten & Bearbeitung
* **Wertehilfe (F4):** Das Feld "Genehmigender" bietet eine Auswahl aller verfügbaren Mitarbeiter des Unternehmens an. _(A1.15)_
* **Statusanzeige:** Anzeige von technischem Schlüssel (z. B. B) und Beschreibung (z. B. Beantragt). _(A1.16)_
* **Bearbeitung:** Eigene Anträge können bearbeitet oder gelöscht werden. _(A1.17)_
* **Status-Reset:** Wird ein bereits genehmigter Antrag geändert, wird der Status automatisch auf "Beantragt" (B) zurückgesetzt. _(A1.18)_

---

## 🛠 Technische Umsetzung

### Datenmodell
Die Anwendung basiert auf relationalen Datenbanktabellen zur Speicherung von Mitarbeiterstammdaten und Urlaubsantragsdaten.

### Logik-Implementierung
* **Kalender-Integration:** Zur korrekten Berechnung der Netto-Urlaubstage (ohne Wochenenden und Feiertage) wird der Fabrikkalender für Baden-Württemberg herangezogen.
* **Validierung:** Vor dem Speichervorgang (`SAVE`-Event) durchläuft jeder Antrag eine Validierungsroutine, die logische Fehler (z. B. Enddatum < Startdatum) oder Regelverstöße (z. B. zu wenig Resturlaub) abfängt.

---

## 🚀 Installation / Nutzung

1.  Klonen Sie dieses Repository.
2.  Importieren Sie die ABAP-Quellcodes in das SAP-System.
3.  Führen Sie das Hauptprogramm/die Transaktion aus.
