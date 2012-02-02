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


OBJS= 	\
	spinlock.o	\
	console.o	\
	lapic.o		\
	string.o	\
	proc.o		\
	ioapic.o	\
	kalloc.o	\
	mp.o		\
	file.o		\
	fs.o		\
	bio.o		\
	ide.o		\
	picirq.o	\
	pipe.o		\
	swtch.o		\
	syscall.o	\
	sysfile.o	\
	sysproc.o	\
	timer.o		\
	exec.o		\
	kbd.o		\
	trap.o		\
	trapasm.o	\
	vectors.o	\
	main.o

all:kernel

kernel: $(OBJS) ../boot/x86/bootother initcode
	$(LD) $(LDFLAGS) -Ttext 0x100000 -e main -o kernel $(OBJS)  -b binary initcode ../boot/x86/bootother
	$(OBJDUMP) -S kernel > kernel.asm
	$(OBJDUMP) -t kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > kernel.sym


initcode: initcode.S
	$(CC) $(CFLAGS) -nostdinc -c initcode.S
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o initcode.out initcode.o
	$(OBJCOPY) -S -O binary initcode.out initcode
	$(OBJDUMP) -S initcode.o > initcode.asm

vectors.S: vectors.pl
	perl vectors.pl > vectors.S


../boot/x86/bootother:
	cd ../boot/x86/;make
	
	
-include *.d


clean:
	rm -f ${OBJS}
	rm -f kernel
	rm -f kernel.*
	rm -f *.d
	rm -f initcode
	rm -f initcode.o
	rm -f initcode.out
	rm -f initcode.asm
	rm -f vectors.S