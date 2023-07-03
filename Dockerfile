FROM registry.gitlab.com/islandoftex/images/texlive:latest
# Dependencies
RUN apt-get update && apt-get install -y librsvg2-bin nodejs imagemagick ghostscript
RUN sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
RUN sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
RUN sed -i "s/rights=\"none\" pattern=\"SVG\"/rights=\"read|write\" pattern=\"SVG\"/" /etc/ImageMagick-6/policy.xml
RUN mkdir -p "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
    && curl -o tuda_logo.svg -L https://upload.wikimedia.org/wikipedia/de/2/24/TU_Darmstadt_Logo.svg\?download \
    && rsvg-convert -f pdf -o tuda_logo.pdf tuda_logo.svg \
    && mv tuda_logo.pdf "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
    && texhash --verbose
# Install RubosTudaTemplate
WORKDIR /RubosTudaTemplate
COPY . .
RUN l3build install --full
WORKDIR /
