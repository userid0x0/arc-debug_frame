#CROSS_COMPILE="/home/amerkle/Daten/zephyr/3.1.0/sdk/zephyr-sdk-0.14.2/arc-zephyr-elf/bin/arc-zephyr-elf-"
CPU="-mcpu=arcem "
OPT="-g -gdwarf-4 -fno-unwind-tables -fno-asynchronous-unwind-tables"
CFLAGS="-ffreestanding -fno-common -fdiagnostics-color=always -fno-pie -fno-pic -fno-reorder-functions -fno-defer-pop -ffunction-sections -fdata-sections -fno-delete-null-pointer-checks -mno-sdata -std=c99 -nostdinc"
WARN="-Wall -Wformat -Wformat-security -Wno-format-zero-length -Wno-main -Wno-pointer-sign -Wpointer-arith -Wexpansion-to-defined -Wno-unused-but-set-variable -Werror=implicit-int"

if [[ ! -f toolchain_linux-x86_64_arc-zephyr-elf.tar.gz ]]; then
  wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.15.0-beta2/toolchain_linux-x86_64_arc-zephyr-elf.tar.gz
fi
if [[ ! -d arc-zephyr-elf ]]; then
  tar -xzf toolchain_linux-x86_64_arc-zephyr-elf.tar.gz
fi
CROSS_COMPILE="./arc-zephyr-elf/bin/arc-zephyr-elf-"

${CROSS_COMPILE}gcc ${CPU} ${OPT} ${CFLAGS} ${WARN} -Os -c -o sieve.Os.o sieve.c
${CROSS_COMPILE}gcc ${CPU} ${OPT} ${CFLAGS} ${WARN} -o sieve.Os.elf sieve.Os.o
${CROSS_COMPILE}objdump --dwarf=frames sieve.Os.o > sieve.c.Os.objdump
${CROSS_COMPILE}objdump --dwarf=frames sieve.Os.elf > sieve.elf.Os.objdump


${CROSS_COMPILE}gcc ${CPU} ${OPT} ${CFLAGS} ${WARN} -O2 -c -o sieve.O2.o sieve.c
${CROSS_COMPILE}gcc ${CPU} ${OPT} ${CFLAGS} ${WARN} -o sieve.O2.elf sieve.O2.o
${CROSS_COMPILE}objdump --dwarf=frames sieve.O2.o > sieve.c.O2.objdump
${CROSS_COMPILE}objdump --dwarf=frames sieve.O2.elf > sieve.elf.O2.objdump
