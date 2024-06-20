#!/usr/bin/env bash
## Automated Testing of Apache NuttX RTOS on Sophgo SG2000 SoC / Milk-V Duo S SBC

set -e  ##  Exit when any command fails
set -x  ##  Echo commands

## Get the Home Assistant Token, copied from http://localhost:8123/profile/security
## token=xxxx
set +x  ##  Disable echo
. $HOME/home-assistant-token.sh
set -x  ##  Enable echo

##  Default Build Prefix is "nuttx-sg2000"
if [ "$BUILD_PREFIX" == '' ]; then
    export BUILD_PREFIX=nuttx-sg2000
fi

##  Default Build Date is today (YYYY-MM-DD)
if [ "$BUILD_DATE" == '' ]; then
    export BUILD_DATE=$(date +'%Y-%m-%d')
fi

##  Default USB Device is /dev/tty.usbserial-0001
if [ "$USB_DEVICE" == '' ]; then
    export USB_DEVICE=/dev/tty.usbserial-0001
fi

set +x  ##  Disable echo
echo "----- Download the latest NuttX build for $BUILD_DATE"
set -x  ##  Enable echo
wget -q https://github.com/lupyuen/nuttx-sg2000/releases/download/$BUILD_PREFIX-$BUILD_DATE/nuttx.zip -O /tmp/nuttx.zip
pushd /tmp
unzip -o nuttx.zip
popd
set +x  ##  Disable echo

##  Get the Script Directory
SCRIPT_PATH="${BASH_SOURCE}"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

## Print the Commit Hashes
if [ -f /tmp/nuttx.hash ]; then
    cat /tmp/nuttx.hash
fi

##  Write the Release Tag for populating the Release Log later
echo "$BUILD_PREFIX-$BUILD_DATE" >/tmp/release.tag

## Copy NuttX Image to TFTP Server
echo "----- Copy NuttX Image to TFTP Server"
set -x  ##  Enable echo
scp /tmp/Image tftpserver:/tftpboot/Image-sg2000
ssh tftpserver ls -l /tftpboot/Image-sg2000
set +x  ##  Disable echo

## TODO: Reboot the SBC with a Smart Power Plug
echo Power off the SBC, press Enter, then power on...
read

set +x  ##  Disable echo
# echo "----- Power Off the SBC"
# curl \
#     -X POST \
#     -H "Authorization: Bearer $token" \
#     -H "Content-Type: application/json" \
#     -d '{"entity_id": "automation.sg2000_power_off"}' \
#     http://localhost:8123/api/services/automation/trigger
set -x  ##  Enable echo

set +x  ##  Disable echo
# echo "----- Power On the SBC"
# curl \
#     -X POST \
#     -H "Authorization: Bearer $token" \
#     -H "Content-Type: application/json" \
#     -d '{"entity_id": "automation.sg2000_power_on"}' \
#     http://localhost:8123/api/services/automation/trigger
set -x  ##  Enable echo

##  Run the Automated Test
script /tmp/test.log $SCRIPT_DIR/nuttx.exp

## TODO: Power off the SBC with a Smart Power Plug
echo Power off the SBC

set +x  ##  Disable echo
# echo "----- Power Off the SBC"
# curl \
#     -X POST \
#     -H "Authorization: Bearer $token" \
#     -H "Content-Type: application/json" \
#     -d '{"entity_id": "automation.sg2000_power_off"}' \
#     http://localhost:8123/api/services/automation/trigger
set -x  ##  Enable echo

##  Check whether BL602 has crashed
# set +e  ##  Don't exit when any command fails
# match=$(grep "registerdump" /tmp/test.log)
# set -e  ##  Exit when any command fails

# if [ "$match" == "" ]; then
#     ##  If BL602 has not crashed, send the test command to BL602
# else
#     ##  If BL602 has crashed, do the Crash Analysis
#     echo; echo "===== Boot FAILED. Below is the Crash Analysis"; echo

#     ##  Don't exit when any command fails (grep)
#     set +e

#     ##  Find all code addresses 23?????? in the Output Log, remove duplicates, skip 23007000.
#     ##  Returns a newline-delimited list of addresses: "23011000\n230053a0\n..."
#     grep --extended-regexp \
#         --only-matching \
#         "23[0-9a-f]{6}" \
#         /tmp/test.log \
#         | grep -v "23007000" \
#         | uniq \
#         >/tmp/test.addr

#     ##  For every address, show the corresponding line in the disassembly
#     for addr in $(cat /tmp/test.addr); do
#         ##  Skip addresses that don't match
#         match=$(grep "$addr:" /tmp/nuttx.S)
#         if [ "$match" != "" ]; then
#             echo "----- Code Address $addr"
#             grep \
#                 --context=5 \
#                 --color=auto \
#                 "$addr:" \
#                 /tmp/nuttx.S
#             echo
#         fi
#     done

#     ##  Find all data addresses 42?????? in the Output Log, remove duplicates.
#     ##  Returns a newline-delimited list of addresses: "23011000\n230053a0\n..."
#     grep --extended-regexp \
#         --only-matching \
#         "42[0-9a-f]{6}" \
#         /tmp/test.log \
#         | uniq \
#         >/tmp/test.addr

#     ##  For every address, show the corresponding line in the disassembly
#     for addr in $(cat /tmp/test.addr); do
#         ##  Skip addresses that don't match
#         match=$(grep "^$addr" /tmp/nuttx.S)
#         if [ "$match" != "" ]; then
#             echo "----- Data Address $addr"
#             grep \
#                 --color=auto \
#                 "^$addr" \
#                 /tmp/nuttx.S \
#                 | grep -v "noinit"
#             echo
#         fi
#     done

#     ##  Exit when any command fails
#     set -e
# fi
