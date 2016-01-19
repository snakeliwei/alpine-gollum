FROM alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="build-base python make git nodejs gcc g++" \
    DEV_PACKAGES="py-docutils icu-dev zlib-dev libxml2-dev libxslt-dev readline-dev libffi-dev" \
    RUBY_PACKAGES="ruby ruby-dev ruby-io-console ruby-bundler ruby-nokogiri ruby-rdoc ruby-irb"

RUN apk add --update $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES


# Install gollum
RUN gem install gollum redcarpet github-markdown --no-rdoc \

# cleanup and settings
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /app/*

# Initialize wiki data
RUN mkdir /wikidata \
    && cd /wikidata \
    && git init .

WORKDIR /wikidata

# Expose default gollum port 4567
EXPOSE 4567

ENTRYPOINT ["gollum"]
