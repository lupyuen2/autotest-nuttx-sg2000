#!/usr/bin/env bash
## Background Task for Automated Testing of Apache NuttX RTOS

set -e  ##  Exit when any command fails
set -x  ##  Echo commands

##  Default Build Prefix is "nuttx-sg2000"
if [ "$BUILD_PREFIX" == '' ]; then
  export BUILD_PREFIX=nuttx-sg2000
fi

## Get the Script Directory
SCRIPT_PATH="${BASH_SOURCE}"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

## Wait for GitHub Release, then test NuttX on SBC
function test_nuttx {

  ## If NuttX Build already downloaded, quit
  local date=$1
  NUTTX_ZIP=/tmp/$BUILD_PREFIX-$date-nuttx.zip
  if [ -e $NUTTX_ZIP ] 
  then
    return
  fi

  echo "----- Download the NuttX Build"
  wget -q \
    https://github.com/lupyuen/nuttx-sg2000/releases/download/$BUILD_PREFIX-$date/nuttx.zip \
    -O $NUTTX_ZIP \
    || true

  ## If build doesn't exist, quit
  FILESIZE=$(wc -c $NUTTX_ZIP | cut -d/ -f1)
  if [ "$FILESIZE" -eq "0" ]; then
    rm $NUTTX_ZIP
    return
  fi

  echo "----- Run the NuttX Test"
  $SCRIPT_DIR/test.sh \
    | tee /tmp/release.log \
    2>&1

  ## Trim to first 1500 lines
  head -n 1500 /tmp/release.log \
    >/tmp/release2.log
  mv /tmp/release2.log \
    /tmp/release.log

  echo "----- Upload the Test Log"
  $SCRIPT_DIR/upload.sh

  echo test_nuttx OK!
}

## If Build Date is specified: Run once and quit
if [ "$BUILD_DATE" != '' ]; then
  test_nuttx $BUILD_DATE
  exit
fi

## Wait for GitHub Release, then test NuttX on SBC
for (( ; ; ))
do
  ## Default Build Date is today (YYYY-MM-DD)
  BUILD_DATE=$(date +'%Y-%m-%d')
  test_nuttx $BUILD_DATE

  ## Wait a while
  date
  sleep 600
done
echo Done!
