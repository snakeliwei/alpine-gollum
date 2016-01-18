FROM alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="build-base python make git nodejs gcc g++" \
    DEV_PACKAGES="py-docutils icu-libs zlib-dev libxml2-dev libxslt-dev readline-dev libffi-dev" \
    RUBY_PACKAGES="ruby ruby-dev ruby-io-console ruby-bundler"

RUN apk add --update $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES


# Install gollum
RUN gem install gollum redcarpet github-markdown \

# cleanup and settings
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /app/*

# Initialize wiki data
VOLUME /wikidata
RUN mkdir /wikidata \
    && git init /wikidata

# Expose default gollum port 4567
EXPOSE 4567

ENTRYPOINT ["gollum"]