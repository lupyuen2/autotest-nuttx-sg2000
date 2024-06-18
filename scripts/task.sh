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

  ## Default Build Date is today (YYYY-MM-DD)
  if [ "$BUILD_DATE" == '' ]; then
    export BUILD_DATE=$(date +'%Y-%m-%d')
  fi

  ## If NuttX Build already downloaded, quit
  NUTTX_ZIP=/tmp/$BUILD_PREFIX-$BUILD_DATE-nuttx.zip
  if [ -e $NUTTX_ZIP ] 
  then
    return
  fi

  echo "----- Download the NuttX Build"
  wget -q \
    https://github.com/lupyuen/nuttx-sg2000/releases/download/$BUILD_PREFIX-$BUILD_DATE/nuttx.zip \
    -O $NUTTX_ZIP \
    || true

  ## If build doesn't exist, quit
  FILESIZE=$(wc -c $NUTTX_ZIP | cut -d/ -f1)
  if [ "$FILESIZE" -eq "0" ]; then
    rm $NUTTX_ZIP
    return
  fi

  echo "----- Run the NuttX Test"
  script \
    /tmp/release.log \
    $SCRIPT_DIR/test.sh \
    && $SCRIPT_DIR/upload.sh

  echo test_nuttx OK!
}

## Wait for GitHub Release, then test NuttX on SBC
for (( ; ; ))
do
  test_nuttx
  sleep 600
done
echo Done!
