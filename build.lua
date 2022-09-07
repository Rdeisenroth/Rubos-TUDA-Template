#!/usr/bin/env texlua

-- Identify the bundle and module
module = "rubos-tuda-template"

-- TDS-based installation
installfiles = {}
sourcefiles = {}
unpackfiles = {}
tdsdirs = {tex = "tex/latex/rubos-tuda-template"}

-- documentation (this will change to doc once i write "actual" documentation)
docfiledir = "examples"
-- demofiles     = {"examples/Example.tex","examples/Feature-Showoff.tex"}
-- ypesetdemofiles = {"*.tex"}
typesetfiles = {"*.tex"}
typesetexe = "lualatex"
typesetopts = "-interaction=nonstopmode --shell-escape -halt-on-error"
packtdszip = true -- recommended for "tree" layouts

-- Tagging
tagfiles = {"tex/*.sty", "tex/*.cls"}
function tag_hook(tagname)
    -- os.execute('git commit -a -m "Step release tag"')
    -- os.execute('git tag -a -m "" ' .. tagname)
end

-- Detail how to set the version automatically
function update_tag(file, content, tagname, tagdate)
    tagname = string.gsub(tagname, "^v", "")
    if string.match(file, ".*%.sty") or string.match(file, ".*%.cls") then
        -- \ProvidesExplPackage{<name>}{<date>}{<version>}{<description>}
        temp = string.gsub(content,
            "\\ProvidesExplPackage%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}",
            "\\ProvidesExplPackage{%1}{" .. tagdate .. "}{" .. tagname .. "}{%4}"
        )
        -- \ProvidesExplClass{<name>}{<date>}{<version>}{<description>}
        return temp.gsub(temp,
            "\\ProvidesExplClass%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}",
            "\\ProvidesExplClass{%1}{" .. tagdate .. "}{" .. tagname .. "}{%4}"
        )
    end
    return content
end
