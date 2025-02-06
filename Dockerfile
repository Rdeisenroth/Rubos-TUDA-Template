FROM registry.gitlab.com/islandoftex/images/texlive:latest
# Dependencies
RUN apt-get update && apt-get install -y librsvg2-bin nodejs imagemagick ghostscript inkscape
# Install logo
COPY tuda_logo.pdf .
RUN mkdir -p "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
    && mv tuda_logo.pdf "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
    && texhash --verbose

# cancel the build if logo is not found
RUN kpsewhich tuda_logo.pdf
# Install RubosTudaTemplate
WORKDIR /RubosTudaTemplate
COPY . .
RUN l3build install --full --texmfhome="$(kpsewhich -var-value=TEXMFDIST)"
RUN texhash --verbose
WORKDIR /
