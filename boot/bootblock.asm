
bootblock.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
#########################################################################

.globl start				# Entry point
start:
.code16						# This runs in real mode
	cli						# Disable interrupts
    7c00:	fa                   	cli    
	cld						# String operations increment
    7c01:	fc                   	cld    

	# Set up the important data segment registers (DS, ES, SS)
	xorw	%ax, %ax		# Segment number zero
    7c02:	31 c0                	xor    %eax,%eax
	movw	%ax, %ds		# -> Data Segment
    7c04:	8e d8                	mov    %eax,%ds
	movw	%ax, %es		# -> Extra Segment
    7c06:	8e c0                	mov    %eax,%es
	movw	%ax, %ss		# -> Stack Segment
    7c08:	8e d0                	mov    %eax,%ss

	# Set up the stack pointer, growing downward from 0x7c00
	movw	$start, %sp		# Stack Pointer
    7c0a:	bc 00 7c e4 64       	mov    $0x64e47c00,%esp

00007c0d <seta20.1>:
	# compatibility), physical address line 20 is tied to low when the
	# machine boots. Obviously this a bit of a drag for us, especially
	# when trying to address memory above 1MB. This code undoes this.

seta20.1:
	inb		$0x64, %al		# Get status
    7c0d:	e4 64                	in     $0x64,%al
	testb	$0x02, %al		# Busy?
    7c0f:	a8 02                	test   $0x2,%al
	jnz		seta20.1		# Yes
    7c11:	75 fa                	jne    7c0d <seta20.1>
	movb	$0xd1, %al		# Command: Write
    7c13:	b0 d1                	mov    $0xd1,%al
	outb	%al, $0x64		# Output port
    7c15:	e6 64                	out    %al,$0x64

00007c17 <seta20.2>:

seta20.2:
	inb		$0x64, %al		# Get status
    7c17:	e4 64                	in     $0x64,%al
	testb	$0x02, %al		# Busy?
    7c19:	a8 02                	test   $0x2,%al
	jnz		seta20.2		# Yes
    7c1b:	75 fa                	jne    7c17 <seta20.2>
	movb	$0xdf, %al		# Enable
    7c1d:	b0 df                	mov    $0xdf,%al
	outb 	%al, $0x60		# A20
    7c1f:	e6 60                	out    %al,$0x60

00007c21 <real_2_protect>:
	# that it is running directly on physical memory with no translation.
	# This initial NOP-translation setup is required by the processor
	# to ensure that the transition to protected mode occurs smoothly.

real_2_protect:
	cli							# Mandatory since we donot set up an IDT
    7c21:	fa                   	cli    
	lgdt	gdtdesc				# load GDT -- mandatory in protected mode
    7c22:	0f 01 16             	lgdtl  (%esi)
    7c25:	68 7c 0f 20 c0       	push   $0xc0200f7c
	movl	%cr0, %eax			#
	orl		$CR0_PE_ON, %eax	# turn on protected mode
    7c2a:	66 83 c8 01          	or     $0x1,%ax
	movl	%eax, %cr0			#
    7c2e:	0f 22 c0             	mov    %eax,%cr0

	### CPU magic: jump to relocation, flush prefetch queue, and reload %cs
	### Has the effect of just jmp to the next instruction, but simultaneous
	### loads CS with $PROT_MODE_CSEG.
	ljmp	$PROT_MODE_CSEG, $protected_mode
    7c31:	ea 36 7c 08 00 66 b8 	ljmp   $0xb866,$0x87c36

00007c36 <protected_mode>:

	#### we are in 32-bit protected mode (hence the .code32)
.code32
protected_mode:
	# Set up the protected?mode data segment registers
	movw	$PROT_MODE_DSEG, %ax	# Our data segment selector
    7c36:	66 b8 10 00          	mov    $0x10,%ax
	movw	%ax, %ds							# -> DS: Data Segment
    7c3a:	8e d8                	mov    %eax,%ds
	movw	%ax, %es							# -> ES: Extra Segment
    7c3c:	8e c0                	mov    %eax,%es
	movw	%ax, %fs							# -> FS
    7c3e:	8e e0                	mov    %eax,%fs
	movw	%ax, %gs							# -> GS
    7c40:	8e e8                	mov    %eax,%gs
	movw	%ax, %ss							# -> SS: Stack Segment
    7c42:	8e d0                	mov    %eax,%ss

	movl    $start, %esp						# Set up the stack pointer and call into C.
    7c44:	bc 00 7c 00 00       	mov    $0x7c00,%esp
	call	load								# finish the boot load from C.
    7c49:	e8 cf 00 00 00       	call   7d1d <load>

00007c4e <spin>:

	# load() should not return

spin:
	jmp		spin									# ..but in case it does, spin
    7c4e:	eb fe                	jmp    7c4e <spin>

00007c50 <gdt>:
	...
    7c58:	ff                   	(bad)  
    7c59:	ff 00                	incl   (%eax)
    7c5b:	00 00                	add    %al,(%eax)
    7c5d:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c64:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00007c68 <gdtdesc>:
    7c68:	17                   	pop    %ss
    7c69:	00 50 7c             	add    %dl,0x7c(%eax)
    7c6c:	00 00                	add    %al,(%eax)
    7c6e:	90                   	nop
    7c6f:	90                   	nop

00007c70 <wait_disk>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    7c70:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c75:	ec                   	in     (%dx),%al


void wait_disk(void)
{
	// Wait for disk ready.
	while((inb(0x1F7) & 0xC0) != 0x40);
    7c76:	25 c0 00 00 00       	and    $0xc0,%eax
    7c7b:	83 f8 40             	cmp    $0x40,%eax
    7c7e:	75 f5                	jne    7c75 <wait_disk+0x5>
}
    7c80:	f3 c3                	repz ret 

00007c82 <read_sector>:

/**
 * Read a single sector at offset into destination.
 */
void read_sector(void *dst, uint offset)
{
    7c82:	57                   	push   %edi
    7c83:	53                   	push   %ebx
    7c84:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Issue command.
	wait_disk();
    7c88:	e8 e3 ff ff ff       	call   7c70 <wait_disk>


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7c8d:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7c92:	b8 01 00 00 00       	mov    $0x1,%eax
    7c97:	ee                   	out    %al,(%dx)
    7c98:	b2 f3                	mov    $0xf3,%dl
    7c9a:	89 d8                	mov    %ebx,%eax
    7c9c:	ee                   	out    %al,(%dx)
	outb(0x1F2, 1);   					// count = 1
	outb(0x1F3, offset);
	outb(0x1F4, offset >> 8);
    7c9d:	89 d8                	mov    %ebx,%eax
    7c9f:	c1 e8 08             	shr    $0x8,%eax
    7ca2:	b2 f4                	mov    $0xf4,%dl
    7ca4:	ee                   	out    %al,(%dx)
	outb(0x1F5, offset >> 16);
    7ca5:	89 d8                	mov    %ebx,%eax
    7ca7:	c1 e8 10             	shr    $0x10,%eax
    7caa:	b2 f5                	mov    $0xf5,%dl
    7cac:	ee                   	out    %al,(%dx)
	outb(0x1F6, (offset >> 24) | 0xE0);
    7cad:	c1 eb 18             	shr    $0x18,%ebx
    7cb0:	89 d8                	mov    %ebx,%eax
    7cb2:	83 c8 e0             	or     $0xffffffe0,%eax
    7cb5:	b2 f6                	mov    $0xf6,%dl
    7cb7:	ee                   	out    %al,(%dx)
    7cb8:	b2 f7                	mov    $0xf7,%dl
    7cba:	b8 20 00 00 00       	mov    $0x20,%eax
    7cbf:	ee                   	out    %al,(%dx)
	outb(0x1F7, 0x20);  				// cmd 0x20 - read sectors

	// Read data.
	wait_disk();
    7cc0:	e8 ab ff ff ff       	call   7c70 <wait_disk>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\tinsl"     :
    7cc5:	8b 7c 24 0c          	mov    0xc(%esp),%edi
    7cc9:	b9 80 00 00 00       	mov    $0x80,%ecx
    7cce:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7cd3:	fc                   	cld    
    7cd4:	f2 6d                	repnz insl (%dx),%es:(%edi)
	insl(0x1F0, dst, SECTOR_SIZE / 4);
}
    7cd6:	5b                   	pop    %ebx
    7cd7:	5f                   	pop    %edi
    7cd8:	c3                   	ret    

00007cd9 <read_segment>:
/**
 * Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
 * Might copy more than asked.
 */
void read_segment(uint va, uint count, uint offset)
{
    7cd9:	57                   	push   %edi
    7cda:	56                   	push   %esi
    7cdb:	53                   	push   %ebx
    7cdc:	83 ec 08             	sub    $0x8,%esp
    7cdf:	8b 5c 24 18          	mov    0x18(%esp),%ebx
	uint eva;

	eva = va + count;
    7ce3:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
    7ce7:	01 df                	add    %ebx,%edi

	// Round down to sector boundary.
	va &= ~(SECTOR_SIZE - 1);
    7ce9:	81 e3 00 fe ff ff    	and    $0xfffffe00,%ebx
	offset = (offset / SECTOR_SIZE) + 1;

	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	for(; va < eva; va += SECTOR_SIZE, offset++)
    7cef:	39 df                	cmp    %ebx,%edi
    7cf1:	76 23                	jbe    7d16 <read_segment+0x3d>

	// Round down to sector boundary.
	va &= ~(SECTOR_SIZE - 1);

	// Translate from bytes to sectors; kernel starts at sector 1.
	offset = (offset / SECTOR_SIZE) + 1;
    7cf3:	8b 74 24 20          	mov    0x20(%esp),%esi
    7cf7:	c1 ee 09             	shr    $0x9,%esi
    7cfa:	83 c6 01             	add    $0x1,%esi

	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	for(; va < eva; va += SECTOR_SIZE, offset++)
		read_sector((uchar*)va, offset);
    7cfd:	89 74 24 04          	mov    %esi,0x4(%esp)
    7d01:	89 1c 24             	mov    %ebx,(%esp)
    7d04:	e8 79 ff ff ff       	call   7c82 <read_sector>
	offset = (offset / SECTOR_SIZE) + 1;

	// If this is too slow, we could read lots of sectors at a time.
	// We'd write more to memory than asked, but it doesn't matter --
	// we load in increasing order.
	for(; va < eva; va += SECTOR_SIZE, offset++)
    7d09:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d0f:	83 c6 01             	add    $0x1,%esi
    7d12:	39 df                	cmp    %ebx,%edi
    7d14:	77 e7                	ja     7cfd <read_segment+0x24>
		read_sector((uchar*)va, offset);
}
    7d16:	83 c4 08             	add    $0x8,%esp
    7d19:	5b                   	pop    %ebx
    7d1a:	5e                   	pop    %esi
    7d1b:	5f                   	pop    %edi
    7d1c:	c3                   	ret    

00007d1d <load>:
 * read segment from disk
 */
void read_segment(uint va, uint count, uint offset);

void load(void)
{
    7d1d:	56                   	push   %esi
    7d1e:	53                   	push   %ebx
    7d1f:	83 ec 14             	sub    $0x14,%esp

	// kernel loaded into physical address 0x10000	64KB处
	elf = (struct elfhdr*)0x10000; 					// scratch space

	 // Read 1st page off disk from 1st sector, 0 sector for bootsector
  	read_segment((uint)elf, SECTOR_SIZE * 8, 0);
    7d22:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    7d29:	00 
    7d2a:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    7d31:	00 
    7d32:	c7 04 24 00 00 01 00 	movl   $0x10000,(%esp)
    7d39:	e8 9b ff ff ff       	call   7cd9 <read_segment>

	// Is this an ELF executable?
  	if(elf->magic != ELF_MAGIC)
    7d3e:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d45:	45 4c 46 
    7d48:	75 4d                	jne    7d97 <load+0x7a>
    		goto bad;

	// Load each program segment (ignores ph flags).
  	ph = (struct proghdr*)((uchar*)elf + elf->phoff);
    7d4a:	8b 1d 1c 00 01 00    	mov    0x1001c,%ebx
    7d50:	81 c3 00 00 01 00    	add    $0x10000,%ebx
  	eph = ph + elf->phnum;
    7d56:	0f b7 35 2c 00 01 00 	movzwl 0x1002c,%esi
    7d5d:	c1 e6 05             	shl    $0x5,%esi
    7d60:	01 de                	add    %ebx,%esi
	for(; ph < eph; ph++)
    7d62:	39 f3                	cmp    %esi,%ebx
    7d64:	73 25                	jae    7d8b <load+0x6e>
    		read_segment(ph->va & 0xFFFFFF, ph->memsz, ph->offset);
    7d66:	8b 43 04             	mov    0x4(%ebx),%eax
    7d69:	89 44 24 08          	mov    %eax,0x8(%esp)
    7d6d:	8b 43 14             	mov    0x14(%ebx),%eax
    7d70:	89 44 24 04          	mov    %eax,0x4(%esp)
    7d74:	8b 43 08             	mov    0x8(%ebx),%eax
    7d77:	25 ff ff ff 00       	and    $0xffffff,%eax
    7d7c:	89 04 24             	mov    %eax,(%esp)
    7d7f:	e8 55 ff ff ff       	call   7cd9 <read_segment>
    		goto bad;

	// Load each program segment (ignores ph flags).
  	ph = (struct proghdr*)((uchar*)elf + elf->phoff);
  	eph = ph + elf->phnum;
	for(; ph < eph; ph++)
    7d84:	83 c3 20             	add    $0x20,%ebx
    7d87:	39 de                	cmp    %ebx,%esi
    7d89:	77 db                	ja     7d66 <load+0x49>
    		read_segment(ph->va & 0xFFFFFF, ph->memsz, ph->offset);

	// Call the entry point from the ELF header.
  	// Does not return!
  	entry = (void(*)(void))(elf->entry & 0xFFFFFF);
    7d8b:	a1 18 00 01 00       	mov    0x10018,%eax
    7d90:	25 ff ff ff 00       	and    $0xffffff,%eax
  	entry();
    7d95:	ff d0                	call   *%eax
}

static inline void
outw(ushort port, ushort data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7d97:	ba 00 8a ff ff       	mov    $0xffff8a00,%edx
    7d9c:	b8 00 8a ff ff       	mov    $0xffff8a00,%eax
    7da1:	66 ef                	out    %ax,(%dx)
    7da3:	b8 00 8e ff ff       	mov    $0xffff8e00,%eax
    7da8:	66 ef                	out    %ax,(%dx)
    7daa:	eb fe                	jmp    7daa <load+0x8d>
