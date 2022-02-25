# Rubos-Tuda-Template
## Was ist das?
Eine Vorlage basierend auf tudaexercise.cls, die den Funktionsumfang für Abgaben und Zusammenfassungen erweitert (sowie einige Erleichterungen für Übungsblattersteller bereitstellt)

## Voraussetzungen
- Latex-Installation (z.B. MikTex oder TexLive)
- Installation der [TU-Template](https://github.com/tudace/tuda_latex_templates) und der verwendeten Plugins
- Python-Installation mit pip und dem Plugin `pygments`  - wenn pip installiert ist, kann pygments wie folgt installiert werden:
```sh
pip install pygments
```

Um die volle Funktionalität zu erreichen (z.B. für Code-Blöcke) muss mit dem `--shell-escape`-Flag kompilliert werden. (Ansonsten wird der Kompatibillitätsmodus geladen). Bei VS-Code mit LaTeX-Workshop kann dazu beispielsweise die `settings.json` angepasst werden, indem man Folgendes anhängt:
```jsonc
"latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "--shell-escape",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-lualatex", // alternativ: "-pdf" o.ä.
                "-outdir=%OUTDIR%",
                "%DOC%"
            ]
        },
    ],
```
Dadurch kann die Vorlage Reibungslos mit VS-Code kompillieren.


Die Vorlage wurde für LuaLaTeX geschrieben, ist aber dank des Latex3-Kernels auch mit PDFLaTeX und XELaTeX kompatibel.
## Installation
Der [`tex`](tex/)-Ordner der Vorlage muss im TeX-Path existieren.
Diesen findet man mit dem Befehl:
```sh
kpsewhich -var-value=TEXMFHOME
```
> Unter Linux liegt der meist bei `~/texmf/tex/latex`

<!-- Beispiel:

```sh
cd path/to/texmf/tex/latex/
git clone https://github.com/Rdeisenroth/Rubos-TUDA-Template.git
``` -->

Dazu kann man den [`tex`](tex/)-Ordner verlinken:

```sh
# Linux/Mac
git clone https://github.com/Rdeisenroth/Rubos-TUDA-Template.git
cd Rubos-TUDA-Template
mkdir -p "$(kpsewhich -var-value=TEXMFHOME)/tex/latex/Rubos-TUDA-Template"
# Hier kann auch -r statt -rs benutzt werden, um keinen Symlink zu erstellen...
# texhash unterstützt keine Symlinks auf Verzeichnisse, sondern nur auf einzelne Dateien :(
cp -rs "$(pwd)/tex" "$(kpsewhich -var-value=TEXMFHOME)/tex/latex/Rubos-TUDA-Template"
sudo texhash "$(kpsewhich -var-value=TEXMFHOME)"
```
```bat
REM Windows
git clone https://github.com/Rdeisenroth/Rubos-TUDA-Template.git
cd Rubos-TUDA-Template/tex
REM (hierbei `path/to/texmf/` mit dem entsprechenden Tex-Path ersetzen)
mklink path/to/texmf/tex/latex/Rubos-TUDA-Template 
texhash
```

> Wichtig: bei jeder Dateiänderungen in TeX-Path muss nochmal der Command `texhash` (unter linux mit sudo) ausgeführt werden, bevor die Dateien erkannt werden.

## Bekannte Fehler/Warnungen
<!-- - aktuell keine -->
- Einige Font-Shape Warnungen seit dem 2022-Kernel

## Was ist geplant?
- Style-Vorlagen für Fächer
- Dokumentation
- Erweiterung der Vorlage auf TudaBeamer und TudaPub
- Bessere Performance (optimierung)
## Wie kann ich Helfen?
Wenn dir ein Fehler aufgefallen ist, du die Vorlage erweitern willst oder einfach nur Anregungen hast kannst du entwerder einen PR oder Issue eröffnen, oder mir auf Discord an `Rubosplay#0815` eine DM senden.