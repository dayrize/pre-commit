#!/bin/sh
#
# git prepare-commit-msg hook for automatically prepending an issue key
# from the start of the current branch name to commit messages.

# check if commit is merge commit or a commit ammend
if [ $2 = "merge" ] || [ $2 = "commit" ]; then
    exit
fi
ISSUE_KEY=`git branch | grep -o "\* \(.*/\)*[A-Z]\{2,\}-[0-9]\+" | grep -o "[A-Z]\{2,\}-[0-9]\+"`
if [ $? -ne 0 ]; then
    # no issue key in branch, use the default message
    exit
fi
# issue key matched from branch prefix, prepend to commit message
sed -i -e "1s/^/$ISSUE_KEY /" $1
