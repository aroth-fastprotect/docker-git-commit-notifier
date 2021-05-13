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
# if "skip_commits_older_than" is set in "git-commit-notifier.yml" than very often
# the commits for testing are rejected because they are too old.
# For testing is advised to remove the "skip_commits_older_than" setting from the
# git-commit-notifier.yml.
touch git-commit-notifier.log
chmod 666 git-commit-notifier.log
#chown 1000.1000 git-commit-notifier.log
echo "HEAD^1 HEAD refs/heads/master" | \
    docker run --rm -i -w /git --user "$REPO_UID:$REPO_GID" -v "$REPO_DIR:/git" \
    rothan/docker-git-commit-notifier:latest \
    "/git/git-commit-notifier.yml"
