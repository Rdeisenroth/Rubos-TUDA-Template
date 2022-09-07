# Rubos-Tuda-Template
[![Build](https://github.com/Rdeisenroth/Rubos-TUDA-Template/actions/workflows/build.yml/badge.svg)](https://github.com/Rdeisenroth/Rubos-TUDA-Template/actions/workflows/build.yml)
## Was ist das?
Eine Vorlage basierend auf tudaexercise.cls, die den Funktionsumfang für Abgaben und Zusammenfassungen erweitert (sowie einige Erleichterungen für Übungsblattersteller bereitstellt).

Die Vorlage ist auch auf [ShareLaTex](https://sharelatex01.ca.hrz.tu-darmstadt.de/templates/6218fc3d29efbb0097fc87b5) verfügbar.

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
Da es aktuell noch keine Vollständige Dokumentation gibt, ist das Paket nicht auf CTAN erhältlich. Das Paket kann durch den folgenden Befehl installiert werden:
```sh
l3build install --full
```
Alternativ ohne Dokumentation auch durch:
```sh
l3build install
```

Falls `l3build` nicht verfügbar ist (z.B. bei Overleaf oder Sharelatex) kann der Inhalt des [`tex`](tex/)-Ordners der Vorlage in das Arbeitsverzeichnis kopiert werden, oder per .latexmkrc eingebunden werden.

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
