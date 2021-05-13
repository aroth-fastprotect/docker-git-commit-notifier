FROM ruby:alpine
MAINTAINER Andreas Roth <andreas.roth@fastprotect.net>

RUN apk add --no-cache libxml2 libxslt build-base libxml2-dev libxslt-dev git unzip && \
    gem install bundler:1.17.3

RUN git clone https://github.com/aroth-arsoft/git-commit-notifier.git /tmp/git-commit-notifier

RUN cd /tmp/git-commit-notifier && \
    bundle _1.17.3_ install && \
    gem build git-commit-notifier.gemspec && \
    gem install /tmp/git-commit-notifier/git-commit-notifier-0.12.10.gem

# RUN apk add --no-cache libxml2 libxslt build-base libxml2-dev libxslt-dev git && \
#     gem install git-commit-notifier && \
#     apk del --no-cache build-base libxml2-dev libxslt-dev && \
#     addgroup -S git && \
#     adduser --system --shell /bin/false git git

# USER git
WORKDIR /git
ENTRYPOINT ["/usr/local/bundle/bin/git-commit-notifier"]

#ENTRYPOINT "/bin/sh"
