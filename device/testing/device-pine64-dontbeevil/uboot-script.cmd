setenv bootargs init=/init.sh rw console=tty0 console=ttyS0,115200 no_console_suspend earlycon=uart,mmio32,0x01c28000 panic=10 consoleblank=0 loglevel=1

printenv

echo Loading DTB
load mmc ${mmc_bootdev}:1 ${fdt_addr_r} sun50i-a64-dontbeevil-longts.dtb
load mmc ${mmc_bootdev}:1 ${fdt_addr_r} sun50i-a64-dontbeevil.dtb

echo Loading Initramfs
load mmc ${mmc_bootdev}:1 ${ramdisk_addr_r} uInitrd

echo Loading Kernel
load mmc ${mmc_bootdev}:1 ${kernel_addr_r} vmlinuz

echo Resizing FDT
fdt addr ${fdt_addr_r}
fdt resize

echo Booting kernel
booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
