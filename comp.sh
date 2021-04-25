echo "nasm1"
nasm bootloader.asm -f bin -o bootloader.bin
echo "nasm2"
nasm extendedProgram.asm -f elf64 -o extendedProgram.o
echo "gcc"
x86_64-elf-gcc -ffreestanding -mno-red-zone -m64 -c "kernel.cpp" -o "kernel.o"
echo "ld"
x86_64-elf-ld -o kernel.tmp -Ttext 0x7e00 extendedProgram.o kernel.o
echo "objcopy"
objcopy -O binary kernel.tmp kernel.bin
echo "cat"
cat bootloader.bin kernel.bin > bootloader.flp
