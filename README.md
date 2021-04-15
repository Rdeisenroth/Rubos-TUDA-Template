# Rubos-Tuda-Template
## Was ist das?
Eine Vorlage basierend auf tudaexercise.cls, die den Funktionsumfang für Abgaben und Zusammenfassungen erweitert (sowie einige Erleichterungen für Übungsblattersteller bereitstellt)

## Verwendung
### Requirements:
- Latex-Installation (z.B. MikTex oder TexLive)
- Installation der [TU-Template](https://github.com/tudace/tuda_latex_templates) und der verwendeten Plugins

Um die volle Funktionalität zu erreichen (z.B. für Code-Blöcke) muss mit dem `--shell-escape`-Flag kompilliert werden.  
  
Bei VS-Code mit LaTeX-Workshop kann dazu beispielsweise die `settings.json` angepasst werden, indem man Folgendes anhängt:
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
Dadurch kann die Zusammenfassung Reibungslos mit VS-Code kompillieren.

## Bekannte Fehler/Warnungen
- aktuell keine
## Wie kann ich Helfen?
Wenn dir ein Fehler aufgefallen ist, du die Vorlage erweitern willst oder einfach nur Anregungen hast kannst du entwerder einen PR oder Issue eröffnen, oder mir auf Discord an `Rubosplay#0815` eine DM senden.