#!/usr/bin/env bash
## Automated Testing of Apache NuttX RTOS on Sophgo SG2000 SoC / Milk-V Duo S SBC

echo Now running https://github.com/lupyuen2/autotest-nuttx-sg2000/blob/main/scripts/test.sh

set -e  ##  Exit when any command fails
set -x  ##  Echo commands

## Server that controls Oz64 SG2000. And the TFTP Server.
export OZ64_SERVER=tftpserver
export TFTP_SERVER=tftpserver

##  Default Build Prefix is "nuttx-sg2000"
if [ "$BUILD_PREFIX" == '' ]; then
    export BUILD_PREFIX=nuttx-sg2000
fi

##  Default Build Date is today (YYYY-MM-DD)
if [ "$BUILD_DATE" == '' ]; then
    export BUILD_DATE=$(date +'%Y-%m-%d')
fi

set +x  ##  Disable echo
date
echo "----- Download the latest NuttX build for $BUILD_DATE"
set -x  ##  Enable echo
wget -q https://github.com/lupyuen/nuttx-sg2000/releases/download/$BUILD_PREFIX-$BUILD_DATE/nuttx.zip -O /tmp/nuttx.zip
pushd /tmp
unzip -o nuttx.zip
popd
set +x  ##  Disable echo
date

##  Get the Script Directory
SCRIPT_PATH="${BASH_SOURCE}"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

## Print the Commit Hashes
if [ -f /tmp/nuttx.hash ]; then
    cat /tmp/nuttx.hash
fi

##  Write the Release Tag for populating the Release Log later
echo "$BUILD_PREFIX-$BUILD_DATE" >/tmp/release.tag

echo ----- Download the Device Tree
set -x  ##  Enable echo
pushd /tmp
rm -f cv181x_milkv_duos_sd.dtb
wget https://github.com/lupyuen2/wip-nuttx/releases/download/sg2000-1/cv181x_milkv_duos_sd.dtb
popd
set +x  ##  Disable echo

echo ----- Copy NuttX Binary Image and Device Tree to TFTP Server
set -x  ##  Enable echo
pushd /tmp
scp cv181x_milkv_duos_sd.dtb $TFTP_SERVER:/tftpboot/cv181x_milkv_duos_sd.dtb
scp Image $TFTP_SERVER:/tftpboot/Image-sg2000
ssh $TFTP_SERVER ls -l /tftpboot/Image-sg2000
rm Image cv181x_milkv_duos_sd.dtb
popd
set +x  ##  Disable echo

echo ----- Run the NuttX Test
set -x  ##  Enable echo
pushd /tmp
rm -f oz64.exp oz64-power.sh
wget https://raw.githubusercontent.com/lupyuen/nuttx-release/refs/heads/main/oz64.exp
wget https://raw.githubusercontent.com/lupyuen/nuttx-release/refs/heads/main/oz64-power.sh
chmod +x oz64.exp oz64-power.sh
expect ./oz64.exp
rm oz64.exp oz64-power.sh
popd
set +x  ##  Disable echo
