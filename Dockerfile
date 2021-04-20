FROM ruby:alpine
MAINTAINER Andreas Roth <andreas.roth@fastprotect.net>

RUN apk add --no-cache libxml2 libxslt build-base libxml2-dev libxslt-dev && \
    gem install git-commit-notifier && \
    apk del --no-cache build-base libxml2-dev libxslt-dev && \
    adduser --system --shell /bin/false git

USER git
WORKDIR /
