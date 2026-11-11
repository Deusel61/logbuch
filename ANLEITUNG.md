# Logbuch als iPhone-App installieren

Die App läuft komplett offline und speichert deinen Fortschritt auf dem iPhone.
Du brauchst: einen kostenlosen GitHub-Account, deinen Windows-PC, das iPhone und ein USB-Kabel.

---

## Teil 1 – App bauen lassen (einmalig, ca. 10 Minuten)

1. Auf **github.com** anmelden (oder kostenlos registrieren).
2. Oben rechts **„+“ → „New repository“**.
   - Name: `logbuch`
   - **Public** auswählen. Nur dann ist der Cloud-Mac kostenlos und unbegrenzt.
   - „Create repository“ klicken.
3. Auf der neuen, leeren Seite auf den Link **„uploading an existing file“** klicken.
4. Diese ZIP auf dem PC entpacken. Dann **den gesamten Inhalt des Ordners `Logbuch-iOS`**
   (also `.github`, `Sources`, `Resources`, `Web`, `project.yml`, `ANLEITUNG.md`)
   per Drag & Drop ins Browserfenster ziehen.
   Wichtig: Ziehen, nicht über „choose your files“ auswählen, sonst fehlen die Unterordner.
5. Unten **„Commit changes“** klicken.
6. Oben auf **„Actions“** klicken. Der Bau „IPA bauen“ startet automatisch
   (sonst links „IPA bauen“ → rechts „Run workflow“).
7. Nach ca. 3 bis 6 Minuten erscheint ein grüner Haken. Auf den Lauf klicken,
   ganz unten bei **„Artifacts“** auf **„Logbuch-IPA“** klicken. Das lädt eine ZIP herunter.
   Darin liegt **`Logbuch.ipa`**. Entpacke sie.

Rotes X statt grünem Haken? Klick auf den Lauf und schick Claude einen Screenshot der roten Zeile.

---

## Teil 2 – Auf das iPhone bringen (mit Sideloadly)

### Vorbereitung am PC (einmalig)
1. **iTunes** und **iCloud** installieren, und zwar die Versionen **direkt von apple.com**,
   nicht aus dem Microsoft Store. Sideloadly braucht deren Treiber.
2. **Sideloadly** von sideloadly.io herunterladen und installieren.

### Vorbereitung am iPhone (einmalig)
1. iPhone per Kabel an den PC anschließen und auf dem iPhone **„Vertrauen“** tippen.
2. **Einstellungen → Datenschutz & Sicherheit → Entwicklermodus** einschalten.
   Das iPhone startet neu, danach „Einschalten“ bestätigen.

### Installieren
1. Sideloadly öffnen. Oben sollte dein iPhone angezeigt werden.
2. Bei **„Apple ID“** deine normale Apple-ID eintragen.
3. Die Datei **`Logbuch.ipa`** in das Sideloadly-Fenster ziehen und auf **„Start“** klicken.
   Beim ersten Mal fragt Sideloadly nach deinem Apple-Passwort und evtl. einem Bestätigungscode.
   Das ist normal: Damit wird die App mit deiner Apple-ID signiert.
4. Am iPhone: **Einstellungen → Allgemein → VPN & Geräteverwaltung** →
   deine Apple-ID antippen → **„Vertrauen“**.
5. Fertig. Das Logbuch-Symbol ist auf dem Home-Bildschirm.

---

## Wichtig: alle 7 Tage erneuern

Mit einer kostenlosen Apple-ID läuft die Signatur **nach 7 Tagen ab**. Die App lässt sich
dann nicht mehr öffnen. **Dein Fortschritt bleibt aber erhalten.**

- Einfach: iPhone anstecken und in Sideloadly erneut „Start“ mit derselben IPA klicken.
- Bequemer: In Sideloadly bei **„Advanced Options“** die **automatische Erneuerung**
  einschalten. Dann erneuert Sideloadly die App selbst, solange PC und iPhone
  im gleichen WLAN sind und Sideloadly läuft.

---

## Fortschritt zwischen Web-Version und App übertragen

Ganz unten in beiden Versionen gibt es **„Fortschritt übertragen“**:
1. Auf dem einen Gerät **„Code kopieren“** tippen.
2. Den Code auf das andere Gerät bringen (z. B. als Notiz oder Nachricht an dich selbst).
3. Dort einfügen und **„Übernehmen“** tippen. Neuere Einträge gewinnen, nichts geht verloren.
