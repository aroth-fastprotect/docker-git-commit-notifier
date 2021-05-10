#!/bin/bash
SCRIPT_FILE=`readlink -f "$0"`
SCRIPT_DIR=`dirname "$SCRIPT_FILE"`
REPO_DIR=`readlink -f "${1:-.}"`
REPO_UID=`stat -c '%u' "$REPO_DIR"`
REPO_GID=`stat -c '%g' "$REPO_DIR"`

repo_name=`git config hooks.emailprefix`
if [ -z "$repo_name" ]; then
    git config hooks.emailprefix "$(basename $REPO_DIR)"
fi
touch git-commit-notifier.log
chmod 666 git-commit-notifier.log
#chown 1000.1000 git-commit-notifier.log
echo "HEAD^1 HEAD refs/heads/master" | \
    docker run --rm -i --user "$REPO_UID:$REPO_GID" -v `readlink -f .`:/git \
    rothan/docker-git-commit-notifier:latest \
    "/git/git-commit-notifier.yml"
