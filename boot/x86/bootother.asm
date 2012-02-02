
bootother.o:     file format elf32-i386


Disassembly of section .text:

00000000 <start>:
.set CR0_PE_ON,      0x1         # protected mode enable flag

.globl start
start:
  .code16                     # Assemble for 16-bit mode
  cli                         # Disable interrupts
   0:	fa                   	cli    
  cld                         # String operations increment
   1:	fc                   	cld    

  # Set up the important data segment registers (DS, ES, SS).
  xorw    %ax,%ax             # Segment number zero
   2:	31 c0                	xor    %eax,%eax
  movw    %ax,%ds             # -> Data Segment
   4:	8e d8                	mov    %eax,%ds
  movw    %ax,%es             # -> Extra Segment
   6:	8e c0                	mov    %eax,%es
  movw    %ax,%ss             # -> Stack Segment
   8:	8e d0                	mov    %eax,%ss

  # Switch from real to protected mode, using a bootstrap GDT
  # and segment translation that makes virtual addresses
  # identical to their physical addresses, so that the
  # effective memory map does not change during the switch.
  lgdt    gdtdesc
   a:	0f 01 16             	lgdtl  (%esi)
   d:	54                   	push   %esp
   e:	00 0f                	add    %cl,(%edi)
  movl    %cr0, %eax
  10:	20 c0                	and    %al,%al
  orl     $CR0_PE_ON, %eax
  12:	66 83 c8 01          	or     $0x1,%ax
  movl    %eax, %cr0
  16:	0f 22 c0             	mov    %eax,%cr0

  # Jump to next instruction, but in 32-bit code segment.
  # Switches processor into 32-bit mode.
  ljmp    $PROT_MODE_CSEG, $protcseg
  19:	ea 1e 00 08 00 66 b8 	ljmp   $0xb866,$0x8001e

0000001e <protcseg>:

  .code32                     # Assemble for 32-bit mode
protcseg:
  # Set up the protected-mode data segment registers
  movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
  1e:	66 b8 10 00          	mov    $0x10,%ax
  movw    %ax, %ds                # -> DS: Data Segment
  22:	8e d8                	mov    %eax,%ds
  movw    %ax, %es                # -> ES: Extra Segment
  24:	8e c0                	mov    %eax,%es
  movw    %ax, %fs                # -> FS
  26:	8e e0                	mov    %eax,%fs
  movw    %ax, %gs                # -> GS
  28:	8e e8                	mov    %eax,%gs
  movw    %ax, %ss                # -> SS: Stack Segment
  2a:	8e d0                	mov    %eax,%ss

  movl    start-4, %esp
  2c:	8b 25 fc ff ff ff    	mov    0xfffffffc,%esp
  movl    start-8, %eax
  32:	a1 f8 ff ff ff       	mov    0xfffffff8,%eax
  jmp     *%eax
  37:	ff e0                	jmp    *%eax
  39:	8d 76 00             	lea    0x0(%esi),%esi

0000003c <gdt>:
	...
  44:	ff                   	(bad)  
  45:	ff 00                	incl   (%eax)
  47:	00 00                	add    %al,(%eax)
  49:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
  50:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00000054 <gdtdesc>:
  54:	17                   	pop    %ss
  55:	00 3c 00             	add    %bh,(%eax,%eax,1)
	...
