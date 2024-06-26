#!/usr/bin/env bash
## Upload Test Log to GitHub Release Notes. Assumes the following files are present...
## /tmp/release.log: Test Log
## /tmp/release.tag: Release Tag

repo=lupyuen/nuttx-sg2000

set -e  ##  Exit when any command fails

rm -f /tmp/release2.log

##  Preserve the Auto-Generated GitHub Release Notes.
##  Fetch the current GitHub Release Notes and extract the body text.
set -x  ##  Echo commands
gh release view \
    `cat /tmp/release.tag` \
    --json body \
    --jq '.body' \
    --repo $repo \
    >/tmp/release.old
set +x  ##  Don't echo commands

##  Find the position of the Previous Test Log, starting with "```"
set +e  ##  Don't exit when any command fails
cat /tmp/release.old \
    | grep '```' --max-count=1 --byte-offset \
    | sed 's/:.*//g' \
    >/tmp/previous-log.txt
set -e  ##  Exit when any command fails
prev=`cat /tmp/previous-log.txt`

##  If Previous Test Log exists, discard it
if [ "$prev" != '' ]; then
    cat /tmp/release.old \
        | head --bytes=$prev \
        >>/tmp/release2.log
else
    ##  Else copy the entire Release Notes
    cat /tmp/release.old \
        >>/tmp/release2.log
    echo "" >>/tmp/release2.log
fi

##  Show the Test Status
set +e  ##  Don't exit when any command fails
grep "^===== " /tmp/release.log \
    | colrm 1 6 \
    >>/tmp/release2.log
set -e  ##  Exit when any command fails

##  Enquote the Test Log without Carriage Return and Terminal Control Characters
##  TODO: The long pattern for sed doesn't work on macOS
##  https://stackoverflow.com/questions/17998978/removing-colors-from-output
echo '```text' >>/tmp/release2.log
cat /tmp/release.log \
    | tr -d '\r' \
    | tr -d '\r' \
    | sed 's/\x08/ /g' \
    | sed 's/\x1B(B//g' \
    | sed 's/\x1B\[K//g' \
    | sed 's/\x1B[<=>]//g' \
    | sed 's/\x1B\[[0-9:;<=>?]*[!]*[A-Za-z]//g' \
    | sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g' \
    >>/tmp/release2.log
echo '```' >>/tmp/release2.log

##  Upload the Test Log to the GitHub Release Notes
set -x  ##  Echo commands
gh release edit \
    `cat /tmp/release.tag` \
    --notes-file /tmp/release2.log \
    --repo $repo
set +x  ##  Don't echo commands

##  Show the Test Status
set +e  ##  Don't exit when any command fails
grep "^===== " /tmp/release.log
set -e  ##  Exit when any command fails
