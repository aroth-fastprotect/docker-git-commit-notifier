FROM ruby:alpine
MAINTAINER Andreas Roth <andreas.roth@fastprotect.net>

RUN apk add --no-cache libxml2 libxslt build-base libxml2-dev libxslt-dev git && \
    gem install git-commit-notifier && \
    apk del --no-cache build-base libxml2-dev libxslt-dev && \
    addgroup -S git && \
    adduser --system --shell /bin/false git git

USER git
WORKDIR /git
ENTRYPOINT ["/usr/local/bundle/bin/git-commit-notifier"]
