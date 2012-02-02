# Cross-compiling (e.g., on Mac OS X)
# TOOLPREFIX = i386-jos-elf-

# Using native tools (e.g., on X86 Linux)
TOOLPREFIX = 

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
CFLAGS = -fno-builtin -O2 -Wall -MD -ggdb -m32 -I ../inc
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)
ASFLAGS = -m32
# FreeBSD ld wants ``elf_i386_fbsd''
LDFLAGS += -m $(shell $(LD) -V | grep elf_i386 2>/dev/null)

all:bootblock

bootblock: x86/bootsector.o loader.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 -o bootblock.o x86/bootsector.o loader.o
	$(OBJDUMP) -S bootblock.o > bootblock.asm
	$(OBJCOPY) -R .eh_frame -S -O binary bootblock.o bootblock
	./sign.pl bootblock

loader.o:
	$(CC) $(CFLAGS) -O -nostdinc -c loader.c
	
x86/bootsector.o:
	cd x86;make

clean:
	rm -f bootblock.o
	rm -f bootblock
	rm -f bootblock.asm
	rm -f loader.d
	rm -f loader.o
	cd x86;make clean