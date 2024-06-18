![64-bit RISC-V Sophgo SG2000 (T-Head C906 / Milk-V Duo S)](https://lupyuen.github.io/images/sg2000-title.jpg)

# Automated Testing of Apache NuttX RTOS on Sophgo SG2000 SoC / Milk-V Duo S SBC

We are now running Daily Automated Testing of [Apache NuttX RTOS](https://github.com/lupyuen/nuttx-sg2000) on a Real Milk-V Duo S SBC (Sophgo SG2000 SoC)...

1.  Download the [Automated Daily Build](https://github.com/lupyuen/nuttx-sg2000#nuttx-automated-daily-build-for-sg2000) to TFTP Server
1.  TODO: Power on our SBC with an [IKEA Smart Power Plug via Home Assistant](https://lupyuen.github.io/articles/tftp#whats-next)
1.  Our SBC boots the Daily Build over TFTP
1.  Capture the Automated Testing Log and write to the Release Notes

Like this...

```bash
## Run the Daily Automated Testing
script /tmp/release.log scripts/test.sh

## Upload the Test Log to GitHub Release Notes
scripts/upload.sh
```

Release Notes will appear like this: [nuttx-sg2000-2024-06-18](https://github.com/lupyuen/nuttx-sg2000/releases/tag/nuttx-sg2000-2024-06-18)

Here are the Automated Testing Scripts...

- [test.sh](scripts/test.sh)
- [upload.sh](scripts/upload.sh)
- [nuttx.exp](scripts/nuttx.exp)

# Expected Output


Test OK

```text
Script started on Tue Jun 18 13:20:21 2024
Command: /Users/luppy/sg2000/autotest-nuttx-sg2000/scripts/test.sh
+ '[' '' == '' ']'
++ date +%Y-%m-%d
+ export BUILD_DATE=2024-06-18
+ BUILD_DATE=2024-06-18
+ '[' '' == '' ']'
+ export USB_DEVICE=/dev/tty.usbserial-0001
+ USB_DEVICE=/dev/tty.usbserial-0001
+ set +x
----- Download the latest NuttX build for 2024-06-18
+ wget -q https://github.com/lupyuen/nuttx-sg2000/releases/download/nuttx-sg2000-2024-06-18/nuttx.zip -O /tmp/nuttx.zip
+ pushd /tmp
/tmp /tmp
+ unzip -o nuttx.zip
Archive:  nuttx.zip
  inflating: nuttx                   
  inflating: nuttx-export-12.5.1.tar.gz  
  inflating: nuttx.S                 
  inflating: nuttx.bin               
  inflating: nuttx.config            
  inflating: nuttx.hash              
  inflating: nuttx.hex               
  inflating: nuttx.manifest          
  inflating: nuttx.map               
  inflating: initrd                  
  inflating: init.S                  
  inflating: hello.S                 
  inflating: Image                   
  inflating: System.map              
+ popd
/tmp
+ set +x
NuttX Source: https://github.com/apache/nuttx/tree/28ae3b38499c6c7bac0d432658da263b9eab2981
NuttX Apps: https://github.com/apache/nuttx-apps/tree/00f98947786892eaabf60b2e61fad553aee1c36c
----- Copy NuttX Image to TFTP Server
+ scp /tmp/Image tftpserver:/tftpboot/Image-sg2000
Image                                                               0%    0     0.0KB/s   --:-- ETAImage                                                             100%   15MB  46.1MB/s   00:00    
+ ssh tftpserver ls -l /tftpboot/Image-sg2000
-rw-r--r-- 1 pi pi 15687256 Jun 18 06:20 /tftpboot/Image-sg2000
+ set +x
Power on the SBC. Press Enter...

Script started, output file is /tmp/test.log
spawn screen /dev/tty.usbserial-0001 115200

[?1049h[22;0;0t[!p[?3;4l[4l>[4l[?1h=[0m(B[1;50r[H[2J[H[2JC.SCS/0/0.WD.URPL.SDI/25000000/6000000.BS/SD.PS.SD/0x0/0x1000/0x1000/0.PE.BS.SD/0x1000/0x8200/0x8200/0.BE.J.
FSBL Jb2829:gbeb1483-dirty:2024-05-07T08:13:20+00:00
st_on_reason=d0000
st_off_reason=0
P2S/0x1000/0xc00a200.
SD/0x9200/0x1000/0x1000/0.P2E.
DPS/0xa200/0x2000.
SD/0xa200/0x2000/0x2000/0.DPE.
DDR init.
ddr_param[0]=0x78075562.
pkg_type=1
D2_4_1
DDR3-4G-BGA
Data rate=1866.
DDR BIST PASS
PLLS/OD.
C2S/0xc200/0x9fe00000/0x200.
SD/0xc200/0x200/0x200/0.RSC.
C2E.
MS/0xc400/0x80000000/0x1b000.
SD/0xc400/0x1b000/0x1b000/0.ME.
L2/0x27400.
SD/0x27400/0x200/0x200/0.L2/0x414d3342/0xcafe170c/0x80200000/0x37e00/0x37e00
COMP/1.
SD/0x27400/0x37e00/0x37e00/0.DCP/0x80200020/0x1000000/0x81900020/0x37e00/1.
DCP/0x75aa0/0.
Loader_2nd loaded.
Switch RTC mode to xtal32k
Jump to monitor at 0x80000000.
OPENSBI: next_addr=0x80200020 arg1=0x80080000
OpenSBI v0.9
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : Milk-V DuoS
Platform Features         : mfdeleg
Platform HART Count       : 1
Platform IPI Device       : clint
Platform Timer Device     : clint
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform SysReset Device  : ---
Firmware Base             : 0x80000000
Firmware Size             : 132 KB
Runtime SBI Version       : 0.3

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*
Domain0 Region00          : 0x0000000074000000-0x000000007400ffff (I)
Domain0 Region01          : 0x0000000080000000-0x000000008003ffff ()
Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
Domain0 Next Address      : 0x0000000080200020
Domain0 Next Arg1         : 0x0000000080080000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART ISA             : rv64imafdcvsux
Boot HART Features        : scounteren,mcounteren,time
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4096
Boot HART PMP Address Bits: 38
Boot HART MHPM Count      : 8
Boot HART MHPM Count      : 8
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109


U-Boot 2021.10-ga57aa1f2-dirty (May 07 2024 - 08:13:12 +0000) cvitek_cv181x

DRAM:  510 MiB
gd->relocaddr=0x9fbc6000. offset=0x1f9c6000
set_rtc_register_for_power
MMC:   cv-sd@4310000: 0, wifi-sd@4320000: 1
Loading Environment from FAT... mmc1 : finished tuning, code:54
OK
In:    serial
Out:   serial
Err:   serial
Net:   
Warning: ethernet@4070000 (eth0) using random MAC address - 5a:2a:b4:9f:54:6b
eth0: ethernet@4070000
Hit any key to stop autoboot:  1  0 
ethernet@4070000 Waiting for PHY auto negotiation to complete... done
Speed: 100, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 43
DHCP client bound to address 192.168.31.125 (358 ms)
Using ethernet@4070000 device
TFTP from server 192.168.31.10; our IP address is 192.168.31.125
Filename 'Image-sg2000'.
Load address: 0x80200000
Loading: *#################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #################################################################
[8C #############################
[8C 1.2 MiB/s
done
Bytes transferred = 15687256 (ef5e58 hex)
Speed: 100, full duplex
Using ethernet@4070000 device
TFTP from server 192.168.31.10; our IP address is 192.168.31.125
Filename 'jh7110-star64-pine64.dtb'.
Load address: 0x81200000
Loading: *####
[8C 1.2 MiB/s
done
Bytes transferred = 50235 (c43b hex)
## Flattened Device Tree blob at 81200000
   Booting using the fdt blob at 0x81200000
   Loading Device Tree to 000000009f26e000, end 000000009f27d43a ... OK

Starting kernel ...

ABC
NuttShell (NSH) NuttX-12.5.1
nsh> [Kuname -a
NuttX 12.5.1 28ae3b3849 Jun 18 2024 03:15:56 risc-v milkv_duos
nsh> [Kfree
                 total       used       free    maxused    maxfree  nused  nfree
      Kmem:    2061304      11576    2049728      38160    2042848     33      5
      Page:   20971520     647168   20324352   20324352
nsh> [Khello
Hello, World!!
nsh> [Kgetprime
Set thread priority to 10
Set thread policy to SCHED_RR
Start thread #0
thread #0 started, looking for primes < 10000, doing 10 run(s)
thread #0 finished, found 1230 primes, last one was 9973
Done
getprime took 18491 msec
nsh> [Khello
Hello, World!!
nsh> [Kgetprime
Set thread priority to 10
Set thread policy to SCHED_RR
Start thread #0
thread #0 started, looking for primes < 10000, doing 10 run(s)
thread #0 finished, found 1230 primes, last one was 9973
Done
getprime took 18489 msec
nsh> [Kostest
stdio_test: write fd=1
stdio_test: Standard I/O Check: printf
stdio_test: write fd=2
stdio_test: Standard I/O Check: fprintf to stderr
ostest_main: putenv(Variable1=BadValue3)
ostest_main: setenv(Variable1, GoodValue1, TRUE)
ostest_main: setenv(Variable2, BadValue1, FALSE)
ostest_main: setenv(Variable2, GoodValue2, TRUE)
ostest_main: setenv(Variable3, GoodValue3, FALSE)
ostest_main: setenv(Variable3, BadValue2, FALSE)
show_variable: Variable=Variable1 has value=GoodValue1
show_variable: Variable=Variable2 has value=GoodValue2
show_variable: Variable=Variable3 has value=GoodValue3
ostest_main: Started user_main at PID=11

user_main: Begin argument test
user_main: Started with argc=5
user_main: argv[0]="user_main"
user_main: argv[1]="Arg1"
user_main: argv[2]="Arg2"
user_main: argv[3]="Arg3"
user_main: argv[4]="Arg4"

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        2
mxordblk    7cff0    7cff0
uordblks     2688     2688
fordblks    7e970    7e970

user_main: getopt() test
getopt():  Simple test
getopt():  Invalid argument
getopt():  Missing optional argument
getopt_long():  Simple test
getopt_long():  No short options
getopt_long():  Argument for --option=argument
getopt_long():  Invalid long option
getopt_long():  Mixed long and short options
getopt_long():  Invalid short option
getopt_long():  Missing optional arguments
getopt_long_only():  Mixed long and short options
getopt_long_only():  Single hyphen long options

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        2
mxordblk    7cff0    7cff0
uordblks     2688     2688
fordblks    7e970    7e970

user_main: libc tests

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        2
mxordblk    7cff0    7cff0
uordblks     2688     2688
fordblks    7e970    7e970
show_variable: Variable=Variable1 has value=GoodValue1
show_variable: Variable=Variable2 has value=GoodValue2
show_variable: Variable=Variable3 has value=GoodValue3
show_variable: Variable=Variable1 has no value
show_variable: Variable=Variable2 has value=GoodValue2
show_variable: Variable=Variable3 has value=GoodValue3

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        3
mxordblk    7cff0    7cff0
uordblks     2688     2668
fordblks    7e970    7e990
show_variable: Variable=Variable1 has no value
show_variable: Variable=Variable2 has no value
show_variable: Variable=Variable3 has no value

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        2
mxordblk    7cff0    7cff0
uordblks     2668     2588
fordblks    7e990    7ea70

user_main: setvbuf test
setvbuf_test: Test NO buffering
setvbuf_test: Using NO buffering
setvbuf_test: Test default FULL buffering
setvbuf_test: Using default FULL buffering
setvbuf_test: Test FULL buffering, buffer size 64
setvbuf_test: Using FULL buffering, buffer size 64
setvbuf_test: Test FULL buffering, pre-allocated buffer
setvbuf_test: Using FULL buffering, pre-allocated buffer
setvbuf_test: Test LINE buffering, buffer size 64
setvbuf_test: Using LINE buffering, buffer size 64
setvbuf_test: Test FULL buffering, pre-allocated buffer
setvbuf_test: Using FULL buffering, pre-allocated buffer

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        2
mxordblk    7cff0    7cff0
uordblks     2588     2588
fordblks    7ea70    7ea70

user_main: /dev/null test
dev_null: Read 0 bytes from /dev/null
dev_null: Wrote 1024 bytes to /dev/null

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        2
mxordblk    7cff0    7cff0
uordblks     2588     2588
fordblks    7ea70    7ea70

user_main: mutex test
Initializing mutex
Starting thread 1
Starting thread 2
[8C[8CThread1 Thread2
[8CLoops   32[6C32
[8CErrors  0[7C0

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        4
mxordblk    7cff0    787f0
uordblks     2588     35a8
fordblks    7ea70    7da50

user_main: timed mutex test
mutex_test: Initializing mutex
mutex_test: Starting thread
pthread:  Started
pthread:  Waiting for lock or timeout
mutex_test: Unlocking
pthread:  Got the lock
pthread:  Waiting for lock or timeout
pthread:  Got the timeout.  Terminating
mutex_test: PASSED

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         4        3
mxordblk    787f0    7a7f0
uordblks     35a8     2d98
fordblks    7da50    7e260

user_main: cancel test
cancel_test: Test 1a: Normal Cancellation
cancel_test: Starting thread
start_thread: Initializing mutex
start_thread: Initializing cond
start_thread: Starting thread
start_thread: Yielding
sem_waiter: Taking mutex
sem_waiter: Starting wait for condition
cancel_test: Canceling thread
cancel_test: Joining
cancel_test: waiter exited with result=0xffffffffffffffff
cancel_test: PASS thread terminated with PTHREAD_CANCELED
cancel_test: Test 2: Asynchronous Cancellation
... Skipped
cancel_test: Test 3: Cancellation of detached thread
cancel_test: Re-starting thread
restart_thread: Destroying cond
restart_thread: Destroying mutex
restart_thread: Re-starting thread
start_thread: Initializing mutex
start_thread: Initializing cond
start_thread: Starting thread
start_thread: Yielding
sem_waiter: Taking mutex
sem_waiter: Starting wait for condition
cancel_test: Canceling thread
cancel_test: Joining
cancel_test: PASS pthread_join failed with status=ESRCH
cancel_test: Test 5: Non-cancelable threads
cancel_test: Re-starting thread (non-cancelable)
restart_thread: Destroying cond
restart_thread: Destroying mutex
restart_thread: Re-starting thread
start_thread: Initializing mutex
start_thread: Initializing cond
start_thread: Starting thread
start_thread: Yielding
sem_waiter: Taking mutex
sem_waiter: Starting wait for condition
sem_waiter: Setting non-cancelable
cancel_test: Canceling thread
cancel_test: Joining
sem_waiter: Releasing mutex
sem_waiter: Setting cancelable
cancel_test: waiter exited with result=0xffffffffffffffff
cancel_test: PASS thread terminated with PTHREAD_CANCELED
cancel_test: Test 6: Cancel message queue wait
cancel_test: Starting thread (cancelable)
Skipped
cancel_test: Test 7: Cancel signal wait
cancel_test: Starting thread (cancelable)
Skipped

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        3
mxordblk    7a7f0    78ff0
uordblks     2d98     4598
fordblks    7e260    7ca60

user_main: robust test
robust_test: Initializing mutex
robust_test: Starting thread
robust_waiter: Taking mutex
robust_waiter: Exiting with mutex
robust_test: Take the lock again
robust_test: Make the mutex consistent again.
robust_test: Take the lock again
robust_test: Joining
robust_test: waiter exited with result=0
robust_test: Test complete with nerrors=0

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        3
mxordblk    78ff0    78ff0
uordblks     4598     4598
fordblks    7ca60    7ca60

user_main: semaphore test
sem_test: Initializing semaphore to 0
sem_test: Starting waiter thread 1
sem_test: Set thread 1 priority to 191
waiter_func: Thread 1 Started
waiter_func: Thread 1 initial semaphore value = 0
waiter_func: Thread 1 waiting on semaphore
sem_test: Starting waiter thread 2
sem_test: Set thread 2 priority to 128
waiter_func: Thread 2 Started
waiter_func: Thread 2 initial semaphore value = -1
waiter_func: Thread 2 waiting on semaphore
sem_test: Starting poster thread 3
sem_test: Set thread 3 priority to 64
poster_func: Thread 3 started
poster_func: Thread 3 semaphore value = -2
poster_func: Thread 3 posting semaphore
waiter_func: Thread 1 awakened
waiter_func: Thread 1 new semaphore value = -1
waiter_func: Thread 1 done
poster_func: Thread 3 new semaphore value = -1
poster_func: Thread 3 semaphore value = -1
poster_func: Thread 3 posting semaphore
waiter_func: Thread 2 awakened
waiter_func: Thread 2 new semaphore value = 0
waiter_func: Thread 2 done
poster_func: Thread 3 new semaphore value = 0
poster_func: Thread 3 done

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        5
mxordblk    78ff0    767f0
uordblks     4598     3db8
fordblks    7ca60    7d240

user_main: timed semaphore test
semtimed_test: Initializing semaphore to 0
semtimed_test: Waiting for two second timeout
semtimed_test: PASS: first test returned timeout
BEFORE: (63 sec, 904000000 nsec)
AFTER:  (65 sec, 905000000 nsec)
semtimed_test: Starting poster thread
semtimed_test: Set thread 1 priority to 191
semtimed_test: Starting poster thread 3
semtimed_test: Set thread 3 priority to 64
semtimed_test: Waiting for two second timeout
poster_func: Waiting for 1 second
poster_func: Posting
semtimed_test: PASS: sem_timedwait succeeded
BEFORE: (65 sec, 934000000 nsec)
AFTER:  (66 sec, 940000000 nsec)

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         5        3
mxordblk    767f0    7a7f0
uordblks     3db8     2d98
fordblks    7d240    7e260

user_main: condition variable test
cond_test: Initializing mutex
cond_test: Initializing cond
cond_test: Starting waiter
cond_test: Set thread 1 priority to 128
waiter_thread: Started
cond_test: Starting signaler
cond_test: Set thread 2 priority to 64
thread_signaler: Started
thread_signaler: Terminating
cond_test: signaler terminated, now cancel the waiter
cond_test: [5CWaiter  Signaler
cond_test: Loops[8C32[6C32
cond_test: Errors[7C0[7C0
cond_test:
cond_test: 0 times, waiter did not have to wait for data
cond_test: 0 times, data was already available when the signaler run
cond_test: 0 times, the waiter was in an unexpected state when the signaler ran

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        3
mxordblk    7a7f0    787f0
uordblks     2d98     2d98
fordblks    7e260    7e260

user_main: pthread_exit() test
pthread_exit_test: Started pthread_exit_main at PID=30
pthread_exit_main 30: Starting pthread_exit_thread
pthread_exit_main 30: Sleeping for 5 seconds
pthread_exit_thread 31: Sleeping for 10 second
pthread_exit_main 30: Calling pthread_exit()
pthread_exit_thread 31: Still running...

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        4
mxordblk    787f0    767f0
uordblks     2d98     4da8
fordblks    7e260    7c250

user_main: pthread_rwlock test
pthread_rwlock: Initializing rwlock
pthread_exit_thread 31: Exiting

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         4        5
mxordblk    767f0    747f0
uordblks     4da8     3db8
fordblks    7c250    7d240

user_main: pthread_rwlock_cancel test
pthread_rwlock_cancel: Starting test

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         5        2
mxordblk    747f0    7cff0
uordblks     3db8     2588
fordblks    7d240    7ea70

user_main: timed wait test
thread_waiter: Initializing mutex
timedwait_test: Initializing cond
timedwait_test: Starting waiter
timedwait_test: Set thread 2 priority to 177
thread_waiter: Taking mutex
thread_waiter: Starting 5 second wait for condition
timedwait_test: Joining
thread_waiter: pthread_cond_timedwait timed out
thread_waiter: Releasing mutex
thread_waiter: Exit with status 0x12345678
timedwait_test: waiter exited with result=0x12345678

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        3
mxordblk    7cff0    7a7f0
uordblks     2588     2d98
fordblks    7ea70    7e260

user_main: message queue test
mqueue_test: Starting receiver
mqueue_test: Set receiver priority to 128
receiver_thread: Starting
mqueue_test: Starting sender
mqueue_test: Set sender thread priority to 64
mqueue_test: Waiting for sender to complete
sender_thread: Starting
receiver_thread: mq_receive succeeded on msg 0
sender_thread: mq_send succeeded on msg 0
receiver_thread: mq_receive succeeded on msg 1
sender_thread: mq_send succeeded on msg 1
receiver_thread: mq_receive succeeded on msg 2
sender_thread: mq_send succeeded on msg 2
receiver_thread: mq_receive succeeded on msg 3
sender_thread: mq_send succeeded on msg 3
receiver_thread: mq_receive succeeded on msg 4
sender_thread: mq_send succeeded on msg 4
receiver_thread: mq_receive succeeded on msg 5
sender_thread: mq_send succeeded on msg 5
receiver_thread: mq_receive succeeded on msg 6
sender_thread: mq_send succeeded on msg 6
receiver_thread: mq_receive succeeded on msg 7
sender_thread: mq_send succeeded on msg 7
receiver_thread: mq_receive succeeded on msg 8
sender_thread: mq_send succeeded on msg 8
receiver_thread: mq_receive succeeded on msg 9
sender_thread: mq_send succeeded on msg 9
sender_thread: returning nerrors=0
mqueue_test: Killing receiver
receiver_thread: mq_receive interrupted!
receiver_thread: returning nerrors=0
mqueue_test: Canceling receiver
mqueue_test: receiver has already terminated

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        4
mxordblk    7a7f0    74ff0
uordblks     2d98     65a8
fordblks    7e260    7aa50

user_main: timed message queue test
timedmqueue_test: Starting sender
timedmqueue_test: Waiting for sender to complete
sender_thread: Starting
sender_thread: mq_timedsend succeeded on msg 0
sender_thread: mq_timedsend succeeded on msg 1
sender_thread: mq_timedsend succeeded on msg 2
sender_thread: mq_timedsend succeeded on msg 3
sender_thread: mq_timedsend succeeded on msg 4
sender_thread: mq_timedsend succeeded on msg 5
sender_thread: mq_timedsend succeeded on msg 6
sender_thread: mq_timedsend succeeded on msg 7
sender_thread: mq_timedsend succeeded on msg 8
sender_thread: mq_timedsend 9 timed out as expected
sender_thread: returning nerrors=0
timedmqueue_test: Starting receiver
timedmqueue_test: Waiting for receiver to complete
receiver_thread: Starting
receiver_thread: mq_timedreceive succeed on msg 0
receiver_thread: mq_timedreceive succeed on msg 1
receiver_thread: mq_timedreceive succeed on msg 2
receiver_thread: mq_timedreceive succeed on msg 3
receiver_thread: mq_timedreceive succeed on msg 4
receiver_thread: mq_timedreceive succeed on msg 5
receiver_thread: mq_timedreceive succeed on msg 6
receiver_thread: mq_timedreceive succeed on msg 7
receiver_thread: mq_timedreceive succeed on msg 8
receiver_thread: Receive 9 timed out as expected
receiver_thread: returning nerrors=0
timedmqueue_test: Test complete

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         4        3
mxordblk    74ff0    78ff0
uordblks     65a8     4598
fordblks    7aa50    7ca60

user_main: sigprocmask test
sigprocmask_test: SUCCESS

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        3
mxordblk    78ff0    78ff0
uordblks     4598     4598
fordblks    7ca60    7ca60

user_main: signal handler test
sighand_test: Initializing semaphore to 0
sighand_test: Unmasking SIGCHLD
sighand_test: Registering SIGCHLD handler
sighand_test: Starting waiter task
sighand_test: Started waiter_main pid=50
waiter_main: Waiter started
waiter_main: Unmasking signal 32
waiter_main: Registering signal handler
waiter_main: oact.sigaction=0 oact.sa_flags=0 oact.sa_mask=0000000000000000
waiter_main: Waiting on semaphore
sighand_test: Signaling pid=50 with signo=32 sigvalue=42
waiter_main: sem_wait() successfully interrupted by signal
waiter_main: done
sighand_test: done

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        3
mxordblk    78ff0    78ff0
uordblks     4598     4598
fordblks    7ca60    7ca60

user_main: nested signal handler test
signest_test: Starting signal waiter task at priority 101
waiter_main: Waiter started
waiter_main: Setting signal mask
waiter_main: Registering signal handler
waiter_main: Waiting on semaphore
signest_test: Started waiter_main pid=52
signest_test: Starting interfering task at priority 102
interfere_main: Waiting on semaphore
signest_test: Started interfere_main pid=53
signest_test: Simple case:
  Total signalled 1240  Odd=620 Even=620
  Total handled   1240  Odd=620 Even=620
  Total nested    0    Odd=0   Even=0  
signest_test: With task locking
  Total signalled 2480  Odd=1240 Even=1240
  Total handled   2480  Odd=1240 Even=1240
  Total nested    0    Odd=0   Even=0  
signest_test: With intefering thread
  Total signalled 3720  Odd=1860 Even=1860
  Total handled   3720  Odd=1860 Even=1860
  Total nested    0    Odd=0   Even=0  
signest_test: done

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         3        4
mxordblk    78ff0    74ff0
uordblks     4598     65a8
fordblks    7ca60    7aa50

user_main: POSIX timer test
timer_test: Initializing semaphore to 0
timer_test: Unmasking signal 32
timer_test: Registering signal handler
timer_test: oact.sigaction=0xc00084d4 oact.sa_flags=0 oact.sa_mask=2aaaaaaaaaaaaaaa
timer_test: Creating timer
timer_test: Starting timer
timer_test: Waiting on semaphore
timer_expiration: Received signal 32
timer_expiration: sival_int=42
timer_expiration: si_code=2 (SI_TIMER)
timer_expiration: ucontext=0
timer_test: sem_wait() successfully interrupted by signal
timer_test: g_nsigreceived=1
timer_test: Waiting on semaphore
timer_expiration: Received signal 32
timer_expiration: sival_int=42
timer_expiration: si_code=2 (SI_TIMER)
timer_expiration: ucontext=0
timer_test: sem_wait() successfully interrupted by signal
timer_test: g_nsigreceived=2
timer_test: Waiting on semaphore
timer_expiration: Received signal 32
timer_expiration: sival_int=42
timer_expiration: si_code=2 (SI_TIMER)
timer_expiration: ucontext=0
timer_test: sem_wait() successfully interrupted by signal
timer_test: g_nsigreceived=3
timer_test: Waiting on semaphore
timer_expiration: Received signal 32
timer_expiration: sival_int=42
timer_expiration: si_code=2 (SI_TIMER)
timer_expiration: ucontext=0
timer_test: sem_wait() successfully interrupted by signal
timer_test: g_nsigreceived=4
timer_test: Waiting on semaphore
timer_expiration: Received signal 32
timer_expiration: sival_int=42
timer_expiration: si_code=2 (SI_TIMER)
timer_expiration: ucontext=0
timer_test: sem_wait() successfully interrupted by signal
timer_test: g_nsigreceived=5
timer_test: Deleting timer
timer_test: done

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         4        4
mxordblk    74ff0    74ff0
uordblks     65a8     65a8
fordblks    7aa50    7aa50

user_main: round-robin scheduler test
rr_test: Set thread priority to 1
rr_test: Set thread policy to SCHED_RR
rr_test: Starting first get_primes_thread
         First get_primes_thread: 54
rr_test: Starting second get_primes_thread
         Second get_primes_thread: 55
rr_test: Waiting for threads to complete -- this should take awhile
         If RR scheduling is working, they should start and complete at
         about the same time
get_primes_thread id=1 started, looking for primes < 10000, doing 10 run(s)
get_primes_thread id=2 started, looking for primes < 10000, doing 10 run(s)
get_primes_thread id=1 finished, found 1230 primes, last one was 9973
get_primes_thread id=2 finished, found 1230 primes, last one was 9973
rr_test: Done

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         4        4
mxordblk    74ff0    787f0
uordblks     65a8     35a8
fordblks    7aa50    7da50

user_main: barrier test
barrier_test: Initializing barrier
barrier_test: Thread 0 created
barrier_test: Thread 1 created
barrier_test: Thread 2 created
barrier_test: Thread 3 created
barrier_test: Thread 4 created
barrier_test: Thread 5 created
barrier_test: Thread 6 created
barrier_test: Thread 7 created
barrier_func: Thread 0 started
barrier_func: Thread 1 started
barrier_func: Thread 2 started
barrier_func: Thread 3 started
barrier_func: Thread 4 started
barrier_func: Thread 5 started
barrier_func: Thread 6 started
barrier_func: Thread 7 started
barrier_func: Thread 0 calling pthread_barrier_wait()
barrier_func: Thread 1 calling pthread_barrier_wait()
barrier_func: Thread 2 calling pthread_barrier_wait()
barrier_func: Thread 3 calling pthread_barrier_wait()
barrier_func: Thread 4 calling pthread_barrier_wait()
barrier_func: Thread 5 calling pthread_barrier_wait()
barrier_func: Thread 6 calling pthread_barrier_wait()
barrier_func: Thread 7 calling pthread_barrier_wait()
barrier_func: Thread 7, back with status=PTHREAD_BARRIER_SERIAL_THREAD (I AM SPECIAL)
barrier_func: Thread 0, back with status=0 (I am not special)
barrier_func: Thread 1, back with status=0 (I am not special)
barrier_func: Thread 2, back with status=0 (I am not special)
barrier_func: Thread 3, back with status=0 (I am not special)
barrier_func: Thread 4, back with status=0 (I am not special)
barrier_func: Thread 5, back with status=0 (I am not special)
barrier_func: Thread 6, back with status=0 (I am not special)
barrier_func: Thread 7 done
barrier_func: Thread 0 done
barrier_test: Thread 0 completed with result=0
barrier_func: Thread 1 done
barrier_test: Thread 1 completed with result=0
barrier_func: Thread 2 done
barrier_test: Thread 2 completed with result=0
barrier_func: Thread 3 done
barrier_func: Thread 4 done
barrier_test: Thread 3 completed with result=0
barrier_test: Thread 4 completed with result=0
barrier_func: Thread 5 done
barrier_func: Thread 6 done
barrier_test: Thread 5 completed with result=0
barrier_test: Thread 6 completed with result=0
barrier_test: Thread 7 completed with result=0

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         4       10
mxordblk    787f0    6c7f0
uordblks     35a8     6608
fordblks    7da50    7a9f0

user_main: scheduler lock test
sched_lock: Starting lowpri_thread at 97
sched_lock: Set lowpri_thread priority to 97
sched_lock: Starting highpri_thread at 98
sched_lock: Set highpri_thread priority to 98
sched_lock: Waiting...
sched_lock: PASSED No pre-emption occurred while scheduler was locked.
sched_lock: Starting lowpri_thread at 97
sched_lock: Set lowpri_thread priority to 97
sched_lock: Starting highpri_thread at 98
sched_lock: Set highpri_thread priority to 98
sched_lock: Waiting...
sched_lock: PASSED No pre-emption occurred while scheduler was locked.
sched_lock: Finished

End of test memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks        10        4
mxordblk    6c7f0    787f0
uordblks     6608     35a8
fordblks    7a9f0    7da50

user_main: vfork() test DISABLED (CONFIG_BUILD_KERNEL)

Final memory usage:
VARIABLE  BEFORE   AFTER
======== ======== ========
arena       80ff8    80ff8
ordblks         2        4
mxordblk    7cff0    787f0
uordblks     2688     35a8
fordblks    7e970    7da50
user_main: Exiting
ostest_main: Exiting with status 0
===== Test OK


Script done, output file is /tmp/test.log

Command exit status: 0
Script done on Tue Jun 18 13:23:33 2024
```
