
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <main>:

/**
 * Bootstrap processor starts running C code here.
 */
int main(void)
{
  100000:	55                   	push   %ebp
	 *	_end(end)		bss段结束后第一个地址
	 */
	extern char edata[], end[];

  	// clear BSS
  	memset(edata, 0, end - edata);
  100001:	b8 84 29 11 00       	mov    $0x112984,%eax

/**
 * Bootstrap processor starts running C code here.
 */
int main(void)
{
  100006:	89 e5                	mov    %esp,%ebp
	 *	_end(end)		bss段结束后第一个地址
	 */
	extern char edata[], end[];

  	// clear BSS
  	memset(edata, 0, end - edata);
  100008:	2d a6 87 10 00       	sub    $0x1087a6,%eax

/**
 * Bootstrap processor starts running C code here.
 */
int main(void)
{
  10000d:	53                   	push   %ebx
  10000e:	83 e4 f0             	and    $0xfffffff0,%esp
  100011:	83 ec 10             	sub    $0x10,%esp
	 *	_end(end)		bss段结束后第一个地址
	 */
	extern char edata[], end[];

  	// clear BSS
  	memset(edata, 0, end - edata);
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 a6 87 10 00 	movl   $0x1087a6,(%esp)
  100027:	e8 e4 0d 00 00       	call   100e10 <memset>

  	// collect info about this machine
  	mp_init();
  10002c:	e8 5f 1f 00 00       	call   101f90 <mp_init>
  	lapic_init(mp_bcpu());
  100031:	e8 3a 1f 00 00       	call   101f70 <mp_bcpu>
  100036:	89 04 24             	mov    %eax,(%esp)
  100039:	e8 02 0b 00 00       	call   100b40 <lapic_init>

  	cprintf("\ncpu%d: starting myos\n\n", cpu());
  10003e:	e8 ed 0b 00 00       	call   100c30 <cpu>
  100043:	c7 04 24 86 66 10 00 	movl   $0x106686,(%esp)
  10004a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10004e:	e8 cd 06 00 00       	call   100720 <cprintf>
	cprintf("Welcome to myos !\n");
  100053:	c7 04 24 9e 66 10 00 	movl   $0x10669e,(%esp)
  10005a:	e8 c1 06 00 00       	call   100720 <cprintf>

	pinit();         // process table
  10005f:	e8 bc 0f 00 00       	call   101020 <pinit>
	binit();         // buffer cache
  100064:	e8 07 33 00 00       	call   103370 <binit>
	pic_init();      // interrupt controller
  100069:	e8 b2 37 00 00       	call   103820 <pic_init>
  10006e:	66 90                	xchg   %ax,%ax
	ioapic_init();   // another interrupt controller
  100070:	e8 9b 1b 00 00       	call   101c10 <ioapic_init>

	kinit();         // physical memory allocator
  100075:	e8 76 1d 00 00       	call   101df0 <kinit>
	tvinit();        // trap vectors
  10007a:	e8 81 50 00 00       	call   105100 <tvinit>
  10007f:	90                   	nop
	fileinit();      // file table
  100080:	e8 fb 20 00 00       	call   102180 <fileinit>
	iinit();         // inode cache
  100085:	e8 36 28 00 00       	call   1028c0 <iinit>
	console_init();  // I/O devices & their interrupts
  10008a:	e8 b1 09 00 00       	call   100a40 <console_init>
  10008f:	90                   	nop
	ide_init();      // disk
  100090:	e8 7b 35 00 00       	call   103610 <ide_init>
	if(!ismp)
  100095:	a1 c0 d5 10 00       	mov    0x10d5c0,%eax
  10009a:	85 c0                	test   %eax,%eax
  10009c:	0f 84 d2 00 00 00    	je     100174 <main+0x174>
			timer_init();  // uniprocessor timer
	userinit();      // first user process
  1000a2:	e8 09 13 00 00       	call   1013b0 <userinit>
	struct cpu *c;
	char *stack;

	// Write bootstrap code to unused memory at 0x7000.
	code = (uchar*)0x7000;
	memmove(code, _binary____boot_x86_bootother_start, (uint)_binary____boot_x86_bootother_size);
  1000a7:	c7 44 24 08 5a 00 00 	movl   $0x5a,0x8(%esp)
  1000ae:	00 
  1000af:	c7 44 24 04 4c 87 10 	movl   $0x10874c,0x4(%esp)
  1000b6:	00 
  1000b7:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  1000be:	e8 dd 0d 00 00       	call   100ea0 <memmove>

	for(c = cpus; c < cpus+ncpu; c++)
  1000c3:	69 05 40 dc 10 00 cc 	imul   $0xcc,0x10dc40,%eax
  1000ca:	00 00 00 
  1000cd:	05 e0 d5 10 00       	add    $0x10d5e0,%eax
  1000d2:	3d e0 d5 10 00       	cmp    $0x10d5e0,%eax
  1000d7:	0f 86 92 00 00 00    	jbe    10016f <main+0x16f>
  1000dd:	bb e0 d5 10 00       	mov    $0x10d5e0,%ebx
  1000e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	{
		if(c == cpus+cpu())  // We've started already.
  1000e8:	e8 43 0b 00 00       	call   100c30 <cpu>
  1000ed:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  1000f3:	05 e0 d5 10 00       	add    $0x10d5e0,%eax
  1000f8:	39 c3                	cmp    %eax,%ebx
  1000fa:	74 56                	je     100152 <main+0x152>
			continue;
		cprintf("Try to start cup:%d\n", c->apicid);
  1000fc:	0f b6 03             	movzbl (%ebx),%eax
  1000ff:	c7 04 24 b1 66 10 00 	movl   $0x1066b1,(%esp)
  100106:	89 44 24 04          	mov    %eax,0x4(%esp)
  10010a:	e8 11 06 00 00       	call   100720 <cprintf>
		// Fill in %esp, %eip and start code on cpu.
		stack = kalloc(KSTACKSIZE);
  10010f:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  100116:	e8 25 1d 00 00       	call   101e40 <kalloc>
		*(void**)(code-4) = stack + KSTACKSIZE;
		*(void**)(code-8) = mpmain;
  10011b:	c7 05 f8 6f 00 00 e0 	movl   $0x105ee0,0x6ff8
  100122:	5e 10 00 
		if(c == cpus+cpu())  // We've started already.
			continue;
		cprintf("Try to start cup:%d\n", c->apicid);
		// Fill in %esp, %eip and start code on cpu.
		stack = kalloc(KSTACKSIZE);
		*(void**)(code-4) = stack + KSTACKSIZE;
  100125:	05 00 10 00 00       	add    $0x1000,%eax
  10012a:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
		*(void**)(code-8) = mpmain;
		lapic_startap(c->apicid, (uint)code);
  10012f:	0f b6 03             	movzbl (%ebx),%eax
  100132:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  100139:	00 
  10013a:	89 04 24             	mov    %eax,(%esp)
  10013d:	e8 5e 0b 00 00       	call   100ca0 <lapic_startap>
  100142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

		// Wait for cpu to get through bootstrap.
		while(c->booted == 0)
  100148:	8b 83 c0 00 00 00    	mov    0xc0(%ebx),%eax
  10014e:	85 c0                	test   %eax,%eax
  100150:	74 f6                	je     100148 <main+0x148>

	// Write bootstrap code to unused memory at 0x7000.
	code = (uchar*)0x7000;
	memmove(code, _binary____boot_x86_bootother_start, (uint)_binary____boot_x86_bootother_size);

	for(c = cpus; c < cpus+ncpu; c++)
  100152:	69 05 40 dc 10 00 cc 	imul   $0xcc,0x10dc40,%eax
  100159:	00 00 00 
  10015c:	81 c3 cc 00 00 00    	add    $0xcc,%ebx
  100162:	05 e0 d5 10 00       	add    $0x10d5e0,%eax
  100167:	39 c3                	cmp    %eax,%ebx
  100169:	0f 82 79 ff ff ff    	jb     1000e8 <main+0xe8>
			timer_init();  // uniprocessor timer
	userinit();      // first user process
	bootothers();    // start other processors

	// Finish setting up this processor in mpmain.
	mpmain();
  10016f:	e8 6c 5d 00 00       	call   105ee0 <mpmain>
	fileinit();      // file table
	iinit();         // inode cache
	console_init();  // I/O devices & their interrupts
	ide_init();      // disk
	if(!ismp)
			timer_init();  // uniprocessor timer
  100174:	e8 57 4a 00 00       	call   104bd0 <timer_init>
  100179:	e9 24 ff ff ff       	jmp    1000a2 <main+0xa2>
  10017e:	90                   	nop
  10017f:	90                   	nop

00100180 <initlock>:

extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  100180:	8b 44 24 04          	mov    0x4(%esp),%eax
  lock->name = name;
  100184:	8b 54 24 08          	mov    0x8(%esp),%edx
  lock->locked = 0;
  100188:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  lock->name = name;
  10018e:	89 50 04             	mov    %edx,0x4(%eax)
  lock->locked = 0;
  lock->cpu = 0xffffffff;
  100191:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
}
  100198:	c3                   	ret    
  100199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001001a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1001a0:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  1001a1:	8b 54 24 08          	mov    0x8(%esp),%edx
  for(i = 0; i < 10; i++){
  1001a5:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1001a7:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  1001ab:	83 ea 08             	sub    $0x8,%edx
  1001ae:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  1001b0:	8d 5a ff             	lea    -0x1(%edx),%ebx
  1001b3:	83 fb fd             	cmp    $0xfffffffd,%ebx
  1001b6:	77 18                	ja     1001d0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
  1001b8:	8b 5a 04             	mov    0x4(%edx),%ebx
  1001bb:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  1001be:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  1001c1:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  1001c3:	83 f8 0a             	cmp    $0xa,%eax
  1001c6:	75 e8                	jne    1001b0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  1001c8:	5b                   	pop    %ebx
  1001c9:	c3                   	ret    
  1001ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
  1001d0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1001d7:	83 c0 01             	add    $0x1,%eax
  1001da:	83 f8 0a             	cmp    $0xa,%eax
  1001dd:	74 e9                	je     1001c8 <getcallerpcs+0x28>
    pcs[i] = 0;
  1001df:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1001e6:	83 c0 01             	add    $0x1,%eax
  1001e9:	83 f8 0a             	cmp    $0xa,%eax
  1001ec:	75 e2                	jne    1001d0 <getcallerpcs+0x30>
  1001ee:	eb d8                	jmp    1001c8 <getcallerpcs+0x28>

001001f0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  1001f0:	53                   	push   %ebx
  return lock->locked && lock->cpu == cpu() + 10;
  1001f1:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  1001f3:	83 ec 08             	sub    $0x8,%esp
  1001f6:	8b 54 24 10          	mov    0x10(%esp),%edx
  return lock->locked && lock->cpu == cpu() + 10;
  1001fa:	8b 0a                	mov    (%edx),%ecx
  1001fc:	85 c9                	test   %ecx,%ecx
  1001fe:	75 08                	jne    100208 <holding+0x18>
}
  100200:	83 c4 08             	add    $0x8,%esp
  100203:	5b                   	pop    %ebx
  100204:	c3                   	ret    
  100205:	8d 76 00             	lea    0x0(%esi),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  100208:	8b 5a 08             	mov    0x8(%edx),%ebx
  10020b:	e8 20 0a 00 00       	call   100c30 <cpu>
  100210:	83 c0 0a             	add    $0xa,%eax
    pcs[i] = 0;
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
  100213:	39 c3                	cmp    %eax,%ebx
{
  return lock->locked && lock->cpu == cpu() + 10;
  100215:	0f 94 c0             	sete   %al
}
  100218:	83 c4 08             	add    $0x8,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  10021b:	0f b6 c0             	movzbl %al,%eax
}
  10021e:	5b                   	pop    %ebx
  10021f:	c3                   	ret    

00100220 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  100220:	53                   	push   %ebx
  100221:	83 ec 08             	sub    $0x8,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  100224:	9c                   	pushf  
  100225:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
  100226:	fa                   	cli    
  int eflags;

  eflags = read_eflags();
  cli();
  if(cpus[cpu()].ncli++ == 0)
  100227:	e8 04 0a 00 00       	call   100c30 <cpu>
  10022c:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  100232:	8b 90 a4 d6 10 00    	mov    0x10d6a4(%eax),%edx
  100238:	8d 4a 01             	lea    0x1(%edx),%ecx
  10023b:	85 d2                	test   %edx,%edx
  10023d:	89 88 a4 d6 10 00    	mov    %ecx,0x10d6a4(%eax)
  100243:	75 17                	jne    10025c <pushcli+0x3c>
    cpus[cpu()].intena = eflags & FL_IF;
  100245:	e8 e6 09 00 00       	call   100c30 <cpu>
  10024a:	81 e3 00 02 00 00    	and    $0x200,%ebx
  100250:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  100256:	89 98 a8 d6 10 00    	mov    %ebx,0x10d6a8(%eax)
}
  10025c:	83 c4 08             	add    $0x8,%esp
  10025f:	5b                   	pop    %ebx
  100260:	c3                   	ret    
  100261:	eb 0d                	jmp    100270 <acquire>
  100263:	90                   	nop
  100264:	90                   	nop
  100265:	90                   	nop
  100266:	90                   	nop
  100267:	90                   	nop
  100268:	90                   	nop
  100269:	90                   	nop
  10026a:	90                   	nop
  10026b:	90                   	nop
  10026c:	90                   	nop
  10026d:	90                   	nop
  10026e:	90                   	nop
  10026f:	90                   	nop

00100270 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  100270:	53                   	push   %ebx
  100271:	83 ec 18             	sub    $0x18,%esp
  pushcli();
  100274:	e8 a7 ff ff ff       	call   100220 <pushcli>
  if(holding(lock))
  100279:	8b 44 24 20          	mov    0x20(%esp),%eax
  10027d:	89 04 24             	mov    %eax,(%esp)
  100280:	e8 6b ff ff ff       	call   1001f0 <holding>
  100285:	85 c0                	test   %eax,%eax
  100287:	75 40                	jne    1002c9 <acquire+0x59>
  100289:	8b 5c 24 20          	mov    0x20(%esp),%ebx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  10028d:	ba 01 00 00 00       	mov    $0x1,%edx
  100292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100298:	89 d0                	mov    %edx,%eax
  10029a:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it.
  while(xchg(&lock->locked, 1) == 1)
  10029d:	83 f8 01             	cmp    $0x1,%eax
  1002a0:	74 f6                	je     100298 <acquire+0x28>

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  1002a2:	e8 89 09 00 00       	call   100c30 <cpu>
  1002a7:	83 c0 0a             	add    $0xa,%eax
  1002aa:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lock, lock->pcs);
  1002ad:	8b 44 24 20          	mov    0x20(%esp),%eax
  1002b1:	83 c0 0c             	add    $0xc,%eax
  1002b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002b8:	8d 44 24 20          	lea    0x20(%esp),%eax
  1002bc:	89 04 24             	mov    %eax,(%esp)
  1002bf:	e8 dc fe ff ff       	call   1001a0 <getcallerpcs>
}
  1002c4:	83 c4 18             	add    $0x18,%esp
  1002c7:	5b                   	pop    %ebx
  1002c8:	c3                   	ret    
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
    panic("acquire");
  1002c9:	c7 04 24 60 5f 10 00 	movl   $0x105f60,(%esp)
  1002d0:	e8 db 07 00 00       	call   100ab0 <panic>
  1002d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1002d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001002e0 <popcli>:
    cpus[cpu()].intena = eflags & FL_IF;
}

void
popcli(void)
{
  1002e0:	83 ec 1c             	sub    $0x1c,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1002e3:	9c                   	pushf  
  1002e4:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  1002e5:	f6 c4 02             	test   $0x2,%ah
  1002e8:	75 64                	jne    10034e <popcli+0x6e>
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
  1002ea:	e8 41 09 00 00       	call   100c30 <cpu>
  1002ef:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  1002f5:	8b 90 a4 d6 10 00    	mov    0x10d6a4(%eax),%edx
  1002fb:	83 ea 01             	sub    $0x1,%edx
  1002fe:	85 d2                	test   %edx,%edx
  100300:	89 90 a4 d6 10 00    	mov    %edx,0x10d6a4(%eax)
  100306:	78 3a                	js     100342 <popcli+0x62>
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  100308:	e8 23 09 00 00       	call   100c30 <cpu>
  10030d:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  100313:	8b 80 a4 d6 10 00    	mov    0x10d6a4(%eax),%eax
  100319:	85 c0                	test   %eax,%eax
  10031b:	74 0b                	je     100328 <popcli+0x48>
    sti();
}
  10031d:	83 c4 1c             	add    $0x1c,%esp
  100320:	c3                   	ret    
  100321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  100328:	e8 03 09 00 00       	call   100c30 <cpu>
  10032d:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  100333:	8b 80 a8 d6 10 00    	mov    0x10d6a8(%eax),%eax
  100339:	85 c0                	test   %eax,%eax
  10033b:	74 e0                	je     10031d <popcli+0x3d>
}

static inline void
sti(void)
{
  asm volatile("sti");
  10033d:	fb                   	sti    
    sti();
}
  10033e:	83 c4 1c             	add    $0x1c,%esp
  100341:	c3                   	ret    
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  100342:	c7 04 24 7f 5f 10 00 	movl   $0x105f7f,(%esp)
  100349:	e8 62 07 00 00       	call   100ab0 <panic>

void
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  10034e:	c7 04 24 68 5f 10 00 	movl   $0x105f68,(%esp)
  100355:	e8 56 07 00 00       	call   100ab0 <panic>
  10035a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100360 <release>:
}

// Release the lock.
void
release(struct spinlock *lock)
{
  100360:	53                   	push   %ebx
  100361:	83 ec 18             	sub    $0x18,%esp
  100364:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if(!holding(lock))
  100368:	89 1c 24             	mov    %ebx,(%esp)
  10036b:	e8 80 fe ff ff       	call   1001f0 <holding>
  100370:	85 c0                	test   %eax,%eax
  100372:	74 1c                	je     100390 <release+0x30>
    panic("release");

  lock->pcs[0] = 0;
  100374:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  10037b:	31 c0                	xor    %eax,%eax
  lock->cpu = 0xffffffff;
  10037d:	c7 43 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebx)
  100384:	f0 87 03             	lock xchg %eax,(%ebx)
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
}
  100387:	83 c4 18             	add    $0x18,%esp
  10038a:	5b                   	pop    %ebx
  // by the Intel manuals, but does not happen on current
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
  10038b:	e9 50 ff ff ff       	jmp    1002e0 <popcli>
// Release the lock.
void
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");
  100390:	c7 04 24 86 5f 10 00 	movl   $0x105f86,(%esp)
  100397:	e8 14 07 00 00       	call   100ab0 <panic>
  10039c:	90                   	nop
  10039d:	90                   	nop
  10039e:	90                   	nop
  10039f:	90                   	nop

001003a0 <console_read>:
  release(&input.lock);
}

int
console_read(struct inode *ip, char *dst, int n)
{
  1003a0:	55                   	push   %ebp
  1003a1:	57                   	push   %edi
  1003a2:	56                   	push   %esi
  1003a3:	53                   	push   %ebx
  1003a4:	83 ec 2c             	sub    $0x2c,%esp
  1003a7:	8b 7c 24 40          	mov    0x40(%esp),%edi
  1003ab:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  1003af:	8b 74 24 44          	mov    0x44(%esp),%esi
  uint target;
  int c;

  iunlock(ip);
  1003b3:	89 3c 24             	mov    %edi,(%esp)
  1003b6:	e8 55 26 00 00       	call   102a10 <iunlock>
  target = n;
  acquire(&input.lock);
  1003bb:	c7 04 24 60 88 10 00 	movl   $0x108860,(%esp)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  1003c2:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
  acquire(&input.lock);
  1003c6:	e8 a5 fe ff ff       	call   100270 <acquire>
  while(n > 0){
  1003cb:	31 c0                	xor    %eax,%eax
  1003cd:	85 db                	test   %ebx,%ebx
  1003cf:	7f 2b                	jg     1003fc <console_read+0x5c>
  1003d1:	eb 73                	jmp    100446 <console_read+0xa6>
  1003d3:	90                   	nop
  1003d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(cp->killed){
  1003d8:	e8 b3 10 00 00       	call   101490 <curproc>
  1003dd:	8b 40 1c             	mov    0x1c(%eax),%eax
  1003e0:	85 c0                	test   %eax,%eax
  1003e2:	0f 85 88 00 00 00    	jne    100470 <console_read+0xd0>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  1003e8:	c7 44 24 04 60 88 10 	movl   $0x108860,0x4(%esp)
  1003ef:	00 
  1003f0:	c7 04 24 14 89 10 00 	movl   $0x108914,(%esp)
  1003f7:	e8 34 13 00 00       	call   101730 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  1003fc:	a1 14 89 10 00       	mov    0x108914,%eax
  100401:	3b 05 18 89 10 00    	cmp    0x108918,%eax
  100407:	74 cf                	je     1003d8 <console_read+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  100409:	89 c1                	mov    %eax,%ecx
  10040b:	c1 f9 1f             	sar    $0x1f,%ecx
  10040e:	c1 e9 19             	shr    $0x19,%ecx
  100411:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100414:	83 e2 7f             	and    $0x7f,%edx
  100417:	29 ca                	sub    %ecx,%edx
  100419:	0f b6 8a 94 88 10 00 	movzbl 0x108894(%edx),%ecx
  100420:	8d 68 01             	lea    0x1(%eax),%ebp
  100423:	89 2d 14 89 10 00    	mov    %ebp,0x108914
  100429:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
  10042c:	83 fa 04             	cmp    $0x4,%edx
  10042f:	74 60                	je     100491 <console_read+0xf1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100431:	88 0e                	mov    %cl,(%esi)
    --n;
  100433:	83 eb 01             	sub    $0x1,%ebx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100436:	83 c6 01             	add    $0x1,%esi
    --n;
    if(c == '\n')
  100439:	83 fa 0a             	cmp    $0xa,%edx
  10043c:	74 5e                	je     10049c <console_read+0xfc>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  10043e:	85 db                	test   %ebx,%ebx
  100440:	75 ba                	jne    1003fc <console_read+0x5c>
  100442:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  100446:	c7 04 24 60 88 10 00 	movl   $0x108860,(%esp)
  10044d:	89 44 24 18          	mov    %eax,0x18(%esp)
  100451:	e8 0a ff ff ff       	call   100360 <release>
  ilock(ip);
  100456:	89 3c 24             	mov    %edi,(%esp)
  100459:	e8 b2 24 00 00       	call   102910 <ilock>
  10045e:	8b 44 24 18          	mov    0x18(%esp),%eax

  return target - n;
}
  100462:	83 c4 2c             	add    $0x2c,%esp
  100465:	5b                   	pop    %ebx
  100466:	5e                   	pop    %esi
  100467:	5f                   	pop    %edi
  100468:	5d                   	pop    %ebp
  100469:	c3                   	ret    
  10046a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
  100470:	c7 04 24 60 88 10 00 	movl   $0x108860,(%esp)
  100477:	e8 e4 fe ff ff       	call   100360 <release>
        ilock(ip);
  10047c:	89 3c 24             	mov    %edi,(%esp)
  10047f:	e8 8c 24 00 00       	call   102910 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  100484:	83 c4 2c             	add    $0x2c,%esp
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
        ilock(ip);
        return -1;
  100487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  10048c:	5b                   	pop    %ebx
  10048d:	5e                   	pop    %esi
  10048e:	5f                   	pop    %edi
  10048f:	5d                   	pop    %ebp
  100490:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  100491:	39 5c 24 1c          	cmp    %ebx,0x1c(%esp)
  100495:	76 05                	jbe    10049c <console_read+0xfc>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  100497:	a3 14 89 10 00       	mov    %eax,0x108914
  10049c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1004a0:	29 d8                	sub    %ebx,%eax
  1004a2:	eb a2                	jmp    100446 <console_read+0xa6>
  1004a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1004aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001004b0 <cons_putc>:
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  1004b0:	57                   	push   %edi
  1004b1:	56                   	push   %esi
  1004b2:	53                   	push   %ebx
  1004b3:	83 ec 10             	sub    $0x10,%esp
  if(panicked){
  1004b6:	8b 15 c4 87 10 00    	mov    0x1087c4,%edx
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  1004bc:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  if(panicked){
  1004c0:	85 d2                	test   %edx,%edx
  1004c2:	0f 85 d8 00 00 00    	jne    1005a0 <cons_putc+0xf0>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1004c8:	b8 79 03 00 00       	mov    $0x379,%eax
  1004cd:	89 c2                	mov    %eax,%edx
  1004cf:	ec                   	in     (%dx),%al
static void
lpt_putc(int c)
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
  1004d0:	84 c0                	test   %al,%al
  1004d2:	bb 00 32 00 00       	mov    $0x3200,%ebx
  1004d7:	79 0c                	jns    1004e5 <cons_putc+0x35>
  1004d9:	eb 0f                	jmp    1004ea <cons_putc+0x3a>
  1004db:	90                   	nop
  1004dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1004e0:	83 eb 01             	sub    $0x1,%ebx
  1004e3:	74 05                	je     1004ea <cons_putc+0x3a>
  1004e5:	ec                   	in     (%dx),%al
  1004e6:	84 c0                	test   %al,%al
  1004e8:	79 f6                	jns    1004e0 <cons_putc+0x30>
    ;
  if(c == BACKSPACE)
  1004ea:	bb 08 00 00 00       	mov    $0x8,%ebx
  1004ef:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  1004f5:	89 d8                	mov    %ebx,%eax


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1004f7:	ba 78 03 00 00       	mov    $0x378,%edx
  1004fc:	0f 45 c1             	cmovne %ecx,%eax
  1004ff:	ee                   	out    %al,(%dx)
  100500:	b8 0d 00 00 00       	mov    $0xd,%eax
  100505:	b2 7a                	mov    $0x7a,%dl
  100507:	ee                   	out    %al,(%dx)
  100508:	89 d8                	mov    %ebx,%eax
  10050a:	ee                   	out    %al,(%dx)
  10050b:	be d4 03 00 00       	mov    $0x3d4,%esi
  100510:	b8 0e 00 00 00       	mov    $0xe,%eax
  100515:	89 f2                	mov    %esi,%edx
  100517:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100518:	bf d5 03 00 00       	mov    $0x3d5,%edi
  10051d:	89 fa                	mov    %edi,%edx
  10051f:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  100520:	0f b6 d8             	movzbl %al,%ebx


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100523:	89 f2                	mov    %esi,%edx
  100525:	c1 e3 08             	shl    $0x8,%ebx
  100528:	b8 0f 00 00 00       	mov    $0xf,%eax
  10052d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10052e:	89 fa                	mov    %edi,%edx
  100530:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  100531:	0f b6 c0             	movzbl %al,%eax
  100534:	09 c3                	or     %eax,%ebx

  if(c == '\n')
  100536:	83 f9 0a             	cmp    $0xa,%ecx
  100539:	74 68                	je     1005a3 <cons_putc+0xf3>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  10053b:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  100541:	0f 84 c3 00 00 00    	je     10060a <cons_putc+0x15a>
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  100547:	66 81 e1 ff 00       	and    $0xff,%cx
  10054c:	80 cd 07             	or     $0x7,%ch
  10054f:	66 89 8c 1b 00 80 0b 	mov    %cx,0xb8000(%ebx,%ebx,1)
  100556:	00 
  100557:	83 c3 01             	add    $0x1,%ebx

  if((pos/80) >= 24){  // Scroll up.
  10055a:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  100560:	7f 5e                	jg     1005c0 <cons_putc+0x110>
  100562:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100569:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  10056e:	b8 0e 00 00 00       	mov    $0xe,%eax
  100573:	89 ca                	mov    %ecx,%edx
  100575:	ee                   	out    %al,(%dx)
  100576:	bf d5 03 00 00       	mov    $0x3d5,%edi
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  10057b:	89 d8                	mov    %ebx,%eax
  10057d:	c1 f8 08             	sar    $0x8,%eax
  100580:	89 fa                	mov    %edi,%edx
  100582:	ee                   	out    %al,(%dx)
  100583:	b8 0f 00 00 00       	mov    $0xf,%eax
  100588:	89 ca                	mov    %ecx,%edx
  10058a:	ee                   	out    %al,(%dx)
  10058b:	89 d8                	mov    %ebx,%eax
  10058d:	89 fa                	mov    %edi,%edx
  10058f:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  100590:	66 c7 06 20 07       	movw   $0x720,(%esi)
      ;
  }

  lpt_putc(c);
  cga_putc(c);
}
  100595:	83 c4 10             	add    $0x10,%esp
  100598:	5b                   	pop    %ebx
  100599:	5e                   	pop    %esi
  10059a:	5f                   	pop    %edi
  10059b:	c3                   	ret    
  10059c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
cli(void)
{
  asm volatile("cli");
  1005a0:	fa                   	cli    
  1005a1:	eb fe                	jmp    1005a1 <cons_putc+0xf1>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  1005a3:	89 d8                	mov    %ebx,%eax
  1005a5:	ba 67 66 66 66       	mov    $0x66666667,%edx
  1005aa:	f7 ea                	imul   %edx
  1005ac:	c1 fa 05             	sar    $0x5,%edx
  1005af:	8d 04 92             	lea    (%edx,%edx,4),%eax
  1005b2:	c1 e0 04             	shl    $0x4,%eax
  1005b5:	8d 58 50             	lea    0x50(%eax),%ebx
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if((pos/80) >= 24){  // Scroll up.
  1005b8:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  1005be:	7e a2                	jle    100562 <cons_putc+0xb2>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  1005c0:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
  1005c7:	00 
    pos -= 80;
  1005c8:	8d 7b b0             	lea    -0x50(%ebx),%edi
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  1005cb:	c7 44 24 04 a0 80 0b 	movl   $0xb80a0,0x4(%esp)
  1005d2:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  1005d3:	8d b4 3f 00 80 0b 00 	lea    0xb8000(%edi,%edi,1),%esi
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  1005da:	c7 04 24 00 80 0b 00 	movl   $0xb8000,(%esp)
  1005e1:	e8 ba 08 00 00       	call   100ea0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  1005e6:	b8 d0 07 00 00       	mov    $0x7d0,%eax
  1005eb:	29 d8                	sub    %ebx,%eax
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
  1005ed:	89 fb                	mov    %edi,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  1005ef:	01 c0                	add    %eax,%eax
  1005f1:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005f5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1005fc:	00 
  1005fd:	89 34 24             	mov    %esi,(%esp)
  100600:	e8 0b 08 00 00       	call   100e10 <memset>
  100605:	e9 5f ff ff ff       	jmp    100569 <cons_putc+0xb9>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
  10060a:	85 db                	test   %ebx,%ebx
  10060c:	0f 8e 50 ff ff ff    	jle    100562 <cons_putc+0xb2>
      crt[--pos] = ' ' | 0x0700;
  100612:	83 eb 01             	sub    $0x1,%ebx
  100615:	66 c7 84 1b 00 80 0b 	movw   $0x720,0xb8000(%ebx,%ebx,1)
  10061c:	00 20 07 
  10061f:	e9 36 ff ff ff       	jmp    10055a <cons_putc+0xaa>
  100624:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10062a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100630 <console_write>:
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  100630:	55                   	push   %ebp
  100631:	57                   	push   %edi
  100632:	56                   	push   %esi
  100633:	53                   	push   %ebx
  100634:	83 ec 1c             	sub    $0x1c,%esp
  100637:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  10063b:	8b 74 24 38          	mov    0x38(%esp),%esi
  10063f:	8b 7c 24 34          	mov    0x34(%esp),%edi
  int i;

  iunlock(ip);
  100643:	89 2c 24             	mov    %ebp,(%esp)
  100646:	e8 c5 23 00 00       	call   102a10 <iunlock>
  acquire(&console_lock);
  10064b:	c7 04 24 e0 87 10 00 	movl   $0x1087e0,(%esp)
  100652:	e8 19 fc ff ff       	call   100270 <acquire>
  for(i = 0; i < n; i++)
  100657:	85 f6                	test   %esi,%esi
  100659:	7e 18                	jle    100673 <console_write+0x43>
  10065b:	31 db                	xor    %ebx,%ebx
  10065d:	8d 76 00             	lea    0x0(%esi),%esi
    cons_putc(buf[i] & 0xff);
  100660:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  100664:	83 c3 01             	add    $0x1,%ebx
    cons_putc(buf[i] & 0xff);
  100667:	89 14 24             	mov    %edx,(%esp)
  10066a:	e8 41 fe ff ff       	call   1004b0 <cons_putc>
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  10066f:	39 f3                	cmp    %esi,%ebx
  100671:	75 ed                	jne    100660 <console_write+0x30>
    cons_putc(buf[i] & 0xff);
  release(&console_lock);
  100673:	c7 04 24 e0 87 10 00 	movl   $0x1087e0,(%esp)
  10067a:	e8 e1 fc ff ff       	call   100360 <release>
  ilock(ip);
  10067f:	89 2c 24             	mov    %ebp,(%esp)
  100682:	e8 89 22 00 00       	call   102910 <ilock>

  return n;
}
  100687:	83 c4 1c             	add    $0x1c,%esp
  10068a:	89 f0                	mov    %esi,%eax
  10068c:	5b                   	pop    %ebx
  10068d:	5e                   	pop    %esi
  10068e:	5f                   	pop    %edi
  10068f:	5d                   	pop    %ebp
  100690:	c3                   	ret    
  100691:	eb 0d                	jmp    1006a0 <printint>
  100693:	90                   	nop
  100694:	90                   	nop
  100695:	90                   	nop
  100696:	90                   	nop
  100697:	90                   	nop
  100698:	90                   	nop
  100699:	90                   	nop
  10069a:	90                   	nop
  10069b:	90                   	nop
  10069c:	90                   	nop
  10069d:	90                   	nop
  10069e:	90                   	nop
  10069f:	90                   	nop

001006a0 <printint>:
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  1006a0:	56                   	push   %esi
  1006a1:	53                   	push   %ebx
  1006a2:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  1006a5:	8b 4c 24 38          	mov    0x38(%esp),%ecx
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  1006a9:	8b 44 24 30          	mov    0x30(%esp),%eax
  1006ad:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  1006b1:	85 c9                	test   %ecx,%ecx
  1006b3:	74 63                	je     100718 <printint+0x78>
  1006b5:	89 c2                	mov    %eax,%edx
  1006b7:	c1 ea 1f             	shr    $0x1f,%edx
  1006ba:	84 d2                	test   %dl,%dl
  1006bc:	74 5a                	je     100718 <printint+0x78>
    neg = 1;
    x = 0 - xx;
  1006be:	f7 d8                	neg    %eax
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
  1006c0:	be 01 00 00 00       	mov    $0x1,%esi
void
printint(int xx, int base, int sgn)
{
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  1006c5:	31 c9                	xor    %ecx,%ecx
  1006c7:	eb 09                	jmp    1006d2 <printint+0x32>
  1006c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  1006d0:	89 d1                	mov    %edx,%ecx
  1006d2:	31 d2                	xor    %edx,%edx
  1006d4:	f7 f3                	div    %ebx
  1006d6:	0f b6 92 be 5f 10 00 	movzbl 0x105fbe(%edx),%edx
  }while((x /= base) != 0);
  1006dd:	85 c0                	test   %eax,%eax
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  1006df:	88 54 0c 10          	mov    %dl,0x10(%esp,%ecx,1)
  1006e3:	8d 51 01             	lea    0x1(%ecx),%edx
  }while((x /= base) != 0);
  1006e6:	75 e8                	jne    1006d0 <printint+0x30>
  if(neg)
  1006e8:	85 f6                	test   %esi,%esi
  1006ea:	74 08                	je     1006f4 <printint+0x54>
    buf[i++] = '-';
  1006ec:	c6 44 14 10 2d       	movb   $0x2d,0x10(%esp,%edx,1)
  1006f1:	8d 51 02             	lea    0x2(%ecx),%edx

  while(--i >= 0)
  1006f4:	8d 5a ff             	lea    -0x1(%edx),%ebx
  1006f7:	90                   	nop
    cons_putc(buf[i]);
  1006f8:	0f be 44 1c 10       	movsbl 0x10(%esp,%ebx,1),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  1006fd:	83 eb 01             	sub    $0x1,%ebx
    cons_putc(buf[i]);
  100700:	89 04 24             	mov    %eax,(%esp)
  100703:	e8 a8 fd ff ff       	call   1004b0 <cons_putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  100708:	83 fb ff             	cmp    $0xffffffff,%ebx
  10070b:	75 eb                	jne    1006f8 <printint+0x58>
    cons_putc(buf[i]);
}
  10070d:	83 c4 24             	add    $0x24,%esp
  100710:	5b                   	pop    %ebx
  100711:	5e                   	pop    %esi
  100712:	c3                   	ret    
  100713:	90                   	nop
  100714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
printint(int xx, int base, int sgn)
{
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  100718:	31 f6                	xor    %esi,%esi
  10071a:	eb a9                	jmp    1006c5 <printint+0x25>
  10071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100720 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  100720:	55                   	push   %ebp
  100721:	57                   	push   %edi
  100722:	56                   	push   %esi
  100723:	53                   	push   %ebx
  100724:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  100727:	a1 c0 87 10 00       	mov    0x1087c0,%eax
  if(locking)
  10072c:	85 c0                	test   %eax,%eax
{
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  10072e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  if(locking)
  100732:	0f 85 58 01 00 00    	jne    100890 <cprintf+0x170>
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100738:	8b 5c 24 40          	mov    0x40(%esp),%ebx
  10073c:	0f b6 03             	movzbl (%ebx),%eax
  10073f:	84 c0                	test   %al,%al
  100741:	74 75                	je     1007b8 <cprintf+0x98>
  100743:	8d 6c 24 44          	lea    0x44(%esp),%ebp
  100747:	31 ff                	xor    %edi,%edi
  100749:	eb 27                	jmp    100772 <cprintf+0x52>
  10074b:	90                   	nop
  10074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  100750:	83 fe 25             	cmp    $0x25,%esi
  100753:	0f 84 7f 00 00 00    	je     1007d8 <cprintf+0xb8>
        state = '%';
      else
        cons_putc(c);
  100759:	89 34 24             	mov    %esi,(%esp)
  10075c:	e8 4f fd ff ff       	call   1004b0 <cons_putc>
  100761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
  100768:	83 c3 01             	add    $0x1,%ebx
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  10076b:	0f b6 03             	movzbl (%ebx),%eax
  10076e:	84 c0                	test   %al,%al
  100770:	74 46                	je     1007b8 <cprintf+0x98>
    c = fmt[i] & 0xff;
    switch(state){
  100772:	85 ff                	test   %edi,%edi
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
  100774:	0f b6 f0             	movzbl %al,%esi
    switch(state){
  100777:	74 d7                	je     100750 <cprintf+0x30>
  100779:	83 ff 25             	cmp    $0x25,%edi
  10077c:	75 ea                	jne    100768 <cprintf+0x48>
      else
        cons_putc(c);
      break;

    case '%':
      switch(c){
  10077e:	83 fe 70             	cmp    $0x70,%esi
  100781:	74 67                	je     1007ea <cprintf+0xca>
  100783:	7f 5b                	jg     1007e0 <cprintf+0xc0>
  100785:	83 fe 25             	cmp    $0x25,%esi
  100788:	0f 84 ea 00 00 00    	je     100878 <cprintf+0x158>
  10078e:	83 fe 64             	cmp    $0x64,%esi
  100791:	0f 84 b9 00 00 00    	je     100850 <cprintf+0x130>
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  100797:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
        cons_putc(c);
        break;
  10079e:	83 c3 01             	add    $0x1,%ebx
      }
      state = 0;
  1007a1:	31 ff                	xor    %edi,%edi
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  1007a3:	e8 08 fd ff ff       	call   1004b0 <cons_putc>
        cons_putc(c);
  1007a8:	89 34 24             	mov    %esi,(%esp)
  1007ab:	e8 00 fd ff ff       	call   1004b0 <cons_putc>
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1007b0:	0f b6 03             	movzbl (%ebx),%eax
  1007b3:	84 c0                	test   %al,%al
  1007b5:	75 bb                	jne    100772 <cprintf+0x52>
  1007b7:	90                   	nop
      state = 0;
      break;
    }
  }

  if(locking)
  1007b8:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  1007bc:	85 db                	test   %ebx,%ebx
  1007be:	74 0c                	je     1007cc <cprintf+0xac>
    release(&console_lock);
  1007c0:	c7 04 24 e0 87 10 00 	movl   $0x1087e0,(%esp)
  1007c7:	e8 94 fb ff ff       	call   100360 <release>
}
  1007cc:	83 c4 2c             	add    $0x2c,%esp
  1007cf:	5b                   	pop    %ebx
  1007d0:	5e                   	pop    %esi
  1007d1:	5f                   	pop    %edi
  1007d2:	5d                   	pop    %ebp
  1007d3:	c3                   	ret    
  1007d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
        state = '%';
  1007d8:	bf 25 00 00 00       	mov    $0x25,%edi
  1007dd:	eb 89                	jmp    100768 <cprintf+0x48>
  1007df:	90                   	nop
      else
        cons_putc(c);
      break;

    case '%':
      switch(c){
  1007e0:	83 fe 73             	cmp    $0x73,%esi
  1007e3:	74 2b                	je     100810 <cprintf+0xf0>
  1007e5:	83 fe 78             	cmp    $0x78,%esi
  1007e8:	75 ad                	jne    100797 <cprintf+0x77>
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  1007ea:	8b 45 00             	mov    0x0(%ebp),%eax
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  1007ed:	31 ff                	xor    %edi,%edi
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  1007ef:	83 c5 04             	add    $0x4,%ebp
  1007f2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1007f9:	00 
  1007fa:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100801:	00 
  100802:	89 04 24             	mov    %eax,(%esp)
  100805:	e8 96 fe ff ff       	call   1006a0 <printint>
        break;
  10080a:	e9 59 ff ff ff       	jmp    100768 <cprintf+0x48>
  10080f:	90                   	nop
      case 's':
        s = (char*)*argp++;
  100810:	8b 75 00             	mov    0x0(%ebp),%esi
        if(s == 0)
          s = "(null)";
  100813:	b8 8e 5f 10 00       	mov    $0x105f8e,%eax
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
  100818:	83 c5 04             	add    $0x4,%ebp
        if(s == 0)
          s = "(null)";
  10081b:	85 f6                	test   %esi,%esi
  10081d:	0f 44 f0             	cmove  %eax,%esi
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  100820:	31 ff                	xor    %edi,%edi
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  100822:	0f b6 06             	movzbl (%esi),%eax
  100825:	84 c0                	test   %al,%al
  100827:	0f 84 3b ff ff ff    	je     100768 <cprintf+0x48>
  10082d:	8d 76 00             	lea    0x0(%esi),%esi
          cons_putc(*s);
  100830:	0f be c0             	movsbl %al,%eax
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  100833:	83 c6 01             	add    $0x1,%esi
          cons_putc(*s);
  100836:	89 04 24             	mov    %eax,(%esp)
  100839:	e8 72 fc ff ff       	call   1004b0 <cons_putc>
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  10083e:	0f b6 06             	movzbl (%esi),%eax
  100841:	84 c0                	test   %al,%al
  100843:	75 eb                	jne    100830 <cprintf+0x110>
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  100845:	31 ff                	xor    %edi,%edi
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
        break;
  100847:	e9 1c ff ff ff       	jmp    100768 <cprintf+0x48>
  10084c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;

    case '%':
      switch(c){
      case 'd':
        printint(*argp++, 10, 1);
  100850:	8b 45 00             	mov    0x0(%ebp),%eax
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  100853:	31 ff                	xor    %edi,%edi
      break;

    case '%':
      switch(c){
      case 'd':
        printint(*argp++, 10, 1);
  100855:	83 c5 04             	add    $0x4,%ebp
  100858:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  10085f:	00 
  100860:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  100867:	00 
  100868:	89 04 24             	mov    %eax,(%esp)
  10086b:	e8 30 fe ff ff       	call   1006a0 <printint>
        break;
  100870:	e9 f3 fe ff ff       	jmp    100768 <cprintf+0x48>
  100875:	8d 76 00             	lea    0x0(%esi),%esi
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
  100878:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      state = 0;
  10087f:	31 ff                	xor    %edi,%edi
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
  100881:	e8 2a fc ff ff       	call   1004b0 <cons_putc>
  100886:	e9 dd fe ff ff       	jmp    100768 <cprintf+0x48>
  10088b:	90                   	nop
  10088c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint *argp;
  char *s;

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);
  100890:	c7 04 24 e0 87 10 00 	movl   $0x1087e0,(%esp)
  100897:	e8 d4 f9 ff ff       	call   100270 <acquire>
  10089c:	e9 97 fe ff ff       	jmp    100738 <cprintf+0x18>
  1008a1:	eb 0d                	jmp    1008b0 <console_intr>
  1008a3:	90                   	nop
  1008a4:	90                   	nop
  1008a5:	90                   	nop
  1008a6:	90                   	nop
  1008a7:	90                   	nop
  1008a8:	90                   	nop
  1008a9:	90                   	nop
  1008aa:	90                   	nop
  1008ab:	90                   	nop
  1008ac:	90                   	nop
  1008ad:	90                   	nop
  1008ae:	90                   	nop
  1008af:	90                   	nop

001008b0 <console_intr>:

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  1008b0:	56                   	push   %esi
  1008b1:	53                   	push   %ebx
  1008b2:	83 ec 24             	sub    $0x24,%esp
  int c;

  acquire(&input.lock);
  1008b5:	c7 04 24 60 88 10 00 	movl   $0x108860,(%esp)

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  1008bc:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  int c;

  acquire(&input.lock);
  1008c0:	e8 ab f9 ff ff       	call   100270 <acquire>
  1008c5:	8d 76 00             	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
  1008c8:	ff d3                	call   *%ebx
  1008ca:	85 c0                	test   %eax,%eax
  1008cc:	0f 88 96 00 00 00    	js     100968 <console_intr+0xb8>
    switch(c){
  1008d2:	83 f8 10             	cmp    $0x10,%eax
  1008d5:	0f 84 a5 00 00 00    	je     100980 <console_intr+0xd0>
  1008db:	83 f8 15             	cmp    $0x15,%eax
  1008de:	66 90                	xchg   %ax,%ax
  1008e0:	0f 84 da 00 00 00    	je     1009c0 <console_intr+0x110>
  1008e6:	83 f8 08             	cmp    $0x8,%eax
  1008e9:	0f 84 a1 00 00 00    	je     100990 <console_intr+0xe0>
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
  1008ef:	85 c0                	test   %eax,%eax
  1008f1:	74 d5                	je     1008c8 <console_intr+0x18>
  1008f3:	8b 0d 14 89 10 00    	mov    0x108914,%ecx
  1008f9:	8b 15 1c 89 10 00    	mov    0x10891c,%edx
  1008ff:	83 c1 7f             	add    $0x7f,%ecx
  100902:	39 d1                	cmp    %edx,%ecx
  100904:	7c c2                	jl     1008c8 <console_intr+0x18>
        input.buf[input.e++ % INPUT_BUF] = c;
  100906:	89 d6                	mov    %edx,%esi
  100908:	c1 fe 1f             	sar    $0x1f,%esi
  10090b:	c1 ee 19             	shr    $0x19,%esi
  10090e:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
  100911:	83 c2 01             	add    $0x1,%edx
  100914:	83 e1 7f             	and    $0x7f,%ecx
  100917:	29 f1                	sub    %esi,%ecx
        cons_putc(c);
  100919:	89 04 24             	mov    %eax,(%esp)
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  10091c:	88 81 94 88 10 00    	mov    %al,0x108894(%ecx)
        cons_putc(c);
  100922:	89 44 24 1c          	mov    %eax,0x1c(%esp)
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  100926:	89 15 1c 89 10 00    	mov    %edx,0x10891c
        cons_putc(c);
  10092c:	e8 7f fb ff ff       	call   1004b0 <cons_putc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100931:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  100935:	83 f8 04             	cmp    $0x4,%eax
  100938:	0f 84 df 00 00 00    	je     100a1d <console_intr+0x16d>
  10093e:	83 f8 0a             	cmp    $0xa,%eax
  100941:	0f 84 d6 00 00 00    	je     100a1d <console_intr+0x16d>
  100947:	8b 15 14 89 10 00    	mov    0x108914,%edx
  10094d:	a1 1c 89 10 00       	mov    0x10891c,%eax
  100952:	83 ea 80             	sub    $0xffffff80,%edx
  100955:	39 d0                	cmp    %edx,%eax
  100957:	0f 84 c5 00 00 00    	je     100a22 <console_intr+0x172>
console_intr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  10095d:	ff d3                	call   *%ebx
  10095f:	85 c0                	test   %eax,%eax
  100961:	0f 89 6b ff ff ff    	jns    1008d2 <console_intr+0x22>
  100967:	90                   	nop
        }
      }
      break;
    }
  }
  release(&input.lock);
  100968:	c7 44 24 30 60 88 10 	movl   $0x108860,0x30(%esp)
  10096f:	00 
}
  100970:	83 c4 24             	add    $0x24,%esp
  100973:	5b                   	pop    %ebx
  100974:	5e                   	pop    %esi
        }
      }
      break;
    }
  }
  release(&input.lock);
  100975:	e9 e6 f9 ff ff       	jmp    100360 <release>
  10097a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  100980:	e8 ab 11 00 00       	call   101b30 <procdump>
      break;
  100985:	e9 3e ff ff ff       	jmp    1008c8 <console_intr+0x18>
  10098a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e > input.w){
  100990:	a1 1c 89 10 00       	mov    0x10891c,%eax
  100995:	3b 05 18 89 10 00    	cmp    0x108918,%eax
  10099b:	0f 8e 27 ff ff ff    	jle    1008c8 <console_intr+0x18>
        input.e--;
  1009a1:	83 e8 01             	sub    $0x1,%eax
        cons_putc(BACKSPACE);
  1009a4:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
        cons_putc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e > input.w){
        input.e--;
  1009ab:	a3 1c 89 10 00       	mov    %eax,0x10891c
        cons_putc(BACKSPACE);
  1009b0:	e8 fb fa ff ff       	call   1004b0 <cons_putc>
  1009b5:	e9 0e ff ff ff       	jmp    1008c8 <console_intr+0x18>
  1009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  1009c0:	8b 0d 1c 89 10 00    	mov    0x10891c,%ecx
  1009c6:	39 0d 18 89 10 00    	cmp    %ecx,0x108918
  1009cc:	7c 2e                	jl     1009fc <console_intr+0x14c>
  1009ce:	e9 f5 fe ff ff       	jmp    1008c8 <console_intr+0x18>
  1009d3:	90                   	nop
  1009d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        cons_putc(BACKSPACE);
  1009d8:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  1009df:	89 0d 1c 89 10 00    	mov    %ecx,0x10891c
        cons_putc(BACKSPACE);
  1009e5:	e8 c6 fa ff ff       	call   1004b0 <cons_putc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  1009ea:	8b 0d 1c 89 10 00    	mov    0x10891c,%ecx
  1009f0:	3b 0d 18 89 10 00    	cmp    0x108918,%ecx
  1009f6:	0f 8e cc fe ff ff    	jle    1008c8 <console_intr+0x18>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  1009fc:	83 e9 01             	sub    $0x1,%ecx
  1009ff:	89 ca                	mov    %ecx,%edx
  100a01:	c1 fa 1f             	sar    $0x1f,%edx
  100a04:	c1 ea 19             	shr    $0x19,%edx
  100a07:	8d 04 11             	lea    (%ecx,%edx,1),%eax
  100a0a:	83 e0 7f             	and    $0x7f,%eax
  100a0d:	29 d0                	sub    %edx,%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  100a0f:	80 b8 94 88 10 00 0a 	cmpb   $0xa,0x108894(%eax)
  100a16:	75 c0                	jne    1009d8 <console_intr+0x128>
  100a18:	e9 ab fe ff ff       	jmp    1008c8 <console_intr+0x18>
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        cons_putc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100a1d:	a1 1c 89 10 00       	mov    0x10891c,%eax
          input.w = input.e;
          wakeup(&input.r);
  100a22:	c7 04 24 14 89 10 00 	movl   $0x108914,(%esp)
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        cons_putc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
  100a29:	a3 18 89 10 00       	mov    %eax,0x108918
          wakeup(&input.r);
  100a2e:	e8 cd 0d 00 00       	call   101800 <wakeup>
  100a33:	e9 90 fe ff ff       	jmp    1008c8 <console_intr+0x18>
  100a38:	90                   	nop
  100a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100a40 <console_init>:
  return target - n;
}

void
console_init(void)
{
  100a40:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&console_lock, "console");
  100a43:	c7 44 24 04 95 5f 10 	movl   $0x105f95,0x4(%esp)
  100a4a:	00 
  100a4b:	c7 04 24 e0 87 10 00 	movl   $0x1087e0,(%esp)
  100a52:	e8 29 f7 ff ff       	call   100180 <initlock>
  initlock(&input.lock, "console input");
  100a57:	c7 44 24 04 9d 5f 10 	movl   $0x105f9d,0x4(%esp)
  100a5e:	00 
  100a5f:	c7 04 24 60 88 10 00 	movl   $0x108860,(%esp)
  100a66:	e8 15 f7 ff ff       	call   100180 <initlock>

  devsw[CONSOLE].write = console_write;
  devsw[CONSOLE].read = console_read;
  use_console_lock = 1;

  pic_enable(IRQ_KBD);
  100a6b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
console_init(void)
{
  initlock(&console_lock, "console");
  initlock(&input.lock, "console input");

  devsw[CONSOLE].write = console_write;
  100a72:	c7 05 ac e8 10 00 30 	movl   $0x100630,0x10e8ac
  100a79:	06 10 00 
  devsw[CONSOLE].read = console_read;
  100a7c:	c7 05 a8 e8 10 00 a0 	movl   $0x1003a0,0x10e8a8
  100a83:	03 10 00 
  use_console_lock = 1;
  100a86:	c7 05 c0 87 10 00 01 	movl   $0x1,0x1087c0
  100a8d:	00 00 00 

  pic_enable(IRQ_KBD);
  100a90:	e8 5b 2d 00 00       	call   1037f0 <pic_enable>
  ioapic_enable(IRQ_KBD, 0);
  100a95:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100a9c:	00 
  100a9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100aa4:	e8 07 12 00 00       	call   101cb0 <ioapic_enable>
}
  100aa9:	83 c4 1c             	add    $0x1c,%esp
  100aac:	c3                   	ret    
  100aad:	8d 76 00             	lea    0x0(%esi),%esi

00100ab0 <panic>:

void
panic(char *s)
{
  100ab0:	56                   	push   %esi
  100ab1:	53                   	push   %ebx
  100ab2:	83 ec 44             	sub    $0x44,%esp
  int i;
  uint pcs[10];

  __asm __volatile("cli");
  use_console_lock = 0;
  100ab5:	c7 05 c0 87 10 00 00 	movl   $0x0,0x1087c0
  100abc:	00 00 00 
panic(char *s)
{
  int i;
  uint pcs[10];

  __asm __volatile("cli");
  100abf:	fa                   	cli    
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  100ac0:	e8 6b 01 00 00       	call   100c30 <cpu>
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  100ac5:	8d 5c 24 18          	lea    0x18(%esp),%ebx
  int i;
  uint pcs[10];

  __asm __volatile("cli");
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  100ac9:	c7 04 24 ab 5f 10 00 	movl   $0x105fab,(%esp)
  pic_enable(IRQ_KBD);
  ioapic_enable(IRQ_KBD, 0);
}

void
panic(char *s)
  100ad0:	8d 74 24 40          	lea    0x40(%esp),%esi
  int i;
  uint pcs[10];

  __asm __volatile("cli");
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  100ad4:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ad8:	e8 43 fc ff ff       	call   100720 <cprintf>
  cprintf(s, 0);
  100add:	8b 44 24 50          	mov    0x50(%esp),%eax
  100ae1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100ae8:	00 
  100ae9:	89 04 24             	mov    %eax,(%esp)
  100aec:	e8 2f fc ff ff       	call   100720 <cprintf>
  cprintf("\n", 0);
  100af1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100af8:	00 
  100af9:	c7 04 24 9c 66 10 00 	movl   $0x10669c,(%esp)
  100b00:	e8 1b fc ff ff       	call   100720 <cprintf>
  getcallerpcs(&s, pcs);
  100b05:	8d 44 24 50          	lea    0x50(%esp),%eax
  100b09:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  100b0d:	89 04 24             	mov    %eax,(%esp)
  100b10:	e8 8b f6 ff ff       	call   1001a0 <getcallerpcs>
  100b15:	8d 76 00             	lea    0x0(%esi),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  100b18:	8b 03                	mov    (%ebx),%eax
  100b1a:	83 c3 04             	add    $0x4,%ebx
  100b1d:	c7 04 24 ba 5f 10 00 	movl   $0x105fba,(%esp)
  100b24:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b28:	e8 f3 fb ff ff       	call   100720 <cprintf>
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  100b2d:	39 f3                	cmp    %esi,%ebx
  100b2f:	75 e7                	jne    100b18 <panic+0x68>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  100b31:	c7 05 c4 87 10 00 01 	movl   $0x1,0x1087c4
  100b38:	00 00 00 
  100b3b:	eb fe                	jmp    100b3b <panic+0x8b>
  100b3d:	90                   	nop
  100b3e:	90                   	nop
  100b3f:	90                   	nop

00100b40 <lapic_init>:
}

void
lapic_init(int c)
{
  if(!lapic)
  100b40:	a1 20 89 10 00       	mov    0x108920,%eax
  100b45:	85 c0                	test   %eax,%eax
  100b47:	0f 84 c3 00 00 00    	je     100c10 <lapic_init+0xd0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100b4d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  100b54:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100b57:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100b5a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  100b61:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100b64:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100b67:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  100b6e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  100b71:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100b74:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  100b7b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  100b7e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100b81:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  100b88:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  100b8b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100b8e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  100b95:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  100b98:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  100b9b:	8b 50 30             	mov    0x30(%eax),%edx
  100b9e:	c1 ea 10             	shr    $0x10,%edx
  100ba1:	80 fa 03             	cmp    $0x3,%dl
  100ba4:	77 72                	ja     100c18 <lapic_init+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100ba6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  100bad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100bb0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100bb3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  100bba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100bbd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100bc0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  100bc7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100bca:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100bcd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  100bd4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100bd7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100bda:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  100be1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100be4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100be7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  100bee:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  100bf1:	8b 50 20             	mov    0x20(%eax),%edx
  100bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  100bf8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
  100bfe:	80 e6 10             	and    $0x10,%dh
  100c01:	75 f5                	jne    100bf8 <lapic_init+0xb8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100c03:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  100c0a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100c0d:	8b 40 20             	mov    0x20(%eax),%eax
  100c10:	f3 c3                	repz ret 
  100c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100c18:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  100c1f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  100c22:	8b 50 20             	mov    0x20(%eax),%edx
  100c25:	e9 7c ff ff ff       	jmp    100ba6 <lapic_init+0x66>
  100c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100c30 <cpu>:
  lapicw(TPR, 0);
}

int
cpu(void)
{
  100c30:	83 ec 1c             	sub    $0x1c,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  100c33:	9c                   	pushf  
  100c34:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
  100c35:	f6 c4 02             	test   $0x2,%ah
  100c38:	74 12                	je     100c4c <cpu+0x1c>
    static int n;
    if(n++ == 0)
  100c3a:	a1 14 88 10 00       	mov    0x108814,%eax
  100c3f:	8d 50 01             	lea    0x1(%eax),%edx
  100c42:	85 c0                	test   %eax,%eax
  100c44:	89 15 14 88 10 00    	mov    %edx,0x108814
  100c4a:	74 1c                	je     100c68 <cpu+0x38>
      cprintf("cpu called from %x with interrupts enabled\n",
        ((uint*)read_ebp())[1]);
  }

  if(lapic)
  100c4c:	8b 15 20 89 10 00    	mov    0x108920,%edx
    return lapic[ID]>>24;
  return 0;
  100c52:	31 c0                	xor    %eax,%eax
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
        ((uint*)read_ebp())[1]);
  }

  if(lapic)
  100c54:	85 d2                	test   %edx,%edx
  100c56:	74 06                	je     100c5e <cpu+0x2e>
    return lapic[ID]>>24;
  100c58:	8b 42 20             	mov    0x20(%edx),%eax
  100c5b:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  100c5e:	83 c4 1c             	add    $0x1c,%esp
  100c61:	c3                   	ret    
  100c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
static inline uint
read_ebp(void)
{
  uint ebp;

  asm volatile("movl %%ebp, %0" : "=a" (ebp));
  100c68:	89 e8                	mov    %ebp,%eax
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  100c6a:	8b 40 04             	mov    0x4(%eax),%eax
  100c6d:	c7 04 24 d0 5f 10 00 	movl   $0x105fd0,(%esp)
  100c74:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c78:	e8 a3 fa ff ff       	call   100720 <cprintf>
  100c7d:	eb cd                	jmp    100c4c <cpu+0x1c>
  100c7f:	90                   	nop

00100c80 <lapic_eoi>:

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  if(lapic)
  100c80:	a1 20 89 10 00       	mov    0x108920,%eax
  100c85:	85 c0                	test   %eax,%eax
  100c87:	74 0d                	je     100c96 <lapic_eoi+0x16>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100c89:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  100c90:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100c93:	8b 40 20             	mov    0x20(%eax),%eax
  100c96:	f3 c3                	repz ret 
  100c98:	90                   	nop
  100c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100ca0 <lapic_startap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapic_startap(uchar apicid, uint addr)
{
  100ca0:	57                   	push   %edi


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100ca1:	ba 70 00 00 00       	mov    $0x70,%edx
  100ca6:	56                   	push   %esi
  100ca7:	b8 0f 00 00 00       	mov    $0xf,%eax
  100cac:	53                   	push   %ebx
  100cad:	83 ec 10             	sub    $0x10,%esp
  100cb0:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  100cb4:	0f b6 5c 24 20       	movzbl 0x20(%esp),%ebx
  100cb9:	ee                   	out    %al,(%dx)
  100cba:	b8 0a 00 00 00       	mov    $0xa,%eax
  100cbf:	b2 71                	mov    $0x71,%dl
  100cc1:	ee                   	out    %al,(%dx)
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100cc2:	8b 35 20 89 10 00    	mov    0x108920,%esi
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  100cc8:	89 c8                	mov    %ecx,%eax
  100cca:	c1 e8 04             	shr    $0x4,%eax

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  100ccd:	c1 e3 18             	shl    $0x18,%ebx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  100cd0:	66 a3 69 04 00 00    	mov    %ax,0x469
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  100cd6:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  100cdd:	00 00 
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100cdf:	89 9e 10 03 00 00    	mov    %ebx,0x310(%esi)
  lapic[ID];  // wait for write to finish, by reading
  100ce5:	8b 46 20             	mov    0x20(%esi),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100ce8:	c7 86 00 03 00 00 00 	movl   $0xc500,0x300(%esi)
  100cef:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100cf2:	8b 46 20             	mov    0x20(%esi),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  100cf5:	b8 c8 00 00 00       	mov    $0xc8,%eax
  100cfa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100d01:	00 
  100d02:	eb 09                	jmp    100d0d <lapic_startap+0x6d>
  100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(us-- > 0)
  100d08:	83 e8 01             	sub    $0x1,%eax
  100d0b:	74 30                	je     100d3d <lapic_startap+0x9d>
    for(j=0; j<10000; j++);
  100d0d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100d14:	00 
  100d15:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100d19:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  100d1f:	7f e7                	jg     100d08 <lapic_startap+0x68>
  100d21:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100d25:	83 c2 01             	add    $0x1,%edx
  100d28:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100d2c:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100d30:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  100d36:	7e e9                	jle    100d21 <lapic_startap+0x81>
static void
microdelay(int us)
{
  volatile int j = 0;

  while(us-- > 0)
  100d38:	83 e8 01             	sub    $0x1,%eax
  100d3b:	75 d0                	jne    100d0d <lapic_startap+0x6d>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100d3d:	c7 86 00 03 00 00 00 	movl   $0x8500,0x300(%esi)
  100d44:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100d47:	8b 46 20             	mov    0x20(%esi),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  100d4a:	b8 64 00 00 00       	mov    $0x64,%eax
  100d4f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100d56:	00 
  100d57:	eb 0c                	jmp    100d65 <lapic_startap+0xc5>
  100d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  while(us-- > 0)
  100d60:	83 e8 01             	sub    $0x1,%eax
  100d63:	74 30                	je     100d95 <lapic_startap+0xf5>
    for(j=0; j<10000; j++);
  100d65:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100d6c:	00 
  100d6d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100d71:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  100d77:	7f e7                	jg     100d60 <lapic_startap+0xc0>
  100d79:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100d7d:	83 c2 01             	add    $0x1,%edx
  100d80:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100d84:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100d88:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  100d8e:	7e e9                	jle    100d79 <lapic_startap+0xd9>
static void
microdelay(int us)
{
  volatile int j = 0;

  while(us-- > 0)
  100d90:	83 e8 01             	sub    $0x1,%eax
  100d93:	75 d0                	jne    100d65 <lapic_startap+0xc5>
  100d95:	c1 e9 0c             	shr    $0xc,%ecx
  100d98:	bf 02 00 00 00       	mov    $0x2,%edi
  100d9d:	80 cd 06             	or     $0x6,%ch
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100da0:	89 9e 10 03 00 00    	mov    %ebx,0x310(%esi)
  lapic[ID];  // wait for write to finish, by reading
  100da6:	8b 46 20             	mov    0x20(%esi),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  100da9:	89 8e 00 03 00 00    	mov    %ecx,0x300(%esi)
  lapic[ID];  // wait for write to finish, by reading
  100daf:	8b 46 20             	mov    0x20(%esi),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  100db2:	b8 c8 00 00 00       	mov    $0xc8,%eax
  100db7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100dbe:	00 
  100dbf:	eb 0c                	jmp    100dcd <lapic_startap+0x12d>
  100dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  while(us-- > 0)
  100dc8:	83 e8 01             	sub    $0x1,%eax
  100dcb:	74 33                	je     100e00 <lapic_startap+0x160>
    for(j=0; j<10000; j++);
  100dcd:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100dd4:	00 
  100dd5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100dd9:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  100ddf:	7f e7                	jg     100dc8 <lapic_startap+0x128>
  100de1:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100de5:	83 c2 01             	add    $0x1,%edx
  100de8:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100dec:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100df0:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  100df6:	7e e9                	jle    100de1 <lapic_startap+0x141>
static void
microdelay(int us)
{
  volatile int j = 0;

  while(us-- > 0)
  100df8:	83 e8 01             	sub    $0x1,%eax
  100dfb:	75 d0                	jne    100dcd <lapic_startap+0x12d>
  100dfd:	8d 76 00             	lea    0x0(%esi),%esi
  // Send startup IPI (twice!) to enter bootstrap code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
  100e00:	83 ef 01             	sub    $0x1,%edi
  100e03:	75 9b                	jne    100da0 <lapic_startap+0x100>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
  100e05:	83 c4 10             	add    $0x10,%esp
  100e08:	5b                   	pop    %ebx
  100e09:	5e                   	pop    %esi
  100e0a:	5f                   	pop    %edi
  100e0b:	c3                   	ret    
  100e0c:	90                   	nop
  100e0d:	90                   	nop
  100e0e:	90                   	nop
  100e0f:	90                   	nop

00100e10 <memset>:

#include "type.h"

void*
memset(void *dst, uchar c, uint n)
{
  100e10:	53                   	push   %ebx
  100e11:	8b 54 24 10          	mov    0x10(%esp),%edx
  100e15:	8b 44 24 08          	mov    0x8(%esp),%eax
  100e19:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  100e1d:	85 d2                	test   %edx,%edx
  100e1f:	74 11                	je     100e32 <memset+0x22>
void*
memset(void *dst, uchar c, uint n)
{
  char *d;

  d = (char*)dst;
  100e21:	89 c1                	mov    %eax,%ecx
  100e23:	90                   	nop
  100e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(n-- > 0)
    *d++ = c;
  100e28:	88 19                	mov    %bl,(%ecx)
  100e2a:	83 c1 01             	add    $0x1,%ecx
memset(void *dst, uchar c, uint n)
{
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  100e2d:	83 ea 01             	sub    $0x1,%edx
  100e30:	75 f6                	jne    100e28 <memset+0x18>
    *d++ = c;

  return dst;
}
  100e32:	5b                   	pop    %ebx
  100e33:	c3                   	ret    
  100e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100e40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  100e40:	57                   	push   %edi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
  100e41:	31 c0                	xor    %eax,%eax
  return dst;
}

int
memcmp(const void *v1, const void *v2, uint n)
{
  100e43:	56                   	push   %esi
  100e44:	53                   	push   %ebx
  100e45:	8b 7c 24 18          	mov    0x18(%esp),%edi
  100e49:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100e4d:	8b 74 24 14          	mov    0x14(%esp),%esi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  100e51:	85 ff                	test   %edi,%edi
  100e53:	74 29                	je     100e7e <memcmp+0x3e>
    if(*s1 != *s2)
  100e55:	0f b6 03             	movzbl (%ebx),%eax
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  100e58:	83 ef 01             	sub    $0x1,%edi
  100e5b:	31 d2                	xor    %edx,%edx
    if(*s1 != *s2)
  100e5d:	0f b6 0e             	movzbl (%esi),%ecx
  100e60:	38 c8                	cmp    %cl,%al
  100e62:	74 14                	je     100e78 <memcmp+0x38>
  100e64:	eb 22                	jmp    100e88 <memcmp+0x48>
  100e66:	66 90                	xchg   %ax,%ax
  100e68:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
  100e6d:	83 c2 01             	add    $0x1,%edx
  100e70:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  100e74:	38 c8                	cmp    %cl,%al
  100e76:	75 10                	jne    100e88 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  100e78:	39 d7                	cmp    %edx,%edi
  100e7a:	75 ec                	jne    100e68 <memcmp+0x28>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
  100e7c:	31 c0                	xor    %eax,%eax
}
  100e7e:	5b                   	pop    %ebx
  100e7f:	5e                   	pop    %esi
  100e80:	5f                   	pop    %edi
  100e81:	c3                   	ret    
  100e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  100e88:	0f b6 c0             	movzbl %al,%eax
  100e8b:	0f b6 c9             	movzbl %cl,%ecx
    s1++, s2++;
  }

  return 0;
}
  100e8e:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  100e8f:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
  100e91:	5e                   	pop    %esi
  100e92:	5f                   	pop    %edi
  100e93:	c3                   	ret    
  100e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100ea0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  100ea0:	57                   	push   %edi
  100ea1:	56                   	push   %esi
  100ea2:	53                   	push   %ebx
  100ea3:	8b 44 24 10          	mov    0x10(%esp),%eax
  100ea7:	8b 74 24 14          	mov    0x14(%esp),%esi
  100eab:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  100eaf:	39 c6                	cmp    %eax,%esi
  100eb1:	73 35                	jae    100ee8 <memmove+0x48>
  100eb3:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
  100eb6:	39 c8                	cmp    %ecx,%eax
  100eb8:	73 2e                	jae    100ee8 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
  100eba:	85 db                	test   %ebx,%ebx
  100ebc:	74 20                	je     100ede <memmove+0x3e>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
  100ebe:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
  100ec1:	89 da                	mov    %ebx,%edx

  return 0;
}

void*
memmove(void *dst, const void *src, uint n)
  100ec3:	f7 db                	neg    %ebx
  100ec5:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
  100ec8:	01 fb                	add    %edi,%ebx
  100eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  100ed0:	0f b6 4c 16 ff       	movzbl -0x1(%esi,%edx,1),%ecx
  100ed5:	88 4c 13 ff          	mov    %cl,-0x1(%ebx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  100ed9:	83 ea 01             	sub    $0x1,%edx
  100edc:	75 f2                	jne    100ed0 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  100ede:	5b                   	pop    %ebx
  100edf:	5e                   	pop    %esi
  100ee0:	5f                   	pop    %edi
  100ee1:	c3                   	ret    
  100ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  100ee8:	31 d2                	xor    %edx,%edx
  100eea:	85 db                	test   %ebx,%ebx
  100eec:	74 f0                	je     100ede <memmove+0x3e>
  100eee:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
  100ef0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  100ef4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100ef7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  100efa:	39 d3                	cmp    %edx,%ebx
  100efc:	75 f2                	jne    100ef0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
  100efe:	5b                   	pop    %ebx
  100eff:	5e                   	pop    %esi
  100f00:	5f                   	pop    %edi
  100f01:	c3                   	ret    
  100f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f10 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  100f10:	55                   	push   %ebp
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  100f11:	31 c0                	xor    %eax,%eax
  return dst;
}

int
strncmp(const char *p, const char *q, uint n)
{
  100f13:	57                   	push   %edi
  100f14:	56                   	push   %esi
  100f15:	53                   	push   %ebx
  100f16:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
  100f1a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  100f1e:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  while(n > 0 && *p && *p == *q)
  100f22:	85 ed                	test   %ebp,%ebp
  100f24:	74 32                	je     100f58 <strncmp+0x48>
  100f26:	0f b6 01             	movzbl (%ecx),%eax
  100f29:	0f b6 33             	movzbl (%ebx),%esi
  100f2c:	84 c0                	test   %al,%al
  100f2e:	74 30                	je     100f60 <strncmp+0x50>
  100f30:	89 f2                	mov    %esi,%edx
  100f32:	38 d0                	cmp    %dl,%al
  100f34:	74 1b                	je     100f51 <strncmp+0x41>
  100f36:	eb 28                	jmp    100f60 <strncmp+0x50>
    n--, p++, q++;
  100f38:	83 c1 01             	add    $0x1,%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  100f3b:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  100f3f:	0f b6 01             	movzbl (%ecx),%eax
    n--, p++, q++;
  100f42:	8d 7b 01             	lea    0x1(%ebx),%edi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  100f45:	84 c0                	test   %al,%al
  100f47:	74 17                	je     100f60 <strncmp+0x50>
  100f49:	89 f2                	mov    %esi,%edx
  100f4b:	38 d0                	cmp    %dl,%al
  100f4d:	75 11                	jne    100f60 <strncmp+0x50>
    n--, p++, q++;
  100f4f:	89 fb                	mov    %edi,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  100f51:	83 ed 01             	sub    $0x1,%ebp
  100f54:	75 e2                	jne    100f38 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
  100f56:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
  100f58:	5b                   	pop    %ebx
  100f59:	5e                   	pop    %esi
  100f5a:	5f                   	pop    %edi
  100f5b:	5d                   	pop    %ebp
  100f5c:	c3                   	ret    
  100f5d:	8d 76 00             	lea    0x0(%esi),%esi
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  100f60:	81 e6 ff 00 00 00    	and    $0xff,%esi
  100f66:	0f b6 c0             	movzbl %al,%eax
}
  100f69:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  100f6a:	29 f0                	sub    %esi,%eax
}
  100f6c:	5e                   	pop    %esi
  100f6d:	5f                   	pop    %edi
  100f6e:	5d                   	pop    %ebp
  100f6f:	c3                   	ret    

00100f70 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  100f70:	57                   	push   %edi
  100f71:	56                   	push   %esi
  100f72:	53                   	push   %ebx
  100f73:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100f77:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  100f7b:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  100f7f:	89 fa                	mov    %edi,%edx
  100f81:	eb 14                	jmp    100f97 <strncpy+0x27>
  100f83:	90                   	nop
  100f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100f88:	0f b6 03             	movzbl (%ebx),%eax
  100f8b:	83 c3 01             	add    $0x1,%ebx
  100f8e:	88 02                	mov    %al,(%edx)
  100f90:	83 c2 01             	add    $0x1,%edx
  100f93:	84 c0                	test   %al,%al
  100f95:	74 0a                	je     100fa1 <strncpy+0x31>
  100f97:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  100f9a:	8d 71 01             	lea    0x1(%ecx),%esi
{
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  100f9d:	85 f6                	test   %esi,%esi
  100f9f:	7f e7                	jg     100f88 <strncpy+0x18>
    ;
  while(n-- > 0)
  100fa1:	85 c9                	test   %ecx,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  100fa3:	8d 1c 0a             	lea    (%edx,%ecx,1),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  100fa6:	7e 0a                	jle    100fb2 <strncpy+0x42>
    *s++ = 0;
  100fa8:	c6 02 00             	movb   $0x0,(%edx)
  100fab:	83 c2 01             	add    $0x1,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  100fae:	39 da                	cmp    %ebx,%edx
  100fb0:	75 f6                	jne    100fa8 <strncpy+0x38>
    *s++ = 0;
  return os;
}
  100fb2:	89 f8                	mov    %edi,%eax
  100fb4:	5b                   	pop    %ebx
  100fb5:	5e                   	pop    %esi
  100fb6:	5f                   	pop    %edi
  100fb7:	c3                   	ret    
  100fb8:	90                   	nop
  100fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100fc0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  100fc0:	56                   	push   %esi
  100fc1:	53                   	push   %ebx
  100fc2:	8b 54 24 14          	mov    0x14(%esp),%edx
  100fc6:	8b 74 24 0c          	mov    0xc(%esp),%esi
  100fca:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  char *os;

  os = s;
  if(n <= 0)
  100fce:	85 d2                	test   %edx,%edx
  100fd0:	7e 1d                	jle    100fef <safestrcpy+0x2f>
  100fd2:	89 f1                	mov    %esi,%ecx
  100fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  100fd8:	83 ea 01             	sub    $0x1,%edx
  100fdb:	74 0f                	je     100fec <safestrcpy+0x2c>
  100fdd:	0f b6 03             	movzbl (%ebx),%eax
  100fe0:	83 c3 01             	add    $0x1,%ebx
  100fe3:	88 01                	mov    %al,(%ecx)
  100fe5:	83 c1 01             	add    $0x1,%ecx
  100fe8:	84 c0                	test   %al,%al
  100fea:	75 ec                	jne    100fd8 <safestrcpy+0x18>
    ;
  *s = 0;
  100fec:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
  100fef:	89 f0                	mov    %esi,%eax
  100ff1:	5b                   	pop    %ebx
  100ff2:	5e                   	pop    %esi
  100ff3:	c3                   	ret    
  100ff4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100ffa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101000 <strlen>:

int
strlen(const char *s)
{
  101000:	8b 54 24 04          	mov    0x4(%esp),%edx
  int n;

  for(n = 0; s[n]; n++)
  101004:	31 c0                	xor    %eax,%eax
  101006:	80 3a 00             	cmpb   $0x0,(%edx)
  101009:	74 0e                	je     101019 <strlen+0x19>
  10100b:	90                   	nop
  10100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101010:	83 c0 01             	add    $0x1,%eax
  101013:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  101017:	75 f7                	jne    101010 <strlen+0x10>
    ;
  return n;
}
  101019:	f3 c3                	repz ret 
  10101b:	90                   	nop
  10101c:	90                   	nop
  10101d:	90                   	nop
  10101e:	90                   	nop
  10101f:	90                   	nop

00101020 <pinit>:
extern void forkret(void);
extern void forkret1(struct trapframe*);

void
pinit(void)
{
  101020:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&proc_table_lock, "proc_table_lock");
  101023:	c7 44 24 04 2f 60 10 	movl   $0x10602f,0x4(%esp)
  10102a:	00 
  10102b:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  101032:	e8 49 f1 ff ff       	call   100180 <initlock>
}
  101037:	83 c4 1c             	add    $0x1c,%esp
  10103a:	c3                   	ret    
  10103b:	90                   	nop
  10103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101040 <setupsegs>:

// Set up CPU's segment descriptors and task state for a given process.
// If p==0, set up for "idle" state for when scheduler() is running.
void
setupsegs(struct proc *p)
{
  101040:	55                   	push   %ebp
  101041:	57                   	push   %edi
  101042:	56                   	push   %esi
  101043:	53                   	push   %ebx
  101044:	83 ec 2c             	sub    $0x2c,%esp
  101047:	8b 5c 24 40          	mov    0x40(%esp),%ebx
  struct cpu *c;

  pushcli();
  10104b:	e8 d0 f1 ff ff       	call   100220 <pushcli>
  c = &cpus[cpu()];
  101050:	e8 db fb ff ff       	call   100c30 <cpu>
  101055:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  10105b:	05 e0 d5 10 00       	add    $0x10d5e0,%eax
  c->ts.ss0 = SEGMENT_KERNEL_DATA << 3;
  if(p)
  101060:	85 db                	test   %ebx,%ebx
{
  struct cpu *c;

  pushcli();
  c = &cpus[cpu()];
  c->ts.ss0 = SEGMENT_KERNEL_DATA << 3;
  101062:	66 c7 40 30 10 00    	movw   $0x10,0x30(%eax)
  if(p)
  101068:	0f 84 aa 01 00 00    	je     101218 <setupsegs+0x1d8>
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  10106e:	8b 53 08             	mov    0x8(%ebx),%edx
  101071:	81 c2 00 10 00 00    	add    $0x1000,%edx
  101077:	89 50 2c             	mov    %edx,0x2c(%eax)
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  c->gdt[SEGMENT_KERNEL_CODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEGMENT_KERNEL_DATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEGMENT_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  10107a:	8d 50 28             	lea    0x28(%eax),%edx
  10107d:	89 d1                	mov    %edx,%ecx
  10107f:	c1 e9 10             	shr    $0x10,%ecx
  101082:	66 89 90 ba 00 00 00 	mov    %dx,0xba(%eax)
  101089:	c1 ea 18             	shr    $0x18,%edx
  c->gdt[SEGMENT_TSS].s = 0;
  if(p){
  10108c:	85 db                	test   %ebx,%ebx
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  10108e:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
  101095:	00 00 00 
  101098:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
  10109f:	00 00 00 
  c->gdt[SEGMENT_KERNEL_CODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1010a2:	66 c7 80 98 00 00 00 	movw   $0x10f,0x98(%eax)
  1010a9:	0f 01 
  1010ab:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
  1010b2:	00 00 
  1010b4:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
  1010bb:	c6 80 9d 00 00 00 9a 	movb   $0x9a,0x9d(%eax)
  1010c2:	c6 80 9e 00 00 00 c0 	movb   $0xc0,0x9e(%eax)
  1010c9:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
  c->gdt[SEGMENT_KERNEL_DATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1010d0:	66 c7 80 a0 00 00 00 	movw   $0xffff,0xa0(%eax)
  1010d7:	ff ff 
  1010d9:	66 c7 80 a2 00 00 00 	movw   $0x0,0xa2(%eax)
  1010e0:	00 00 
  1010e2:	c6 80 a4 00 00 00 00 	movb   $0x0,0xa4(%eax)
  1010e9:	c6 80 a5 00 00 00 92 	movb   $0x92,0xa5(%eax)
  1010f0:	c6 80 a6 00 00 00 cf 	movb   $0xcf,0xa6(%eax)
  1010f7:	c6 80 a7 00 00 00 00 	movb   $0x0,0xa7(%eax)
  c->gdt[SEGMENT_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  1010fe:	66 c7 80 b8 00 00 00 	movw   $0x67,0xb8(%eax)
  101105:	67 00 
  101107:	88 88 bc 00 00 00    	mov    %cl,0xbc(%eax)
  10110d:	c6 80 be 00 00 00 40 	movb   $0x40,0xbe(%eax)
  101114:	88 90 bf 00 00 00    	mov    %dl,0xbf(%eax)
  c->gdt[SEGMENT_TSS].s = 0;
  10111a:	c6 80 bd 00 00 00 89 	movb   $0x89,0xbd(%eax)
  if(p){
  101121:	0f 84 c1 00 00 00    	je     1011e8 <setupsegs+0x1a8>
    c->gdt[SEGMENT_USER_CODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  101127:	8b 13                	mov    (%ebx),%edx
  101129:	8b 6b 04             	mov    0x4(%ebx),%ebp
  10112c:	89 d6                	mov    %edx,%esi
  10112e:	89 d1                	mov    %edx,%ecx
  101130:	c1 ee 10             	shr    $0x10,%esi
  101133:	83 ed 01             	sub    $0x1,%ebp
  101136:	89 f3                	mov    %esi,%ebx
  101138:	89 ef                	mov    %ebp,%edi
  10113a:	88 98 ac 00 00 00    	mov    %bl,0xac(%eax)
  101140:	89 eb                	mov    %ebp,%ebx
  101142:	bd c0 ff ff ff       	mov    $0xffffffc0,%ebp
  101147:	c1 eb 1c             	shr    $0x1c,%ebx
  10114a:	c1 e9 18             	shr    $0x18,%ecx
  10114d:	09 dd                	or     %ebx,%ebp
  10114f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  101153:	89 e9                	mov    %ebp,%ecx
    c->gdt[SEGMENT_USER_DATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  101155:	89 eb                	mov    %ebp,%ebx
  c->gdt[SEGMENT_KERNEL_CODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEGMENT_KERNEL_DATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEGMENT_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEGMENT_TSS].s = 0;
  if(p){
    c->gdt[SEGMENT_USER_CODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  101157:	c6 80 ad 00 00 00 fa 	movb   $0xfa,0xad(%eax)
  10115e:	c1 ef 0c             	shr    $0xc,%edi
  101161:	88 88 ae 00 00 00    	mov    %cl,0xae(%eax)
  101167:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    c->gdt[SEGMENT_USER_DATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  10116c:	c6 80 b5 00 00 00 f2 	movb   $0xf2,0xb5(%eax)
  101173:	88 98 b6 00 00 00    	mov    %bl,0xb6(%eax)
  c->gdt[SEGMENT_KERNEL_CODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEGMENT_KERNEL_DATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEGMENT_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEGMENT_TSS].s = 0;
  if(p){
    c->gdt[SEGMENT_USER_CODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  101179:	66 89 90 aa 00 00 00 	mov    %dx,0xaa(%eax)
  101180:	88 88 af 00 00 00    	mov    %cl,0xaf(%eax)
    c->gdt[SEGMENT_USER_DATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  101186:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
  10118b:	66 89 90 b2 00 00 00 	mov    %dx,0xb2(%eax)
  101192:	89 f2                	mov    %esi,%edx
  c->gdt[SEGMENT_KERNEL_CODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEGMENT_KERNEL_DATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEGMENT_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEGMENT_TSS].s = 0;
  if(p){
    c->gdt[SEGMENT_USER_CODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  101194:	66 89 b8 a8 00 00 00 	mov    %di,0xa8(%eax)
    c->gdt[SEGMENT_USER_DATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  10119b:	66 89 b8 b0 00 00 00 	mov    %di,0xb0(%eax)
  1011a2:	88 90 b4 00 00 00    	mov    %dl,0xb4(%eax)
  1011a8:	88 88 b7 00 00 00    	mov    %cl,0xb7(%eax)
  } else {
    c->gdt[SEGMENT_USER_CODE] = SEG_NULL;
    c->gdt[SEGMENT_USER_DATA] = SEG_NULL;
  }

  lgdt(c->gdt, sizeof(c->gdt));
  1011ae:	05 90 00 00 00       	add    $0x90,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  1011b3:	66 c7 44 24 1a 2f 00 	movw   $0x2f,0x1a(%esp)
  pd[1] = (uint)p;
  1011ba:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  pd[2] = (uint)p >> 16;
  1011bf:	c1 e8 10             	shr    $0x10,%eax
  1011c2:	66 89 44 24 1e       	mov    %ax,0x1e(%esp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  1011c7:	8d 44 24 1a          	lea    0x1a(%esp),%eax
  1011cb:	0f 01 10             	lgdtl  (%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  1011ce:	b8 28 00 00 00       	mov    $0x28,%eax
  1011d3:	0f 00 d8             	ltr    %ax
  ltr(SEGMENT_TSS << 3);
  popcli();
  1011d6:	e8 05 f1 ff ff       	call   1002e0 <popcli>
}
  1011db:	83 c4 2c             	add    $0x2c,%esp
  1011de:	5b                   	pop    %ebx
  1011df:	5e                   	pop    %esi
  1011e0:	5f                   	pop    %edi
  1011e1:	5d                   	pop    %ebp
  1011e2:	c3                   	ret    
  1011e3:	90                   	nop
  1011e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c->gdt[SEGMENT_TSS].s = 0;
  if(p){
    c->gdt[SEGMENT_USER_CODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
    c->gdt[SEGMENT_USER_DATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  } else {
    c->gdt[SEGMENT_USER_CODE] = SEG_NULL;
  1011e8:	c7 80 a8 00 00 00 00 	movl   $0x0,0xa8(%eax)
  1011ef:	00 00 00 
  1011f2:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
  1011f9:	00 00 00 
    c->gdt[SEGMENT_USER_DATA] = SEG_NULL;
  1011fc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  101203:	00 00 00 
  101206:	c7 80 b4 00 00 00 00 	movl   $0x0,0xb4(%eax)
  10120d:	00 00 00 
  101210:	eb 9c                	jmp    1011ae <setupsegs+0x16e>
  101212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c = &cpus[cpu()];
  c->ts.ss0 = SEGMENT_KERNEL_DATA << 3;
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;
  101218:	c7 40 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%eax)
  10121f:	e9 56 fe ff ff       	jmp    10107a <setupsegs+0x3a>
  101224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10122a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101230 <copyproc>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  101230:	57                   	push   %edi
  101231:	56                   	push   %esi
  101232:	53                   	push   %ebx
  101233:	83 ec 10             	sub    $0x10,%esp
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  101236:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  10123d:	8b 7c 24 20          	mov    0x20(%esp),%edi
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  101241:	e8 2a f0 ff ff       	call   100270 <acquire>
  for(i = 0; i < NPROC; i++){
  101246:	31 c0                	xor    %eax,%eax
  101248:	eb 14                	jmp    10125e <copyproc+0x2e>
  10124a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101250:	83 c0 01             	add    $0x1,%eax
  101253:	3d 80 00 00 00       	cmp    $0x80,%eax
  101258:	0f 84 12 01 00 00    	je     101370 <copyproc+0x140>
    p = &proc[i];
  10125e:	69 f0 98 00 00 00    	imul   $0x98,%eax,%esi
  101264:	81 c6 40 89 10 00    	add    $0x108940,%esi
    if(p->state == UNUSED){
  10126a:	8b 56 0c             	mov    0xc(%esi),%edx
  10126d:	85 d2                	test   %edx,%edx
  10126f:	75 df                	jne    101250 <copyproc+0x20>
      p->state = EMBRYO;
      p->pid = nextpid++;
  101271:	a1 00 80 10 00       	mov    0x108000,%eax

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED){
      p->state = EMBRYO;
  101276:	c7 46 0c 01 00 00 00 	movl   $0x1,0xc(%esi)
      p->pid = nextpid++;
  10127d:	89 46 10             	mov    %eax,0x10(%esi)
  101280:	83 c0 01             	add    $0x1,%eax
      release(&proc_table_lock);
  101283:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED){
      p->state = EMBRYO;
      p->pid = nextpid++;
  10128a:	a3 00 80 10 00       	mov    %eax,0x108000
      release(&proc_table_lock);
  10128f:	e8 cc f0 ff ff       	call   100360 <release>
  // Allocate process.
  if((np = allocproc()) == 0)
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
  101294:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  10129b:	e8 a0 0b 00 00       	call   101e40 <kalloc>
  1012a0:	85 c0                	test   %eax,%eax
  1012a2:	89 46 08             	mov    %eax,0x8(%esi)
  1012a5:	0f 84 f6 00 00 00    	je     1013a1 <copyproc+0x171>
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  1012ab:	05 bc 0f 00 00       	add    $0xfbc,%eax

  if(p){  // Copy process state from p.
  1012b0:	85 ff                	test   %edi,%edi
  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  1012b2:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)

  if(p){  // Copy process state from p.
  1012b8:	74 78                	je     101332 <copyproc+0x102>
    np->parent = p;
  1012ba:	89 7e 14             	mov    %edi,0x14(%esi)
    memmove(np->tf, p->tf, sizeof(*np->tf));
  1012bd:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  1012c4:	00 
  1012c5:	8b 97 84 00 00 00    	mov    0x84(%edi),%edx
  1012cb:	89 04 24             	mov    %eax,(%esp)
  1012ce:	89 54 24 04          	mov    %edx,0x4(%esp)
  1012d2:	e8 c9 fb ff ff       	call   100ea0 <memmove>

    np->sz = p->sz;
  1012d7:	8b 47 04             	mov    0x4(%edi),%eax
  1012da:	89 46 04             	mov    %eax,0x4(%esi)
    if((np->mem = kalloc(np->sz)) == 0){
  1012dd:	89 04 24             	mov    %eax,(%esp)
  1012e0:	e8 5b 0b 00 00       	call   101e40 <kalloc>
  1012e5:	85 c0                	test   %eax,%eax
  1012e7:	89 06                	mov    %eax,(%esi)
  1012e9:	0f 84 98 00 00 00    	je     101387 <copyproc+0x157>
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);
  1012ef:	8b 56 04             	mov    0x4(%esi),%edx

    for(i = 0; i < NOFILE; i++)
  1012f2:	31 db                	xor    %ebx,%ebx
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);
  1012f4:	89 54 24 08          	mov    %edx,0x8(%esp)
  1012f8:	8b 17                	mov    (%edi),%edx
  1012fa:	89 04 24             	mov    %eax,(%esp)
  1012fd:	89 54 24 04          	mov    %edx,0x4(%esp)
  101301:	e8 9a fb ff ff       	call   100ea0 <memmove>
  101306:	66 90                	xchg   %ax,%ax

    for(i = 0; i < NOFILE; i++)
      if(p->ofile[i])
  101308:	8b 44 9f 20          	mov    0x20(%edi,%ebx,4),%eax
  10130c:	85 c0                	test   %eax,%eax
  10130e:	74 0c                	je     10131c <copyproc+0xec>
        np->ofile[i] = filedup(p->ofile[i]);
  101310:	89 04 24             	mov    %eax,(%esp)
  101313:	e8 08 0f 00 00       	call   102220 <filedup>
  101318:	89 44 9e 20          	mov    %eax,0x20(%esi,%ebx,4)
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);

    for(i = 0; i < NOFILE; i++)
  10131c:	83 c3 01             	add    $0x1,%ebx
  10131f:	83 fb 10             	cmp    $0x10,%ebx
  101322:	75 e4                	jne    101308 <copyproc+0xd8>
      if(p->ofile[i])
        np->ofile[i] = filedup(p->ofile[i]);
    np->cwd = idup(p->cwd);
  101324:	8b 47 60             	mov    0x60(%edi),%eax
  101327:	89 04 24             	mov    %eax,(%esp)
  10132a:	e8 b1 15 00 00       	call   1028e0 <idup>
  10132f:	89 46 60             	mov    %eax,0x60(%esi)
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  101332:	8d 46 64             	lea    0x64(%esi),%eax
  101335:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
  10133c:	00 
  10133d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101344:	00 
  101345:	89 04 24             	mov    %eax,(%esp)
  101348:	e8 c3 fa ff ff       	call   100e10 <memset>
  np->context.eip = (uint)forkret;
  np->context.esp = (uint)np->tf;
  10134d:	8b 86 84 00 00 00    	mov    0x84(%esi),%eax
    np->cwd = idup(p->cwd);
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  np->context.eip = (uint)forkret;
  101353:	c7 46 64 c0 14 10 00 	movl   $0x1014c0,0x64(%esi)
  np->context.esp = (uint)np->tf;
  10135a:	89 46 68             	mov    %eax,0x68(%esi)

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  10135d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  return np;
}
  101364:	83 c4 10             	add    $0x10,%esp
  101367:	89 f0                	mov    %esi,%eax
  101369:	5b                   	pop    %ebx
  10136a:	5e                   	pop    %esi
  10136b:	5f                   	pop    %edi
  10136c:	c3                   	ret    
  10136d:	8d 76 00             	lea    0x0(%esi),%esi
      p->pid = nextpid++;
      release(&proc_table_lock);
      return p;
    }
  }
  release(&proc_table_lock);
  101370:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  int i;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return 0;
  101377:	31 f6                	xor    %esi,%esi
      p->pid = nextpid++;
      release(&proc_table_lock);
      return p;
    }
  }
  release(&proc_table_lock);
  101379:	e8 e2 ef ff ff       	call   100360 <release>
  np->context.esp = (uint)np->tf;

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  return np;
}
  10137e:	83 c4 10             	add    $0x10,%esp
  101381:	89 f0                	mov    %esi,%eax
  101383:	5b                   	pop    %ebx
  101384:	5e                   	pop    %esi
  101385:	5f                   	pop    %edi
  101386:	c3                   	ret    
    np->parent = p;
    memmove(np->tf, p->tf, sizeof(*np->tf));

    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
  101387:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  10138e:	00 
  10138f:	8b 46 08             	mov    0x8(%esi),%eax
  101392:	89 04 24             	mov    %eax,(%esp)
  101395:	e8 46 09 00 00       	call   101ce0 <kfree>
      np->kstack = 0;
  10139a:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
      np->state = UNUSED;
  1013a1:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
      return 0;
  1013a8:	31 f6                	xor    %esi,%esi
  1013aa:	eb b8                	jmp    101364 <copyproc+0x134>
  1013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001013b0 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  1013b0:	53                   	push   %ebx
  1013b1:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];

  p = copyproc(0);
  1013b4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1013bb:	e8 70 fe ff ff       	call   101230 <copyproc>
  p->sz = PAGE;
  1013c0:	c7 40 04 00 10 00 00 	movl   $0x1000,0x4(%eax)
userinit(void)
{
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];

  p = copyproc(0);
  1013c7:	89 c3                	mov    %eax,%ebx
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  1013c9:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  1013d0:	e8 6b 0a 00 00       	call   101e40 <kalloc>
  1013d5:	89 03                	mov    %eax,(%ebx)
  p->cwd = namei("/");
  1013d7:	c7 04 24 fc 5f 10 00 	movl   $0x105ffc,(%esp)
  1013de:	e8 4d 1f 00 00       	call   103330 <namei>
  1013e3:	89 43 60             	mov    %eax,0x60(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  1013e6:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  1013ed:	00 
  1013ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1013f5:	00 
  1013f6:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  1013fc:	89 04 24             	mov    %eax,(%esp)
  1013ff:	e8 0c fa ff ff       	call   100e10 <memset>
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;

  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  101404:	8b 4b 04             	mov    0x4(%ebx),%ecx
  p = copyproc(0);
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEGMENT_USER_CODE << 3) | DPL_USER;
  101407:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;

  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  10140d:	8d 51 fc             	lea    -0x4(%ecx),%edx
  101410:	89 50 3c             	mov    %edx,0x3c(%eax)
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  101413:	8b 13                	mov    (%ebx),%edx
  p = copyproc(0);
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEGMENT_USER_CODE << 3) | DPL_USER;
  101415:	66 c7 40 34 1b 00    	movw   $0x1b,0x34(%eax)
  p->tf->ds = (SEGMENT_USER_DATA << 3) | DPL_USER;
  10141b:	66 c7 40 24 23 00    	movw   $0x23,0x24(%eax)
  p->tf->es = p->tf->ds;
  101421:	66 c7 40 20 23 00    	movw   $0x23,0x20(%eax)
  p->tf->ss = p->tf->ds;
  101427:	66 c7 40 40 23 00    	movw   $0x23,0x40(%eax)
  p->tf->eflags = FL_IF;
  10142d:	c7 40 38 00 02 00 00 	movl   $0x200,0x38(%eax)
  p->tf->esp = p->sz;

  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  101434:	c7 44 0a fc ef ef ef 	movl   $0xefefefef,-0x4(%edx,%ecx,1)
  10143b:	ef 

  // On entry to user space, start executing at beginning of initcode.S.
  p->tf->eip = 0;
  10143c:	c7 40 30 00 00 00 00 	movl   $0x0,0x30(%eax)
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  101443:	89 14 24             	mov    %edx,(%esp)
  101446:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  10144d:	00 
  10144e:	c7 44 24 04 20 87 10 	movl   $0x108720,0x4(%esp)
  101455:	00 
  101456:	e8 45 fa ff ff       	call   100ea0 <memmove>
  safestrcpy(p->name, "initcode", sizeof(p->name));
  10145b:	8d 83 88 00 00 00    	lea    0x88(%ebx),%eax
  101461:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  101468:	00 
  101469:	c7 44 24 04 fe 5f 10 	movl   $0x105ffe,0x4(%esp)
  101470:	00 
  101471:	89 04 24             	mov    %eax,(%esp)
  101474:	e8 47 fb ff ff       	call   100fc0 <safestrcpy>
  p->state = RUNNABLE;
  101479:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  initproc = p;
  101480:	89 1d 18 88 10 00    	mov    %ebx,0x108818
}
  101486:	83 c4 18             	add    $0x18,%esp
  101489:	5b                   	pop    %ebx
  10148a:	c3                   	ret    
  10148b:	90                   	nop
  10148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101490 <curproc>:

// Return currently running process.
struct proc*
curproc(void)
{
  101490:	53                   	push   %ebx
  101491:	83 ec 08             	sub    $0x8,%esp
  struct proc *p;

  pushcli();
  101494:	e8 87 ed ff ff       	call   100220 <pushcli>
  p = cpus[cpu()].curproc;
  101499:	e8 92 f7 ff ff       	call   100c30 <cpu>
  10149e:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  1014a4:	8b 98 e4 d5 10 00    	mov    0x10d5e4(%eax),%ebx
  popcli();
  1014aa:	e8 31 ee ff ff       	call   1002e0 <popcli>
  return p;
}
  1014af:	83 c4 08             	add    $0x8,%esp
  1014b2:	89 d8                	mov    %ebx,%eax
  1014b4:	5b                   	pop    %ebx
  1014b5:	c3                   	ret    
  1014b6:	8d 76 00             	lea    0x0(%esi),%esi
  1014b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001014c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  1014c0:	83 ec 1c             	sub    $0x1c,%esp
  // Still holding proc_table_lock from scheduler.
  release(&proc_table_lock);
  1014c3:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  1014ca:	e8 91 ee ff ff       	call   100360 <release>

  // Jump into assembly, never to return.
  forkret1(cp->tf);
  1014cf:	e8 bc ff ff ff       	call   101490 <curproc>
  1014d4:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  1014da:	89 04 24             	mov    %eax,(%esp)
  1014dd:	e8 76 3f 00 00       	call   105458 <forkret1>
}
  1014e2:	83 c4 1c             	add    $0x1c,%esp
  1014e5:	c3                   	ret    
  1014e6:	8d 76 00             	lea    0x0(%esi),%esi
  1014e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001014f0 <growproc>:

// Grow current process's memory by n bytes.
// Return old size on success, -1 on failure.
int
growproc(int n)
{
  1014f0:	57                   	push   %edi
  1014f1:	56                   	push   %esi
  1014f2:	53                   	push   %ebx
  1014f3:	83 ec 10             	sub    $0x10,%esp
  1014f6:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  char *newmem, *oldmem;

  newmem = kalloc(cp->sz + n);
  1014fa:	e8 91 ff ff ff       	call   101490 <curproc>
  1014ff:	8b 40 04             	mov    0x4(%eax),%eax
  101502:	01 d8                	add    %ebx,%eax
  101504:	89 04 24             	mov    %eax,(%esp)
  101507:	e8 34 09 00 00       	call   101e40 <kalloc>
  if(newmem == 0)
  10150c:	85 c0                	test   %eax,%eax
int
growproc(int n)
{
  char *newmem, *oldmem;

  newmem = kalloc(cp->sz + n);
  10150e:	89 c6                	mov    %eax,%esi
  if(newmem == 0)
  101510:	0f 84 8a 00 00 00    	je     1015a0 <growproc+0xb0>
    return -1;
  memmove(newmem, cp->mem, cp->sz);
  101516:	e8 75 ff ff ff       	call   101490 <curproc>
  10151b:	8b 78 04             	mov    0x4(%eax),%edi
  10151e:	e8 6d ff ff ff       	call   101490 <curproc>
  101523:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101527:	8b 00                	mov    (%eax),%eax
  101529:	89 34 24             	mov    %esi,(%esp)
  10152c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101530:	e8 6b f9 ff ff       	call   100ea0 <memmove>
  memset(newmem + cp->sz, 0, n);
  101535:	e8 56 ff ff ff       	call   101490 <curproc>
  10153a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  10153e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101545:	00 
  101546:	8b 40 04             	mov    0x4(%eax),%eax
  101549:	01 f0                	add    %esi,%eax
  10154b:	89 04 24             	mov    %eax,(%esp)
  10154e:	e8 bd f8 ff ff       	call   100e10 <memset>
  oldmem = cp->mem;
  101553:	e8 38 ff ff ff       	call   101490 <curproc>
  101558:	8b 38                	mov    (%eax),%edi
  cp->mem = newmem;
  10155a:	e8 31 ff ff ff       	call   101490 <curproc>
  10155f:	89 30                	mov    %esi,(%eax)
  kfree(oldmem, cp->sz);
  101561:	e8 2a ff ff ff       	call   101490 <curproc>
  101566:	8b 40 04             	mov    0x4(%eax),%eax
  101569:	89 3c 24             	mov    %edi,(%esp)
  10156c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101570:	e8 6b 07 00 00       	call   101ce0 <kfree>
  cp->sz += n;
  101575:	e8 16 ff ff ff       	call   101490 <curproc>
  10157a:	01 58 04             	add    %ebx,0x4(%eax)
  setupsegs(cp);
  10157d:	e8 0e ff ff ff       	call   101490 <curproc>
  101582:	89 04 24             	mov    %eax,(%esp)
  101585:	e8 b6 fa ff ff       	call   101040 <setupsegs>
  return cp->sz - n;
  10158a:	e8 01 ff ff ff       	call   101490 <curproc>
  10158f:	8b 40 04             	mov    0x4(%eax),%eax
  101592:	29 d8                	sub    %ebx,%eax
}
  101594:	83 c4 10             	add    $0x10,%esp
  101597:	5b                   	pop    %ebx
  101598:	5e                   	pop    %esi
  101599:	5f                   	pop    %edi
  10159a:	c3                   	ret    
  10159b:	90                   	nop
  10159c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *newmem, *oldmem;

  newmem = kalloc(cp->sz + n);
  if(newmem == 0)
    return -1;
  1015a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1015a5:	eb ed                	jmp    101594 <growproc+0xa4>
  1015a7:	89 f6                	mov    %esi,%esi
  1015a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001015b0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  1015b0:	55                   	push   %ebp
  1015b1:	57                   	push   %edi
  1015b2:	56                   	push   %esi
  1015b3:	53                   	push   %ebx
  1015b4:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c;
  int i;

  c = &cpus[cpu()];
  1015b7:	e8 74 f6 ff ff       	call   100c30 <cpu>
  1015bc:	69 f8 cc 00 00 00    	imul   $0xcc,%eax,%edi
  1015c2:	81 c7 e0 d5 10 00    	add    $0x10d5e0,%edi
  1015c8:	8d 6f 08             	lea    0x8(%edi),%ebp
  1015cb:	90                   	nop
  1015cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
  1015d0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  1015d1:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
    for(i = 0; i < NPROC; i++){
  1015d8:	31 db                	xor    %ebx,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  1015da:	e8 91 ec ff ff       	call   100270 <acquire>
  1015df:	eb 12                	jmp    1015f3 <scheduler+0x43>
  1015e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < NPROC; i++){
  1015e8:	83 c3 01             	add    $0x1,%ebx
  1015eb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  1015f1:	74 55                	je     101648 <scheduler+0x98>
      p = &proc[i];
  1015f3:	69 f3 98 00 00 00    	imul   $0x98,%ebx,%esi
  1015f9:	81 c6 40 89 10 00    	add    $0x108940,%esi
      if(p->state != RUNNABLE)
  1015ff:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
  101603:	75 e3                	jne    1015e8 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
  101605:	89 77 04             	mov    %esi,0x4(%edi)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  101608:	83 c3 01             	add    $0x1,%ebx

      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
  10160b:	89 34 24             	mov    %esi,(%esp)
  10160e:	e8 2d fa ff ff       	call   101040 <setupsegs>
      p->state = RUNNING;
  101613:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      swtch(&c->context, &p->context);
  10161a:	83 c6 64             	add    $0x64,%esi
  10161d:	89 74 24 04          	mov    %esi,0x4(%esp)
  101621:	89 2c 24             	mov    %ebp,(%esp)
  101624:	e8 27 26 00 00       	call   103c50 <swtch>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
  101629:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%edi)
      setupsegs(0);
  101630:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  101637:	e8 04 fa ff ff       	call   101040 <setupsegs>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  10163c:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  101642:	75 af                	jne    1015f3 <scheduler+0x43>
  101644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
      setupsegs(0);
    }
    release(&proc_table_lock);
  101648:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  10164f:	e8 0c ed ff ff       	call   100360 <release>

  }
  101654:	e9 77 ff ff ff       	jmp    1015d0 <scheduler+0x20>
  101659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101660 <sched>:

// Enter scheduler.  Must already hold proc_table_lock
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  101660:	53                   	push   %ebx
  101661:	83 ec 18             	sub    $0x18,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  101664:	9c                   	pushf  
  101665:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  101666:	f6 c4 02             	test   $0x2,%ah
  101669:	75 5b                	jne    1016c6 <sched+0x66>
    panic("sched interruptible");
  if(cp->state == RUNNING)
  10166b:	e8 20 fe ff ff       	call   101490 <curproc>
  101670:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  101674:	74 74                	je     1016ea <sched+0x8a>
    panic("sched running");
  if(!holding(&proc_table_lock))
  101676:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  10167d:	e8 6e eb ff ff       	call   1001f0 <holding>
  101682:	85 c0                	test   %eax,%eax
  101684:	74 58                	je     1016de <sched+0x7e>
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
  101686:	e8 a5 f5 ff ff       	call   100c30 <cpu>
  10168b:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  101691:	83 b8 a4 d6 10 00 01 	cmpl   $0x1,0x10d6a4(%eax)
  101698:	75 38                	jne    1016d2 <sched+0x72>
    panic("sched locks");

  swtch(&cp->context, &cpus[cpu()].context);
  10169a:	e8 91 f5 ff ff       	call   100c30 <cpu>
  10169f:	89 c3                	mov    %eax,%ebx
  1016a1:	e8 ea fd ff ff       	call   101490 <curproc>
  1016a6:	69 db cc 00 00 00    	imul   $0xcc,%ebx,%ebx
  1016ac:	81 c3 e8 d5 10 00    	add    $0x10d5e8,%ebx
  1016b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1016b6:	83 c0 64             	add    $0x64,%eax
  1016b9:	89 04 24             	mov    %eax,(%esp)
  1016bc:	e8 8f 25 00 00       	call   103c50 <swtch>
}
  1016c1:	83 c4 18             	add    $0x18,%esp
  1016c4:	5b                   	pop    %ebx
  1016c5:	c3                   	ret    
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  1016c6:	c7 04 24 07 60 10 00 	movl   $0x106007,(%esp)
  1016cd:	e8 de f3 ff ff       	call   100ab0 <panic>
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
    panic("sched locks");
  1016d2:	c7 04 24 3f 60 10 00 	movl   $0x10603f,(%esp)
  1016d9:	e8 d2 f3 ff ff       	call   100ab0 <panic>
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  1016de:	c7 04 24 29 60 10 00 	movl   $0x106029,(%esp)
  1016e5:	e8 c6 f3 ff ff       	call   100ab0 <panic>
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  1016ea:	c7 04 24 1b 60 10 00 	movl   $0x10601b,(%esp)
  1016f1:	e8 ba f3 ff ff       	call   100ab0 <panic>
  1016f6:	8d 76 00             	lea    0x0(%esi),%esi
  1016f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101700 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  101700:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&proc_table_lock);
  101703:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  10170a:	e8 61 eb ff ff       	call   100270 <acquire>
  cp->state = RUNNABLE;
  10170f:	e8 7c fd ff ff       	call   101490 <curproc>
  101714:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  10171b:	e8 40 ff ff ff       	call   101660 <sched>
  release(&proc_table_lock);
  101720:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  101727:	e8 34 ec ff ff       	call   100360 <release>
}
  10172c:	83 c4 1c             	add    $0x1c,%esp
  10172f:	c3                   	ret    

00101730 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  101730:	56                   	push   %esi
  101731:	53                   	push   %ebx
  101732:	83 ec 14             	sub    $0x14,%esp
  101735:	8b 74 24 20          	mov    0x20(%esp),%esi
  101739:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  if(cp == 0)
  10173d:	e8 4e fd ff ff       	call   101490 <curproc>
  101742:	85 c0                	test   %eax,%eax
  101744:	0f 84 9d 00 00 00    	je     1017e7 <sleep+0xb7>
    panic("sleep");

  if(lk == 0)
  10174a:	85 db                	test   %ebx,%ebx
  10174c:	0f 84 89 00 00 00    	je     1017db <sleep+0xab>
  // change p->state and then call sched.
  // Once we hold proc_table_lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with proc_table_lock locked),
  // so it's okay to release lk.
  if(lk != &proc_table_lock){
  101752:	81 fb 40 d5 10 00    	cmp    $0x10d540,%ebx
  101758:	74 56                	je     1017b0 <sleep+0x80>
    acquire(&proc_table_lock);
  10175a:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  101761:	e8 0a eb ff ff       	call   100270 <acquire>
    release(lk);
  101766:	89 1c 24             	mov    %ebx,(%esp)
  101769:	e8 f2 eb ff ff       	call   100360 <release>
  }

  // Go to sleep.
  cp->chan = chan;
  10176e:	e8 1d fd ff ff       	call   101490 <curproc>
  101773:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  101776:	e8 15 fd ff ff       	call   101490 <curproc>
  10177b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  101782:	e8 d9 fe ff ff       	call   101660 <sched>

  // Tidy up.
  cp->chan = 0;
  101787:	e8 04 fd ff ff       	call   101490 <curproc>
  10178c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
  101793:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  10179a:	e8 c1 eb ff ff       	call   100360 <release>
    acquire(lk);
  10179f:	89 5c 24 20          	mov    %ebx,0x20(%esp)
  }
}
  1017a3:	83 c4 14             	add    $0x14,%esp
  1017a6:	5b                   	pop    %ebx
  1017a7:	5e                   	pop    %esi
  cp->chan = 0;

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  1017a8:	e9 c3 ea ff ff       	jmp    100270 <acquire>
  1017ad:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&proc_table_lock);
    release(lk);
  }

  // Go to sleep.
  cp->chan = chan;
  1017b0:	e8 db fc ff ff       	call   101490 <curproc>
  1017b5:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  1017b8:	e8 d3 fc ff ff       	call   101490 <curproc>
  1017bd:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  1017c4:	e8 97 fe ff ff       	call   101660 <sched>

  // Tidy up.
  cp->chan = 0;
  1017c9:	e8 c2 fc ff ff       	call   101490 <curproc>
  1017ce:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  }
}
  1017d5:	83 c4 14             	add    $0x14,%esp
  1017d8:	5b                   	pop    %ebx
  1017d9:	5e                   	pop    %esi
  1017da:	c3                   	ret    
{
  if(cp == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
  1017db:	c7 04 24 51 60 10 00 	movl   $0x106051,(%esp)
  1017e2:	e8 c9 f2 ff ff       	call   100ab0 <panic>
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(cp == 0)
    panic("sleep");
  1017e7:	c7 04 24 4b 60 10 00 	movl   $0x10604b,(%esp)
  1017ee:	e8 bd f2 ff ff       	call   100ab0 <panic>
  1017f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1017f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101800 <wakeup>:

// Wake up all processes sleeping on chan.
// Proc_table_lock is acquired and released.
void
wakeup(void *chan)
{
  101800:	53                   	push   %ebx
  101801:	83 ec 18             	sub    $0x18,%esp
  acquire(&proc_table_lock);
  101804:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)

// Wake up all processes sleeping on chan.
// Proc_table_lock is acquired and released.
void
wakeup(void *chan)
{
  10180b:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  acquire(&proc_table_lock);
  10180f:	e8 5c ea ff ff       	call   100270 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  101814:	b8 40 89 10 00       	mov    $0x108940,%eax
  101819:	eb 11                	jmp    10182c <wakeup+0x2c>
  10181b:	90                   	nop
  10181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101820:	05 98 00 00 00       	add    $0x98,%eax
  101825:	3d 40 d5 10 00       	cmp    $0x10d540,%eax
  10182a:	73 1e                	jae    10184a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
  10182c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  101830:	75 ee                	jne    101820 <wakeup+0x20>
  101832:	3b 58 18             	cmp    0x18(%eax),%ebx
  101835:	75 e9                	jne    101820 <wakeup+0x20>
      p->state = RUNNABLE;
  101837:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  10183e:	05 98 00 00 00       	add    $0x98,%eax
  101843:	3d 40 d5 10 00       	cmp    $0x10d540,%eax
  101848:	72 e2                	jb     10182c <wakeup+0x2c>
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  10184a:	c7 44 24 20 40 d5 10 	movl   $0x10d540,0x20(%esp)
  101851:	00 
}
  101852:	83 c4 18             	add    $0x18,%esp
  101855:	5b                   	pop    %ebx
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  101856:	e9 05 eb ff ff       	jmp    100360 <release>
  10185b:	90                   	nop
  10185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101860 <kill>:
// Kill the process with the given pid.
// Process won't actually exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  101860:	53                   	push   %ebx
  101861:	83 ec 18             	sub    $0x18,%esp
  101864:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct proc *p;

  acquire(&proc_table_lock);
  101868:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  10186f:	e8 fc e9 ff ff       	call   100270 <acquire>
  for(p = proc; p < &proc[NPROC]; p++){
  101874:	b8 40 89 10 00       	mov    $0x108940,%eax
    if(p->pid == pid){
  101879:	39 1d 50 89 10 00    	cmp    %ebx,0x108950
  10187f:	74 18                	je     101899 <kill+0x39>
  101881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
kill(int pid)
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
  101888:	05 98 00 00 00       	add    $0x98,%eax
  10188d:	3d 40 d5 10 00       	cmp    $0x10d540,%eax
  101892:	73 2c                	jae    1018c0 <kill+0x60>
    if(p->pid == pid){
  101894:	39 58 10             	cmp    %ebx,0x10(%eax)
  101897:	75 ef                	jne    101888 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  101899:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  10189d:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1018a4:	75 07                	jne    1018ad <kill+0x4d>
        p->state = RUNNABLE;
  1018a6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&proc_table_lock);
  1018ad:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  1018b4:	e8 a7 ea ff ff       	call   100360 <release>
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
}
  1018b9:	83 c4 18             	add    $0x18,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&proc_table_lock);
      return 0;
  1018bc:	31 c0                	xor    %eax,%eax
    }
  }
  release(&proc_table_lock);
  return -1;
}
  1018be:	5b                   	pop    %ebx
  1018bf:	c3                   	ret    
        p->state = RUNNABLE;
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  1018c0:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  1018c7:	e8 94 ea ff ff       	call   100360 <release>
  return -1;
}
  1018cc:	83 c4 18             	add    $0x18,%esp
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
  1018cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1018d4:	5b                   	pop    %ebx
  1018d5:	c3                   	ret    
  1018d6:	8d 76 00             	lea    0x0(%esi),%esi
  1018d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001018e0 <exit>:
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  1018e0:	56                   	push   %esi
  1018e1:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(cp == initproc)
  1018e2:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  1018e4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  int fd;

  if(cp == initproc)
  1018e7:	e8 a4 fb ff ff       	call   101490 <curproc>
  1018ec:	3b 05 18 88 10 00    	cmp    0x108818,%eax
  1018f2:	0f 84 21 01 00 00    	je     101a19 <exit+0x139>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd]){
  1018f8:	e8 93 fb ff ff       	call   101490 <curproc>
  1018fd:	8d 73 08             	lea    0x8(%ebx),%esi
  101900:	8b 0c b0             	mov    (%eax,%esi,4),%ecx
  101903:	85 c9                	test   %ecx,%ecx
  101905:	74 1c                	je     101923 <exit+0x43>
      fileclose(cp->ofile[fd]);
  101907:	e8 84 fb ff ff       	call   101490 <curproc>
  10190c:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  10190f:	89 04 24             	mov    %eax,(%esp)
  101912:	e8 59 09 00 00       	call   102270 <fileclose>
      cp->ofile[fd] = 0;
  101917:	e8 74 fb ff ff       	call   101490 <curproc>
  10191c:	c7 04 b0 00 00 00 00 	movl   $0x0,(%eax,%esi,4)

  if(cp == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  101923:	83 c3 01             	add    $0x1,%ebx
  101926:	83 fb 10             	cmp    $0x10,%ebx
  101929:	75 cd                	jne    1018f8 <exit+0x18>
      fileclose(cp->ofile[fd]);
      cp->ofile[fd] = 0;
    }
  }

  iput(cp->cwd);
  10192b:	e8 60 fb ff ff       	call   101490 <curproc>
  101930:	8b 40 60             	mov    0x60(%eax),%eax
  101933:	89 04 24             	mov    %eax,(%esp)
  101936:	e8 85 12 00 00       	call   102bc0 <iput>
  cp->cwd = 0;
  10193b:	e8 50 fb ff ff       	call   101490 <curproc>
  101940:	c7 40 60 00 00 00 00 	movl   $0x0,0x60(%eax)

  acquire(&proc_table_lock);
  101947:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  10194e:	e8 1d e9 ff ff       	call   100270 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);
  101953:	e8 38 fb ff ff       	call   101490 <curproc>
  101958:	8b 50 14             	mov    0x14(%eax),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  10195b:	b8 40 89 10 00       	mov    $0x108940,%eax
  101960:	eb 12                	jmp    101974 <exit+0x94>
  101962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101968:	05 98 00 00 00       	add    $0x98,%eax
  10196d:	3d 40 d5 10 00       	cmp    $0x10d540,%eax
  101972:	73 1e                	jae    101992 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
  101974:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  101978:	75 ee                	jne    101968 <exit+0x88>
  10197a:	3b 50 18             	cmp    0x18(%eax),%edx
  10197d:	75 e9                	jne    101968 <exit+0x88>
      p->state = RUNNABLE;
  10197f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  101986:	05 98 00 00 00       	add    $0x98,%eax
  10198b:	3d 40 d5 10 00       	cmp    $0x10d540,%eax
  101990:	72 e2                	jb     101974 <exit+0x94>
  101992:	bb 40 89 10 00       	mov    $0x108940,%ebx
  101997:	eb 15                	jmp    1019ae <exit+0xce>
  101999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
  1019a0:	81 c3 98 00 00 00    	add    $0x98,%ebx
  1019a6:	81 fb 40 d5 10 00    	cmp    $0x10d540,%ebx
  1019ac:	73 42                	jae    1019f0 <exit+0x110>
    if(p->parent == cp){
  1019ae:	8b 73 14             	mov    0x14(%ebx),%esi
  1019b1:	e8 da fa ff ff       	call   101490 <curproc>
  1019b6:	39 c6                	cmp    %eax,%esi
  1019b8:	75 e6                	jne    1019a0 <exit+0xc0>
      p->parent = initproc;
  1019ba:	8b 15 18 88 10 00    	mov    0x108818,%edx
      if(p->state == ZOMBIE)
  1019c0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->parent == cp){
      p->parent = initproc;
  1019c4:	89 53 14             	mov    %edx,0x14(%ebx)
      if(p->state == ZOMBIE)
  1019c7:	75 d7                	jne    1019a0 <exit+0xc0>
  1019c9:	b8 40 89 10 00       	mov    $0x108940,%eax
  1019ce:	eb 0c                	jmp    1019dc <exit+0xfc>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  1019d0:	05 98 00 00 00       	add    $0x98,%eax
  1019d5:	3d 40 d5 10 00       	cmp    $0x10d540,%eax
  1019da:	73 c4                	jae    1019a0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
  1019dc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  1019e0:	75 ee                	jne    1019d0 <exit+0xf0>
  1019e2:	3b 50 18             	cmp    0x18(%eax),%edx
  1019e5:	75 e9                	jne    1019d0 <exit+0xf0>
      p->state = RUNNABLE;
  1019e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  1019ee:	eb e0                	jmp    1019d0 <exit+0xf0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  cp->killed = 0;
  1019f0:	e8 9b fa ff ff       	call   101490 <curproc>
  1019f5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  cp->state = ZOMBIE;
  1019fc:	e8 8f fa ff ff       	call   101490 <curproc>
  101a01:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
  101a08:	e8 53 fc ff ff       	call   101660 <sched>
  panic("zombie exit");
  101a0d:	c7 04 24 6f 60 10 00 	movl   $0x10606f,(%esp)
  101a14:	e8 97 f0 ff ff       	call   100ab0 <panic>
{
  struct proc *p;
  int fd;

  if(cp == initproc)
    panic("init exiting");
  101a19:	c7 04 24 62 60 10 00 	movl   $0x106062,(%esp)
  101a20:	e8 8b f0 ff ff       	call   100ab0 <panic>
  101a25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101a30 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  101a30:	55                   	push   %ebp
  101a31:	57                   	push   %edi
  int i, havekids, pid;

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
  101a32:	31 ff                	xor    %edi,%edi

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  101a34:	56                   	push   %esi
  101a35:	53                   	push   %ebx

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  101a36:	31 db                	xor    %ebx,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  101a38:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  101a3b:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  101a42:	e8 29 e8 ff ff       	call   100270 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  101a47:	83 fb 7f             	cmp    $0x7f,%ebx
  101a4a:	7e 2d                	jle    101a79 <wait+0x49>
  101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        havekids = 1;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
  101a50:	85 ff                	test   %edi,%edi
  101a52:	74 64                	je     101ab8 <wait+0x88>
  101a54:	e8 37 fa ff ff       	call   101490 <curproc>
  101a59:	8b 58 1c             	mov    0x1c(%eax),%ebx
  101a5c:	85 db                	test   %ebx,%ebx
  101a5e:	75 58                	jne    101ab8 <wait+0x88>
      release(&proc_table_lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  101a60:	e8 2b fa ff ff       	call   101490 <curproc>
  int i, havekids, pid;

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
  101a65:	31 ff                	xor    %edi,%edi
    for(i = 0; i < NPROC; i++){
  101a67:	31 db                	xor    %ebx,%ebx
      release(&proc_table_lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  101a69:	c7 44 24 04 40 d5 10 	movl   $0x10d540,0x4(%esp)
  101a70:	00 
  101a71:	89 04 24             	mov    %eax,(%esp)
  101a74:	e8 b7 fc ff ff       	call   101730 <sleep>
  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
      p = &proc[i];
  101a79:	69 f3 98 00 00 00    	imul   $0x98,%ebx,%esi
  101a7f:	81 c6 40 89 10 00    	add    $0x108940,%esi
      if(p->state == UNUSED)
  101a85:	8b 6e 0c             	mov    0xc(%esi),%ebp
  101a88:	85 ed                	test   %ebp,%ebp
  101a8a:	75 0c                	jne    101a98 <wait+0x68>

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  101a8c:	83 c3 01             	add    $0x1,%ebx
  101a8f:	83 fb 7f             	cmp    $0x7f,%ebx
  101a92:	7e e5                	jle    101a79 <wait+0x49>
  101a94:	eb ba                	jmp    101a50 <wait+0x20>
  101a96:	66 90                	xchg   %ax,%ax
      p = &proc[i];
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
  101a98:	8b 6e 14             	mov    0x14(%esi),%ebp
  101a9b:	e8 f0 f9 ff ff       	call   101490 <curproc>
  101aa0:	39 c5                	cmp    %eax,%ebp
  101aa2:	75 e8                	jne    101a8c <wait+0x5c>
        if(p->state == ZOMBIE){
  101aa4:	83 7e 0c 05          	cmpl   $0x5,0xc(%esi)
  101aa8:	74 27                	je     101ad1 <wait+0xa1>
          p->parent = 0;
          p->name[0] = 0;
          release(&proc_table_lock);
          return pid;
        }
        havekids = 1;
  101aaa:	bf 01 00 00 00       	mov    $0x1,%edi
  101aaf:	eb db                	jmp    101a8c <wait+0x5c>
  101ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
      release(&proc_table_lock);
  101ab8:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  101abf:	e8 9c e8 ff ff       	call   100360 <release>
      return -1;
  101ac4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  }
}
  101ac9:	83 c4 2c             	add    $0x2c,%esp
  101acc:	5b                   	pop    %ebx
  101acd:	5e                   	pop    %esi
  101ace:	5f                   	pop    %edi
  101acf:	5d                   	pop    %ebp
  101ad0:	c3                   	ret    
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
  101ad1:	8b 46 04             	mov    0x4(%esi),%eax
  101ad4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ad8:	8b 06                	mov    (%esi),%eax
  101ada:	89 04 24             	mov    %eax,(%esp)
  101add:	e8 fe 01 00 00       	call   101ce0 <kfree>
          kfree(p->kstack, KSTACKSIZE);
  101ae2:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  101ae9:	00 
  101aea:	8b 46 08             	mov    0x8(%esi),%eax
  101aed:	89 04 24             	mov    %eax,(%esp)
  101af0:	e8 eb 01 00 00       	call   101ce0 <kfree>
          pid = p->pid;
  101af5:	8b 46 10             	mov    0x10(%esi),%eax
          p->state = UNUSED;
  101af8:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
          p->pid = 0;
  101aff:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
          p->parent = 0;
  101b06:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
          p->name[0] = 0;
  101b0d:	c6 86 88 00 00 00 00 	movb   $0x0,0x88(%esi)
          release(&proc_table_lock);
  101b14:	c7 04 24 40 d5 10 00 	movl   $0x10d540,(%esp)
  101b1b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  101b1f:	e8 3c e8 ff ff       	call   100360 <release>
          return pid;
  101b24:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  101b28:	eb 9f                	jmp    101ac9 <wait+0x99>
  101b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101b30 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  101b30:	55                   	push   %ebp
  101b31:	57                   	push   %edi
  101b32:	56                   	push   %esi
  101b33:	53                   	push   %ebx
  int i, j;
  struct proc *p;
  char *state;
  uint pc[10];

  for(i = 0; i < NPROC; i++){
  101b34:	31 db                	xor    %ebx,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  101b36:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
  101b39:	8d 6c 24 18          	lea    0x18(%esp),%ebp

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
  101b3d:	8d 7c 24 40          	lea    0x40(%esp),%edi
  101b41:	eb 20                	jmp    101b63 <procdump+0x33>
  101b43:	90                   	nop
  101b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  101b48:	c7 04 24 9c 66 10 00 	movl   $0x10669c,(%esp)
  101b4f:	e8 cc eb ff ff       	call   100720 <cprintf>
  int i, j;
  struct proc *p;
  char *state;
  uint pc[10];

  for(i = 0; i < NPROC; i++){
  101b54:	83 c3 01             	add    $0x1,%ebx
  101b57:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  101b5d:	0f 84 95 00 00 00    	je     101bf8 <procdump+0xc8>
    p = &proc[i];
  101b63:	69 f3 98 00 00 00    	imul   $0x98,%ebx,%esi
  101b69:	81 c6 40 89 10 00    	add    $0x108940,%esi
    if(p->state == UNUSED)
  101b6f:	8b 46 0c             	mov    0xc(%esi),%eax
  101b72:	85 c0                	test   %eax,%eax
  101b74:	74 de                	je     101b54 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  101b76:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
  101b79:	ba 7b 60 10 00       	mov    $0x10607b,%edx

  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  101b7e:	77 11                	ja     101b91 <procdump+0x61>
  101b80:	8b 14 85 b4 60 10 00 	mov    0x1060b4(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
  101b87:	b8 7b 60 10 00       	mov    $0x10607b,%eax
  101b8c:	85 d2                	test   %edx,%edx
  101b8e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
  101b91:	8d 86 88 00 00 00    	lea    0x88(%esi),%eax
  101b97:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101b9b:	89 54 24 08          	mov    %edx,0x8(%esp)
  101b9f:	8b 46 10             	mov    0x10(%esi),%eax
  101ba2:	c7 04 24 7f 60 10 00 	movl   $0x10607f,(%esp)
  101ba9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bad:	e8 6e eb ff ff       	call   100720 <cprintf>
    if(p->state == SLEEPING){
  101bb2:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
  101bb6:	75 90                	jne    101b48 <procdump+0x18>
      getcallerpcs((uint*)p->context.ebp+2, pc);
  101bb8:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  101bbc:	8b 86 80 00 00 00    	mov    0x80(%esi),%eax
  101bc2:	89 ee                	mov    %ebp,%esi
  101bc4:	83 c0 08             	add    $0x8,%eax
  101bc7:	89 04 24             	mov    %eax,(%esp)
  101bca:	e8 d1 e5 ff ff       	call   1001a0 <getcallerpcs>
  101bcf:	90                   	nop
      for(j=0; j<10 && pc[j] != 0; j++)
  101bd0:	8b 06                	mov    (%esi),%eax
  101bd2:	85 c0                	test   %eax,%eax
  101bd4:	0f 84 6e ff ff ff    	je     101b48 <procdump+0x18>
        cprintf(" %p", pc[j]);
  101bda:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bde:	83 c6 04             	add    $0x4,%esi
  101be1:	c7 04 24 ba 5f 10 00 	movl   $0x105fba,(%esp)
  101be8:	e8 33 eb ff ff       	call   100720 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
  101bed:	39 fe                	cmp    %edi,%esi
  101bef:	75 df                	jne    101bd0 <procdump+0xa0>
  101bf1:	e9 52 ff ff ff       	jmp    101b48 <procdump+0x18>
  101bf6:	66 90                	xchg   %ax,%ax
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  }
}
  101bf8:	83 c4 4c             	add    $0x4c,%esp
  101bfb:	5b                   	pop    %ebx
  101bfc:	5e                   	pop    %esi
  101bfd:	5f                   	pop    %edi
  101bfe:	5d                   	pop    %ebp
  101bff:	90                   	nop
  101c00:	c3                   	ret    
  101c01:	90                   	nop
  101c02:	90                   	nop
  101c03:	90                   	nop
  101c04:	90                   	nop
  101c05:	90                   	nop
  101c06:	90                   	nop
  101c07:	90                   	nop
  101c08:	90                   	nop
  101c09:	90                   	nop
  101c0a:	90                   	nop
  101c0b:	90                   	nop
  101c0c:	90                   	nop
  101c0d:	90                   	nop
  101c0e:	90                   	nop
  101c0f:	90                   	nop

00101c10 <ioapic_init>:
  ioapic->data = data;
}

void
ioapic_init(void)
{
  101c10:	56                   	push   %esi
  101c11:	53                   	push   %ebx
  101c12:	83 ec 14             	sub    $0x14,%esp
  int i, id, maxintr;

  if(!ismp)
  101c15:	a1 c0 d5 10 00       	mov    0x10d5c0,%eax
  101c1a:	85 c0                	test   %eax,%eax
  101c1c:	0f 84 82 00 00 00    	je     101ca4 <ioapic_init+0x94>
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  101c22:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  101c29:	00 00 00 
  return ioapic->data;
  101c2c:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  101c32:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  101c37:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  101c3e:	00 00 00 
  return ioapic->data;
  101c41:	8b 15 10 00 c0 fe    	mov    0xfec00010,%edx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  101c47:	0f b6 0d c4 d5 10 00 	movzbl 0x10d5c4,%ecx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  101c4e:	c7 05 74 d5 10 00 00 	movl   $0xfec00000,0x10d574
  101c55:	00 c0 fe 
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  101c58:	c1 ee 10             	shr    $0x10,%esi
  id = ioapic_read(REG_ID) >> 24;
  101c5b:	c1 ea 18             	shr    $0x18,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  101c5e:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  101c64:	39 d1                	cmp    %edx,%ecx
  101c66:	74 11                	je     101c79 <ioapic_init+0x69>
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");
  101c68:	c7 04 24 cc 60 10 00 	movl   $0x1060cc,(%esp)
  101c6f:	e8 ac ea ff ff       	call   100720 <cprintf>
  101c74:	a1 74 d5 10 00       	mov    0x10d574,%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  101c79:	b9 10 00 00 00       	mov    $0x10,%ecx
  101c7e:	31 d2                	xor    %edx,%edx
  ioapic->reg = reg;
  ioapic->data = data;
}

void
ioapic_init(void)
  101c80:	8d 5a 20             	lea    0x20(%edx),%ebx
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  101c83:	83 c2 01             	add    $0x1,%edx
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  101c86:	81 cb 00 00 01 00    	or     $0x10000,%ebx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  101c8c:	89 08                	mov    %ecx,(%eax)
  ioapic->data = data;
  101c8e:	89 58 10             	mov    %ebx,0x10(%eax)
}

void
ioapic_init(void)
  101c91:	8d 59 01             	lea    0x1(%ecx),%ebx
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  101c94:	83 c1 02             	add    $0x2,%ecx
  101c97:	39 d6                	cmp    %edx,%esi
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  101c99:	89 18                	mov    %ebx,(%eax)
  ioapic->data = data;
  101c9b:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  101ca2:	7d dc                	jge    101c80 <ioapic_init+0x70>
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
    ioapic_write(REG_TABLE+2*i+1, 0);
  }
}
  101ca4:	83 c4 14             	add    $0x14,%esp
  101ca7:	5b                   	pop    %ebx
  101ca8:	5e                   	pop    %esi
  101ca9:	c3                   	ret    
  101caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101cb0 <ioapic_enable>:

void
ioapic_enable(int irq, int cpunum)
{
  if(!ismp)
  101cb0:	8b 15 c0 d5 10 00    	mov    0x10d5c0,%edx
  }
}

void
ioapic_enable(int irq, int cpunum)
{
  101cb6:	8b 44 24 04          	mov    0x4(%esp),%eax
  if(!ismp)
  101cba:	85 d2                	test   %edx,%edx
  101cbc:	74 20                	je     101cde <ioapic_enable+0x2e>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  101cbe:	8d 48 20             	lea    0x20(%eax),%ecx
  101cc1:	8d 54 00 10          	lea    0x10(%eax,%eax,1),%edx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  101cc5:	a1 74 d5 10 00       	mov    0x10d574,%eax
  101cca:	89 10                	mov    %edx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  101ccc:	83 c2 01             	add    $0x1,%edx

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  101ccf:	89 48 10             	mov    %ecx,0x10(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  101cd2:	8b 4c 24 08          	mov    0x8(%esp),%ecx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  101cd6:	89 10                	mov    %edx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  101cd8:	c1 e1 18             	shl    $0x18,%ecx

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  101cdb:	89 48 10             	mov    %ecx,0x10(%eax)
  101cde:	f3 c3                	repz ret 

00101ce0 <kfree>:
// which normally should have been returned by a
// call to kalloc(length).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int length)
{
  101ce0:	55                   	push   %ebp
  101ce1:	57                   	push   %edi
  101ce2:	56                   	push   %esi
  101ce3:	53                   	push   %ebx
  101ce4:	83 ec 1c             	sub    $0x1c,%esp
  101ce7:	8b 74 24 34          	mov    0x34(%esp),%esi
  101ceb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  struct run *r, *rend, **rp, *p, *pend;

  if(length <= 0 || length % PAGE)
  101cef:	85 f6                	test   %esi,%esi
  101cf1:	0f 8e d7 00 00 00    	jle    101dce <kfree+0xee>
  101cf7:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
  101cfd:	0f 85 cb 00 00 00    	jne    101dce <kfree+0xee>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, length);
  101d03:	89 74 24 08          	mov    %esi,0x8(%esp)
  101d07:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  101d0e:	00 
  101d0f:	89 1c 24             	mov    %ebx,(%esp)
  101d12:	e8 f9 f0 ff ff       	call   100e10 <memset>

  acquire(&kalloc_lock);
  101d17:	c7 04 24 80 d5 10 00 	movl   $0x10d580,(%esp)
  101d1e:	e8 4d e5 ff ff       	call   100270 <acquire>
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  101d23:	a1 b4 d5 10 00       	mov    0x10d5b4,%eax
  101d28:	85 c0                	test   %eax,%eax
  101d2a:	74 57                	je     101d83 <kfree+0xa3>
  // Fill with junk to catch dangling refs.
  memset(v, 1, length);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  101d2c:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  101d2f:	39 c1                	cmp    %eax,%ecx
  101d31:	72 50                	jb     101d83 <kfree+0xa3>
    rend = (struct run*)((char*)r + r->length);
  101d33:	8b 78 04             	mov    0x4(%eax),%edi
    if(r <= p && p < rend)
  101d36:	39 c3                	cmp    %eax,%ebx

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->length);
  101d38:	8d 14 38             	lea    (%eax,%edi,1),%edx
    if(r <= p && p < rend)
  101d3b:	0f 83 99 00 00 00    	jae    101dda <kfree+0xfa>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  101d41:	39 c1                	cmp    %eax,%ecx
  101d43:	75 1f                	jne    101d64 <kfree+0x84>
  101d45:	eb 5d                	jmp    101da4 <kfree+0xc4>
  101d47:	90                   	nop
  memset(v, 1, length);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  101d48:	89 c5                	mov    %eax,%ebp
  101d4a:	8b 00                	mov    (%eax),%eax
  101d4c:	85 c0                	test   %eax,%eax
  101d4e:	66 90                	xchg   %ax,%ax
  101d50:	74 36                	je     101d88 <kfree+0xa8>
  101d52:	39 c1                	cmp    %eax,%ecx
  101d54:	72 32                	jb     101d88 <kfree+0xa8>
    rend = (struct run*)((char*)r + r->length);
  101d56:	8b 78 04             	mov    0x4(%eax),%edi
  101d59:	8d 14 38             	lea    (%eax,%edi,1),%edx
    if(r <= p && p < rend)
  101d5c:	39 d3                	cmp    %edx,%ebx
  101d5e:	72 5e                	jb     101dbe <kfree+0xde>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  101d60:	39 c1                	cmp    %eax,%ecx
  101d62:	74 4c                	je     101db0 <kfree+0xd0>
      p->length = length + r->length;
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
  101d64:	39 d3                	cmp    %edx,%ebx
  101d66:	75 e0                	jne    101d48 <kfree+0x68>
      r->length += length;
      if(r->next && r->next == pend){  // r now next to r->next?
  101d68:	8b 10                	mov    (%eax),%edx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->length += length;
  101d6a:	01 fe                	add    %edi,%esi
  101d6c:	89 70 04             	mov    %esi,0x4(%eax)
      if(r->next && r->next == pend){  // r now next to r->next?
  101d6f:	85 d2                	test   %edx,%edx
  101d71:	74 1d                	je     101d90 <kfree+0xb0>
  101d73:	39 d1                	cmp    %edx,%ecx
  101d75:	75 19                	jne    101d90 <kfree+0xb0>
        r->length += r->next->length;
        r->next = r->next->next;
  101d77:	8b 11                	mov    (%ecx),%edx
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->length += length;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->length += r->next->length;
  101d79:	03 71 04             	add    0x4(%ecx),%esi
        r->next = r->next->next;
  101d7c:	89 10                	mov    %edx,(%eax)
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->length += length;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->length += r->next->length;
  101d7e:	89 70 04             	mov    %esi,0x4(%eax)
  101d81:	eb 0d                	jmp    101d90 <kfree+0xb0>
  memset(v, 1, length);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  101d83:	bd b4 d5 10 00       	mov    $0x10d5b4,%ebp
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->length = length;
  101d88:	89 73 04             	mov    %esi,0x4(%ebx)
  p->next = r;
  101d8b:	89 03                	mov    %eax,(%ebx)
  *rp = p;
  101d8d:	89 5d 00             	mov    %ebx,0x0(%ebp)

 out:
  release(&kalloc_lock);
  101d90:	c7 44 24 30 80 d5 10 	movl   $0x10d580,0x30(%esp)
  101d97:	00 
}
  101d98:	83 c4 1c             	add    $0x1c,%esp
  101d9b:	5b                   	pop    %ebx
  101d9c:	5e                   	pop    %esi
  101d9d:	5f                   	pop    %edi
  101d9e:	5d                   	pop    %ebp
  p->length = length;
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
  101d9f:	e9 bc e5 ff ff       	jmp    100360 <release>
  memset(v, 1, length);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  101da4:	bd b4 d5 10 00       	mov    $0x10d5b4,%ebp
  101da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    rend = (struct run*)((char*)r + r->length);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->length = length + r->length;
      p->next = r->next;
  101db0:	8b 00                	mov    (%eax),%eax
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->length);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->length = length + r->length;
  101db2:	01 fe                	add    %edi,%esi
  101db4:	89 73 04             	mov    %esi,0x4(%ebx)
      p->next = r->next;
  101db7:	89 03                	mov    %eax,(%ebx)
      *rp = p;
  101db9:	89 5d 00             	mov    %ebx,0x0(%ebp)
      goto out;
  101dbc:	eb d2                	jmp    101d90 <kfree+0xb0>
  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->length);
    if(r <= p && p < rend)
  101dbe:	39 c3                	cmp    %eax,%ebx
  101dc0:	72 9e                	jb     101d60 <kfree+0x80>
      panic("freeing free page");
  101dc2:	c7 04 24 06 61 10 00 	movl   $0x106106,(%esp)
  101dc9:	e8 e2 ec ff ff       	call   100ab0 <panic>
kfree(char *v, int length)
{
  struct run *r, *rend, **rp, *p, *pend;

  if(length <= 0 || length % PAGE)
    panic("kfree");
  101dce:	c7 04 24 00 61 10 00 	movl   $0x106100,(%esp)
  101dd5:	e8 d6 ec ff ff       	call   100ab0 <panic>
  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->length);
    if(r <= p && p < rend)
  101dda:	39 d3                	cmp    %edx,%ebx
  101ddc:	0f 83 5f ff ff ff    	jae    101d41 <kfree+0x61>
  101de2:	eb de                	jmp    101dc2 <kfree+0xe2>
  101de4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101dea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101df0 <kinit>:
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  101df0:	83 ec 1c             	sub    $0x1c,%esp
  extern int end;
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  101df3:	c7 44 24 04 18 61 10 	movl   $0x106118,0x4(%esp)
  101dfa:	00 
  101dfb:	c7 04 24 80 d5 10 00 	movl   $0x10d580,(%esp)
  101e02:	e8 79 e3 ff ff       	call   100180 <initlock>
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  101e07:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  101e0e:	00 
  101e0f:	c7 04 24 1f 61 10 00 	movl   $0x10611f,(%esp)
  101e16:	e8 05 e9 ff ff       	call   100720 <cprintf>
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  101e1b:	b8 84 39 11 00       	mov    $0x113984,%eax
  101e20:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  kfree(start, mem * PAGE);
  101e25:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  101e2c:	00 
  101e2d:	89 04 24             	mov    %eax,(%esp)
  101e30:	e8 ab fe ff ff       	call   101ce0 <kfree>
}
  101e35:	83 c4 1c             	add    $0x1c,%esp
  101e38:	c3                   	ret    
  101e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101e40 <kalloc>:
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
// 这个函数操作链表有搞头，有深度，我靠
char*
kalloc(int n)
{
  101e40:	53                   	push   %ebx
  101e41:	83 ec 28             	sub    $0x28,%esp
  101e44:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  101e48:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
  101e4e:	0f 85 a1 00 00 00    	jne    101ef5 <kalloc+0xb5>
  101e54:	85 db                	test   %ebx,%ebx
  101e56:	0f 8e 99 00 00 00    	jle    101ef5 <kalloc+0xb5>
    panic("kalloc");

  acquire(&kalloc_lock);
  101e5c:	c7 04 24 80 d5 10 00 	movl   $0x10d580,(%esp)
  101e63:	e8 08 e4 ff ff       	call   100270 <acquire>
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  101e68:	a1 b4 d5 10 00       	mov    0x10d5b4,%eax
  101e6d:	85 c0                	test   %eax,%eax
  101e6f:	74 3f                	je     101eb0 <kalloc+0x70>
    if(r->length == n){
  101e71:	8b 50 04             	mov    0x4(%eax),%edx
  101e74:	39 da                	cmp    %ebx,%edx
  101e76:	75 17                	jne    101e8f <kalloc+0x4f>
  101e78:	eb 55                	jmp    101ecf <kalloc+0x8f>
  101e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  101e80:	89 c1                	mov    %eax,%ecx
  101e82:	8b 00                	mov    (%eax),%eax
  101e84:	85 c0                	test   %eax,%eax
  101e86:	74 28                	je     101eb0 <kalloc+0x70>
    if(r->length == n){
  101e88:	8b 50 04             	mov    0x4(%eax),%edx
  101e8b:	39 da                	cmp    %ebx,%edx
  101e8d:	74 49                	je     101ed8 <kalloc+0x98>
      *rp = r->next;
      release(&kalloc_lock);
      return (char*)r;
    }
    if(r->length > n){
  101e8f:	39 d3                	cmp    %edx,%ebx
  101e91:	7d ed                	jge    101e80 <kalloc+0x40>
      r->length -= n;
  101e93:	29 da                	sub    %ebx,%edx
  101e95:	89 50 04             	mov    %edx,0x4(%eax)
      p = (char*)r + r->length;
  101e98:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
      release(&kalloc_lock);
  101e9b:	c7 04 24 80 d5 10 00 	movl   $0x10d580,(%esp)
  101ea2:	e8 b9 e4 ff ff       	call   100360 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  101ea7:	83 c4 28             	add    $0x28,%esp
    }
    if(r->length > n){
      r->length -= n;
      p = (char*)r + r->length;
      release(&kalloc_lock);
      return p;
  101eaa:	89 d8                	mov    %ebx,%eax
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  101eac:	5b                   	pop    %ebx
  101ead:	c3                   	ret    
  101eae:	66 90                	xchg   %ax,%ax
      p = (char*)r + r->length;
      release(&kalloc_lock);
      return p;
    }
  }
  release(&kalloc_lock);
  101eb0:	c7 04 24 80 d5 10 00 	movl   $0x10d580,(%esp)
  101eb7:	e8 a4 e4 ff ff       	call   100360 <release>

  cprintf("kalloc: out of memory\n");
  101ebc:	c7 04 24 29 61 10 00 	movl   $0x106129,(%esp)
  101ec3:	e8 58 e8 ff ff       	call   100720 <cprintf>
  return 0;
}
  101ec8:	83 c4 28             	add    $0x28,%esp
    }
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
  101ecb:	31 c0                	xor    %eax,%eax
}
  101ecd:	5b                   	pop    %ebx
  101ece:	c3                   	ret    

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  101ecf:	b9 b4 d5 10 00       	mov    $0x10d5b4,%ecx
  101ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(r->length == n){
      *rp = r->next;
  101ed8:	8b 10                	mov    (%eax),%edx
  101eda:	89 11                	mov    %edx,(%ecx)
      release(&kalloc_lock);
  101edc:	c7 04 24 80 d5 10 00 	movl   $0x10d580,(%esp)
  101ee3:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  101ee7:	e8 74 e4 ff ff       	call   100360 <release>
      return (char*)r;
  101eec:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  101ef0:	83 c4 28             	add    $0x28,%esp
  101ef3:	5b                   	pop    %ebx
  101ef4:	c3                   	ret    
{
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
    panic("kalloc");
  101ef5:	c7 04 24 18 61 10 00 	movl   $0x106118,(%esp)
  101efc:	e8 af eb ff ff       	call   100ab0 <panic>
  101f01:	90                   	nop
  101f02:	90                   	nop
  101f03:	90                   	nop
  101f04:	90                   	nop
  101f05:	90                   	nop
  101f06:	90                   	nop
  101f07:	90                   	nop
  101f08:	90                   	nop
  101f09:	90                   	nop
  101f0a:	90                   	nop
  101f0b:	90                   	nop
  101f0c:	90                   	nop
  101f0d:	90                   	nop
  101f0e:	90                   	nop
  101f0f:	90                   	nop

00101f10 <mp_search1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  101f10:	56                   	push   %esi
  101f11:	53                   	push   %ebx

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
  101f12:	31 db                	xor    %ebx,%ebx
static struct mp*
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  101f14:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  101f17:	83 ec 14             	sub    $0x14,%esp
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  101f1a:	39 f0                	cmp    %esi,%eax
  101f1c:	73 3d                	jae    101f5b <mp_search1+0x4b>
  101f1e:	89 c3                	mov    %eax,%ebx
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  101f20:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  101f27:	00 
  101f28:	c7 44 24 04 40 61 10 	movl   $0x106140,0x4(%esp)
  101f2f:	00 
  101f30:	89 1c 24             	mov    %ebx,(%esp)
  101f33:	e8 08 ef ff ff       	call   100e40 <memcmp>
  101f38:	85 c0                	test   %eax,%eax
  101f3a:	75 16                	jne    101f52 <mp_search1+0x42>
  101f3c:	31 d2                	xor    %edx,%edx
  101f3e:	66 90                	xchg   %ax,%ax
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  101f40:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
  101f44:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  101f47:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
  101f49:	83 f8 10             	cmp    $0x10,%eax
  101f4c:	75 f2                	jne    101f40 <mp_search1+0x30>
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  101f4e:	84 d2                	test   %dl,%dl
  101f50:	74 09                	je     101f5b <mp_search1+0x4b>
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  101f52:	83 c3 10             	add    $0x10,%ebx
  101f55:	39 de                	cmp    %ebx,%esi
  101f57:	77 c7                	ja     101f20 <mp_search1+0x10>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
  101f59:	31 db                	xor    %ebx,%ebx
}
  101f5b:	83 c4 14             	add    $0x14,%esp
  101f5e:	89 d8                	mov    %ebx,%eax
  101f60:	5b                   	pop    %ebx
  101f61:	5e                   	pop    %esi
  101f62:	c3                   	ret    
  101f63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f70 <mp_bcpu>:
uchar ioapic_id;

int
mp_bcpu(void)
{
  return bcpu-cpus;
  101f70:	a1 1c 88 10 00       	mov    0x10881c,%eax
  101f75:	2d e0 d5 10 00       	sub    $0x10d5e0,%eax
  101f7a:	c1 f8 02             	sar    $0x2,%eax
  101f7d:	69 c0 fb fa fa fa    	imul   $0xfafafafb,%eax,%eax
}
  101f83:	c3                   	ret    
  101f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101f90 <mp_init>:
  return conf;
}

void
mp_init(void)
{
  101f90:	55                   	push   %ebp
  101f91:	57                   	push   %edi
  101f92:	56                   	push   %esi
  101f93:	53                   	push   %ebx
  101f94:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  101f97:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[ncpu];
  101f9e:	69 05 40 dc 10 00 cc 	imul   $0xcc,0x10dc40,%eax
  101fa5:	00 00 00 
  101fa8:	05 e0 d5 10 00       	add    $0x10d5e0,%eax
  101fad:	a3 1c 88 10 00       	mov    %eax,0x10881c
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  101fb2:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  101fb9:	c1 e0 08             	shl    $0x8,%eax
  101fbc:	09 d0                	or     %edx,%eax
  101fbe:	c1 e0 04             	shl    $0x4,%eax
  101fc1:	85 c0                	test   %eax,%eax
  101fc3:	75 1b                	jne    101fe0 <mp_init+0x50>
    if((mp = mp_search1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  101fc5:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  101fcc:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  101fd3:	c1 e0 08             	shl    $0x8,%eax
  101fd6:	09 d0                	or     %edx,%eax
  101fd8:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mp_search1((uchar*)p-1024, 1024)))
  101fdb:	2d 00 04 00 00       	sub    $0x400,%eax
  101fe0:	ba 00 04 00 00       	mov    $0x400,%edx
  101fe5:	e8 26 ff ff ff       	call   101f10 <mp_search1>
  101fea:	85 c0                	test   %eax,%eax
  101fec:	89 c3                	mov    %eax,%ebx
  101fee:	0f 84 4c 01 00 00    	je     102140 <mp_init+0x1b0>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  101ff4:	8b 73 04             	mov    0x4(%ebx),%esi
  101ff7:	85 f6                	test   %esi,%esi
  101ff9:	0f 84 e2 00 00 00    	je     1020e1 <mp_init+0x151>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  101fff:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102006:	00 
  102007:	c7 44 24 04 45 61 10 	movl   $0x106145,0x4(%esp)
  10200e:	00 
  10200f:	89 34 24             	mov    %esi,(%esp)
  102012:	e8 29 ee ff ff       	call   100e40 <memcmp>
  102017:	85 c0                	test   %eax,%eax
  102019:	0f 85 c2 00 00 00    	jne    1020e1 <mp_init+0x151>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  10201f:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  102023:	3c 04                	cmp    $0x4,%al
  102025:	0f 85 35 01 00 00    	jne    102160 <mp_init+0x1d0>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  10202b:	0f b7 56 04          	movzwl 0x4(%esi),%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
  10202f:	85 d2                	test   %edx,%edx
  102031:	74 1a                	je     10204d <mp_init+0xbd>
  102033:	31 c9                	xor    %ecx,%ecx
  102035:	31 c0                	xor    %eax,%eax
  102037:	90                   	nop
    sum += addr[i];
  102038:	0f b6 3c 06          	movzbl (%esi,%eax,1),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
  10203c:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  10203f:	01 f9                	add    %edi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
  102041:	39 c2                	cmp    %eax,%edx
  102043:	7f f3                	jg     102038 <mp_init+0xa8>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102045:	84 c9                	test   %cl,%cl
  102047:	0f 85 94 00 00 00    	jne    1020e1 <mp_init+0x151>
  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  10204d:	8b 46 24             	mov    0x24(%esi),%eax

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102050:	01 f2                	add    %esi,%edx

  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  102052:	c7 05 c0 d5 10 00 01 	movl   $0x1,0x10d5c0
  102059:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  10205c:	a3 20 89 10 00       	mov    %eax,0x108920

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102061:	8d 46 2c             	lea    0x2c(%esi),%eax
  102064:	39 d0                	cmp    %edx,%eax
  102066:	73 61                	jae    1020c9 <mp_init+0x139>
  102068:	8b 0d 1c 88 10 00    	mov    0x10881c,%ecx
  10206e:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
    switch(*p){
  102072:	0f b6 30             	movzbl (%eax),%esi
  102075:	89 f3                	mov    %esi,%ebx
  102077:	80 fb 04             	cmp    $0x4,%bl
  10207a:	76 2c                	jbe    1020a8 <mp_init+0x118>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  10207c:	81 e6 ff 00 00 00    	and    $0xff,%esi
  102082:	89 74 24 04          	mov    %esi,0x4(%esp)
  102086:	c7 04 24 54 61 10 00 	movl   $0x106154,(%esp)
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  10208d:	89 0d 1c 88 10 00    	mov    %ecx,0x10881c
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102093:	e8 88 e6 ff ff       	call   100720 <cprintf>
      panic("mp_init");
  102098:	c7 04 24 4a 61 10 00 	movl   $0x10614a,(%esp)
  10209f:	e8 0c ea ff ff       	call   100ab0 <panic>
  1020a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  1020a8:	81 e6 ff 00 00 00    	and    $0xff,%esi
  1020ae:	ff 24 b5 78 61 10 00 	jmp    *0x106178(,%esi,4)
  1020b5:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  1020b8:	83 c0 08             	add    $0x8,%eax
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  1020bb:	39 c2                	cmp    %eax,%edx
  1020bd:	77 b3                	ja     102072 <mp_init+0xe2>
  1020bf:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  1020c3:	89 0d 1c 88 10 00    	mov    %ecx,0x10881c
      cprintf("mp_init: unknown config type %x\n", *p);
      panic("mp_init");
    }
  }

  if(mp->imcrp){
  1020c9:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
  1020cd:	74 12                	je     1020e1 <mp_init+0x151>


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1020cf:	ba 22 00 00 00       	mov    $0x22,%edx
  1020d4:	b8 70 00 00 00       	mov    $0x70,%eax
  1020d9:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1020da:	b2 23                	mov    $0x23,%dl
  1020dc:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  1020dd:	83 c8 01             	or     $0x1,%eax


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1020e0:	ee                   	out    %al,(%dx)
  }
}
  1020e1:	83 c4 2c             	add    $0x2c,%esp
  1020e4:	5b                   	pop    %ebx
  1020e5:	5e                   	pop    %esi
  1020e6:	5f                   	pop    %edi
  1020e7:	5d                   	pop    %ebp
  1020e8:	c3                   	ret    
  1020e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
  1020f0:	8b 35 40 dc 10 00    	mov    0x10dc40,%esi
  1020f6:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
  1020fa:	69 fe cc 00 00 00    	imul   $0xcc,%esi,%edi
  102100:	88 9f e0 d5 10 00    	mov    %bl,0x10d5e0(%edi)
  102106:	8d af e0 d5 10 00    	lea    0x10d5e0(%edi),%ebp
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
  10210c:	f6 40 03 02          	testb  $0x2,0x3(%eax)
  102110:	0f 45 cd             	cmovne %ebp,%ecx
      ncpu++;
  102113:	83 c6 01             	add    $0x1,%esi
  102116:	89 35 40 dc 10 00    	mov    %esi,0x10dc40
      p += sizeof(struct mpproc);
  10211c:	83 c0 14             	add    $0x14,%eax
      continue;
  10211f:	eb 9a                	jmp    1020bb <mp_init+0x12b>
  102121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102128:	0f b6 70 01          	movzbl 0x1(%eax),%esi
      p += sizeof(struct mpioapic);
  10212c:	83 c0 08             	add    $0x8,%eax
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  10212f:	89 f3                	mov    %esi,%ebx
  102131:	88 1d c4 d5 10 00    	mov    %bl,0x10d5c4
      p += sizeof(struct mpioapic);
      continue;
  102137:	eb 82                	jmp    1020bb <mp_init+0x12b>
  102139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102140:	ba 00 00 01 00       	mov    $0x10000,%edx
  102145:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  10214a:	e8 c1 fd ff ff       	call   101f10 <mp_search1>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  10214f:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102151:	89 c3                	mov    %eax,%ebx
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102153:	0f 85 9b fe ff ff    	jne    101ff4 <mp_init+0x64>
  102159:	eb 86                	jmp    1020e1 <mp_init+0x151>
  10215b:	90                   	nop
  10215c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102160:	3c 01                	cmp    $0x1,%al
  102162:	0f 84 c3 fe ff ff    	je     10202b <mp_init+0x9b>
  102168:	90                   	nop
  102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102170:	e9 6c ff ff ff       	jmp    1020e1 <mp_init+0x151>
  102175:	90                   	nop
  102176:	90                   	nop
  102177:	90                   	nop
  102178:	90                   	nop
  102179:	90                   	nop
  10217a:	90                   	nop
  10217b:	90                   	nop
  10217c:	90                   	nop
  10217d:	90                   	nop
  10217e:	90                   	nop
  10217f:	90                   	nop

00102180 <fileinit>:
struct spinlock file_table_lock;
struct file file[NFILE];

void
fileinit(void)
{
  102180:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&file_table_lock, "file_table");
  102183:	c7 44 24 04 8c 61 10 	movl   $0x10618c,0x4(%esp)
  10218a:	00 
  10218b:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
  102192:	e8 e9 df ff ff       	call   100180 <initlock>
}
  102197:	83 c4 1c             	add    $0x1c,%esp
  10219a:	c3                   	ret    
  10219b:	90                   	nop
  10219c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001021a0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
  1021a0:	53                   	push   %ebx
  1021a1:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&file_table_lock);
  1021a4:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
  1021ab:	e8 c0 e0 ff ff       	call   100270 <acquire>
  1021b0:	ba 60 dc 10 00       	mov    $0x10dc60,%edx
  for(i = 0; i < NFILE; i++){
  1021b5:	31 c0                	xor    %eax,%eax
  1021b7:	eb 14                	jmp    1021cd <filealloc+0x2d>
  1021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1021c0:	83 c0 01             	add    $0x1,%eax
  1021c3:	83 c2 18             	add    $0x18,%edx
  1021c6:	3d 80 00 00 00       	cmp    $0x80,%eax
  1021cb:	74 3b                	je     102208 <filealloc+0x68>
    if(file[i].type == FD_CLOSED){
  1021cd:	8b 0a                	mov    (%edx),%ecx
  1021cf:	85 c9                	test   %ecx,%ecx
  1021d1:	75 ed                	jne    1021c0 <filealloc+0x20>
      file[i].type = FD_NONE;
  1021d3:	8d 04 40             	lea    (%eax,%eax,2),%eax
  1021d6:	c1 e0 03             	shl    $0x3,%eax
      file[i].ref = 1;
      release(&file_table_lock);
  1021d9:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
  int i;

  acquire(&file_table_lock);
  for(i = 0; i < NFILE; i++){
    if(file[i].type == FD_CLOSED){
      file[i].type = FD_NONE;
  1021e0:	8d 98 60 dc 10 00    	lea    0x10dc60(%eax),%ebx
  1021e6:	c7 80 60 dc 10 00 01 	movl   $0x1,0x10dc60(%eax)
  1021ed:	00 00 00 
      file[i].ref = 1;
  1021f0:	c7 80 64 dc 10 00 01 	movl   $0x1,0x10dc64(%eax)
  1021f7:	00 00 00 
      release(&file_table_lock);
  1021fa:	e8 61 e1 ff ff       	call   100360 <release>
      return file + i;
    }
  }
  release(&file_table_lock);
  return 0;
}
  1021ff:	83 c4 18             	add    $0x18,%esp
  for(i = 0; i < NFILE; i++){
    if(file[i].type == FD_CLOSED){
      file[i].type = FD_NONE;
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
  102202:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&file_table_lock);
  return 0;
}
  102204:	5b                   	pop    %ebx
  102205:	c3                   	ret    
  102206:	66 90                	xchg   %ax,%ax
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  102208:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
  10220f:	e8 4c e1 ff ff       	call   100360 <release>
  return 0;
}
  102214:	83 c4 18             	add    $0x18,%esp
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  return 0;
  102217:	31 c0                	xor    %eax,%eax
}
  102219:	5b                   	pop    %ebx
  10221a:	c3                   	ret    
  10221b:	90                   	nop
  10221c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102220 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  102220:	53                   	push   %ebx
  102221:	83 ec 18             	sub    $0x18,%esp
  102224:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  acquire(&file_table_lock);
  102228:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
  10222f:	e8 3c e0 ff ff       	call   100270 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  102234:	8b 43 04             	mov    0x4(%ebx),%eax
  102237:	85 c0                	test   %eax,%eax
  102239:	7e 1f                	jle    10225a <filedup+0x3a>
  10223b:	8b 13                	mov    (%ebx),%edx
  10223d:	85 d2                	test   %edx,%edx
  10223f:	74 19                	je     10225a <filedup+0x3a>
    panic("filedup");
  f->ref++;
  102241:	83 c0 01             	add    $0x1,%eax
  102244:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&file_table_lock);
  102247:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
  10224e:	e8 0d e1 ff ff       	call   100360 <release>
  return f;
}
  102253:	83 c4 18             	add    $0x18,%esp
  102256:	89 d8                	mov    %ebx,%eax
  102258:	5b                   	pop    %ebx
  102259:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("filedup");
  10225a:	c7 04 24 97 61 10 00 	movl   $0x106197,(%esp)
  102261:	e8 4a e8 ff ff       	call   100ab0 <panic>
  102266:	8d 76 00             	lea    0x0(%esi),%esi
  102269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102270 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  102270:	83 ec 3c             	sub    $0x3c,%esp
  102273:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
  102277:	8b 5c 24 40          	mov    0x40(%esp),%ebx
  struct file ff;

  acquire(&file_table_lock);
  10227b:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  102282:	89 74 24 30          	mov    %esi,0x30(%esp)
  102286:	89 7c 24 34          	mov    %edi,0x34(%esp)
  10228a:	89 6c 24 38          	mov    %ebp,0x38(%esp)
  struct file ff;

  acquire(&file_table_lock);
  10228e:	e8 dd df ff ff       	call   100270 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  102293:	8b 43 04             	mov    0x4(%ebx),%eax
  102296:	85 c0                	test   %eax,%eax
  102298:	0f 8e a7 00 00 00    	jle    102345 <fileclose+0xd5>
  10229e:	8b 33                	mov    (%ebx),%esi
  1022a0:	85 f6                	test   %esi,%esi
  1022a2:	0f 84 9d 00 00 00    	je     102345 <fileclose+0xd5>
    panic("fileclose");
  if(--f->ref > 0){
  1022a8:	83 e8 01             	sub    $0x1,%eax
  1022ab:	85 c0                	test   %eax,%eax
  1022ad:	89 43 04             	mov    %eax,0x4(%ebx)
  1022b0:	74 26                	je     1022d8 <fileclose+0x68>
    release(&file_table_lock);
  1022b2:	c7 44 24 40 60 e8 10 	movl   $0x10e860,0x40(%esp)
  1022b9:	00 
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  1022ba:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  1022be:	8b 74 24 30          	mov    0x30(%esp),%esi
  1022c2:	8b 7c 24 34          	mov    0x34(%esp),%edi
  1022c6:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  1022ca:	83 c4 3c             	add    $0x3c,%esp

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  1022cd:	e9 8e e0 ff ff       	jmp    100360 <release>
  1022d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return;
  }
  ff = *f;
  1022d8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  1022dc:	8b 6b 0c             	mov    0xc(%ebx),%ebp
  1022df:	8b 7b 10             	mov    0x10(%ebx),%edi
  f->ref = 0;
  f->type = FD_CLOSED;
  1022e2:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&file_table_lock);
  1022e8:	c7 04 24 60 e8 10 00 	movl   $0x10e860,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
    return;
  }
  ff = *f;
  1022ef:	88 44 24 1f          	mov    %al,0x1f(%esp)
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  1022f3:	e8 68 e0 ff ff       	call   100360 <release>

  if(ff.type == FD_PIPE)
  1022f8:	83 fe 02             	cmp    $0x2,%esi
  1022fb:	74 23                	je     102320 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  1022fd:	83 fe 03             	cmp    $0x3,%esi
  102300:	75 43                	jne    102345 <fileclose+0xd5>
    iput(ff.ip);
  102302:	89 7c 24 40          	mov    %edi,0x40(%esp)
  else
    panic("fileclose");
}
  102306:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  10230a:	8b 74 24 30          	mov    0x30(%esp),%esi
  10230e:	8b 7c 24 34          	mov    0x34(%esp),%edi
  102312:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  102316:	83 c4 3c             	add    $0x3c,%esp
  release(&file_table_lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  102319:	e9 a2 08 00 00       	jmp    102bc0 <iput>
  10231e:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  102320:	0f be 44 24 1f       	movsbl 0x1f(%esp),%eax
  102325:	89 2c 24             	mov    %ebp,(%esp)
  102328:	89 44 24 04          	mov    %eax,0x4(%esp)
  10232c:	e8 9f 16 00 00       	call   1039d0 <pipeclose>
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  102331:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  102335:	8b 74 24 30          	mov    0x30(%esp),%esi
  102339:	8b 7c 24 34          	mov    0x34(%esp),%edi
  10233d:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  102341:	83 c4 3c             	add    $0x3c,%esp
  102344:	c3                   	ret    
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
  102345:	c7 04 24 9f 61 10 00 	movl   $0x10619f,(%esp)
  10234c:	e8 5f e7 ff ff       	call   100ab0 <panic>
  102351:	eb 0d                	jmp    102360 <filestat>
  102353:	90                   	nop
  102354:	90                   	nop
  102355:	90                   	nop
  102356:	90                   	nop
  102357:	90                   	nop
  102358:	90                   	nop
  102359:	90                   	nop
  10235a:	90                   	nop
  10235b:	90                   	nop
  10235c:	90                   	nop
  10235d:	90                   	nop
  10235e:	90                   	nop
  10235f:	90                   	nop

00102360 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  102360:	53                   	push   %ebx
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
  102361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  102366:	83 ec 18             	sub    $0x18,%esp
  102369:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if(f->type == FD_INODE){
  10236d:	83 3b 03             	cmpl   $0x3,(%ebx)
  102370:	75 2b                	jne    10239d <filestat+0x3d>
    ilock(f->ip);
  102372:	8b 43 10             	mov    0x10(%ebx),%eax
  102375:	89 04 24             	mov    %eax,(%esp)
  102378:	e8 93 05 00 00       	call   102910 <ilock>
    stati(f->ip, st);
  10237d:	8b 44 24 24          	mov    0x24(%esp),%eax
  102381:	89 44 24 04          	mov    %eax,0x4(%esp)
  102385:	8b 43 10             	mov    0x10(%ebx),%eax
  102388:	89 04 24             	mov    %eax,(%esp)
  10238b:	e8 90 09 00 00       	call   102d20 <stati>
    iunlock(f->ip);
  102390:	8b 43 10             	mov    0x10(%ebx),%eax
  102393:	89 04 24             	mov    %eax,(%esp)
  102396:	e8 75 06 00 00       	call   102a10 <iunlock>
    return 0;
  10239b:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
  10239d:	83 c4 18             	add    $0x18,%esp
  1023a0:	5b                   	pop    %ebx
  1023a1:	c3                   	ret    
  1023a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1023a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001023b0 <fileread>:

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  1023b0:	83 ec 1c             	sub    $0x1c,%esp
  1023b3:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1023b7:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1023bb:	89 74 24 14          	mov    %esi,0x14(%esp)
  1023bf:	8b 74 24 24          	mov    0x24(%esp),%esi
  1023c3:	89 7c 24 18          	mov    %edi,0x18(%esp)
  1023c7:	8b 7c 24 28          	mov    0x28(%esp),%edi
  int r;

  if(f->readable == 0)
  1023cb:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  1023cf:	74 77                	je     102448 <fileread+0x98>
    return -1;
  if(f->type == FD_PIPE)
  1023d1:	8b 03                	mov    (%ebx),%eax
  1023d3:	83 f8 02             	cmp    $0x2,%eax
  1023d6:	74 50                	je     102428 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  1023d8:	83 f8 03             	cmp    $0x3,%eax
  1023db:	75 72                	jne    10244f <fileread+0x9f>
    ilock(f->ip);
  1023dd:	8b 43 10             	mov    0x10(%ebx),%eax
  1023e0:	89 04 24             	mov    %eax,(%esp)
  1023e3:	e8 28 05 00 00       	call   102910 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  1023e8:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1023ec:	8b 43 14             	mov    0x14(%ebx),%eax
  1023ef:	89 74 24 04          	mov    %esi,0x4(%esp)
  1023f3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1023f7:	8b 43 10             	mov    0x10(%ebx),%eax
  1023fa:	89 04 24             	mov    %eax,(%esp)
  1023fd:	e8 4e 09 00 00       	call   102d50 <readi>
  102402:	85 c0                	test   %eax,%eax
  102404:	89 c6                	mov    %eax,%esi
  102406:	7e 03                	jle    10240b <fileread+0x5b>
      f->off += r;
  102408:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  10240b:	8b 43 10             	mov    0x10(%ebx),%eax
  10240e:	89 04 24             	mov    %eax,(%esp)
  102411:	e8 fa 05 00 00       	call   102a10 <iunlock>
    return r;
  }
  panic("fileread");
}
  102416:	89 f0                	mov    %esi,%eax
  102418:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10241c:	8b 74 24 14          	mov    0x14(%esp),%esi
  102420:	8b 7c 24 18          	mov    0x18(%esp),%edi
  102424:	83 c4 1c             	add    $0x1c,%esp
  102427:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  102428:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  10242b:	8b 74 24 14          	mov    0x14(%esp),%esi
  10242f:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  102433:	8b 7c 24 18          	mov    0x18(%esp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  102437:	89 44 24 20          	mov    %eax,0x20(%esp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  10243b:	83 c4 1c             	add    $0x1c,%esp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  10243e:	e9 3d 17 00 00       	jmp    103b80 <piperead>
  102443:	90                   	nop
  102444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
  102448:	be ff ff ff ff       	mov    $0xffffffff,%esi
  10244d:	eb c7                	jmp    102416 <fileread+0x66>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  10244f:	c7 04 24 a9 61 10 00 	movl   $0x1061a9,(%esp)
  102456:	e8 55 e6 ff ff       	call   100ab0 <panic>
  10245b:	90                   	nop
  10245c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102460 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  102460:	83 ec 1c             	sub    $0x1c,%esp
  102463:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  102467:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10246b:	89 74 24 14          	mov    %esi,0x14(%esp)
  10246f:	8b 74 24 24          	mov    0x24(%esp),%esi
  102473:	89 7c 24 18          	mov    %edi,0x18(%esp)
  102477:	8b 7c 24 28          	mov    0x28(%esp),%edi
  int r;

  if(f->writable == 0)
  10247b:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  10247f:	74 77                	je     1024f8 <filewrite+0x98>
    return -1;
  if(f->type == FD_PIPE)
  102481:	8b 03                	mov    (%ebx),%eax
  102483:	83 f8 02             	cmp    $0x2,%eax
  102486:	74 50                	je     1024d8 <filewrite+0x78>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  102488:	83 f8 03             	cmp    $0x3,%eax
  10248b:	75 72                	jne    1024ff <filewrite+0x9f>
    ilock(f->ip);
  10248d:	8b 43 10             	mov    0x10(%ebx),%eax
  102490:	89 04 24             	mov    %eax,(%esp)
  102493:	e8 78 04 00 00       	call   102910 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  102498:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10249c:	8b 43 14             	mov    0x14(%ebx),%eax
  10249f:	89 74 24 04          	mov    %esi,0x4(%esp)
  1024a3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1024a7:	8b 43 10             	mov    0x10(%ebx),%eax
  1024aa:	89 04 24             	mov    %eax,(%esp)
  1024ad:	e8 ae 09 00 00       	call   102e60 <writei>
  1024b2:	85 c0                	test   %eax,%eax
  1024b4:	89 c6                	mov    %eax,%esi
  1024b6:	7e 03                	jle    1024bb <filewrite+0x5b>
      f->off += r;
  1024b8:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  1024bb:	8b 43 10             	mov    0x10(%ebx),%eax
  1024be:	89 04 24             	mov    %eax,(%esp)
  1024c1:	e8 4a 05 00 00       	call   102a10 <iunlock>
    return r;
  }
  panic("filewrite");
}
  1024c6:	89 f0                	mov    %esi,%eax
  1024c8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1024cc:	8b 74 24 14          	mov    0x14(%esp),%esi
  1024d0:	8b 7c 24 18          	mov    0x18(%esp),%edi
  1024d4:	83 c4 1c             	add    $0x1c,%esp
  1024d7:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  1024d8:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  1024db:	8b 74 24 14          	mov    0x14(%esp),%esi
  1024df:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1024e3:	8b 7c 24 18          	mov    0x18(%esp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  1024e7:	89 44 24 20          	mov    %eax,0x20(%esp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  1024eb:	83 c4 1c             	add    $0x1c,%esp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  1024ee:	e9 7d 15 00 00       	jmp    103a70 <pipewrite>
  1024f3:	90                   	nop
  1024f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
  1024f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
  1024fd:	eb c7                	jmp    1024c6 <filewrite+0x66>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  1024ff:	c7 04 24 b2 61 10 00 	movl   $0x1061b2,(%esp)
  102506:	e8 a5 e5 ff ff       	call   100ab0 <panic>
  10250b:	90                   	nop
  10250c:	90                   	nop
  10250d:	90                   	nop
  10250e:	90                   	nop
  10250f:	90                   	nop

00102510 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  102510:	57                   	push   %edi
  102511:	89 d7                	mov    %edx,%edi
  102513:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  102514:	31 f6                	xor    %esi,%esi

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  102516:	53                   	push   %ebx
  102517:	89 c3                	mov    %eax,%ebx
  102519:	83 ec 20             	sub    $0x20,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
  10251c:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102523:	e8 48 dd ff ff       	call   100270 <acquire>

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  102528:	b8 54 e9 10 00       	mov    $0x10e954,%eax
  10252d:	eb 0f                	jmp    10253e <iget+0x2e>
  10252f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  102530:	85 f6                	test   %esi,%esi
  102532:	74 3c                	je     102570 <iget+0x60>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  102534:	83 c0 50             	add    $0x50,%eax
  102537:	3d 54 fd 10 00       	cmp    $0x10fd54,%eax
  10253c:	73 42                	jae    102580 <iget+0x70>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  10253e:	8b 48 08             	mov    0x8(%eax),%ecx
  102541:	85 c9                	test   %ecx,%ecx
  102543:	7e eb                	jle    102530 <iget+0x20>
  102545:	39 18                	cmp    %ebx,(%eax)
  102547:	75 e7                	jne    102530 <iget+0x20>
  102549:	39 78 04             	cmp    %edi,0x4(%eax)
  10254c:	75 e2                	jne    102530 <iget+0x20>
      ip->ref++;
  10254e:	83 c1 01             	add    $0x1,%ecx
  102551:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
  102554:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  10255b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  10255f:	e8 fc dd ff ff       	call   100360 <release>
      return ip;
  102564:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  102568:	83 c4 20             	add    $0x20,%esp
  10256b:	5b                   	pop    %ebx
  10256c:	5e                   	pop    %esi
  10256d:	5f                   	pop    %edi
  10256e:	c3                   	ret    
  10256f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  102570:	85 c9                	test   %ecx,%ecx
  102572:	0f 44 f0             	cmove  %eax,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  102575:	83 c0 50             	add    $0x50,%eax
  102578:	3d 54 fd 10 00       	cmp    $0x10fd54,%eax
  10257d:	72 bf                	jb     10253e <iget+0x2e>
  10257f:	90                   	nop
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  102580:	85 f6                	test   %esi,%esi
  102582:	74 28                	je     1025ac <iget+0x9c>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  102584:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
  102586:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
  102589:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  102590:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
  102597:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  10259e:	e8 bd dd ff ff       	call   100360 <release>

  return ip;
}
  1025a3:	83 c4 20             	add    $0x20,%esp
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
  1025a6:	89 f0                	mov    %esi,%eax
}
  1025a8:	5b                   	pop    %ebx
  1025a9:	5e                   	pop    %esi
  1025aa:	5f                   	pop    %edi
  1025ab:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  1025ac:	c7 04 24 bc 61 10 00 	movl   $0x1061bc,(%esp)
  1025b3:	e8 f8 e4 ff ff       	call   100ab0 <panic>
  1025b8:	90                   	nop
  1025b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001025c0 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1025c0:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *bp;

  bp = bread(dev, 1);
  1025c3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1025ca:	00 
  1025cb:	89 04 24             	mov    %eax,(%esp)
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1025ce:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  1025d2:	89 74 24 18          	mov    %esi,0x18(%esp)
  1025d6:	89 d6                	mov    %edx,%esi
  struct buf *bp;

  bp = bread(dev, 1);
  1025d8:	e8 f3 0d 00 00       	call   1033d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  1025dd:	89 34 24             	mov    %esi,(%esp)
  1025e0:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  1025e7:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
  1025e8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  1025ea:	8d 40 18             	lea    0x18(%eax),%eax
  1025ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1025f1:	e8 aa e8 ff ff       	call   100ea0 <memmove>
  brelse(bp);
  1025f6:	89 1c 24             	mov    %ebx,(%esp)
  1025f9:	e8 e2 0e 00 00       	call   1034e0 <brelse>
}
  1025fe:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  102602:	8b 74 24 18          	mov    0x18(%esp),%esi
  102606:	83 c4 1c             	add    $0x1c,%esp
  102609:	c3                   	ret    
  10260a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102610 <balloc>:
// Blocks.

// Allocate a disk block.
static uint
balloc(uint dev)
{
  102610:	55                   	push   %ebp
  102611:	57                   	push   %edi
  102612:	56                   	push   %esi
  102613:	53                   	push   %ebx
  102614:	83 ec 3c             	sub    $0x3c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  102617:	8d 54 24 24          	lea    0x24(%esp),%edx
// Blocks.

// Allocate a disk block.
static uint
balloc(uint dev)
{
  10261b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  10261f:	e8 9c ff ff ff       	call   1025c0 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  102624:	8b 44 24 24          	mov    0x24(%esp),%eax
  102628:	85 c0                	test   %eax,%eax
  10262a:	0f 84 a6 00 00 00    	je     1026d6 <balloc+0xc6>
  102630:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  102637:	00 
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  102638:	bb 01 00 00 00       	mov    $0x1,%ebx
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  10263d:	8b 44 24 2c          	mov    0x2c(%esp),%eax
    for(bi = 0; bi < BPB; bi++){
  102641:	31 f6                	xor    %esi,%esi
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  102643:	8b 54 24 18          	mov    0x18(%esp),%edx
  102647:	c1 e8 03             	shr    $0x3,%eax
  10264a:	c1 fa 0c             	sar    $0xc,%edx
  10264d:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  102651:	89 44 24 04          	mov    %eax,0x4(%esp)
  102655:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  102659:	89 04 24             	mov    %eax,(%esp)
  10265c:	e8 6f 0d 00 00       	call   1033d0 <bread>
  102661:	89 c7                	mov    %eax,%edi
  102663:	eb 0e                	jmp    102673 <balloc+0x63>
  102665:	8d 76 00             	lea    0x0(%esi),%esi
    for(bi = 0; bi < BPB; bi++){
  102668:	83 c6 01             	add    $0x1,%esi
  10266b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
  102671:	74 45                	je     1026b8 <balloc+0xa8>
      m = 1 << (bi % 8);
  102673:	89 f1                	mov    %esi,%ecx
  102675:	89 d8                	mov    %ebx,%eax
  102677:	83 e1 07             	and    $0x7,%ecx
  10267a:	d3 e0                	shl    %cl,%eax
  10267c:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10267e:	89 f0                	mov    %esi,%eax
  102680:	c1 f8 03             	sar    $0x3,%eax
  102683:	0f b6 54 07 18       	movzbl 0x18(%edi,%eax,1),%edx
  102688:	0f b6 ea             	movzbl %dl,%ebp
  10268b:	85 cd                	test   %ecx,%ebp
  10268d:	75 d9                	jne    102668 <balloc+0x58>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  10268f:	09 d1                	or     %edx,%ecx
  102691:	88 4c 07 18          	mov    %cl,0x18(%edi,%eax,1)
        bwrite(bp);
  102695:	89 3c 24             	mov    %edi,(%esp)
  102698:	e8 13 0e 00 00       	call   1034b0 <bwrite>
        brelse(bp);
  10269d:	89 3c 24             	mov    %edi,(%esp)
  1026a0:	e8 3b 0e 00 00       	call   1034e0 <brelse>
        return b + bi;
  1026a5:	8b 44 24 18          	mov    0x18(%esp),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  1026a9:	83 c4 3c             	add    $0x3c,%esp
  1026ac:	5b                   	pop    %ebx
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
        return b + bi;
  1026ad:	01 f0                	add    %esi,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  1026af:	5e                   	pop    %esi
  1026b0:	5f                   	pop    %edi
  1026b1:	5d                   	pop    %ebp
  1026b2:	c3                   	ret    
  1026b3:	90                   	nop
  1026b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  1026b8:	89 3c 24             	mov    %edi,(%esp)
  1026bb:	e8 20 0e 00 00       	call   1034e0 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  1026c0:	81 44 24 18 00 10 00 	addl   $0x1000,0x18(%esp)
  1026c7:	00 
  1026c8:	8b 44 24 18          	mov    0x18(%esp),%eax
  1026cc:	3b 44 24 24          	cmp    0x24(%esp),%eax
  1026d0:	0f 82 67 ff ff ff    	jb     10263d <balloc+0x2d>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  1026d6:	c7 04 24 cc 61 10 00 	movl   $0x1061cc,(%esp)
  1026dd:	e8 ce e3 ff ff       	call   100ab0 <panic>
  1026e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001026f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  1026f0:	57                   	push   %edi
  1026f1:	56                   	push   %esi
  1026f2:	89 c6                	mov    %eax,%esi
  1026f4:	53                   	push   %ebx
  1026f5:	89 d3                	mov    %edx,%ebx
  1026f7:	83 ec 20             	sub    $0x20,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
  1026fa:	89 54 24 04          	mov    %edx,0x4(%esp)
  1026fe:	89 04 24             	mov    %eax,(%esp)
  102701:	e8 ca 0c 00 00       	call   1033d0 <bread>
  memset(bp->data, 0, BSIZE);
  102706:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  10270d:	00 
  10270e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  102715:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
  102716:	89 c7                	mov    %eax,%edi
  memset(bp->data, 0, BSIZE);
  102718:	8d 40 18             	lea    0x18(%eax),%eax
  10271b:	89 04 24             	mov    %eax,(%esp)
  10271e:	e8 ed e6 ff ff       	call   100e10 <memset>
  bwrite(bp);
  102723:	89 3c 24             	mov    %edi,(%esp)
  102726:	e8 85 0d 00 00       	call   1034b0 <bwrite>
  brelse(bp);
  10272b:	89 3c 24             	mov    %edi,(%esp)
  10272e:	e8 ad 0d 00 00       	call   1034e0 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  102733:	89 f0                	mov    %esi,%eax
  102735:	8d 54 24 14          	lea    0x14(%esp),%edx
  102739:	e8 82 fe ff ff       	call   1025c0 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  10273e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  102742:	89 da                	mov    %ebx,%edx
  102744:	c1 ea 0c             	shr    $0xc,%edx
  102747:	89 34 24             	mov    %esi,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  10274a:	be 01 00 00 00       	mov    $0x1,%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  10274f:	c1 e8 03             	shr    $0x3,%eax
  102752:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  102756:	89 44 24 04          	mov    %eax,0x4(%esp)
  10275a:	e8 71 0c 00 00       	call   1033d0 <bread>
  bi = b % BPB;
  10275f:	89 da                	mov    %ebx,%edx
  m = 1 << (bi % 8);
  102761:	89 d9                	mov    %ebx,%ecx

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  102763:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
  102769:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
  10276c:	c1 fa 03             	sar    $0x3,%edx
  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  10276f:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
  102771:	0f b6 4c 10 18       	movzbl 0x18(%eax,%edx,1),%ecx
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  102776:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  102778:	0f b6 c1             	movzbl %cl,%eax
  10277b:	85 f0                	test   %esi,%eax
  10277d:	74 21                	je     1027a0 <bfree+0xb0>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  10277f:	89 f0                	mov    %esi,%eax
  102781:	f7 d0                	not    %eax
  102783:	21 c8                	and    %ecx,%eax
  102785:	88 44 17 18          	mov    %al,0x18(%edi,%edx,1)
  bwrite(bp);
  102789:	89 3c 24             	mov    %edi,(%esp)
  10278c:	e8 1f 0d 00 00       	call   1034b0 <bwrite>
  brelse(bp);
  102791:	89 3c 24             	mov    %edi,(%esp)
  102794:	e8 47 0d 00 00       	call   1034e0 <brelse>
}
  102799:	83 c4 20             	add    $0x20,%esp
  10279c:	5b                   	pop    %ebx
  10279d:	5e                   	pop    %esi
  10279e:	5f                   	pop    %edi
  10279f:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  1027a0:	c7 04 24 e2 61 10 00 	movl   $0x1061e2,(%esp)
  1027a7:	e8 04 e3 ff ff       	call   100ab0 <panic>
  1027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001027b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  1027b0:	83 ec 2c             	sub    $0x2c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1027b3:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  1027b6:	89 5c 24 20          	mov    %ebx,0x20(%esp)
  1027ba:	89 c3                	mov    %eax,%ebx
  1027bc:	89 74 24 24          	mov    %esi,0x24(%esp)
  1027c0:	89 7c 24 28          	mov    %edi,0x28(%esp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1027c4:	77 2a                	ja     1027f0 <bmap+0x40>
    if((addr = ip->addrs[bn]) == 0){
  1027c6:	8d 72 04             	lea    0x4(%edx),%esi
  1027c9:	8b 44 b0 0c          	mov    0xc(%eax,%esi,4),%eax
  1027cd:	85 c0                	test   %eax,%eax
  1027cf:	75 0d                	jne    1027de <bmap+0x2e>
      if(!alloc)
  1027d1:	85 c9                	test   %ecx,%ecx
        return -1;
  1027d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0){
      if(!alloc)
  1027d8:	0f 85 8a 00 00 00    	jne    102868 <bmap+0xb8>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1027de:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1027e2:	8b 74 24 24          	mov    0x24(%esp),%esi
  1027e6:	8b 7c 24 28          	mov    0x28(%esp),%edi
  1027ea:	83 c4 2c             	add    $0x2c,%esp
  1027ed:	c3                   	ret    
  1027ee:	66 90                	xchg   %ax,%ax
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
    }
    return addr;
  }
  bn -= NDIRECT;
  1027f0:	8d 72 f4             	lea    -0xc(%edx),%esi

  if(bn < NINDIRECT){
  1027f3:	83 fe 7f             	cmp    $0x7f,%esi
  1027f6:	0f 87 aa 00 00 00    	ja     1028a6 <bmap+0xf6>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
  1027fc:	8b 40 4c             	mov    0x4c(%eax),%eax
  1027ff:	85 c0                	test   %eax,%eax
  102801:	75 1b                	jne    10281e <bmap+0x6e>
      if(!alloc)
  102803:	85 c9                	test   %ecx,%ecx
        return -1;
  102805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
  10280a:	74 d2                	je     1027de <bmap+0x2e>
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
  10280c:	8b 03                	mov    (%ebx),%eax
  10280e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  102812:	e8 f9 fd ff ff       	call   102610 <balloc>
  102817:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  10281b:	89 43 4c             	mov    %eax,0x4c(%ebx)
    }
    bp = bread(ip->dev, addr);
  10281e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102822:	8b 03                	mov    (%ebx),%eax
  102824:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  102828:	89 04 24             	mov    %eax,(%esp)
  10282b:	e8 a0 0b 00 00       	call   1033d0 <bread>
    a = (uint*)bp->data;

    if((addr = a[bn]) == 0){
  102830:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  102834:	8d 74 b0 18          	lea    0x18(%eax,%esi,4),%esi
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
    }
    bp = bread(ip->dev, addr);
  102838:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;

    if((addr = a[bn]) == 0){
  10283a:	8b 06                	mov    (%esi),%eax
  10283c:	85 c0                	test   %eax,%eax
  10283e:	75 51                	jne    102891 <bmap+0xe1>
      if(!alloc){
  102840:	85 c9                	test   %ecx,%ecx
  102842:	75 34                	jne    102878 <bmap+0xc8>
        brelse(bp);
  102844:	89 3c 24             	mov    %edi,(%esp)
  102847:	e8 94 0c 00 00       	call   1034e0 <brelse>
        return -1;
  10284c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  102851:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  102855:	8b 74 24 24          	mov    0x24(%esp),%esi
  102859:	8b 7c 24 28          	mov    0x28(%esp),%edi
  10285d:	83 c4 2c             	add    $0x2c,%esp
  102860:	c3                   	ret    
  102861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
  102868:	8b 03                	mov    (%ebx),%eax
  10286a:	e8 a1 fd ff ff       	call   102610 <balloc>
  10286f:	89 44 b3 0c          	mov    %eax,0xc(%ebx,%esi,4)
  102873:	e9 66 ff ff ff       	jmp    1027de <bmap+0x2e>
    if((addr = a[bn]) == 0){
      if(!alloc){
        brelse(bp);
        return -1;
      }
      a[bn] = addr = balloc(ip->dev);
  102878:	8b 03                	mov    (%ebx),%eax
  10287a:	e8 91 fd ff ff       	call   102610 <balloc>
  10287f:	89 06                	mov    %eax,(%esi)
      bwrite(bp);
  102881:	89 3c 24             	mov    %edi,(%esp)
  102884:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  102888:	e8 23 0c 00 00       	call   1034b0 <bwrite>
  10288d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    }
    brelse(bp);
  102891:	89 3c 24             	mov    %edi,(%esp)
  102894:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  102898:	e8 43 0c 00 00       	call   1034e0 <brelse>
  10289d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1028a1:	e9 38 ff ff ff       	jmp    1027de <bmap+0x2e>
    return addr;
  }

  panic("bmap: out of range");
  1028a6:	c7 04 24 f5 61 10 00 	movl   $0x1061f5,(%esp)
  1028ad:	e8 fe e1 ff ff       	call   100ab0 <panic>
  1028b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1028b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001028c0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  1028c0:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache.lock");
  1028c3:	c7 44 24 04 08 62 10 	movl   $0x106208,0x4(%esp)
  1028ca:	00 
  1028cb:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  1028d2:	e8 a9 d8 ff ff       	call   100180 <initlock>
}
  1028d7:	83 c4 1c             	add    $0x1c,%esp
  1028da:	c3                   	ret    
  1028db:	90                   	nop
  1028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001028e0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  1028e0:	53                   	push   %ebx
  1028e1:	83 ec 18             	sub    $0x18,%esp
  1028e4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  acquire(&icache.lock);
  1028e8:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  1028ef:	e8 7c d9 ff ff       	call   100270 <acquire>
  ip->ref++;
  1028f4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  1028f8:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  1028ff:	e8 5c da ff ff       	call   100360 <release>
  return ip;
}
  102904:	83 c4 18             	add    $0x18,%esp
  102907:	89 d8                	mov    %ebx,%eax
  102909:	5b                   	pop    %ebx
  10290a:	c3                   	ret    
  10290b:	90                   	nop
  10290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102910 <ilock>:

// Lock the given inode.
void
ilock(struct inode *ip)
{
  102910:	56                   	push   %esi
  102911:	53                   	push   %ebx
  102912:	83 ec 14             	sub    $0x14,%esp
  102915:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  102919:	85 db                	test   %ebx,%ebx
  10291b:	0f 84 df 00 00 00    	je     102a00 <ilock+0xf0>
  102921:	8b 53 08             	mov    0x8(%ebx),%edx
  102924:	85 d2                	test   %edx,%edx
  102926:	0f 8e d4 00 00 00    	jle    102a00 <ilock+0xf0>
    panic("ilock");

  acquire(&icache.lock);
  10292c:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102933:	e8 38 d9 ff ff       	call   100270 <acquire>
  while(ip->flags & I_BUSY)
  102938:	8b 43 0c             	mov    0xc(%ebx),%eax
  10293b:	a8 01                	test   $0x1,%al
  10293d:	74 18                	je     102957 <ilock+0x47>
  10293f:	90                   	nop
    sleep(ip, &icache.lock);
  102940:	c7 44 24 04 20 e9 10 	movl   $0x10e920,0x4(%esp)
  102947:	00 
  102948:	89 1c 24             	mov    %ebx,(%esp)
  10294b:	e8 e0 ed ff ff       	call   101730 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  102950:	8b 43 0c             	mov    0xc(%ebx),%eax
  102953:	a8 01                	test   $0x1,%al
  102955:	75 e9                	jne    102940 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  102957:	83 c8 01             	or     $0x1,%eax
  10295a:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
  10295d:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102964:	e8 f7 d9 ff ff       	call   100360 <release>

  if(!(ip->flags & I_VALID)){
  102969:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  10296d:	74 09                	je     102978 <ilock+0x68>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  10296f:	83 c4 14             	add    $0x14,%esp
  102972:	5b                   	pop    %ebx
  102973:	5e                   	pop    %esi
  102974:	c3                   	ret    
  102975:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  102978:	8b 43 04             	mov    0x4(%ebx),%eax
  10297b:	c1 e8 03             	shr    $0x3,%eax
  10297e:	83 c0 02             	add    $0x2,%eax
  102981:	89 44 24 04          	mov    %eax,0x4(%esp)
  102985:	8b 03                	mov    (%ebx),%eax
  102987:	89 04 24             	mov    %eax,(%esp)
  10298a:	e8 41 0a 00 00       	call   1033d0 <bread>
  10298f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  102991:	8b 43 04             	mov    0x4(%ebx),%eax
  102994:	83 e0 07             	and    $0x7,%eax
  102997:	c1 e0 06             	shl    $0x6,%eax
  10299a:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
  10299e:	0f b7 10             	movzwl (%eax),%edx
  1029a1:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
  1029a5:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  1029a9:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
  1029ad:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  1029b1:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
  1029b5:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  1029b9:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
  1029bd:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1029c0:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  1029c3:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1029c6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1029ca:	8d 43 1c             	lea    0x1c(%ebx),%eax
  1029cd:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  1029d4:	00 
  1029d5:	89 04 24             	mov    %eax,(%esp)
  1029d8:	e8 c3 e4 ff ff       	call   100ea0 <memmove>
    brelse(bp);
  1029dd:	89 34 24             	mov    %esi,(%esp)
  1029e0:	e8 fb 0a 00 00       	call   1034e0 <brelse>
    ip->flags |= I_VALID;
  1029e5:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  1029e9:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  1029ee:	0f 85 7b ff ff ff    	jne    10296f <ilock+0x5f>
      panic("ilock: no type");
  1029f4:	c7 04 24 1a 62 10 00 	movl   $0x10621a,(%esp)
  1029fb:	e8 b0 e0 ff ff       	call   100ab0 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  102a00:	c7 04 24 14 62 10 00 	movl   $0x106214,(%esp)
  102a07:	e8 a4 e0 ff ff       	call   100ab0 <panic>
  102a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102a10 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  102a10:	53                   	push   %ebx
  102a11:	83 ec 18             	sub    $0x18,%esp
  102a14:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  102a18:	85 db                	test   %ebx,%ebx
  102a1a:	74 36                	je     102a52 <iunlock+0x42>
  102a1c:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  102a20:	74 30                	je     102a52 <iunlock+0x42>
  102a22:	8b 4b 08             	mov    0x8(%ebx),%ecx
  102a25:	85 c9                	test   %ecx,%ecx
  102a27:	7e 29                	jle    102a52 <iunlock+0x42>
    panic("iunlock");

  acquire(&icache.lock);
  102a29:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102a30:	e8 3b d8 ff ff       	call   100270 <acquire>
  ip->flags &= ~I_BUSY;
  102a35:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  102a39:	89 1c 24             	mov    %ebx,(%esp)
  102a3c:	e8 bf ed ff ff       	call   101800 <wakeup>
  release(&icache.lock);
  102a41:	c7 44 24 20 20 e9 10 	movl   $0x10e920,0x20(%esp)
  102a48:	00 
}
  102a49:	83 c4 18             	add    $0x18,%esp
  102a4c:	5b                   	pop    %ebx
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  102a4d:	e9 0e d9 ff ff       	jmp    100360 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  102a52:	c7 04 24 29 62 10 00 	movl   $0x106229,(%esp)
  102a59:	e8 52 e0 ff ff       	call   100ab0 <panic>
  102a5e:	66 90                	xchg   %ax,%ax

00102a60 <ialloc>:
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  102a60:	55                   	push   %ebp
  102a61:	57                   	push   %edi
  102a62:	56                   	push   %esi
  102a63:	53                   	push   %ebx
  102a64:	83 ec 3c             	sub    $0x3c,%esp
  102a67:	0f b7 44 24 54       	movzwl 0x54(%esp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  102a6c:	8d 54 24 24          	lea    0x24(%esp),%edx
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  102a70:	8b 5c 24 50          	mov    0x50(%esp),%ebx
  102a74:	66 89 44 24 1e       	mov    %ax,0x1e(%esp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  102a79:	89 d8                	mov    %ebx,%eax
  102a7b:	e8 40 fb ff ff       	call   1025c0 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  102a80:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
  102a85:	0f 86 91 00 00 00    	jbe    102b1c <ialloc+0xbc>
  102a8b:	bf 01 00 00 00       	mov    $0x1,%edi
  102a90:	be 01 00 00 00       	mov    $0x1,%esi
  102a95:	eb 14                	jmp    102aab <ialloc+0x4b>
  102a97:	90                   	nop
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  102a98:	89 2c 24             	mov    %ebp,(%esp)
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  102a9b:	83 c6 01             	add    $0x1,%esi
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  102a9e:	e8 3d 0a 00 00       	call   1034e0 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  102aa3:	89 f7                	mov    %esi,%edi
  102aa5:	3b 74 24 2c          	cmp    0x2c(%esp),%esi
  102aa9:	73 71                	jae    102b1c <ialloc+0xbc>
    bp = bread(dev, IBLOCK(inum));
  102aab:	89 f8                	mov    %edi,%eax
  102aad:	c1 e8 03             	shr    $0x3,%eax
  102ab0:	83 c0 02             	add    $0x2,%eax
  102ab3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ab7:	89 1c 24             	mov    %ebx,(%esp)
  102aba:	e8 11 09 00 00       	call   1033d0 <bread>
  102abf:	89 c5                	mov    %eax,%ebp
    dip = (struct dinode*)bp->data + inum%IPB;
  102ac1:	89 f8                	mov    %edi,%eax
  102ac3:	83 e0 07             	and    $0x7,%eax
  102ac6:	c1 e0 06             	shl    $0x6,%eax
  102ac9:	8d 54 05 18          	lea    0x18(%ebp,%eax,1),%edx
    if(dip->type == 0){  // a free inode
  102acd:	66 83 3a 00          	cmpw   $0x0,(%edx)
  102ad1:	75 c5                	jne    102a98 <ialloc+0x38>
      memset(dip, 0, sizeof(*dip));
  102ad3:	89 14 24             	mov    %edx,(%esp)
  102ad6:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  102add:	00 
  102ade:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  102ae5:	00 
  102ae6:	89 54 24 18          	mov    %edx,0x18(%esp)
  102aea:	e8 21 e3 ff ff       	call   100e10 <memset>
      dip->type = type;
  102aef:	8b 54 24 18          	mov    0x18(%esp),%edx
  102af3:	0f b7 44 24 1e       	movzwl 0x1e(%esp),%eax
  102af8:	66 89 02             	mov    %ax,(%edx)
      bwrite(bp);   // mark it allocated on the disk
  102afb:	89 2c 24             	mov    %ebp,(%esp)
  102afe:	e8 ad 09 00 00       	call   1034b0 <bwrite>
      brelse(bp);
  102b03:	89 2c 24             	mov    %ebp,(%esp)
  102b06:	e8 d5 09 00 00       	call   1034e0 <brelse>
      return iget(dev, inum);
  102b0b:	89 fa                	mov    %edi,%edx
  102b0d:	89 d8                	mov    %ebx,%eax
  102b0f:	e8 fc f9 ff ff       	call   102510 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  102b14:	83 c4 3c             	add    $0x3c,%esp
  102b17:	5b                   	pop    %ebx
  102b18:	5e                   	pop    %esi
  102b19:	5f                   	pop    %edi
  102b1a:	5d                   	pop    %ebp
  102b1b:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  102b1c:	c7 04 24 31 62 10 00 	movl   $0x106231,(%esp)
  102b23:	e8 88 df ff ff       	call   100ab0 <panic>
  102b28:	90                   	nop
  102b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102b30 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  102b30:	56                   	push   %esi
  102b31:	53                   	push   %ebx
  102b32:	83 ec 14             	sub    $0x14,%esp
  102b35:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  102b39:	8b 43 04             	mov    0x4(%ebx),%eax
  102b3c:	c1 e8 03             	shr    $0x3,%eax
  102b3f:	83 c0 02             	add    $0x2,%eax
  102b42:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b46:	8b 03                	mov    (%ebx),%eax
  102b48:	89 04 24             	mov    %eax,(%esp)
  102b4b:	e8 80 08 00 00       	call   1033d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  102b50:	0f b7 53 10          	movzwl 0x10(%ebx),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  102b54:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  102b56:	8b 43 04             	mov    0x4(%ebx),%eax
  102b59:	83 e0 07             	and    $0x7,%eax
  102b5c:	c1 e0 06             	shl    $0x6,%eax
  102b5f:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
  102b63:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  102b66:	0f b7 53 12          	movzwl 0x12(%ebx),%edx
  102b6a:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
  102b6e:	0f b7 53 14          	movzwl 0x14(%ebx),%edx
  102b72:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
  102b76:	0f b7 53 16          	movzwl 0x16(%ebx),%edx
  102b7a:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
  102b7e:	8b 53 18             	mov    0x18(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  102b81:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  102b84:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  102b87:	83 c0 0c             	add    $0xc,%eax
  102b8a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102b8e:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  102b95:	00 
  102b96:	89 04 24             	mov    %eax,(%esp)
  102b99:	e8 02 e3 ff ff       	call   100ea0 <memmove>
  bwrite(bp);
  102b9e:	89 34 24             	mov    %esi,(%esp)
  102ba1:	e8 0a 09 00 00       	call   1034b0 <bwrite>
  brelse(bp);
  102ba6:	89 74 24 20          	mov    %esi,0x20(%esp)
}
  102baa:	83 c4 14             	add    $0x14,%esp
  102bad:	5b                   	pop    %ebx
  102bae:	5e                   	pop    %esi
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  102baf:	e9 2c 09 00 00       	jmp    1034e0 <brelse>
  102bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102bc0 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  102bc0:	55                   	push   %ebp
  102bc1:	57                   	push   %edi
  102bc2:	56                   	push   %esi
  102bc3:	53                   	push   %ebx
  102bc4:	83 ec 1c             	sub    $0x1c,%esp
  102bc7:	8b 74 24 30          	mov    0x30(%esp),%esi
  acquire(&icache.lock);
  102bcb:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102bd2:	e8 99 d6 ff ff       	call   100270 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  102bd7:	8b 46 08             	mov    0x8(%esi),%eax
  102bda:	83 f8 01             	cmp    $0x1,%eax
  102bdd:	0f 85 9f 00 00 00    	jne    102c82 <iput+0xc2>
  102be3:	8b 56 0c             	mov    0xc(%esi),%edx
  102be6:	f6 c2 02             	test   $0x2,%dl
  102be9:	0f 84 93 00 00 00    	je     102c82 <iput+0xc2>
  102bef:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  102bf4:	0f 85 88 00 00 00    	jne    102c82 <iput+0xc2>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  102bfa:	f6 c2 01             	test   $0x1,%dl
  102bfd:	0f 85 ee 00 00 00    	jne    102cf1 <iput+0x131>
      panic("iput busy");
    ip->flags |= I_BUSY;
  102c03:	83 ca 01             	or     $0x1,%edx
    release(&icache.lock);
  102c06:	89 f3                	mov    %esi,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  102c08:	89 56 0c             	mov    %edx,0xc(%esi)
  release(&icache.lock);
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
  102c0b:	8d 7e 30             	lea    0x30(%esi),%edi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
  102c0e:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102c15:	e8 46 d7 ff ff       	call   100360 <release>
  102c1a:	eb 0b                	jmp    102c27 <iput+0x67>
  102c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
  102c20:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  102c23:	39 fb                	cmp    %edi,%ebx
  102c25:	74 1c                	je     102c43 <iput+0x83>
    if(ip->addrs[i]){
  102c27:	8b 53 1c             	mov    0x1c(%ebx),%edx
  102c2a:	85 d2                	test   %edx,%edx
  102c2c:	74 f2                	je     102c20 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
  102c2e:	8b 06                	mov    (%esi),%eax
  102c30:	e8 bb fa ff ff       	call   1026f0 <bfree>
      ip->addrs[i] = 0;
  102c35:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  102c3c:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  102c3f:	39 fb                	cmp    %edi,%ebx
  102c41:	75 e4                	jne    102c27 <iput+0x67>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[INDIRECT]){
  102c43:	8b 46 4c             	mov    0x4c(%esi),%eax
  102c46:	85 c0                	test   %eax,%eax
  102c48:	75 56                	jne    102ca0 <iput+0xe0>
    }
    brelse(bp);
    ip->addrs[INDIRECT] = 0;
  }

  ip->size = 0;
  102c4a:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  102c51:	89 34 24             	mov    %esi,(%esp)
  102c54:	e8 d7 fe ff ff       	call   102b30 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  102c59:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  102c5f:	89 34 24             	mov    %esi,(%esp)
  102c62:	e8 c9 fe ff ff       	call   102b30 <iupdate>
    acquire(&icache.lock);
  102c67:	c7 04 24 20 e9 10 00 	movl   $0x10e920,(%esp)
  102c6e:	e8 fd d5 ff ff       	call   100270 <acquire>
    ip->flags &= ~I_BUSY;
  102c73:	83 66 0c fe          	andl   $0xfffffffe,0xc(%esi)
    wakeup(ip);
  102c77:	89 34 24             	mov    %esi,(%esp)
  102c7a:	e8 81 eb ff ff       	call   101800 <wakeup>
  102c7f:	8b 46 08             	mov    0x8(%esi),%eax
  }
  ip->ref--;
  102c82:	83 e8 01             	sub    $0x1,%eax
  102c85:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  102c88:	c7 44 24 30 20 e9 10 	movl   $0x10e920,0x30(%esp)
  102c8f:	00 
}
  102c90:	83 c4 1c             	add    $0x1c,%esp
  102c93:	5b                   	pop    %ebx
  102c94:	5e                   	pop    %esi
  102c95:	5f                   	pop    %edi
  102c96:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags &= ~I_BUSY;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  102c97:	e9 c4 d6 ff ff       	jmp    100360 <release>
  102c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  102ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ca4:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
  102ca6:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  102ca8:	89 04 24             	mov    %eax,(%esp)
  102cab:	e8 20 07 00 00       	call   1033d0 <bread>
  102cb0:	89 c5                	mov    %eax,%ebp
    a = (uint*)bp->data;
  102cb2:	8d 78 18             	lea    0x18(%eax),%edi
    for(j = 0; j < NINDIRECT; j++){
  102cb5:	31 c0                	xor    %eax,%eax
  102cb7:	eb 14                	jmp    102ccd <iput+0x10d>
  102cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102cc0:	83 c3 01             	add    $0x1,%ebx
  102cc3:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  102cc9:	89 d8                	mov    %ebx,%eax
  102ccb:	74 10                	je     102cdd <iput+0x11d>
      if(a[j])
  102ccd:	8b 14 87             	mov    (%edi,%eax,4),%edx
  102cd0:	85 d2                	test   %edx,%edx
  102cd2:	74 ec                	je     102cc0 <iput+0x100>
        bfree(ip->dev, a[j]);
  102cd4:	8b 06                	mov    (%esi),%eax
  102cd6:	e8 15 fa ff ff       	call   1026f0 <bfree>
  102cdb:	eb e3                	jmp    102cc0 <iput+0x100>
    }
    brelse(bp);
  102cdd:	89 2c 24             	mov    %ebp,(%esp)
  102ce0:	e8 fb 07 00 00       	call   1034e0 <brelse>
    ip->addrs[INDIRECT] = 0;
  102ce5:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  102cec:	e9 59 ff ff ff       	jmp    102c4a <iput+0x8a>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  102cf1:	c7 04 24 43 62 10 00 	movl   $0x106243,(%esp)
  102cf8:	e8 b3 dd ff ff       	call   100ab0 <panic>
  102cfd:	8d 76 00             	lea    0x0(%esi),%esi

00102d00 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  102d00:	53                   	push   %ebx
  102d01:	83 ec 18             	sub    $0x18,%esp
  102d04:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  iunlock(ip);
  102d08:	89 1c 24             	mov    %ebx,(%esp)
  102d0b:	e8 00 fd ff ff       	call   102a10 <iunlock>
  iput(ip);
  102d10:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  102d14:	83 c4 18             	add    $0x18,%esp
  102d17:	5b                   	pop    %ebx
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  102d18:	e9 a3 fe ff ff       	jmp    102bc0 <iput>
  102d1d:	8d 76 00             	lea    0x0(%esi),%esi

00102d20 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  102d20:	8b 54 24 04          	mov    0x4(%esp),%edx
  102d24:	8b 44 24 08          	mov    0x8(%esp),%eax
  st->dev = ip->dev;
  102d28:	8b 0a                	mov    (%edx),%ecx
  102d2a:	89 08                	mov    %ecx,(%eax)
  st->ino = ip->inum;
  102d2c:	8b 4a 04             	mov    0x4(%edx),%ecx
  102d2f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->type = ip->type;
  102d32:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  102d36:	66 89 48 08          	mov    %cx,0x8(%eax)
  st->nlink = ip->nlink;
  102d3a:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  st->size = ip->size;
  102d3e:	8b 52 18             	mov    0x18(%edx),%edx
stati(struct inode *ip, struct stat *st)
{
  st->dev = ip->dev;
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  102d41:	66 89 48 0a          	mov    %cx,0xa(%eax)
  st->size = ip->size;
  102d45:	89 50 0c             	mov    %edx,0xc(%eax)
}
  102d48:	c3                   	ret    
  102d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102d50 <readi>:

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  102d50:	55                   	push   %ebp
  102d51:	57                   	push   %edi
  102d52:	56                   	push   %esi
  102d53:	53                   	push   %ebx
  102d54:	83 ec 2c             	sub    $0x2c,%esp
  102d57:	8b 74 24 40          	mov    0x40(%esp),%esi
  102d5b:	8b 44 24 44          	mov    0x44(%esp),%eax
  102d5f:	8b 54 24 4c          	mov    0x4c(%esp),%edx
  102d63:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  102d67:	66 83 7e 10 03       	cmpw   $0x3,0x10(%esi)
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  102d6c:	89 44 24 18          	mov    %eax,0x18(%esp)
  102d70:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  102d74:	0f 84 b6 00 00 00    	je     102e30 <readi+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  102d7a:	8b 56 18             	mov    0x18(%esi),%edx
    return -1;
  102d7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  102d82:	39 da                	cmp    %ebx,%edx
  102d84:	0f 82 97 00 00 00    	jb     102e21 <readi+0xd1>
  102d8a:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  102d8e:	01 d9                	add    %ebx,%ecx
  102d90:	0f 82 8b 00 00 00    	jb     102e21 <readi+0xd1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  102d96:	89 d0                	mov    %edx,%eax
  102d98:	29 d8                	sub    %ebx,%eax
  102d9a:	39 ca                	cmp    %ecx,%edx
  102d9c:	0f 43 44 24 1c       	cmovae 0x1c(%esp),%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  102da1:	85 c0                	test   %eax,%eax
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  102da3:	89 44 24 1c          	mov    %eax,0x1c(%esp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  102da7:	74 74                	je     102e1d <readi+0xcd>
  102da9:	31 ff                	xor    %edi,%edi
  102dab:	90                   	nop
  102dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  102db0:	89 da                	mov    %ebx,%edx
  102db2:	31 c9                	xor    %ecx,%ecx
  102db4:	c1 ea 09             	shr    $0x9,%edx
  102db7:	89 f0                	mov    %esi,%eax
  102db9:	e8 f2 f9 ff ff       	call   1027b0 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  102dbe:	bd 00 02 00 00       	mov    $0x200,%ebp
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  102dc3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dc7:	8b 06                	mov    (%esi),%eax
  102dc9:	89 04 24             	mov    %eax,(%esp)
  102dcc:	e8 ff 05 00 00       	call   1033d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  102dd1:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  102dd5:	29 f9                	sub    %edi,%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  102dd7:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  102dd9:	89 d8                	mov    %ebx,%eax
  102ddb:	25 ff 01 00 00       	and    $0x1ff,%eax
  102de0:	29 c5                	sub    %eax,%ebp
    memmove(dst, bp->data + off%BSIZE, m);
  102de2:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
  102de6:	39 cd                	cmp    %ecx,%ebp
    memmove(dst, bp->data + off%BSIZE, m);
  102de8:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dec:	8b 44 24 18          	mov    0x18(%esp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
  102df0:	0f 47 e9             	cmova  %ecx,%ebp
    memmove(dst, bp->data + off%BSIZE, m);
  102df3:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  102df7:	01 ef                	add    %ebp,%edi
  102df9:	01 eb                	add    %ebp,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  102dfb:	89 54 24 14          	mov    %edx,0x14(%esp)
  102dff:	89 04 24             	mov    %eax,(%esp)
  102e02:	e8 99 e0 ff ff       	call   100ea0 <memmove>
    brelse(bp);
  102e07:	8b 54 24 14          	mov    0x14(%esp),%edx
  102e0b:	89 14 24             	mov    %edx,(%esp)
  102e0e:	e8 cd 06 00 00       	call   1034e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  102e13:	01 6c 24 18          	add    %ebp,0x18(%esp)
  102e17:	39 7c 24 1c          	cmp    %edi,0x1c(%esp)
  102e1b:	77 93                	ja     102db0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  102e1d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
}
  102e21:	83 c4 2c             	add    $0x2c,%esp
  102e24:	5b                   	pop    %ebx
  102e25:	5e                   	pop    %esi
  102e26:	5f                   	pop    %edi
  102e27:	5d                   	pop    %ebp
  102e28:	c3                   	ret    
  102e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  102e30:	0f b7 46 12          	movzwl 0x12(%esi),%eax
  102e34:	66 83 f8 0f          	cmp    $0xf,%ax
  102e38:	77 19                	ja     102e53 <readi+0x103>
  102e3a:	98                   	cwtl   
  102e3b:	8b 04 c5 a0 e8 10 00 	mov    0x10e8a0(,%eax,8),%eax
  102e42:	85 c0                	test   %eax,%eax
  102e44:	74 0d                	je     102e53 <readi+0x103>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  102e46:	89 54 24 48          	mov    %edx,0x48(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  102e4a:	83 c4 2c             	add    $0x2c,%esp
  102e4d:	5b                   	pop    %ebx
  102e4e:	5e                   	pop    %esi
  102e4f:	5f                   	pop    %edi
  102e50:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  102e51:	ff e0                	jmp    *%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
  102e53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102e58:	eb c7                	jmp    102e21 <readi+0xd1>
  102e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102e60 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  102e60:	55                   	push   %ebp
  102e61:	57                   	push   %edi
  102e62:	56                   	push   %esi
  102e63:	53                   	push   %ebx
  102e64:	83 ec 2c             	sub    $0x2c,%esp
  102e67:	8b 74 24 40          	mov    0x40(%esp),%esi
  102e6b:	8b 44 24 44          	mov    0x44(%esp),%eax
  102e6f:	8b 54 24 4c          	mov    0x4c(%esp),%edx
  102e73:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  102e77:	66 83 7e 10 03       	cmpw   $0x3,0x10(%esi)
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  102e7c:	89 44 24 18          	mov    %eax,0x18(%esp)
  102e80:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  102e84:	0f 84 d6 00 00 00    	je     102f60 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off + n < off)
  102e8a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    return -1;
  102e8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off + n < off)
  102e93:	01 da                	add    %ebx,%edx
  102e95:	0f 82 a2 00 00 00    	jb     102f3d <writei+0xdd>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  102e9b:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
  102ea1:	0f 87 a1 00 00 00    	ja     102f48 <writei+0xe8>
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  102ea7:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  102eab:	85 ff                	test   %edi,%edi
  102ead:	0f 84 86 00 00 00    	je     102f39 <writei+0xd9>
  102eb3:	31 ff                	xor    %edi,%edi
  102eb5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  102eb8:	89 da                	mov    %ebx,%edx
  102eba:	b9 01 00 00 00       	mov    $0x1,%ecx
  102ebf:	c1 ea 09             	shr    $0x9,%edx
  102ec2:	89 f0                	mov    %esi,%eax
  102ec4:	e8 e7 f8 ff ff       	call   1027b0 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  102ec9:	bd 00 02 00 00       	mov    $0x200,%ebp
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  102ece:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ed2:	8b 06                	mov    (%esi),%eax
  102ed4:	89 04 24             	mov    %eax,(%esp)
  102ed7:	e8 f4 04 00 00       	call   1033d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  102edc:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  102ee0:	29 f9                	sub    %edi,%ecx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  102ee2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  102ee4:	89 d8                	mov    %ebx,%eax
  102ee6:	25 ff 01 00 00       	and    $0x1ff,%eax
  102eeb:	29 c5                	sub    %eax,%ebp
  102eed:	39 cd                	cmp    %ecx,%ebp
  102eef:	0f 47 e9             	cmova  %ecx,%ebp
    memmove(bp->data + off%BSIZE, src, m);
  102ef2:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  102ef6:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  102efa:	01 ef                	add    %ebp,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  102efc:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  102f00:	01 eb                	add    %ebp,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  102f02:	89 04 24             	mov    %eax,(%esp)
  102f05:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  102f09:	89 54 24 14          	mov    %edx,0x14(%esp)
  102f0d:	e8 8e df ff ff       	call   100ea0 <memmove>
    bwrite(bp);
  102f12:	8b 54 24 14          	mov    0x14(%esp),%edx
  102f16:	89 14 24             	mov    %edx,(%esp)
  102f19:	e8 92 05 00 00       	call   1034b0 <bwrite>
    brelse(bp);
  102f1e:	8b 54 24 14          	mov    0x14(%esp),%edx
  102f22:	89 14 24             	mov    %edx,(%esp)
  102f25:	e8 b6 05 00 00       	call   1034e0 <brelse>
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  102f2a:	01 6c 24 18          	add    %ebp,0x18(%esp)
  102f2e:	39 7c 24 1c          	cmp    %edi,0x1c(%esp)
  102f32:	77 84                	ja     102eb8 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  102f34:	39 5e 18             	cmp    %ebx,0x18(%esi)
  102f37:	72 4f                	jb     102f88 <writei+0x128>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  102f39:	8b 44 24 1c          	mov    0x1c(%esp),%eax
}
  102f3d:	83 c4 2c             	add    $0x2c,%esp
  102f40:	5b                   	pop    %ebx
  102f41:	5e                   	pop    %esi
  102f42:	5f                   	pop    %edi
  102f43:	5d                   	pop    %ebp
  102f44:	c3                   	ret    
  102f45:	8d 76 00             	lea    0x0(%esi),%esi
  }

  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;
  102f48:	c7 44 24 1c 00 18 01 	movl   $0x11800,0x1c(%esp)
  102f4f:	00 
  102f50:	29 5c 24 1c          	sub    %ebx,0x1c(%esp)
  102f54:	e9 4e ff ff ff       	jmp    102ea7 <writei+0x47>
  102f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  102f60:	0f b7 46 12          	movzwl 0x12(%esi),%eax
  102f64:	66 83 f8 0f          	cmp    $0xf,%ax
  102f68:	77 2b                	ja     102f95 <writei+0x135>
  102f6a:	98                   	cwtl   
  102f6b:	8b 04 c5 a4 e8 10 00 	mov    0x10e8a4(,%eax,8),%eax
  102f72:	85 c0                	test   %eax,%eax
  102f74:	74 1f                	je     102f95 <writei+0x135>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  102f76:	89 54 24 48          	mov    %edx,0x48(%esp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  102f7a:	83 c4 2c             	add    $0x2c,%esp
  102f7d:	5b                   	pop    %ebx
  102f7e:	5e                   	pop    %esi
  102f7f:	5f                   	pop    %edi
  102f80:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  102f81:	ff e0                	jmp    *%eax
  102f83:	90                   	nop
  102f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  102f88:	89 5e 18             	mov    %ebx,0x18(%esi)
    iupdate(ip);
  102f8b:	89 34 24             	mov    %esi,(%esp)
  102f8e:	e8 9d fb ff ff       	call   102b30 <iupdate>
  102f93:	eb a4                	jmp    102f39 <writei+0xd9>
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
  102f95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102f9a:	eb a1                	jmp    102f3d <writei+0xdd>
  102f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102fa0 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  102fa0:	83 ec 1c             	sub    $0x1c,%esp
  return strncmp(s, t, DIRSIZ);
  102fa3:	8b 44 24 24          	mov    0x24(%esp),%eax
  102fa7:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  102fae:	00 
  102faf:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fb3:	8b 44 24 20          	mov    0x20(%esp),%eax
  102fb7:	89 04 24             	mov    %eax,(%esp)
  102fba:	e8 51 df ff ff       	call   100f10 <strncmp>
}
  102fbf:	83 c4 1c             	add    $0x1c,%esp
  102fc2:	c3                   	ret    
  102fc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102fd0 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  102fd0:	55                   	push   %ebp
  102fd1:	57                   	push   %edi
  102fd2:	56                   	push   %esi
  102fd3:	53                   	push   %ebx
  102fd4:	83 ec 2c             	sub    $0x2c,%esp
  102fd7:	8b 74 24 40          	mov    0x40(%esp),%esi
  102fdb:	8b 44 24 48          	mov    0x48(%esp),%eax
  102fdf:	8b 5c 24 44          	mov    0x44(%esp),%ebx
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  102fe3:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  102fe8:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  102fec:	0f 85 d1 00 00 00    	jne    1030c3 <dirlookup+0xf3>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  102ff2:	8b 46 18             	mov    0x18(%esi),%eax
  102ff5:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  102ffc:	00 
  102ffd:	85 c0                	test   %eax,%eax
  102fff:	0f 84 b4 00 00 00    	je     1030b9 <dirlookup+0xe9>
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
  103005:	8b 54 24 14          	mov    0x14(%esp),%edx
  103009:	31 c9                	xor    %ecx,%ecx
  10300b:	89 f0                	mov    %esi,%eax
  10300d:	c1 ea 09             	shr    $0x9,%edx
  103010:	e8 9b f7 ff ff       	call   1027b0 <bmap>
  103015:	89 44 24 04          	mov    %eax,0x4(%esp)
  103019:	8b 06                	mov    (%esi),%eax
  10301b:	89 04 24             	mov    %eax,(%esp)
  10301e:	e8 ad 03 00 00       	call   1033d0 <bread>
  103023:	89 44 24 10          	mov    %eax,0x10(%esp)
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
  103027:	8b 6c 24 10          	mov    0x10(%esp),%ebp
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
  10302b:	83 c0 18             	add    $0x18,%eax
  10302e:	89 44 24 18          	mov    %eax,0x18(%esp)
  103032:	89 c7                	mov    %eax,%edi
        de < (struct dirent*)(bp->data + BSIZE);
  103034:	81 c5 18 02 00 00    	add    $0x218,%ebp
  10303a:	eb 0b                	jmp    103047 <dirlookup+0x77>
  10303c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        de++){
  103040:	83 c7 10             	add    $0x10,%edi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
  103043:	39 ef                	cmp    %ebp,%edi
  103045:	73 51                	jae    103098 <dirlookup+0xc8>
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
  103047:	66 83 3f 00          	cmpw   $0x0,(%edi)
  10304b:	74 f3                	je     103040 <dirlookup+0x70>
        continue;
      if(namecmp(name, de->name) == 0){
  10304d:	8d 47 02             	lea    0x2(%edi),%eax
  103050:	89 44 24 04          	mov    %eax,0x4(%esp)
  103054:	89 1c 24             	mov    %ebx,(%esp)
  103057:	e8 44 ff ff ff       	call   102fa0 <namecmp>
  10305c:	85 c0                	test   %eax,%eax
  10305e:	75 e0                	jne    103040 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  103060:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
  103064:	85 ed                	test   %ebp,%ebp
  103066:	74 10                	je     103078 <dirlookup+0xa8>
          *poff = off + (uchar*)de - bp->data;
  103068:	8b 44 24 14          	mov    0x14(%esp),%eax
  10306c:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  103070:	01 f8                	add    %edi,%eax
  103072:	2b 44 24 18          	sub    0x18(%esp),%eax
  103076:	89 02                	mov    %eax,(%edx)
        inum = de->inum;
        brelse(bp);
  103078:	8b 44 24 10          	mov    0x10(%esp),%eax
        continue;
      if(namecmp(name, de->name) == 0){
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
  10307c:	0f b7 1f             	movzwl (%edi),%ebx
        brelse(bp);
  10307f:	89 04 24             	mov    %eax,(%esp)
  103082:	e8 59 04 00 00       	call   1034e0 <brelse>
        return iget(dp->dev, inum);
  103087:	8b 06                	mov    (%esi),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  103089:	83 c4 2c             	add    $0x2c,%esp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  10308c:	89 da                	mov    %ebx,%edx
      }
    }
    brelse(bp);
  }
  return 0;
}
  10308e:	5b                   	pop    %ebx
  10308f:	5e                   	pop    %esi
  103090:	5f                   	pop    %edi
  103091:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  103092:	e9 79 f4 ff ff       	jmp    102510 <iget>
  103097:	90                   	nop
      }
    }
    brelse(bp);
  103098:	8b 44 24 10          	mov    0x10(%esp),%eax
  10309c:	89 04 24             	mov    %eax,(%esp)
  10309f:	e8 3c 04 00 00       	call   1034e0 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  1030a4:	81 44 24 14 00 02 00 	addl   $0x200,0x14(%esp)
  1030ab:	00 
  1030ac:	8b 54 24 14          	mov    0x14(%esp),%edx
  1030b0:	39 56 18             	cmp    %edx,0x18(%esi)
  1030b3:	0f 87 4c ff ff ff    	ja     103005 <dirlookup+0x35>
      }
    }
    brelse(bp);
  }
  return 0;
}
  1030b9:	83 c4 2c             	add    $0x2c,%esp
  1030bc:	31 c0                	xor    %eax,%eax
  1030be:	5b                   	pop    %ebx
  1030bf:	5e                   	pop    %esi
  1030c0:	5f                   	pop    %edi
  1030c1:	5d                   	pop    %ebp
  1030c2:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  1030c3:	c7 04 24 4d 62 10 00 	movl   $0x10624d,(%esp)
  1030ca:	e8 e1 d9 ff ff       	call   100ab0 <panic>
  1030cf:	90                   	nop

001030d0 <_namei>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
_namei(char *path, int parent, char *name)
{
  1030d0:	55                   	push   %ebp
  1030d1:	57                   	push   %edi
  1030d2:	56                   	push   %esi
  1030d3:	89 ce                	mov    %ecx,%esi
  1030d5:	53                   	push   %ebx
  1030d6:	89 c3                	mov    %eax,%ebx
  1030d8:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
  1030db:	80 38 2f             	cmpb   $0x2f,(%eax)
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
_namei(char *path, int parent, char *name)
{
  1030de:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  struct inode *ip, *next;

  if(*path == '/')
  1030e2:	0f 84 0b 01 00 00    	je     1031f3 <_namei+0x123>
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);
  1030e8:	e8 a3 e3 ff ff       	call   101490 <curproc>
  1030ed:	8b 40 60             	mov    0x60(%eax),%eax
  1030f0:	89 04 24             	mov    %eax,(%esp)
  1030f3:	e8 e8 f7 ff ff       	call   1028e0 <idup>
  1030f8:	89 c5                	mov    %eax,%ebp
  1030fa:	eb 07                	jmp    103103 <_namei+0x33>
  1030fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  103100:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  103103:	0f b6 03             	movzbl (%ebx),%eax
  103106:	3c 2f                	cmp    $0x2f,%al
  103108:	74 f6                	je     103100 <_namei+0x30>
    path++;
  if(*path == 0)
  10310a:	84 c0                	test   %al,%al
  10310c:	75 1a                	jne    103128 <_namei+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
  10310e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  103112:	85 c0                	test   %eax,%eax
  103114:	0f 85 26 01 00 00    	jne    103240 <_namei+0x170>
    iput(ip);
    return 0;
  }
  return ip;
}
  10311a:	83 c4 2c             	add    $0x2c,%esp
  10311d:	89 e8                	mov    %ebp,%eax
  10311f:	5b                   	pop    %ebx
  103120:	5e                   	pop    %esi
  103121:	5f                   	pop    %edi
  103122:	5d                   	pop    %ebp
  103123:	c3                   	ret    
  103124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  103128:	0f b6 03             	movzbl (%ebx),%eax
  10312b:	89 df                	mov    %ebx,%edi
  10312d:	84 c0                	test   %al,%al
  10312f:	0f 84 98 00 00 00    	je     1031cd <_namei+0xfd>
  103135:	3c 2f                	cmp    $0x2f,%al
  103137:	75 0b                	jne    103144 <_namei+0x74>
  103139:	e9 8f 00 00 00       	jmp    1031cd <_namei+0xfd>
  10313e:	66 90                	xchg   %ax,%ax
  103140:	3c 2f                	cmp    $0x2f,%al
  103142:	74 0a                	je     10314e <_namei+0x7e>
    path++;
  103144:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  103147:	0f b6 07             	movzbl (%edi),%eax
  10314a:	84 c0                	test   %al,%al
  10314c:	75 f2                	jne    103140 <_namei+0x70>
  10314e:	89 fa                	mov    %edi,%edx
  103150:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
  103152:	83 fa 0d             	cmp    $0xd,%edx
  103155:	7e 79                	jle    1031d0 <_namei+0x100>
    memmove(name, s, DIRSIZ);
  103157:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  10315b:	89 fb                	mov    %edi,%ebx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  10315d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  103164:	00 
  103165:	89 34 24             	mov    %esi,(%esp)
  103168:	e8 33 dd ff ff       	call   100ea0 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  10316d:	80 3f 2f             	cmpb   $0x2f,(%edi)
  103170:	75 0e                	jne    103180 <_namei+0xb0>
  103172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
  103178:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  10317b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  10317e:	74 f8                	je     103178 <_namei+0xa8>
  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
  103180:	85 db                	test   %ebx,%ebx
  103182:	74 8a                	je     10310e <_namei+0x3e>
    ilock(ip);
  103184:	89 2c 24             	mov    %ebp,(%esp)
  103187:	e8 84 f7 ff ff       	call   102910 <ilock>
    if(ip->type != T_DIR){
  10318c:	66 83 7d 10 01       	cmpw   $0x1,0x10(%ebp)
  103191:	75 76                	jne    103209 <_namei+0x139>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
  103193:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  103197:	85 c0                	test   %eax,%eax
  103199:	74 09                	je     1031a4 <_namei+0xd4>
  10319b:	80 3b 00             	cmpb   $0x0,(%ebx)
  10319e:	0f 84 8a 00 00 00    	je     10322e <_namei+0x15e>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  1031a4:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1031ab:	00 
  1031ac:	89 74 24 04          	mov    %esi,0x4(%esp)
  1031b0:	89 2c 24             	mov    %ebp,(%esp)
  1031b3:	e8 18 fe ff ff       	call   102fd0 <dirlookup>
      iunlockput(ip);
  1031b8:	89 2c 24             	mov    %ebp,(%esp)
    if(parent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  1031bb:	85 c0                	test   %eax,%eax
  1031bd:	89 c7                	mov    %eax,%edi
  1031bf:	74 5c                	je     10321d <_namei+0x14d>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  1031c1:	e8 3a fb ff ff       	call   102d00 <iunlockput>
    ip = next;
  1031c6:	89 fd                	mov    %edi,%ebp
  1031c8:	e9 36 ff ff ff       	jmp    103103 <_namei+0x33>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  1031cd:	31 d2                	xor    %edx,%edx
  1031cf:	90                   	nop
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  1031d0:	89 54 24 08          	mov    %edx,0x8(%esp)
  1031d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    name[len] = 0;
  1031d8:	89 fb                	mov    %edi,%ebx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  1031da:	89 34 24             	mov    %esi,(%esp)
  1031dd:	89 54 24 18          	mov    %edx,0x18(%esp)
  1031e1:	e8 ba dc ff ff       	call   100ea0 <memmove>
    name[len] = 0;
  1031e6:	8b 54 24 18          	mov    0x18(%esp),%edx
  1031ea:	c6 04 16 00          	movb   $0x0,(%esi,%edx,1)
  1031ee:	e9 7a ff ff ff       	jmp    10316d <_namei+0x9d>
_namei(char *path, int parent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  1031f3:	ba 01 00 00 00       	mov    $0x1,%edx
  1031f8:	b8 01 00 00 00       	mov    $0x1,%eax
  1031fd:	e8 0e f3 ff ff       	call   102510 <iget>
  103202:	89 c5                	mov    %eax,%ebp
  103204:	e9 fa fe ff ff       	jmp    103103 <_namei+0x33>
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
      iunlockput(ip);
  103209:	89 2c 24             	mov    %ebp,(%esp)
      return 0;
  10320c:	31 ed                	xor    %ebp,%ebp
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
      iunlockput(ip);
  10320e:	e8 ed fa ff ff       	call   102d00 <iunlockput>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  103213:	83 c4 2c             	add    $0x2c,%esp
  103216:	89 e8                	mov    %ebp,%eax
  103218:	5b                   	pop    %ebx
  103219:	5e                   	pop    %esi
  10321a:	5f                   	pop    %edi
  10321b:	5d                   	pop    %ebp
  10321c:	c3                   	ret    
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  10321d:	e8 de fa ff ff       	call   102d00 <iunlockput>
      return 0;
  103222:	31 ed                	xor    %ebp,%ebp
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  103224:	83 c4 2c             	add    $0x2c,%esp
  103227:	5b                   	pop    %ebx
  103228:	89 e8                	mov    %ebp,%eax
  10322a:	5e                   	pop    %esi
  10322b:	5f                   	pop    %edi
  10322c:	5d                   	pop    %ebp
  10322d:	c3                   	ret    
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  10322e:	89 2c 24             	mov    %ebp,(%esp)
  103231:	e8 da f7 ff ff       	call   102a10 <iunlock>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  103236:	83 c4 2c             	add    $0x2c,%esp
  103239:	89 e8                	mov    %ebp,%eax
  10323b:	5b                   	pop    %ebx
  10323c:	5e                   	pop    %esi
  10323d:	5f                   	pop    %edi
  10323e:	5d                   	pop    %ebp
  10323f:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  103240:	89 2c 24             	mov    %ebp,(%esp)
    return 0;
  103243:	31 ed                	xor    %ebp,%ebp
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  103245:	e8 76 f9 ff ff       	call   102bc0 <iput>
    return 0;
  10324a:	e9 cb fe ff ff       	jmp    10311a <_namei+0x4a>
  10324f:	90                   	nop

00103250 <dirlink>:
}

// Write a new directory entry (name, ino) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint ino)
{
  103250:	55                   	push   %ebp
  103251:	57                   	push   %edi
  103252:	56                   	push   %esi
  103253:	53                   	push   %ebx
  103254:	83 ec 2c             	sub    $0x2c,%esp
  103257:	8b 74 24 40          	mov    0x40(%esp),%esi
  10325b:	8b 6c 24 44          	mov    0x44(%esp),%ebp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  10325f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103266:	00 
  103267:	89 34 24             	mov    %esi,(%esp)
  10326a:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  10326e:	e8 5d fd ff ff       	call   102fd0 <dirlookup>
  103273:	85 c0                	test   %eax,%eax
  103275:	0f 85 8a 00 00 00    	jne    103305 <dirlink+0xb5>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  10327b:	8b 46 18             	mov    0x18(%esi),%eax
  10327e:	31 db                	xor    %ebx,%ebx
  103280:	8d 7c 24 10          	lea    0x10(%esp),%edi
  103284:	85 c0                	test   %eax,%eax
  103286:	75 10                	jne    103298 <dirlink+0x48>
  103288:	eb 33                	jmp    1032bd <dirlink+0x6d>
  10328a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103290:	83 c3 10             	add    $0x10,%ebx
  103293:	39 5e 18             	cmp    %ebx,0x18(%esi)
  103296:	76 25                	jbe    1032bd <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103298:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  10329f:	00 
  1032a0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1032a4:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1032a8:	89 34 24             	mov    %esi,(%esp)
  1032ab:	e8 a0 fa ff ff       	call   102d50 <readi>
  1032b0:	83 f8 10             	cmp    $0x10,%eax
  1032b3:	75 5f                	jne    103314 <dirlink+0xc4>
      panic("dirlink read");
    if(de.inum == 0)
  1032b5:	66 83 7c 24 10 00    	cmpw   $0x0,0x10(%esp)
  1032bb:	75 d3                	jne    103290 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  1032bd:	8d 44 24 12          	lea    0x12(%esp),%eax
  1032c1:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  1032c8:	00 
  1032c9:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  1032cd:	89 04 24             	mov    %eax,(%esp)
  1032d0:	e8 9b dc ff ff       	call   100f70 <strncpy>
  de.inum = ino;
  1032d5:	8b 44 24 48          	mov    0x48(%esp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1032d9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1032e0:	00 
  1032e1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1032e5:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1032e9:	89 34 24             	mov    %esi,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  1032ec:	66 89 44 24 10       	mov    %ax,0x10(%esp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1032f1:	e8 6a fb ff ff       	call   102e60 <writei>
  1032f6:	83 f8 10             	cmp    $0x10,%eax
  1032f9:	75 25                	jne    103320 <dirlink+0xd0>
    panic("dirlink");

  return 0;
  1032fb:	31 c0                	xor    %eax,%eax
}
  1032fd:	83 c4 2c             	add    $0x2c,%esp
  103300:	5b                   	pop    %ebx
  103301:	5e                   	pop    %esi
  103302:	5f                   	pop    %edi
  103303:	5d                   	pop    %ebp
  103304:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  103305:	89 04 24             	mov    %eax,(%esp)
  103308:	e8 b3 f8 ff ff       	call   102bc0 <iput>
    return -1;
  10330d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103312:	eb e9                	jmp    1032fd <dirlink+0xad>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  103314:	c7 04 24 5f 62 10 00 	movl   $0x10625f,(%esp)
  10331b:	e8 90 d7 ff ff       	call   100ab0 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  103320:	c7 04 24 6c 62 10 00 	movl   $0x10626c,(%esp)
  103327:	e8 84 d7 ff ff       	call   100ab0 <panic>
  10332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103330 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  103330:	83 ec 1c             	sub    $0x1c,%esp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  103333:	31 d2                	xor    %edx,%edx
  103335:	8b 44 24 20          	mov    0x20(%esp),%eax
  103339:	8d 4c 24 02          	lea    0x2(%esp),%ecx
  10333d:	e8 8e fd ff ff       	call   1030d0 <_namei>
}
  103342:	83 c4 1c             	add    $0x1c,%esp
  103345:	c3                   	ret    
  103346:	8d 76 00             	lea    0x0(%esi),%esi
  103349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103350 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
  return _namei(path, 1, name);
  103350:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  103354:	ba 01 00 00 00       	mov    $0x1,%edx
  103359:	8b 44 24 04          	mov    0x4(%esp),%eax
  10335d:	e9 6e fd ff ff       	jmp    1030d0 <_namei>
  103362:	90                   	nop
  103363:	90                   	nop
  103364:	90                   	nop
  103365:	90                   	nop
  103366:	90                   	nop
  103367:	90                   	nop
  103368:	90                   	nop
  103369:	90                   	nop
  10336a:	90                   	nop
  10336b:	90                   	nop
  10336c:	90                   	nop
  10336d:	90                   	nop
  10336e:	90                   	nop
  10336f:	90                   	nop

00103370 <binit>:
// bufhead->tail is least recently used.
struct buf bufhead;

void
binit(void)
{
  103370:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");
  103373:	c7 44 24 04 74 62 10 	movl   $0x106274,0x4(%esp)
  10337a:	00 
  10337b:	c7 04 24 00 21 11 00 	movl   $0x112100,(%esp)
  103382:	e8 f9 cd ff ff       	call   100180 <initlock>

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  103387:	ba 60 fd 10 00       	mov    $0x10fd60,%edx
  for(b = buf; b < buf+NBUF; b++){
  10338c:	b8 80 ff 10 00       	mov    $0x10ff80,%eax
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  103391:	c7 05 6c fd 10 00 60 	movl   $0x10fd60,0x10fd6c
  103398:	fd 10 00 
  10339b:	eb 07                	jmp    1033a4 <binit+0x34>
  10339d:	8d 76 00             	lea    0x0(%esi),%esi
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  1033a0:	89 c2                	mov    %eax,%edx
  1033a2:	89 c8                	mov    %ecx,%eax
  1033a4:	8d 88 18 02 00 00    	lea    0x218(%eax),%ecx
  1033aa:	81 f9 00 21 11 00    	cmp    $0x112100,%ecx
    b->next = bufhead.next;
  1033b0:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bufhead;
  1033b3:	c7 40 0c 60 fd 10 00 	movl   $0x10fd60,0xc(%eax)
    bufhead.next->prev = b;
  1033ba:	89 42 0c             	mov    %eax,0xc(%edx)
  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  1033bd:	72 e1                	jb     1033a0 <binit+0x30>
  1033bf:	a3 70 fd 10 00       	mov    %eax,0x10fd70
    b->next = bufhead.next;
    b->prev = &bufhead;
    bufhead.next->prev = b;
    bufhead.next = b;
  }
}
  1033c4:	83 c4 1c             	add    $0x1c,%esp
  1033c7:	c3                   	ret    
  1033c8:	90                   	nop
  1033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001033d0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1033d0:	57                   	push   %edi
  1033d1:	56                   	push   %esi
  1033d2:	53                   	push   %ebx
  1033d3:	83 ec 10             	sub    $0x10,%esp
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&buf_table_lock);
  1033d6:	c7 04 24 00 21 11 00 	movl   $0x112100,(%esp)
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1033dd:	8b 74 24 20          	mov    0x20(%esp),%esi
  1033e1:	8b 7c 24 24          	mov    0x24(%esp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&buf_table_lock);
  1033e5:	e8 86 ce ff ff       	call   100270 <acquire>

 loop:
  // Try for cached block.
  for(b = bufhead.next; b != &bufhead; b = b->next){
  1033ea:	8b 1d 70 fd 10 00    	mov    0x10fd70,%ebx
  1033f0:	81 fb 60 fd 10 00    	cmp    $0x10fd60,%ebx
  1033f6:	75 13                	jne    10340b <bread+0x3b>
  1033f8:	eb 3e                	jmp    103438 <bread+0x68>
  1033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103400:	8b 5b 10             	mov    0x10(%ebx),%ebx
  103403:	81 fb 60 fd 10 00    	cmp    $0x10fd60,%ebx
  103409:	74 2d                	je     103438 <bread+0x68>
    if((b->flags & (B_BUSY|B_VALID)) &&
  10340b:	8b 03                	mov    (%ebx),%eax
  10340d:	a8 03                	test   $0x3,%al
  10340f:	74 ef                	je     103400 <bread+0x30>
  103411:	3b 73 04             	cmp    0x4(%ebx),%esi
  103414:	75 ea                	jne    103400 <bread+0x30>
       b->dev == dev && b->sector == sector){
  103416:	3b 7b 08             	cmp    0x8(%ebx),%edi
  103419:	75 e5                	jne    103400 <bread+0x30>
      if(b->flags & B_BUSY){
  10341b:	a8 01                	test   $0x1,%al
  10341d:	8d 76 00             	lea    0x0(%esi),%esi
  103420:	74 70                	je     103492 <bread+0xc2>
        sleep(buf, &buf_table_lock);
  103422:	c7 44 24 04 00 21 11 	movl   $0x112100,0x4(%esp)
  103429:	00 
  10342a:	c7 04 24 80 ff 10 00 	movl   $0x10ff80,(%esp)
  103431:	e8 fa e2 ff ff       	call   101730 <sleep>
  103436:	eb b2                	jmp    1033ea <bread+0x1a>
      return b;
    }
  }

  // Allocate fresh block.
  for(b = bufhead.prev; b != &bufhead; b = b->prev){
  103438:	8b 1d 6c fd 10 00    	mov    0x10fd6c,%ebx
  10343e:	81 fb 60 fd 10 00    	cmp    $0x10fd60,%ebx
  103444:	75 0d                	jne    103453 <bread+0x83>
  103446:	eb 3e                	jmp    103486 <bread+0xb6>
  103448:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  10344b:	81 fb 60 fd 10 00    	cmp    $0x10fd60,%ebx
  103451:	74 33                	je     103486 <bread+0xb6>
    if((b->flags & B_BUSY) == 0){
  103453:	f6 03 01             	testb  $0x1,(%ebx)
  103456:	75 f0                	jne    103448 <bread+0x78>
      b->flags = B_BUSY;
  103458:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      b->dev = dev;
  10345e:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  103461:	89 7b 08             	mov    %edi,0x8(%ebx)
      release(&buf_table_lock);
  103464:	c7 04 24 00 21 11 00 	movl   $0x112100,(%esp)
  10346b:	e8 f0 ce ff ff       	call   100360 <release>
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  103470:	f6 03 02             	testb  $0x2,(%ebx)
  103473:	75 08                	jne    10347d <bread+0xad>
    ide_rw(b);
  103475:	89 1c 24             	mov    %ebx,(%esp)
  103478:	e8 b3 02 00 00       	call   103730 <ide_rw>
  return b;
}
  10347d:	83 c4 10             	add    $0x10,%esp
  103480:	89 d8                	mov    %ebx,%eax
  103482:	5b                   	pop    %ebx
  103483:	5e                   	pop    %esi
  103484:	5f                   	pop    %edi
  103485:	c3                   	ret    
      b->sector = sector;
      release(&buf_table_lock);
      return b;
    }
  }
  panic("bget: no buffers");
  103486:	c7 04 24 7e 62 10 00 	movl   $0x10627e,(%esp)
  10348d:	e8 1e d6 ff ff       	call   100ab0 <panic>
       b->dev == dev && b->sector == sector){
      if(b->flags & B_BUSY){
        sleep(buf, &buf_table_lock);
        goto loop;
      }
      b->flags |= B_BUSY;
  103492:	83 c8 01             	or     $0x1,%eax
  103495:	89 03                	mov    %eax,(%ebx)
      release(&buf_table_lock);
  103497:	c7 04 24 00 21 11 00 	movl   $0x112100,(%esp)
  10349e:	e8 bd ce ff ff       	call   100360 <release>
  1034a3:	eb cb                	jmp    103470 <bread+0xa0>
  1034a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1034a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001034b0 <bwrite>:
}

// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  1034b0:	83 ec 1c             	sub    $0x1c,%esp
  1034b3:	8b 44 24 20          	mov    0x20(%esp),%eax
  if((b->flags & B_BUSY) == 0)
  1034b7:	8b 10                	mov    (%eax),%edx
  1034b9:	f6 c2 01             	test   $0x1,%dl
  1034bc:	74 11                	je     1034cf <bwrite+0x1f>
    panic("bwrite");
  b->flags |= B_DIRTY;
  1034be:	83 ca 04             	or     $0x4,%edx
  1034c1:	89 10                	mov    %edx,(%eax)
  ide_rw(b);
  1034c3:	89 44 24 20          	mov    %eax,0x20(%esp)
}
  1034c7:	83 c4 1c             	add    $0x1c,%esp
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  ide_rw(b);
  1034ca:	e9 61 02 00 00       	jmp    103730 <ide_rw>
// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  1034cf:	c7 04 24 8f 62 10 00 	movl   $0x10628f,(%esp)
  1034d6:	e8 d5 d5 ff ff       	call   100ab0 <panic>
  1034db:	90                   	nop
  1034dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001034e0 <brelse>:
}

// Release the buffer buf.
void
brelse(struct buf *b)
{
  1034e0:	53                   	push   %ebx
  1034e1:	83 ec 18             	sub    $0x18,%esp
  1034e4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if((b->flags & B_BUSY) == 0)
  1034e8:	f6 03 01             	testb  $0x1,(%ebx)
  1034eb:	74 58                	je     103545 <brelse+0x65>
    panic("brelse");

  acquire(&buf_table_lock);
  1034ed:	c7 04 24 00 21 11 00 	movl   $0x112100,(%esp)
  1034f4:	e8 77 cd ff ff       	call   100270 <acquire>

  b->next->prev = b->prev;
  1034f9:	8b 43 10             	mov    0x10(%ebx),%eax
  1034fc:	8b 53 0c             	mov    0xc(%ebx),%edx
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  1034ff:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  if((b->flags & B_BUSY) == 0)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  103502:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  103505:	8b 53 0c             	mov    0xc(%ebx),%edx
  b->next = bufhead.next;
  b->prev = &bufhead;
  103508:	c7 43 0c 60 fd 10 00 	movl   $0x10fd60,0xc(%ebx)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  10350f:	89 42 10             	mov    %eax,0x10(%edx)
  b->next = bufhead.next;
  103512:	a1 70 fd 10 00       	mov    0x10fd70,%eax
  103517:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bufhead;
  bufhead.next->prev = b;
  10351a:	a1 70 fd 10 00       	mov    0x10fd70,%eax
  bufhead.next = b;
  10351f:	89 1d 70 fd 10 00    	mov    %ebx,0x10fd70

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  103525:	89 58 0c             	mov    %ebx,0xc(%eax)
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);
  103528:	c7 04 24 80 ff 10 00 	movl   $0x10ff80,(%esp)
  10352f:	e8 cc e2 ff ff       	call   101800 <wakeup>

  release(&buf_table_lock);
  103534:	c7 44 24 20 00 21 11 	movl   $0x112100,0x20(%esp)
  10353b:	00 
}
  10353c:	83 c4 18             	add    $0x18,%esp
  10353f:	5b                   	pop    %ebx
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);

  release(&buf_table_lock);
  103540:	e9 1b ce ff ff       	jmp    100360 <release>
// Release the buffer buf.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  103545:	c7 04 24 96 62 10 00 	movl   $0x106296,(%esp)
  10354c:	e8 5f d5 ff ff       	call   100ab0 <panic>
  103551:	90                   	nop
  103552:	90                   	nop
  103553:	90                   	nop
  103554:	90                   	nop
  103555:	90                   	nop
  103556:	90                   	nop
  103557:	90                   	nop
  103558:	90                   	nop
  103559:	90                   	nop
  10355a:	90                   	nop
  10355b:	90                   	nop
  10355c:	90                   	nop
  10355d:	90                   	nop
  10355e:	90                   	nop
  10355f:	90                   	nop

00103560 <ide_start_request>:
}

// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  103560:	56                   	push   %esi
  103561:	89 c1                	mov    %eax,%ecx
  103563:	53                   	push   %ebx
  103564:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
  103567:	85 c0                	test   %eax,%eax
  103569:	0f 84 8b 00 00 00    	je     1035fa <ide_start_request+0x9a>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10356f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  103574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103578:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  103579:	0f b6 c0             	movzbl %al,%eax
  10357c:	a8 80                	test   $0x80,%al
  10357e:	75 f8                	jne    103578 <ide_start_request+0x18>
  103580:	a8 40                	test   $0x40,%al
  103582:	74 f4                	je     103578 <ide_start_request+0x18>


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  103584:	ba f6 03 00 00       	mov    $0x3f6,%edx
  103589:	31 c0                	xor    %eax,%eax
  10358b:	ee                   	out    %al,(%dx)
  10358c:	ba f2 01 00 00       	mov    $0x1f2,%edx
  103591:	b8 01 00 00 00       	mov    $0x1,%eax
  103596:	ee                   	out    %al,(%dx)
    panic("ide_start_request");

  ide_wait_ready(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  103597:	8b 59 08             	mov    0x8(%ecx),%ebx
  10359a:	b2 f3                	mov    $0xf3,%dl
  10359c:	89 d8                	mov    %ebx,%eax
  10359e:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  10359f:	89 d8                	mov    %ebx,%eax
  1035a1:	b2 f4                	mov    $0xf4,%dl
  1035a3:	c1 e8 08             	shr    $0x8,%eax
  1035a6:	ee                   	out    %al,(%dx)
  outb(0x1f5, (b->sector >> 16) & 0xff);
  1035a7:	89 d8                	mov    %ebx,%eax
  1035a9:	b2 f5                	mov    $0xf5,%dl
  1035ab:	c1 e8 10             	shr    $0x10,%eax
  1035ae:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  1035af:	8b 41 04             	mov    0x4(%ecx),%eax
  1035b2:	c1 eb 18             	shr    $0x18,%ebx
  1035b5:	b2 f6                	mov    $0xf6,%dl
  1035b7:	83 e3 0f             	and    $0xf,%ebx
  1035ba:	83 e0 01             	and    $0x1,%eax
  1035bd:	c1 e0 04             	shl    $0x4,%eax
  1035c0:	09 d8                	or     %ebx,%eax
  1035c2:	83 c8 e0             	or     $0xffffffe0,%eax
  1035c5:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
  1035c6:	f6 01 04             	testb  $0x4,(%ecx)
  1035c9:	75 11                	jne    1035dc <ide_start_request+0x7c>
  1035cb:	ba f7 01 00 00       	mov    $0x1f7,%edx
  1035d0:	b8 20 00 00 00       	mov    $0x20,%eax
  1035d5:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  1035d6:	83 c4 14             	add    $0x14,%esp
  1035d9:	5b                   	pop    %ebx
  1035da:	5e                   	pop    %esi
  1035db:	c3                   	ret    
  1035dc:	b2 f7                	mov    $0xf7,%dl
  1035de:	b8 30 00 00 00       	mov    $0x30,%eax
  1035e3:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\toutsl"    :
  1035e4:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  1035e9:	8d 71 18             	lea    0x18(%ecx),%esi
  1035ec:	b9 80 00 00 00       	mov    $0x80,%ecx
  1035f1:	fc                   	cld    
  1035f2:	f2 6f                	repnz outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  1035f4:	83 c4 14             	add    $0x14,%esp
  1035f7:	5b                   	pop    %ebx
  1035f8:	5e                   	pop    %esi
  1035f9:	c3                   	ret    
// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  if(b == 0)
    panic("ide_start_request");
  1035fa:	c7 04 24 9d 62 10 00 	movl   $0x10629d,(%esp)
  103601:	e8 aa d4 ff ff       	call   100ab0 <panic>
  103606:	8d 76 00             	lea    0x0(%esi),%esi
  103609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103610 <ide_init>:
  return 0;
}

void
ide_init(void)
{
  103610:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  initlock(&ide_lock, "ide");
  103613:	c7 44 24 04 af 62 10 	movl   $0x1062af,0x4(%esp)
  10361a:	00 
  10361b:	c7 04 24 20 88 10 00 	movl   $0x108820,(%esp)
  103622:	e8 59 cb ff ff       	call   100180 <initlock>
  pic_enable(IRQ_IDE);
  103627:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  10362e:	e8 bd 01 00 00       	call   1037f0 <pic_enable>
  ioapic_enable(IRQ_IDE, ncpu - 1);
  103633:	a1 40 dc 10 00       	mov    0x10dc40,%eax
  103638:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  10363f:	83 e8 01             	sub    $0x1,%eax
  103642:	89 44 24 04          	mov    %eax,0x4(%esp)
  103646:	e8 65 e6 ff ff       	call   101cb0 <ioapic_enable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10364b:	ba f7 01 00 00       	mov    $0x1f7,%edx
  103650:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  103651:	0f b6 c0             	movzbl %al,%eax
  103654:	a8 80                	test   $0x80,%al
  103656:	75 f8                	jne    103650 <ide_init+0x40>
  103658:	a8 40                	test   $0x40,%al
  10365a:	74 f4                	je     103650 <ide_init+0x40>


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10365c:	ba f6 01 00 00       	mov    $0x1f6,%edx
  103661:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  103666:	ee                   	out    %al,(%dx)
  103667:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10366c:	b2 f7                	mov    $0xf7,%dl
  10366e:	eb 05                	jmp    103675 <ide_init+0x65>
  ioapic_enable(IRQ_IDE, ncpu - 1);
  ide_wait_ready(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  103670:	83 e9 01             	sub    $0x1,%ecx
  103673:	74 0f                	je     103684 <ide_init+0x74>
  103675:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  103676:	84 c0                	test   %al,%al
  103678:	74 f6                	je     103670 <ide_init+0x60>
      disk_1_present = 1;
  10367a:	c7 05 54 88 10 00 01 	movl   $0x1,0x108854
  103681:	00 00 00 


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  103684:	ba f6 01 00 00       	mov    $0x1f6,%edx
  103689:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  10368e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10368f:	83 c4 1c             	add    $0x1c,%esp
  103692:	c3                   	ret    
  103693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001036a0 <ide_intr>:
}

// Interrupt handler.
void
ide_intr(void)
{
  1036a0:	57                   	push   %edi
  1036a1:	53                   	push   %ebx
  1036a2:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  acquire(&ide_lock);
  1036a5:	c7 04 24 20 88 10 00 	movl   $0x108820,(%esp)
  1036ac:	e8 bf cb ff ff       	call   100270 <acquire>
  if((b = ide_queue) == 0){
  1036b1:	8b 1d 58 88 10 00    	mov    0x108858,%ebx
  1036b7:	85 db                	test   %ebx,%ebx
  1036b9:	74 28                	je     1036e3 <ide_intr+0x43>
    release(&ide_lock);
    return;
  }

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
  1036bb:	8b 0b                	mov    (%ebx),%ecx
  1036bd:	f6 c1 04             	test   $0x4,%cl
  1036c0:	74 33                	je     1036f5 <ide_intr+0x55>
    insl(0x1f0, b->data, 512/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  1036c2:	83 c9 02             	or     $0x2,%ecx
  b->flags &= ~B_DIRTY;
  1036c5:	83 e1 fb             	and    $0xfffffffb,%ecx
  1036c8:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
  1036ca:	89 1c 24             	mov    %ebx,(%esp)
  1036cd:	e8 2e e1 ff ff       	call   101800 <wakeup>

  // Start disk on next buf in queue.
  if((ide_queue = b->qnext) != 0)
  1036d2:	8b 43 14             	mov    0x14(%ebx),%eax
  1036d5:	85 c0                	test   %eax,%eax
  1036d7:	a3 58 88 10 00       	mov    %eax,0x108858
  1036dc:	74 05                	je     1036e3 <ide_intr+0x43>
    ide_start_request(ide_queue);
  1036de:	e8 7d fe ff ff       	call   103560 <ide_start_request>

  release(&ide_lock);
  1036e3:	c7 04 24 20 88 10 00 	movl   $0x108820,(%esp)
  1036ea:	e8 71 cc ff ff       	call   100360 <release>
}
  1036ef:	83 c4 14             	add    $0x14,%esp
  1036f2:	5b                   	pop    %ebx
  1036f3:	5f                   	pop    %edi
  1036f4:	c3                   	ret    
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1036f5:	ba f7 01 00 00       	mov    $0x1f7,%edx
  1036fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103700:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  103701:	0f b6 c0             	movzbl %al,%eax
  103704:	a8 80                	test   $0x80,%al
  103706:	75 f8                	jne    103700 <ide_intr+0x60>
  103708:	a8 40                	test   $0x40,%al
  10370a:	74 f4                	je     103700 <ide_intr+0x60>
    ;
  if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
  10370c:	a8 21                	test   $0x21,%al
  10370e:	75 b2                	jne    1036c2 <ide_intr+0x22>
    return;
  }

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
    insl(0x1f0, b->data, 512/4);
  103710:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\tinsl"     :
  103713:	b9 80 00 00 00       	mov    $0x80,%ecx
  103718:	ba f0 01 00 00       	mov    $0x1f0,%edx
  10371d:	fc                   	cld    
  10371e:	f2 6d                	repnz insl (%dx),%es:(%edi)
  103720:	8b 0b                	mov    (%ebx),%ecx
  103722:	eb 9e                	jmp    1036c2 <ide_intr+0x22>
  103724:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10372a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103730 <ide_rw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
ide_rw(struct buf *b)
{
  103730:	53                   	push   %ebx
  103731:	83 ec 18             	sub    $0x18,%esp
  103734:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  103738:	8b 03                	mov    (%ebx),%eax
  10373a:	a8 01                	test   $0x1,%al
  10373c:	0f 84 8a 00 00 00    	je     1037cc <ide_rw+0x9c>
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  103742:	83 e0 06             	and    $0x6,%eax
  103745:	83 f8 02             	cmp    $0x2,%eax
  103748:	0f 84 96 00 00 00    	je     1037e4 <ide_rw+0xb4>
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
  10374e:	8b 53 04             	mov    0x4(%ebx),%edx
  103751:	85 d2                	test   %edx,%edx
  103753:	74 09                	je     10375e <ide_rw+0x2e>
  103755:	a1 54 88 10 00       	mov    0x108854,%eax
  10375a:	85 c0                	test   %eax,%eax
  10375c:	74 7a                	je     1037d8 <ide_rw+0xa8>
    panic("ide disk 1 not present");

  acquire(&ide_lock);
  10375e:	c7 04 24 20 88 10 00 	movl   $0x108820,(%esp)
  103765:	e8 06 cb ff ff       	call   100270 <acquire>

  // Append b to ide_queue.
  b->qnext = 0;
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  10376a:	a1 58 88 10 00       	mov    0x108858,%eax
  10376f:	ba 58 88 10 00       	mov    $0x108858,%edx
    panic("ide disk 1 not present");

  acquire(&ide_lock);

  // Append b to ide_queue.
  b->qnext = 0;
  103774:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  10377b:	85 c0                	test   %eax,%eax
  10377d:	74 0b                	je     10378a <ide_rw+0x5a>
  10377f:	90                   	nop
  103780:	8d 50 14             	lea    0x14(%eax),%edx
  103783:	8b 40 14             	mov    0x14(%eax),%eax
  103786:	85 c0                	test   %eax,%eax
  103788:	75 f6                	jne    103780 <ide_rw+0x50>
    ;
  *pp = b;
  10378a:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(ide_queue == b)
  10378c:	39 1d 58 88 10 00    	cmp    %ebx,0x108858
  103792:	75 14                	jne    1037a8 <ide_rw+0x78>
  103794:	eb 2d                	jmp    1037c3 <ide_rw+0x93>
  103796:	66 90                	xchg   %ax,%ax
    ide_start_request(b);

  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);
  103798:	c7 44 24 04 20 88 10 	movl   $0x108820,0x4(%esp)
  10379f:	00 
  1037a0:	89 1c 24             	mov    %ebx,(%esp)
  1037a3:	e8 88 df ff ff       	call   101730 <sleep>
  if(ide_queue == b)
    ide_start_request(b);

  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1037a8:	8b 03                	mov    (%ebx),%eax
  1037aa:	83 e0 06             	and    $0x6,%eax
  1037ad:	83 f8 02             	cmp    $0x2,%eax
  1037b0:	75 e6                	jne    103798 <ide_rw+0x68>
    sleep(b, &ide_lock);

  release(&ide_lock);
  1037b2:	c7 44 24 20 20 88 10 	movl   $0x108820,0x20(%esp)
  1037b9:	00 
}
  1037ba:	83 c4 18             	add    $0x18,%esp
  1037bd:	5b                   	pop    %ebx
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);

  release(&ide_lock);
  1037be:	e9 9d cb ff ff       	jmp    100360 <release>
    ;
  *pp = b;

  // Start disk if necessary.
  if(ide_queue == b)
    ide_start_request(b);
  1037c3:	89 d8                	mov    %ebx,%eax
  1037c5:	e8 96 fd ff ff       	call   103560 <ide_start_request>
  1037ca:	eb dc                	jmp    1037a8 <ide_rw+0x78>
ide_rw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  1037cc:	c7 04 24 b3 62 10 00 	movl   $0x1062b3,(%esp)
  1037d3:	e8 d8 d2 ff ff       	call   100ab0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
    panic("ide disk 1 not present");
  1037d8:	c7 04 24 de 62 10 00 	movl   $0x1062de,(%esp)
  1037df:	e8 cc d2 ff ff       	call   100ab0 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  1037e4:	c7 04 24 c8 62 10 00 	movl   $0x1062c8,(%esp)
  1037eb:	e8 c0 d2 ff ff       	call   100ab0 <panic>

001037f0 <pic_enable>:
}

void
pic_enable(int irq)
{
  pic_setmask(irqmask & ~(1<<irq));
  1037f0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1037f4:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax


static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1037f9:	ba 21 00 00 00       	mov    $0x21,%edx
  1037fe:	d3 c0                	rol    %cl,%eax
  103800:	66 23 05 04 80 10 00 	and    0x108004,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
pic_setmask(ushort mask)
{
  irqmask = mask;
  103807:	66 a3 04 80 10 00    	mov    %ax,0x108004
  10380d:	ee                   	out    %al,(%dx)
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
  10380e:	66 c1 e8 08          	shr    $0x8,%ax
  103812:	b2 a1                	mov    $0xa1,%dl
  103814:	ee                   	out    %al,(%dx)

void
pic_enable(int irq)
{
  pic_setmask(irqmask & ~(1<<irq));
}
  103815:	c3                   	ret    
  103816:	8d 76 00             	lea    0x0(%esi),%esi
  103819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103820 <pic_init>:

// Initialize the 8259A interrupt controllers.
void
pic_init(void)
{
  103820:	83 ec 10             	sub    $0x10,%esp
  103823:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103828:	89 74 24 04          	mov    %esi,0x4(%esp)
  10382c:	be 21 00 00 00       	mov    $0x21,%esi
  103831:	89 1c 24             	mov    %ebx,(%esp)
  103834:	89 f2                	mov    %esi,%edx
  103836:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10383a:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  10383e:	ee                   	out    %al,(%dx)
  10383f:	bb a1 00 00 00       	mov    $0xa1,%ebx
  103844:	89 da                	mov    %ebx,%edx
  103846:	ee                   	out    %al,(%dx)
  103847:	bd 11 00 00 00       	mov    $0x11,%ebp
  10384c:	b9 20 00 00 00       	mov    $0x20,%ecx
  103851:	89 e8                	mov    %ebp,%eax
  103853:	89 ca                	mov    %ecx,%edx
  103855:	ee                   	out    %al,(%dx)
  103856:	b8 20 00 00 00       	mov    $0x20,%eax
  10385b:	89 f2                	mov    %esi,%edx
  10385d:	ee                   	out    %al,(%dx)
  10385e:	b8 04 00 00 00       	mov    $0x4,%eax
  103863:	ee                   	out    %al,(%dx)
  103864:	b8 03 00 00 00       	mov    $0x3,%eax
  103869:	ee                   	out    %al,(%dx)
  10386a:	bf a0 00 00 00       	mov    $0xa0,%edi
  10386f:	89 e8                	mov    %ebp,%eax
  103871:	89 fa                	mov    %edi,%edx
  103873:	ee                   	out    %al,(%dx)
  103874:	b8 28 00 00 00       	mov    $0x28,%eax
  103879:	89 da                	mov    %ebx,%edx
  10387b:	ee                   	out    %al,(%dx)
  10387c:	b8 02 00 00 00       	mov    $0x2,%eax
  103881:	ee                   	out    %al,(%dx)
  103882:	b8 03 00 00 00       	mov    $0x3,%eax
  103887:	ee                   	out    %al,(%dx)
  103888:	be 68 00 00 00       	mov    $0x68,%esi
  10388d:	89 ca                	mov    %ecx,%edx
  10388f:	89 f0                	mov    %esi,%eax
  103891:	ee                   	out    %al,(%dx)
  103892:	bb 0a 00 00 00       	mov    $0xa,%ebx
  103897:	89 d8                	mov    %ebx,%eax
  103899:	ee                   	out    %al,(%dx)
  10389a:	89 f0                	mov    %esi,%eax
  10389c:	89 fa                	mov    %edi,%edx
  10389e:	ee                   	out    %al,(%dx)
  10389f:	89 d8                	mov    %ebx,%eax
  1038a1:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  1038a2:	0f b7 05 04 80 10 00 	movzwl 0x108004,%eax
  1038a9:	66 83 f8 ff          	cmp    $0xffff,%ax
  1038ad:	74 0a                	je     1038b9 <pic_init+0x99>
  1038af:	b2 21                	mov    $0x21,%dl
  1038b1:	ee                   	out    %al,(%dx)
static void
pic_setmask(ushort mask)
{
  irqmask = mask;
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
  1038b2:	66 c1 e8 08          	shr    $0x8,%ax
  1038b6:	b2 a1                	mov    $0xa1,%dl
  1038b8:	ee                   	out    %al,(%dx)
  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    pic_setmask(irqmask);
}
  1038b9:	8b 1c 24             	mov    (%esp),%ebx
  1038bc:	8b 74 24 04          	mov    0x4(%esp),%esi
  1038c0:	8b 7c 24 08          	mov    0x8(%esp),%edi
  1038c4:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1038c8:	83 c4 10             	add    $0x10,%esp
  1038cb:	c3                   	ret    
  1038cc:	90                   	nop
  1038cd:	90                   	nop
  1038ce:	90                   	nop
  1038cf:	90                   	nop

001038d0 <pipealloc>:
  char data[PIPESIZE];
};

int
pipealloc(struct file **f0, struct file **f1)
{
  1038d0:	83 ec 1c             	sub    $0x1c,%esp
  1038d3:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1038d7:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  1038db:	89 74 24 14          	mov    %esi,0x14(%esp)
  1038df:	8b 74 24 20          	mov    0x20(%esp),%esi
  1038e3:	89 7c 24 18          	mov    %edi,0x18(%esp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  1038e7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  1038ed:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  1038f3:	e8 a8 e8 ff ff       	call   1021a0 <filealloc>
  1038f8:	85 c0                	test   %eax,%eax
  1038fa:	89 06                	mov    %eax,(%esi)
  1038fc:	0f 84 aa 00 00 00    	je     1039ac <pipealloc+0xdc>
  103902:	e8 99 e8 ff ff       	call   1021a0 <filealloc>
  103907:	85 c0                	test   %eax,%eax
  103909:	89 03                	mov    %eax,(%ebx)
  10390b:	0f 84 87 00 00 00    	je     103998 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
  103911:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103918:	e8 23 e5 ff ff       	call   101e40 <kalloc>
  10391d:	85 c0                	test   %eax,%eax
  10391f:	89 c7                	mov    %eax,%edi
  103921:	74 75                	je     103998 <pipealloc+0xc8>
    goto bad;
  p->readopen = 1;
  103923:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  p->writeopen = 1;
  103929:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
  p->writep = 0;
  103930:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  p->readp = 0;
  103937:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  initlock(&p->lock, "pipe");
  10393e:	8d 40 10             	lea    0x10(%eax),%eax
  103941:	89 04 24             	mov    %eax,(%esp)
  103944:	c7 44 24 04 f5 62 10 	movl   $0x1062f5,0x4(%esp)
  10394b:	00 
  10394c:	e8 2f c8 ff ff       	call   100180 <initlock>
  (*f0)->type = FD_PIPE;
  103951:	8b 06                	mov    (%esi),%eax
  (*f0)->readable = 1;
  103953:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->readopen = 1;
  p->writeopen = 1;
  p->writep = 0;
  p->readp = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  103957:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  10395d:	8b 06                	mov    (%esi),%eax
  10395f:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  103963:	8b 06                	mov    (%esi),%eax
  103965:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
  103968:	8b 03                	mov    (%ebx),%eax
  (*f1)->readable = 0;
  10396a:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  10396e:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  103974:	8b 03                	mov    (%ebx),%eax
  103976:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  10397a:	8b 03                	mov    (%ebx),%eax
  return 0;
  10397c:	31 db                	xor    %ebx,%ebx
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  10397e:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f1){
    (*f1)->type = FD_NONE;
    fileclose(*f1);
  }
  return -1;
}
  103981:	89 d8                	mov    %ebx,%eax
  103983:	8b 74 24 14          	mov    0x14(%esp),%esi
  103987:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10398b:	8b 7c 24 18          	mov    0x18(%esp),%edi
  10398f:	83 c4 1c             	add    $0x1c,%esp
  103992:	c3                   	ret    
  103993:	90                   	nop
  103994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;

 bad:
  if(p)
    kfree((char*)p, PAGE);
  if(*f0){
  103998:	8b 06                	mov    (%esi),%eax
  10399a:	85 c0                	test   %eax,%eax
  10399c:	74 0e                	je     1039ac <pipealloc+0xdc>
    (*f0)->type = FD_NONE;
  10399e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    fileclose(*f0);
  1039a4:	89 04 24             	mov    %eax,(%esp)
  1039a7:	e8 c4 e8 ff ff       	call   102270 <fileclose>
  }
  if(*f1){
  1039ac:	8b 13                	mov    (%ebx),%edx
    (*f1)->type = FD_NONE;
    fileclose(*f1);
  }
  return -1;
  1039ae:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree((char*)p, PAGE);
  if(*f0){
    (*f0)->type = FD_NONE;
    fileclose(*f0);
  }
  if(*f1){
  1039b3:	85 d2                	test   %edx,%edx
  1039b5:	74 ca                	je     103981 <pipealloc+0xb1>
    (*f1)->type = FD_NONE;
  1039b7:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    fileclose(*f1);
  1039bd:	89 14 24             	mov    %edx,(%esp)
  1039c0:	e8 ab e8 ff ff       	call   102270 <fileclose>
  1039c5:	eb ba                	jmp    103981 <pipealloc+0xb1>
  1039c7:	89 f6                	mov    %esi,%esi
  1039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001039d0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  1039d0:	83 ec 1c             	sub    $0x1c,%esp
  1039d3:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  1039d7:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1039db:	89 7c 24 18          	mov    %edi,0x18(%esp)
  1039df:	8b 7c 24 24          	mov    0x24(%esp),%edi
  1039e3:	89 74 24 14          	mov    %esi,0x14(%esp)
  acquire(&p->lock);
  1039e7:	8d 73 10             	lea    0x10(%ebx),%esi
  1039ea:	89 34 24             	mov    %esi,(%esp)
  1039ed:	e8 7e c8 ff ff       	call   100270 <acquire>
  if(writable){
  1039f2:	85 ff                	test   %edi,%edi
  1039f4:	74 3a                	je     103a30 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->readp);
  1039f6:	8d 43 0c             	lea    0xc(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  1039f9:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
    wakeup(&p->readp);
  103a00:	89 04 24             	mov    %eax,(%esp)
  103a03:	e8 f8 dd ff ff       	call   101800 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  }
  release(&p->lock);
  103a08:	89 34 24             	mov    %esi,(%esp)
  103a0b:	e8 50 c9 ff ff       	call   100360 <release>

  if(p->readopen == 0 && p->writeopen == 0)
  103a10:	8b 13                	mov    (%ebx),%edx
  103a12:	85 d2                	test   %edx,%edx
  103a14:	75 07                	jne    103a1d <pipeclose+0x4d>
  103a16:	8b 43 04             	mov    0x4(%ebx),%eax
  103a19:	85 c0                	test   %eax,%eax
  103a1b:	74 2b                	je     103a48 <pipeclose+0x78>
    kfree((char*)p, PAGE);
}
  103a1d:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103a21:	8b 74 24 14          	mov    0x14(%esp),%esi
  103a25:	8b 7c 24 18          	mov    0x18(%esp),%edi
  103a29:	83 c4 1c             	add    $0x1c,%esp
  103a2c:	c3                   	ret    
  103a2d:	8d 76 00             	lea    0x0(%esi),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  103a30:	8d 43 08             	lea    0x8(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
  103a33:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    wakeup(&p->writep);
  103a39:	89 04 24             	mov    %eax,(%esp)
  103a3c:	e8 bf dd ff ff       	call   101800 <wakeup>
  103a41:	eb c5                	jmp    103a08 <pipeclose+0x38>
  103a43:	90                   	nop
  103a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  103a48:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  103a4c:	8b 74 24 14          	mov    0x14(%esp),%esi
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  103a50:	c7 44 24 24 00 10 00 	movl   $0x1000,0x24(%esp)
  103a57:	00 
}
  103a58:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103a5c:	8b 7c 24 18          	mov    0x18(%esp),%edi
  103a60:	83 c4 1c             	add    $0x1c,%esp
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  103a63:	e9 78 e2 ff ff       	jmp    101ce0 <kfree>
  103a68:	90                   	nop
  103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103a70 <pipewrite>:
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  103a70:	55                   	push   %ebp
  103a71:	57                   	push   %edi
  103a72:	56                   	push   %esi
  103a73:	53                   	push   %ebx
  103a74:	83 ec 2c             	sub    $0x2c,%esp
  103a77:	8b 5c 24 40          	mov    0x40(%esp),%ebx
  int i;

  acquire(&p->lock);
  103a7b:	8d 73 10             	lea    0x10(%ebx),%esi
  103a7e:	89 34 24             	mov    %esi,(%esp)
  103a81:	e8 ea c7 ff ff       	call   100270 <acquire>
  for(i = 0; i < n; i++){
  103a86:	8b 44 24 48          	mov    0x48(%esp),%eax
  103a8a:	85 c0                	test   %eax,%eax
  103a8c:	0f 8e e1 00 00 00    	jle    103b73 <pipewrite+0x103>
  103a92:	8b 43 08             	mov    0x8(%ebx),%eax
    while(((p->writep + 1) % PIPESIZE) == p->readp){
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  103a95:	8d 6b 0c             	lea    0xc(%ebx),%ebp
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  103a98:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  103a9f:	00 
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
  103aa0:	8d 7b 08             	lea    0x8(%ebx),%edi
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  103aa3:	8d 50 01             	lea    0x1(%eax),%edx
  103aa6:	89 d1                	mov    %edx,%ecx
  103aa8:	c1 f9 1f             	sar    $0x1f,%ecx
  103aab:	c1 e9 17             	shr    $0x17,%ecx
  103aae:	01 ca                	add    %ecx,%edx
  103ab0:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  103ab6:	29 ca                	sub    %ecx,%edx
  103ab8:	3b 53 0c             	cmp    0xc(%ebx),%edx
  103abb:	74 47                	je     103b04 <pipewrite+0x94>
  103abd:	e9 a9 00 00 00       	jmp    103b6b <pipewrite+0xfb>
  103ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->readopen == 0 || cp->killed){
  103ac8:	e8 c3 d9 ff ff       	call   101490 <curproc>
  103acd:	8b 48 1c             	mov    0x1c(%eax),%ecx
  103ad0:	85 c9                	test   %ecx,%ecx
  103ad2:	75 36                	jne    103b0a <pipewrite+0x9a>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  103ad4:	89 2c 24             	mov    %ebp,(%esp)
  103ad7:	e8 24 dd ff ff       	call   101800 <wakeup>
      sleep(&p->writep, &p->lock);
  103adc:	89 74 24 04          	mov    %esi,0x4(%esp)
  103ae0:	89 3c 24             	mov    %edi,(%esp)
  103ae3:	e8 48 dc ff ff       	call   101730 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  103ae8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  103aeb:	8d 41 01             	lea    0x1(%ecx),%eax
  103aee:	89 c2                	mov    %eax,%edx
  103af0:	c1 fa 1f             	sar    $0x1f,%edx
  103af3:	c1 ea 17             	shr    $0x17,%edx
  103af6:	01 d0                	add    %edx,%eax
  103af8:	25 ff 01 00 00       	and    $0x1ff,%eax
  103afd:	29 d0                	sub    %edx,%eax
  103aff:	3b 43 0c             	cmp    0xc(%ebx),%eax
  103b02:	75 24                	jne    103b28 <pipewrite+0xb8>
      if(p->readopen == 0 || cp->killed){
  103b04:	8b 03                	mov    (%ebx),%eax
  103b06:	85 c0                	test   %eax,%eax
  103b08:	75 be                	jne    103ac8 <pipewrite+0x58>
        release(&p->lock);
  103b0a:	89 34 24             	mov    %esi,(%esp)
  103b0d:	e8 4e c8 ff ff       	call   100360 <release>
        return -1;
  103b12:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
  103b19:	ff 
    p->writep = (p->writep + 1) % PIPESIZE;
  }
  wakeup(&p->readp);
  release(&p->lock);
  return i;
}
  103b1a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  103b1e:	83 c4 2c             	add    $0x2c,%esp
  103b21:	5b                   	pop    %ebx
  103b22:	5e                   	pop    %esi
  103b23:	5f                   	pop    %edi
  103b24:	5d                   	pop    %ebp
  103b25:	c3                   	ret    
  103b26:	66 90                	xchg   %ax,%ax
  103b28:	89 4c 24 18          	mov    %ecx,0x18(%esp)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  103b2c:	8b 4c 24 44          	mov    0x44(%esp),%ecx
  103b30:	8b 54 24 1c          	mov    0x1c(%esp),%edx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  103b34:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  103b39:	0f b6 14 11          	movzbl (%ecx,%edx,1),%edx
  103b3d:	8b 4c 24 18          	mov    0x18(%esp),%ecx
    p->writep = (p->writep + 1) % PIPESIZE;
  103b41:	89 43 08             	mov    %eax,0x8(%ebx)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  103b44:	88 54 0b 44          	mov    %dl,0x44(%ebx,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  103b48:	8b 54 24 48          	mov    0x48(%esp),%edx
  103b4c:	39 54 24 1c          	cmp    %edx,0x1c(%esp)
  103b50:	0f 85 4d ff ff ff    	jne    103aa3 <pipewrite+0x33>
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
    p->writep = (p->writep + 1) % PIPESIZE;
  }
  wakeup(&p->readp);
  103b56:	83 c3 0c             	add    $0xc,%ebx
  103b59:	89 1c 24             	mov    %ebx,(%esp)
  103b5c:	e8 9f dc ff ff       	call   101800 <wakeup>
  release(&p->lock);
  103b61:	89 34 24             	mov    %esi,(%esp)
  103b64:	e8 f7 c7 ff ff       	call   100360 <release>
  return i;
  103b69:	eb af                	jmp    103b1a <pipewrite+0xaa>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  103b6b:	89 44 24 18          	mov    %eax,0x18(%esp)
  103b6f:	89 d0                	mov    %edx,%eax
  103b71:	eb b9                	jmp    103b2c <pipewrite+0xbc>
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  103b73:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  103b7a:	00 
  103b7b:	eb d9                	jmp    103b56 <pipewrite+0xe6>
  103b7d:	8d 76 00             	lea    0x0(%esi),%esi

00103b80 <piperead>:
  return i;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  103b80:	55                   	push   %ebp
  103b81:	57                   	push   %edi
  103b82:	56                   	push   %esi
  103b83:	53                   	push   %ebx
  103b84:	83 ec 1c             	sub    $0x1c,%esp
  103b87:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  103b8b:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  int i;

  acquire(&p->lock);
  103b8f:	8d 73 10             	lea    0x10(%ebx),%esi
  103b92:	89 34 24             	mov    %esi,(%esp)
  103b95:	e8 d6 c6 ff ff       	call   100270 <acquire>
  while(p->readp == p->writep && p->writeopen){
  103b9a:	8b 53 0c             	mov    0xc(%ebx),%edx
  103b9d:	3b 53 08             	cmp    0x8(%ebx),%edx
  103ba0:	75 4e                	jne    103bf0 <piperead+0x70>
  103ba2:	8b 43 04             	mov    0x4(%ebx),%eax
  103ba5:	85 c0                	test   %eax,%eax
  103ba7:	74 47                	je     103bf0 <piperead+0x70>
    if(cp->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  103ba9:	8d 7b 0c             	lea    0xc(%ebx),%edi
  103bac:	eb 1d                	jmp    103bcb <piperead+0x4b>
  103bae:	66 90                	xchg   %ax,%ax
  103bb0:	89 74 24 04          	mov    %esi,0x4(%esp)
  103bb4:	89 3c 24             	mov    %edi,(%esp)
  103bb7:	e8 74 db ff ff       	call   101730 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
  103bbc:	8b 53 0c             	mov    0xc(%ebx),%edx
  103bbf:	3b 53 08             	cmp    0x8(%ebx),%edx
  103bc2:	75 2c                	jne    103bf0 <piperead+0x70>
  103bc4:	8b 43 04             	mov    0x4(%ebx),%eax
  103bc7:	85 c0                	test   %eax,%eax
  103bc9:	74 25                	je     103bf0 <piperead+0x70>
    if(cp->killed){
  103bcb:	e8 c0 d8 ff ff       	call   101490 <curproc>
  103bd0:	8b 40 1c             	mov    0x1c(%eax),%eax
  103bd3:	85 c0                	test   %eax,%eax
  103bd5:	74 d9                	je     103bb0 <piperead+0x30>
      release(&p->lock);
  103bd7:	89 34 24             	mov    %esi,(%esp)
      return -1;
  103bda:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
    if(cp->killed){
      release(&p->lock);
  103bdf:	e8 7c c7 ff ff       	call   100360 <release>
    p->readp = (p->readp + 1) % PIPESIZE;
  }
  wakeup(&p->writep);
  release(&p->lock);
  return i;
}
  103be4:	83 c4 1c             	add    $0x1c,%esp
  103be7:	89 f8                	mov    %edi,%eax
  103be9:	5b                   	pop    %ebx
  103bea:	5e                   	pop    %esi
  103beb:	5f                   	pop    %edi
  103bec:	5d                   	pop    %ebp
  103bed:	c3                   	ret    
  103bee:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103bf0:	31 ff                	xor    %edi,%edi
  103bf2:	85 ed                	test   %ebp,%ebp
  103bf4:	7e 3d                	jle    103c33 <piperead+0xb3>
    if(p->readp == p->writep)
  103bf6:	3b 53 08             	cmp    0x8(%ebx),%edx
  103bf9:	75 0a                	jne    103c05 <piperead+0x85>
  103bfb:	eb 36                	jmp    103c33 <piperead+0xb3>
  103bfd:	8d 76 00             	lea    0x0(%esi),%esi
  103c00:	39 53 08             	cmp    %edx,0x8(%ebx)
  103c03:	74 2e                	je     103c33 <piperead+0xb3>
      break;
    addr[i] = p->data[p->readp];
  103c05:	0f b6 44 13 44       	movzbl 0x44(%ebx,%edx,1),%eax
  103c0a:	8b 54 24 34          	mov    0x34(%esp),%edx
  103c0e:	88 04 3a             	mov    %al,(%edx,%edi,1)
    p->readp = (p->readp + 1) % PIPESIZE;
  103c11:	8b 53 0c             	mov    0xc(%ebx),%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103c14:	83 c7 01             	add    $0x1,%edi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  103c17:	83 c2 01             	add    $0x1,%edx
  103c1a:	89 d1                	mov    %edx,%ecx
  103c1c:	c1 f9 1f             	sar    $0x1f,%ecx
  103c1f:	c1 e9 17             	shr    $0x17,%ecx
  103c22:	01 ca                	add    %ecx,%edx
  103c24:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  103c2a:	29 ca                	sub    %ecx,%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103c2c:	39 ef                	cmp    %ebp,%edi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  103c2e:	89 53 0c             	mov    %edx,0xc(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103c31:	75 cd                	jne    103c00 <piperead+0x80>
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  }
  wakeup(&p->writep);
  103c33:	83 c3 08             	add    $0x8,%ebx
  103c36:	89 1c 24             	mov    %ebx,(%esp)
  103c39:	e8 c2 db ff ff       	call   101800 <wakeup>
  release(&p->lock);
  103c3e:	89 34 24             	mov    %esi,(%esp)
  103c41:	e8 1a c7 ff ff       	call   100360 <release>
  return i;
}
  103c46:	83 c4 1c             	add    $0x1c,%esp
  103c49:	89 f8                	mov    %edi,%eax
  103c4b:	5b                   	pop    %ebx
  103c4c:	5e                   	pop    %esi
  103c4d:	5f                   	pop    %edi
  103c4e:	5d                   	pop    %ebp
  103c4f:	c3                   	ret    

00103c50 <swtch>:
  103c50:	8b 44 24 04          	mov    0x4(%esp),%eax
  103c54:	8f 00                	popl   (%eax)
  103c56:	89 60 04             	mov    %esp,0x4(%eax)
  103c59:	89 58 08             	mov    %ebx,0x8(%eax)
  103c5c:	89 48 0c             	mov    %ecx,0xc(%eax)
  103c5f:	89 50 10             	mov    %edx,0x10(%eax)
  103c62:	89 70 14             	mov    %esi,0x14(%eax)
  103c65:	89 78 18             	mov    %edi,0x18(%eax)
  103c68:	89 68 1c             	mov    %ebp,0x1c(%eax)
  103c6b:	8b 44 24 04          	mov    0x4(%esp),%eax
  103c6f:	8b 68 1c             	mov    0x1c(%eax),%ebp
  103c72:	8b 78 18             	mov    0x18(%eax),%edi
  103c75:	8b 70 14             	mov    0x14(%eax),%esi
  103c78:	8b 50 10             	mov    0x10(%eax),%edx
  103c7b:	8b 48 0c             	mov    0xc(%eax),%ecx
  103c7e:	8b 58 08             	mov    0x8(%eax),%ebx
  103c81:	8b 60 04             	mov    0x4(%eax),%esp
  103c84:	ff 30                	pushl  (%eax)
  103c86:	c3                   	ret    
  103c87:	90                   	nop
  103c88:	90                   	nop
  103c89:	90                   	nop
  103c8a:	90                   	nop
  103c8b:	90                   	nop
  103c8c:	90                   	nop
  103c8d:	90                   	nop
  103c8e:	90                   	nop
  103c8f:	90                   	nop

00103c90 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103c90:	83 ec 08             	sub    $0x8,%esp
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  103c93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103c98:	89 1c 24             	mov    %ebx,(%esp)
  103c9b:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  103c9f:	8b 54 24 10          	mov    0x10(%esp),%edx
  103ca3:	89 74 24 04          	mov    %esi,0x4(%esp)
  if(addr >= p->sz || addr+4 > p->sz)
  103ca7:	8b 4b 04             	mov    0x4(%ebx),%ecx
  103caa:	39 d1                	cmp    %edx,%ecx
  103cac:	76 14                	jbe    103cc2 <fetchint+0x32>
  103cae:	8d 72 04             	lea    0x4(%edx),%esi
  103cb1:	39 f1                	cmp    %esi,%ecx
  103cb3:	72 0d                	jb     103cc2 <fetchint+0x32>
    return -1;
  *ip = *(int*)(p->mem + addr);
  103cb5:	8b 03                	mov    (%ebx),%eax
  103cb7:	8b 14 10             	mov    (%eax,%edx,1),%edx
  103cba:	8b 44 24 14          	mov    0x14(%esp),%eax
  103cbe:	89 10                	mov    %edx,(%eax)
  return 0;
  103cc0:	31 c0                	xor    %eax,%eax
}
  103cc2:	8b 1c 24             	mov    (%esp),%ebx
  103cc5:	8b 74 24 04          	mov    0x4(%esp),%esi
  103cc9:	83 c4 08             	add    $0x8,%esp
  103ccc:	c3                   	ret    
  103ccd:	8d 76 00             	lea    0x0(%esi),%esi

00103cd0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  103cd0:	56                   	push   %esi
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  103cd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  103cd6:	53                   	push   %ebx
  103cd7:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  103cdb:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  char *s, *ep;

  if(addr >= p->sz)
  103cdf:	8b 53 04             	mov    0x4(%ebx),%edx
  103ce2:	39 ca                	cmp    %ecx,%edx
  103ce4:	76 2b                	jbe    103d11 <fetchstr+0x41>
    return -1;
  *pp = p->mem + addr;
  103ce6:	8b 74 24 14          	mov    0x14(%esp),%esi
  103cea:	03 0b                	add    (%ebx),%ecx
  103cec:	89 0e                	mov    %ecx,(%esi)
  ep = p->mem + p->sz;
  103cee:	03 13                	add    (%ebx),%edx
  for(s = *pp; s < ep; s++)
  103cf0:	39 d1                	cmp    %edx,%ecx
  103cf2:	73 1d                	jae    103d11 <fetchstr+0x41>
    if(*s == 0)
  103cf4:	31 c0                	xor    %eax,%eax
  103cf6:	80 39 00             	cmpb   $0x0,(%ecx)
  103cf9:	74 16                	je     103d11 <fetchstr+0x41>
  103cfb:	89 c8                	mov    %ecx,%eax
  103cfd:	eb 06                	jmp    103d05 <fetchstr+0x35>
  103cff:	90                   	nop
  103d00:	80 38 00             	cmpb   $0x0,(%eax)
  103d03:	74 13                	je     103d18 <fetchstr+0x48>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  103d05:	83 c0 01             	add    $0x1,%eax
  103d08:	39 d0                	cmp    %edx,%eax
  103d0a:	75 f4                	jne    103d00 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  return -1;
  103d0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103d11:	5b                   	pop    %ebx
  103d12:	5e                   	pop    %esi
  103d13:	c3                   	ret    
  103d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  103d18:	29 c8                	sub    %ecx,%eax
      return s - *pp;
  return -1;
}
  103d1a:	5b                   	pop    %ebx
  103d1b:	5e                   	pop    %esi
  103d1c:	c3                   	ret    
  103d1d:	8d 76 00             	lea    0x0(%esi),%esi

00103d20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  103d20:	56                   	push   %esi
  103d21:	53                   	push   %ebx
  103d22:	83 ec 04             	sub    $0x4,%esp
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  103d25:	e8 66 d7 ff ff       	call   101490 <curproc>
  103d2a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103d2e:	c1 e3 02             	shl    $0x2,%ebx
  103d31:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  103d37:	03 58 3c             	add    0x3c(%eax),%ebx
  103d3a:	e8 51 d7 ff ff       	call   101490 <curproc>
// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  103d3f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  103d44:	8d 73 04             	lea    0x4(%ebx),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103d47:	8b 50 04             	mov    0x4(%eax),%edx
  103d4a:	39 d6                	cmp    %edx,%esi
  103d4c:	73 15                	jae    103d63 <argint+0x43>
  103d4e:	8d 73 08             	lea    0x8(%ebx),%esi
  103d51:	39 f2                	cmp    %esi,%edx
  103d53:	72 0e                	jb     103d63 <argint+0x43>
    return -1;
  *ip = *(int*)(p->mem + addr);
  103d55:	8b 00                	mov    (%eax),%eax
  return 0;
  103d57:	31 c9                	xor    %ecx,%ecx
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  *ip = *(int*)(p->mem + addr);
  103d59:	8b 54 18 04          	mov    0x4(%eax,%ebx,1),%edx
  103d5d:	8b 44 24 14          	mov    0x14(%esp),%eax
  103d61:	89 10                	mov    %edx,(%eax)
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
  103d63:	83 c4 04             	add    $0x4,%esp
  103d66:	89 c8                	mov    %ecx,%eax
  103d68:	5b                   	pop    %ebx
  103d69:	5e                   	pop    %esi
  103d6a:	c3                   	ret    
  103d6b:	90                   	nop
  103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103d70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  103d70:	56                   	push   %esi
  103d71:	53                   	push   %ebx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  103d72:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  103d77:	83 ec 24             	sub    $0x24,%esp
  int i;

  if(argint(n, &i) < 0)
  103d7a:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  103d7e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d82:	8b 44 24 30          	mov    0x30(%esp),%eax
  103d86:	89 04 24             	mov    %eax,(%esp)
  103d89:	e8 92 ff ff ff       	call   103d20 <argint>
  103d8e:	85 c0                	test   %eax,%eax
  103d90:	78 33                	js     103dc5 <argptr+0x55>
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
  103d92:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  103d96:	e8 f5 d6 ff ff       	call   101490 <curproc>
  103d9b:	3b 70 04             	cmp    0x4(%eax),%esi
  103d9e:	73 25                	jae    103dc5 <argptr+0x55>
  103da0:	8b 74 24 38          	mov    0x38(%esp),%esi
  103da4:	03 74 24 1c          	add    0x1c(%esp),%esi
  103da8:	e8 e3 d6 ff ff       	call   101490 <curproc>
  103dad:	3b 70 04             	cmp    0x4(%eax),%esi
  103db0:	73 13                	jae    103dc5 <argptr+0x55>
    return -1;
  *pp = cp->mem + i;
  103db2:	e8 d9 d6 ff ff       	call   101490 <curproc>
  103db7:	8b 54 24 34          	mov    0x34(%esp),%edx
  return 0;
  103dbb:	31 db                	xor    %ebx,%ebx

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
    return -1;
  *pp = cp->mem + i;
  103dbd:	8b 00                	mov    (%eax),%eax
  103dbf:	03 44 24 1c          	add    0x1c(%esp),%eax
  103dc3:	89 02                	mov    %eax,(%edx)
  return 0;
}
  103dc5:	83 c4 24             	add    $0x24,%esp
  103dc8:	89 d8                	mov    %ebx,%eax
  103dca:	5b                   	pop    %ebx
  103dcb:	5e                   	pop    %esi
  103dcc:	c3                   	ret    
  103dcd:	8d 76 00             	lea    0x0(%esi),%esi

00103dd0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  103dd0:	56                   	push   %esi
  103dd1:	53                   	push   %ebx
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  103dd2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  103dd7:	83 ec 24             	sub    $0x24,%esp
  int addr;
  if(argint(n, &addr) < 0)
  103dda:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  103dde:	89 44 24 04          	mov    %eax,0x4(%esp)
  103de2:	8b 44 24 30          	mov    0x30(%esp),%eax
  103de6:	89 04 24             	mov    %eax,(%esp)
  103de9:	e8 32 ff ff ff       	call   103d20 <argint>
  103dee:	85 c0                	test   %eax,%eax
  103df0:	78 3f                	js     103e31 <argstr+0x61>
    return -1;
  return fetchstr(cp, addr, pp);
  103df2:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  103df6:	e8 95 d6 ff ff       	call   101490 <curproc>
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
  103dfb:	8b 50 04             	mov    0x4(%eax),%edx
  103dfe:	39 d6                	cmp    %edx,%esi
  103e00:	73 2f                	jae    103e31 <argstr+0x61>
    return -1;
  *pp = p->mem + addr;
  103e02:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  103e06:	03 30                	add    (%eax),%esi
  103e08:	89 31                	mov    %esi,(%ecx)
  ep = p->mem + p->sz;
  103e0a:	03 10                	add    (%eax),%edx
  for(s = *pp; s < ep; s++)
  103e0c:	39 d6                	cmp    %edx,%esi
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  103e0e:	89 d0                	mov    %edx,%eax
  for(s = *pp; s < ep; s++)
  103e10:	73 1f                	jae    103e31 <argstr+0x61>
    if(*s == 0)
  103e12:	31 db                	xor    %ebx,%ebx
  103e14:	80 3e 00             	cmpb   $0x0,(%esi)
  103e17:	74 18                	je     103e31 <argstr+0x61>
  103e19:	89 f3                	mov    %esi,%ebx
  103e1b:	eb 08                	jmp    103e25 <argstr+0x55>
  103e1d:	8d 76 00             	lea    0x0(%esi),%esi
  103e20:	80 3b 00             	cmpb   $0x0,(%ebx)
  103e23:	74 1b                	je     103e40 <argstr+0x70>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  103e25:	83 c3 01             	add    $0x1,%ebx
  103e28:	39 c3                	cmp    %eax,%ebx
  103e2a:	75 f4                	jne    103e20 <argstr+0x50>
    if(*s == 0)
      return s - *pp;
  return -1;
  103e2c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  103e31:	83 c4 24             	add    $0x24,%esp
  103e34:	89 d8                	mov    %ebx,%eax
  103e36:	5b                   	pop    %ebx
  103e37:	5e                   	pop    %esi
  103e38:	c3                   	ret    
  103e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  103e40:	29 f3                	sub    %esi,%ebx
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  103e42:	83 c4 24             	add    $0x24,%esp
  103e45:	89 d8                	mov    %ebx,%eax
  103e47:	5b                   	pop    %ebx
  103e48:	5e                   	pop    %esi
  103e49:	c3                   	ret    
  103e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103e50 <syscall>:
[SYS_write]   sys_write,
};

void
syscall(void)
{
  103e50:	83 ec 1c             	sub    $0x1c,%esp
  103e53:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  103e57:	89 74 24 18          	mov    %esi,0x18(%esp)
  int num;

  num = cp->tf->eax;
  103e5b:	e8 30 d6 ff ff       	call   101490 <curproc>
  103e60:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  103e66:	8b 58 1c             	mov    0x1c(%eax),%ebx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  103e69:	83 fb 14             	cmp    $0x14,%ebx
  103e6c:	77 2a                	ja     103e98 <syscall+0x48>
  103e6e:	8b 34 9d 20 63 10 00 	mov    0x106320(,%ebx,4),%esi
  103e75:	85 f6                	test   %esi,%esi
  103e77:	74 1f                	je     103e98 <syscall+0x48>
    cp->tf->eax = syscalls[num]();
  103e79:	e8 12 d6 ff ff       	call   101490 <curproc>
  103e7e:	8b 98 84 00 00 00    	mov    0x84(%eax),%ebx
  103e84:	ff d6                	call   *%esi
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  }
}
  103e86:	8b 74 24 18          	mov    0x18(%esp),%esi
{
  int num;

  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  103e8a:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  }
}
  103e8d:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  103e91:	83 c4 1c             	add    $0x1c,%esp
  103e94:	c3                   	ret    
  103e95:	8d 76 00             	lea    0x0(%esi),%esi
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
  103e98:	e8 f3 d5 ff ff       	call   101490 <curproc>
  103e9d:	89 c6                	mov    %eax,%esi
  103e9f:	e8 ec d5 ff ff       	call   101490 <curproc>
  103ea4:	81 c6 88 00 00 00    	add    $0x88,%esi

  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  103eaa:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
            cp->pid, cp->name, num);
  103eae:	89 74 24 08          	mov    %esi,0x8(%esp)

  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  103eb2:	8b 40 10             	mov    0x10(%eax),%eax
  103eb5:	c7 04 24 fa 62 10 00 	movl   $0x1062fa,(%esp)
  103ebc:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ec0:	e8 5b c8 ff ff       	call   100720 <cprintf>
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  103ec5:	e8 c6 d5 ff ff       	call   101490 <curproc>
  }
}
  103eca:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  103ece:	8b 74 24 18          	mov    0x18(%esp),%esi
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  103ed2:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  103ed8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  103edf:	83 c4 1c             	add    $0x1c,%esp
  103ee2:	c3                   	ret    
  103ee3:	90                   	nop
  103ee4:	90                   	nop
  103ee5:	90                   	nop
  103ee6:	90                   	nop
  103ee7:	90                   	nop
  103ee8:	90                   	nop
  103ee9:	90                   	nop
  103eea:	90                   	nop
  103eeb:	90                   	nop
  103eec:	90                   	nop
  103eed:	90                   	nop
  103eee:	90                   	nop
  103eef:	90                   	nop

00103ef0 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  103ef0:	57                   	push   %edi
  103ef1:	89 c7                	mov    %eax,%edi
  103ef3:	56                   	push   %esi
  103ef4:	53                   	push   %ebx
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  103ef5:	31 db                	xor    %ebx,%ebx
  103ef7:	90                   	nop
    if(cp->ofile[fd] == 0){
  103ef8:	e8 93 d5 ff ff       	call   101490 <curproc>
  103efd:	8d 73 08             	lea    0x8(%ebx),%esi
  103f00:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  103f03:	85 c0                	test   %eax,%eax
  103f05:	74 19                	je     103f20 <fdalloc+0x30>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  103f07:	83 c3 01             	add    $0x1,%ebx
  103f0a:	83 fb 10             	cmp    $0x10,%ebx
  103f0d:	75 e9                	jne    103ef8 <fdalloc+0x8>
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
  103f0f:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  103f14:	89 d8                	mov    %ebx,%eax
  103f16:	5b                   	pop    %ebx
  103f17:	5e                   	pop    %esi
  103f18:	5f                   	pop    %edi
  103f19:	c3                   	ret    
  103f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  103f20:	e8 6b d5 ff ff       	call   101490 <curproc>
  103f25:	89 3c b0             	mov    %edi,(%eax,%esi,4)
      return fd;
    }
  }
  return -1;
}
  103f28:	89 d8                	mov    %ebx,%eax
  103f2a:	5b                   	pop    %ebx
  103f2b:	5e                   	pop    %esi
  103f2c:	5f                   	pop    %edi
  103f2d:	c3                   	ret    
  103f2e:	66 90                	xchg   %ax,%ax

00103f30 <create>:
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  103f30:	83 ec 5c             	sub    $0x5c,%esp
  103f33:	89 5c 24 4c          	mov    %ebx,0x4c(%esp)
  103f37:	89 d3                	mov    %edx,%ebx
  103f39:	0f b7 54 24 64       	movzwl 0x64(%esp),%edx
  103f3e:	89 74 24 50          	mov    %esi,0x50(%esp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  103f42:	8d 74 24 2e          	lea    0x2e(%esp),%esi
  103f46:	89 74 24 04          	mov    %esi,0x4(%esp)
  103f4a:	89 04 24             	mov    %eax,(%esp)
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  103f4d:	89 7c 24 54          	mov    %edi,0x54(%esp)
  103f51:	89 cf                	mov    %ecx,%edi
  103f53:	89 6c 24 58          	mov    %ebp,0x58(%esp)
  103f57:	0f b7 6c 24 60       	movzwl 0x60(%esp),%ebp
  103f5c:	66 89 54 24 1e       	mov    %dx,0x1e(%esp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  103f61:	e8 ea f3 ff ff       	call   103350 <nameiparent>
  103f66:	85 c0                	test   %eax,%eax
  103f68:	89 44 24 18          	mov    %eax,0x18(%esp)
  103f6c:	0f 84 46 01 00 00    	je     1040b8 <create+0x188>
    return 0;
  ilock(dp);
  103f72:	89 04 24             	mov    %eax,(%esp)
  103f75:	e8 96 e9 ff ff       	call   102910 <ilock>

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
  103f7a:	85 db                	test   %ebx,%ebx
  103f7c:	74 5a                	je     103fd8 <create+0xa8>
  103f7e:	8d 44 24 3c          	lea    0x3c(%esp),%eax
  103f82:	89 44 24 08          	mov    %eax,0x8(%esp)
  103f86:	8b 44 24 18          	mov    0x18(%esp),%eax
  103f8a:	89 74 24 04          	mov    %esi,0x4(%esp)
  103f8e:	89 04 24             	mov    %eax,(%esp)
  103f91:	e8 3a f0 ff ff       	call   102fd0 <dirlookup>
  103f96:	85 c0                	test   %eax,%eax
  103f98:	89 c3                	mov    %eax,%ebx
  103f9a:	74 3c                	je     103fd8 <create+0xa8>
    iunlockput(dp);
  103f9c:	8b 44 24 18          	mov    0x18(%esp),%eax
  103fa0:	89 04 24             	mov    %eax,(%esp)
  103fa3:	e8 58 ed ff ff       	call   102d00 <iunlockput>
    ilock(ip);
  103fa8:	89 1c 24             	mov    %ebx,(%esp)
  103fab:	e8 60 e9 ff ff       	call   102910 <ilock>
    if(ip->type != type || ip->major != major || ip->minor != minor){
  103fb0:	66 39 7b 10          	cmp    %di,0x10(%ebx)
  103fb4:	75 15                	jne    103fcb <create+0x9b>
  103fb6:	66 39 6b 12          	cmp    %bp,0x12(%ebx)
  103fba:	75 0f                	jne    103fcb <create+0x9b>
  103fbc:	0f b7 54 24 1e       	movzwl 0x1e(%esp),%edx
  103fc1:	66 39 53 14          	cmp    %dx,0x14(%ebx)
  103fc5:	0f 84 7c 00 00 00    	je     104047 <create+0x117>
      iunlockput(ip);
  103fcb:	89 1c 24             	mov    %ebx,(%esp)
      return 0;
  103fce:	31 db                	xor    %ebx,%ebx

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(ip->type != type || ip->major != major || ip->minor != minor){
      iunlockput(ip);
  103fd0:	e8 2b ed ff ff       	call   102d00 <iunlockput>
      return 0;
  103fd5:	eb 70                	jmp    104047 <create+0x117>
  103fd7:	90                   	nop
    }
    return ip;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
  103fd8:	8b 54 24 18          	mov    0x18(%esp),%edx
  103fdc:	0f bf c7             	movswl %di,%eax
  103fdf:	89 44 24 04          	mov    %eax,0x4(%esp)
  103fe3:	8b 02                	mov    (%edx),%eax
  103fe5:	89 04 24             	mov    %eax,(%esp)
  103fe8:	e8 73 ea ff ff       	call   102a60 <ialloc>
  103fed:	85 c0                	test   %eax,%eax
  103fef:	89 c3                	mov    %eax,%ebx
  103ff1:	74 48                	je     10403b <create+0x10b>
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  103ff3:	89 04 24             	mov    %eax,(%esp)
  103ff6:	e8 15 e9 ff ff       	call   102910 <ilock>
  ip->major = major;
  ip->minor = minor;
  103ffb:	0f b7 54 24 1e       	movzwl 0x1e(%esp),%edx
  if((ip = ialloc(dp->dev, type)) == 0){
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  ip->major = major;
  104000:	66 89 6b 12          	mov    %bp,0x12(%ebx)
  ip->minor = minor;
  ip->nlink = 1;
  104004:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  10400a:	66 89 53 14          	mov    %dx,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  10400e:	89 1c 24             	mov    %ebx,(%esp)
  104011:	e8 1a eb ff ff       	call   102b30 <iupdate>

  if(dirlink(dp, name, ip->inum) < 0){
  104016:	8b 43 04             	mov    0x4(%ebx),%eax
  104019:	89 74 24 04          	mov    %esi,0x4(%esp)
  10401d:	89 44 24 08          	mov    %eax,0x8(%esp)
  104021:	8b 44 24 18          	mov    0x18(%esp),%eax
  104025:	89 04 24             	mov    %eax,(%esp)
  104028:	e8 23 f2 ff ff       	call   103250 <dirlink>
  10402d:	85 c0                	test   %eax,%eax
  10402f:	0f 88 8b 00 00 00    	js     1040c0 <create+0x190>
    iunlockput(ip);
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
  104035:	66 83 ff 01          	cmp    $0x1,%di
  104039:	74 25                	je     104060 <create+0x130>
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  10403b:	8b 44 24 18          	mov    0x18(%esp),%eax
  10403f:	89 04 24             	mov    %eax,(%esp)
  104042:	e8 b9 ec ff ff       	call   102d00 <iunlockput>
  return ip;
}
  104047:	89 d8                	mov    %ebx,%eax
  104049:	8b 74 24 50          	mov    0x50(%esp),%esi
  10404d:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
  104051:	8b 7c 24 54          	mov    0x54(%esp),%edi
  104055:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  104059:	83 c4 5c             	add    $0x5c,%esp
  10405c:	c3                   	ret    
  10405d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  104060:	8b 44 24 18          	mov    0x18(%esp),%eax
  104064:	66 83 40 16 01       	addw   $0x1,0x16(%eax)
    iupdate(dp);
  104069:	89 04 24             	mov    %eax,(%esp)
  10406c:	e8 bf ea ff ff       	call   102b30 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104071:	8b 43 04             	mov    0x4(%ebx),%eax
  104074:	c7 44 24 04 75 63 10 	movl   $0x106375,0x4(%esp)
  10407b:	00 
  10407c:	89 1c 24             	mov    %ebx,(%esp)
  10407f:	89 44 24 08          	mov    %eax,0x8(%esp)
  104083:	e8 c8 f1 ff ff       	call   103250 <dirlink>
  104088:	85 c0                	test   %eax,%eax
  10408a:	78 1f                	js     1040ab <create+0x17b>
  10408c:	8b 54 24 18          	mov    0x18(%esp),%edx
  104090:	8b 42 04             	mov    0x4(%edx),%eax
  104093:	c7 44 24 04 74 63 10 	movl   $0x106374,0x4(%esp)
  10409a:	00 
  10409b:	89 1c 24             	mov    %ebx,(%esp)
  10409e:	89 44 24 08          	mov    %eax,0x8(%esp)
  1040a2:	e8 a9 f1 ff ff       	call   103250 <dirlink>
  1040a7:	85 c0                	test   %eax,%eax
  1040a9:	79 90                	jns    10403b <create+0x10b>
      panic("create dots");
  1040ab:	c7 04 24 77 63 10 00 	movl   $0x106377,(%esp)
  1040b2:	e8 f9 c9 ff ff       	call   100ab0 <panic>
  1040b7:	90                   	nop
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  1040b8:	31 db                	xor    %ebx,%ebx
  1040ba:	eb 8b                	jmp    104047 <create+0x117>
  1040bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
  1040c0:	66 c7 43 16 00 00    	movw   $0x0,0x16(%ebx)
    iunlockput(ip);
  1040c6:	89 1c 24             	mov    %ebx,(%esp)
    iunlockput(dp);
    return 0;
  1040c9:	31 db                	xor    %ebx,%ebx
  ip->nlink = 1;
  iupdate(ip);

  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
    iunlockput(ip);
  1040cb:	e8 30 ec ff ff       	call   102d00 <iunlockput>
    iunlockput(dp);
  1040d0:	8b 44 24 18          	mov    0x18(%esp),%eax
  1040d4:	89 04 24             	mov    %eax,(%esp)
  1040d7:	e8 24 ec ff ff       	call   102d00 <iunlockput>
    return 0;
  1040dc:	e9 66 ff ff ff       	jmp    104047 <create+0x117>
  1040e1:	eb 0d                	jmp    1040f0 <argfd.constprop.0>
  1040e3:	90                   	nop
  1040e4:	90                   	nop
  1040e5:	90                   	nop
  1040e6:	90                   	nop
  1040e7:	90                   	nop
  1040e8:	90                   	nop
  1040e9:	90                   	nop
  1040ea:	90                   	nop
  1040eb:	90                   	nop
  1040ec:	90                   	nop
  1040ed:	90                   	nop
  1040ee:	90                   	nop
  1040ef:	90                   	nop

001040f0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  1040f0:	83 ec 2c             	sub    $0x2c,%esp
  1040f3:	89 5c 24 20          	mov    %ebx,0x20(%esp)
  1040f7:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  1040f9:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  1040fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  104101:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104108:	89 74 24 24          	mov    %esi,0x24(%esp)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  10410c:	be ff ff ff ff       	mov    $0xffffffff,%esi
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104111:	89 7c 24 28          	mov    %edi,0x28(%esp)
  104115:	89 d7                	mov    %edx,%edi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  104117:	e8 04 fc ff ff       	call   103d20 <argint>
  10411c:	85 c0                	test   %eax,%eax
  10411e:	78 26                	js     104146 <argfd.constprop.0+0x56>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
  104120:	83 7c 24 1c 0f       	cmpl   $0xf,0x1c(%esp)
  104125:	77 1f                	ja     104146 <argfd.constprop.0+0x56>
  104127:	e8 64 d3 ff ff       	call   101490 <curproc>
  10412c:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  104130:	8b 44 90 20          	mov    0x20(%eax,%edx,4),%eax
  104134:	85 c0                	test   %eax,%eax
  104136:	74 0e                	je     104146 <argfd.constprop.0+0x56>
    return -1;
  if(pfd)
  104138:	85 db                	test   %ebx,%ebx
  10413a:	74 02                	je     10413e <argfd.constprop.0+0x4e>
    *pfd = fd;
  10413c:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
  return 0;
  10413e:	31 f6                	xor    %esi,%esi
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
  104140:	85 ff                	test   %edi,%edi
  104142:	74 02                	je     104146 <argfd.constprop.0+0x56>
    *pf = f;
  104144:	89 07                	mov    %eax,(%edi)
  return 0;
}
  104146:	89 f0                	mov    %esi,%eax
  104148:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10414c:	8b 74 24 24          	mov    0x24(%esp),%esi
  104150:	8b 7c 24 28          	mov    0x28(%esp),%edi
  104154:	83 c4 2c             	add    $0x2c,%esp
  104157:	c3                   	ret    
  104158:	90                   	nop
  104159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104160 <sys_read>:
  return -1;
}

int
sys_read(void)
{
  104160:	53                   	push   %ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104161:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_read(void)
{
  104163:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  104166:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10416b:	8d 54 24 14          	lea    0x14(%esp),%edx
  10416f:	e8 7c ff ff ff       	call   1040f0 <argfd.constprop.0>
  104174:	85 c0                	test   %eax,%eax
  104176:	78 56                	js     1041ce <sys_read+0x6e>
  104178:	8d 44 24 18          	lea    0x18(%esp),%eax
  10417c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104180:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104187:	e8 94 fb ff ff       	call   103d20 <argint>
  10418c:	85 c0                	test   %eax,%eax
  10418e:	78 3e                	js     1041ce <sys_read+0x6e>
  104190:	8b 44 24 18          	mov    0x18(%esp),%eax
  104194:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10419b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10419f:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  1041a3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041a7:	e8 c4 fb ff ff       	call   103d70 <argptr>
  1041ac:	85 c0                	test   %eax,%eax
  1041ae:	78 1e                	js     1041ce <sys_read+0x6e>
    return -1;
  return fileread(f, p, n);
  1041b0:	8b 44 24 18          	mov    0x18(%esp),%eax
  1041b4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1041b8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1041bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041c0:	8b 44 24 14          	mov    0x14(%esp),%eax
  1041c4:	89 04 24             	mov    %eax,(%esp)
  1041c7:	e8 e4 e1 ff ff       	call   1023b0 <fileread>
  1041cc:	89 c3                	mov    %eax,%ebx
}
  1041ce:	83 c4 28             	add    $0x28,%esp
  1041d1:	89 d8                	mov    %ebx,%eax
  1041d3:	5b                   	pop    %ebx
  1041d4:	c3                   	ret    
  1041d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001041e0 <sys_write>:

int
sys_write(void)
{
  1041e0:	53                   	push   %ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1041e1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  1041e3:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  1041e6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1041eb:	8d 54 24 14          	lea    0x14(%esp),%edx
  1041ef:	e8 fc fe ff ff       	call   1040f0 <argfd.constprop.0>
  1041f4:	85 c0                	test   %eax,%eax
  1041f6:	78 56                	js     10424e <sys_write+0x6e>
  1041f8:	8d 44 24 18          	lea    0x18(%esp),%eax
  1041fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  104200:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104207:	e8 14 fb ff ff       	call   103d20 <argint>
  10420c:	85 c0                	test   %eax,%eax
  10420e:	78 3e                	js     10424e <sys_write+0x6e>
  104210:	8b 44 24 18          	mov    0x18(%esp),%eax
  104214:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10421b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10421f:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  104223:	89 44 24 04          	mov    %eax,0x4(%esp)
  104227:	e8 44 fb ff ff       	call   103d70 <argptr>
  10422c:	85 c0                	test   %eax,%eax
  10422e:	78 1e                	js     10424e <sys_write+0x6e>
    return -1;
  return filewrite(f, p, n);
  104230:	8b 44 24 18          	mov    0x18(%esp),%eax
  104234:	89 44 24 08          	mov    %eax,0x8(%esp)
  104238:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10423c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104240:	8b 44 24 14          	mov    0x14(%esp),%eax
  104244:	89 04 24             	mov    %eax,(%esp)
  104247:	e8 14 e2 ff ff       	call   102460 <filewrite>
  10424c:	89 c3                	mov    %eax,%ebx
}
  10424e:	83 c4 28             	add    $0x28,%esp
  104251:	89 d8                	mov    %ebx,%eax
  104253:	5b                   	pop    %ebx
  104254:	c3                   	ret    
  104255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104260 <sys_dup>:

int
sys_dup(void)
{
  104260:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
  104261:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  104263:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  104266:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
sys_dup(void)
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
  10426b:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  10426f:	e8 7c fe ff ff       	call   1040f0 <argfd.constprop.0>
  104274:	85 c0                	test   %eax,%eax
  104276:	78 1b                	js     104293 <sys_dup+0x33>
    return -1;
  if((fd=fdalloc(f)) < 0)
  104278:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10427c:	e8 6f fc ff ff       	call   103ef0 <fdalloc>
  104281:	85 c0                	test   %eax,%eax
  104283:	89 c3                	mov    %eax,%ebx
  104285:	78 19                	js     1042a0 <sys_dup+0x40>
    return -1;
  filedup(f);
  104287:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10428b:	89 04 24             	mov    %eax,(%esp)
  10428e:	e8 8d df ff ff       	call   102220 <filedup>
  return fd;
}
  104293:	83 c4 28             	add    $0x28,%esp
  104296:	89 d8                	mov    %ebx,%eax
  104298:	5b                   	pop    %ebx
  104299:	c3                   	ret    
  10429a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  1042a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1042a5:	eb ec                	jmp    104293 <sys_dup+0x33>
  1042a7:	89 f6                	mov    %esi,%esi
  1042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001042b0 <sys_close>:
  return fd;
}

int
sys_close(void)
{
  1042b0:	83 ec 2c             	sub    $0x2c,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
  1042b3:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  1042b7:	8d 44 24 18          	lea    0x18(%esp),%eax
  1042bb:	e8 30 fe ff ff       	call   1040f0 <argfd.constprop.0>
    return -1;
  1042c0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
sys_close(void)
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
  1042c5:	85 c0                	test   %eax,%eax
  1042c7:	78 1f                	js     1042e8 <sys_close+0x38>
    return -1;
  cp->ofile[fd] = 0;
  1042c9:	e8 c2 d1 ff ff       	call   101490 <curproc>
  1042ce:	8b 54 24 18          	mov    0x18(%esp),%edx
  1042d2:	c7 44 90 20 00 00 00 	movl   $0x0,0x20(%eax,%edx,4)
  1042d9:	00 
  fileclose(f);
  1042da:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1042de:	89 04 24             	mov    %eax,(%esp)
  1042e1:	e8 8a df ff ff       	call   102270 <fileclose>
  return 0;
  1042e6:	31 d2                	xor    %edx,%edx
}
  1042e8:	89 d0                	mov    %edx,%eax
  1042ea:	83 c4 2c             	add    $0x2c,%esp
  1042ed:	c3                   	ret    
  1042ee:	66 90                	xchg   %ax,%ax

001042f0 <sys_fstat>:

int
sys_fstat(void)
{
  1042f0:	53                   	push   %ebx
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  1042f1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  1042f3:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  1042f6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
sys_fstat(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  1042fb:	8d 54 24 18          	lea    0x18(%esp),%edx
  1042ff:	e8 ec fd ff ff       	call   1040f0 <argfd.constprop.0>
  104304:	85 c0                	test   %eax,%eax
  104306:	78 36                	js     10433e <sys_fstat+0x4e>
  104308:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  10430c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104313:	00 
  104314:	89 44 24 04          	mov    %eax,0x4(%esp)
  104318:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10431f:	e8 4c fa ff ff       	call   103d70 <argptr>
  104324:	85 c0                	test   %eax,%eax
  104326:	78 16                	js     10433e <sys_fstat+0x4e>
    return -1;
  return filestat(f, st);
  104328:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10432c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104330:	8b 44 24 18          	mov    0x18(%esp),%eax
  104334:	89 04 24             	mov    %eax,(%esp)
  104337:	e8 24 e0 ff ff       	call   102360 <filestat>
  10433c:	89 c3                	mov    %eax,%ebx
}
  10433e:	83 c4 28             	add    $0x28,%esp
  104341:	89 d8                	mov    %ebx,%eax
  104343:	5b                   	pop    %ebx
  104344:	c3                   	ret    
  104345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104350 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104350:	57                   	push   %edi
  104351:	56                   	push   %esi
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;
  104352:	be ff ff ff ff       	mov    $0xffffffff,%esi
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104357:	53                   	push   %ebx
  104358:	83 ec 30             	sub    $0x30,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  10435b:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  10435f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104363:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10436a:	e8 61 fa ff ff       	call   103dd0 <argstr>
  10436f:	85 c0                	test   %eax,%eax
  104371:	0f 88 a7 00 00 00    	js     10441e <sys_link+0xce>
  104377:	8d 44 24 28          	lea    0x28(%esp),%eax
  10437b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10437f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104386:	e8 45 fa ff ff       	call   103dd0 <argstr>
  10438b:	85 c0                	test   %eax,%eax
  10438d:	0f 88 8b 00 00 00    	js     10441e <sys_link+0xce>
    return -1;
  if((ip = namei(old)) == 0)
  104393:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  104397:	89 04 24             	mov    %eax,(%esp)
  10439a:	e8 91 ef ff ff       	call   103330 <namei>
  10439f:	85 c0                	test   %eax,%eax
  1043a1:	89 c3                	mov    %eax,%ebx
  1043a3:	74 79                	je     10441e <sys_link+0xce>
    return -1;
  ilock(ip);
  1043a5:	89 04 24             	mov    %eax,(%esp)
  1043a8:	e8 63 e5 ff ff       	call   102910 <ilock>
  if(ip->type == T_DIR){
  1043ad:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1043b2:	0f 84 a8 00 00 00    	je     104460 <sys_link+0x110>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  1043b8:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  1043bd:	8d 7c 24 1a          	lea    0x1a(%esp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  1043c1:	89 1c 24             	mov    %ebx,(%esp)
  1043c4:	e8 67 e7 ff ff       	call   102b30 <iupdate>
  iunlock(ip);
  1043c9:	89 1c 24             	mov    %ebx,(%esp)
  1043cc:	e8 3f e6 ff ff       	call   102a10 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  1043d1:	8b 44 24 28          	mov    0x28(%esp),%eax
  1043d5:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1043d9:	89 04 24             	mov    %eax,(%esp)
  1043dc:	e8 6f ef ff ff       	call   103350 <nameiparent>
  1043e1:	85 c0                	test   %eax,%eax
  1043e3:	89 c6                	mov    %eax,%esi
  1043e5:	74 49                	je     104430 <sys_link+0xe0>
    goto  bad;
  ilock(dp);
  1043e7:	89 04 24             	mov    %eax,(%esp)
  1043ea:	e8 21 e5 ff ff       	call   102910 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
  1043ef:	8b 03                	mov    (%ebx),%eax
  1043f1:	39 06                	cmp    %eax,(%esi)
  1043f3:	75 33                	jne    104428 <sys_link+0xd8>
  1043f5:	8b 43 04             	mov    0x4(%ebx),%eax
  1043f8:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1043fc:	89 34 24             	mov    %esi,(%esp)
  1043ff:	89 44 24 08          	mov    %eax,0x8(%esp)
  104403:	e8 48 ee ff ff       	call   103250 <dirlink>
  104408:	85 c0                	test   %eax,%eax
  10440a:	78 1c                	js     104428 <sys_link+0xd8>
    goto bad;
  iunlockput(dp);
  10440c:	89 34 24             	mov    %esi,(%esp)
  iput(ip);
  return 0;
  10440f:	31 f6                	xor    %esi,%esi
  if((dp = nameiparent(new, name)) == 0)
    goto  bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
    goto bad;
  iunlockput(dp);
  104411:	e8 ea e8 ff ff       	call   102d00 <iunlockput>
  iput(ip);
  104416:	89 1c 24             	mov    %ebx,(%esp)
  104419:	e8 a2 e7 ff ff       	call   102bc0 <iput>
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
}
  10441e:	83 c4 30             	add    $0x30,%esp
  104421:	89 f0                	mov    %esi,%eax
  104423:	5b                   	pop    %ebx
  104424:	5e                   	pop    %esi
  104425:	5f                   	pop    %edi
  104426:	c3                   	ret    
  104427:	90                   	nop
  iput(ip);
  return 0;

bad:
  if(dp)
    iunlockput(dp);
  104428:	89 34 24             	mov    %esi,(%esp)
  10442b:	e8 d0 e8 ff ff       	call   102d00 <iunlockput>
  ilock(ip);
  104430:	89 1c 24             	mov    %ebx,(%esp)
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  104433:	be ff ff ff ff       	mov    $0xffffffff,%esi
  return 0;

bad:
  if(dp)
    iunlockput(dp);
  ilock(ip);
  104438:	e8 d3 e4 ff ff       	call   102910 <ilock>
  ip->nlink--;
  10443d:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  104442:	89 1c 24             	mov    %ebx,(%esp)
  104445:	e8 e6 e6 ff ff       	call   102b30 <iupdate>
  iunlockput(ip);
  10444a:	89 1c 24             	mov    %ebx,(%esp)
  10444d:	e8 ae e8 ff ff       	call   102d00 <iunlockput>
  return -1;
}
  104452:	83 c4 30             	add    $0x30,%esp
  104455:	89 f0                	mov    %esi,%eax
  104457:	5b                   	pop    %ebx
  104458:	5e                   	pop    %esi
  104459:	5f                   	pop    %edi
  10445a:	c3                   	ret    
  10445b:	90                   	nop
  10445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if((ip = namei(old)) == 0)
    return -1;
  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
  104460:	89 1c 24             	mov    %ebx,(%esp)
  104463:	e8 98 e8 ff ff       	call   102d00 <iunlockput>
    return -1;
  104468:	eb b4                	jmp    10441e <sys_link+0xce>
  10446a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104470 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  104470:	55                   	push   %ebp
  104471:	57                   	push   %edi
  104472:	56                   	push   %esi
  104473:	53                   	push   %ebx
  104474:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104477:	8d 44 24 48          	lea    0x48(%esp),%eax
  10447b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10447f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104486:	e8 45 f9 ff ff       	call   103dd0 <argstr>
  10448b:	85 c0                	test   %eax,%eax
  10448d:	0f 88 63 01 00 00    	js     1045f6 <sys_unlink+0x186>
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  104493:	8b 44 24 48          	mov    0x48(%esp),%eax
  104497:	8d 5c 24 3a          	lea    0x3a(%esp),%ebx
  10449b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10449f:	89 04 24             	mov    %eax,(%esp)
  1044a2:	e8 a9 ee ff ff       	call   103350 <nameiparent>
  1044a7:	85 c0                	test   %eax,%eax
  1044a9:	89 c5                	mov    %eax,%ebp
  1044ab:	0f 84 45 01 00 00    	je     1045f6 <sys_unlink+0x186>
    return -1;
  ilock(dp);
  1044b1:	89 04 24             	mov    %eax,(%esp)
  1044b4:	e8 57 e4 ff ff       	call   102910 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  1044b9:	c7 44 24 04 75 63 10 	movl   $0x106375,0x4(%esp)
  1044c0:	00 
  1044c1:	89 1c 24             	mov    %ebx,(%esp)
  1044c4:	e8 d7 ea ff ff       	call   102fa0 <namecmp>
  1044c9:	85 c0                	test   %eax,%eax
  1044cb:	0f 84 10 01 00 00    	je     1045e1 <sys_unlink+0x171>
  1044d1:	c7 44 24 04 74 63 10 	movl   $0x106374,0x4(%esp)
  1044d8:	00 
  1044d9:	89 1c 24             	mov    %ebx,(%esp)
  1044dc:	e8 bf ea ff ff       	call   102fa0 <namecmp>
  1044e1:	85 c0                	test   %eax,%eax
  1044e3:	0f 84 f8 00 00 00    	je     1045e1 <sys_unlink+0x171>
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  1044e9:	8d 44 24 4c          	lea    0x4c(%esp),%eax
  1044ed:	89 44 24 08          	mov    %eax,0x8(%esp)
  1044f1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1044f5:	89 2c 24             	mov    %ebp,(%esp)
  1044f8:	e8 d3 ea ff ff       	call   102fd0 <dirlookup>
  1044fd:	85 c0                	test   %eax,%eax
  1044ff:	89 c6                	mov    %eax,%esi
  104501:	0f 84 da 00 00 00    	je     1045e1 <sys_unlink+0x171>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104507:	89 04 24             	mov    %eax,(%esp)
  10450a:	e8 01 e4 ff ff       	call   102910 <ilock>

  if(ip->nlink < 1)
  10450f:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104514:	0f 8e fb 00 00 00    	jle    104615 <sys_unlink+0x1a5>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  10451a:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  10451f:	74 6f                	je     104590 <sys_unlink+0x120>
    iunlockput(ip);
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  104521:	8d 5c 24 1a          	lea    0x1a(%esp),%ebx
  104525:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10452c:	00 
  10452d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104534:	00 
  104535:	89 1c 24             	mov    %ebx,(%esp)
  104538:	e8 d3 c8 ff ff       	call   100e10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10453d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  104541:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104548:	00 
  104549:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10454d:	89 2c 24             	mov    %ebp,(%esp)
  104550:	89 44 24 08          	mov    %eax,0x8(%esp)
  104554:	e8 07 e9 ff ff       	call   102e60 <writei>
  104559:	83 f8 10             	cmp    $0x10,%eax
  10455c:	0f 85 a7 00 00 00    	jne    104609 <sys_unlink+0x199>
    panic("unlink: writei");
  iunlockput(dp);
  104562:	89 2c 24             	mov    %ebp,(%esp)
  104565:	e8 96 e7 ff ff       	call   102d00 <iunlockput>

  ip->nlink--;
  10456a:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  10456f:	89 34 24             	mov    %esi,(%esp)
  104572:	e8 b9 e5 ff ff       	call   102b30 <iupdate>
  iunlockput(ip);
  104577:	89 34 24             	mov    %esi,(%esp)
  10457a:	e8 81 e7 ff ff       	call   102d00 <iunlockput>
  return 0;
  10457f:	31 c0                	xor    %eax,%eax
}
  104581:	83 c4 5c             	add    $0x5c,%esp
  104584:	5b                   	pop    %ebx
  104585:	5e                   	pop    %esi
  104586:	5f                   	pop    %edi
  104587:	5d                   	pop    %ebp
  104588:	c3                   	ret    
  104589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104590:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104594:	76 8b                	jbe    104521 <sys_unlink+0xb1>
  104596:	bb 20 00 00 00       	mov    $0x20,%ebx
  10459b:	8d 7c 24 2a          	lea    0x2a(%esp),%edi
  10459f:	eb 13                	jmp    1045b4 <sys_unlink+0x144>
  1045a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1045a8:	83 c3 10             	add    $0x10,%ebx
  1045ab:	3b 5e 18             	cmp    0x18(%esi),%ebx
  1045ae:	0f 83 6d ff ff ff    	jae    104521 <sys_unlink+0xb1>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1045b4:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1045bb:	00 
  1045bc:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1045c0:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1045c4:	89 34 24             	mov    %esi,(%esp)
  1045c7:	e8 84 e7 ff ff       	call   102d50 <readi>
  1045cc:	83 f8 10             	cmp    $0x10,%eax
  1045cf:	75 2c                	jne    1045fd <sys_unlink+0x18d>
      panic("isdirempty: readi");
    if(de.inum != 0)
  1045d1:	66 83 7c 24 2a 00    	cmpw   $0x0,0x2a(%esp)
  1045d7:	74 cf                	je     1045a8 <sys_unlink+0x138>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  1045d9:	89 34 24             	mov    %esi,(%esp)
  1045dc:	e8 1f e7 ff ff       	call   102d00 <iunlockput>
    iunlockput(dp);
  1045e1:	89 2c 24             	mov    %ebp,(%esp)
  1045e4:	e8 17 e7 ff ff       	call   102d00 <iunlockput>

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}
  1045e9:	83 c4 5c             	add    $0x5c,%esp
  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
    return -1;
  1045ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}
  1045f1:	5b                   	pop    %ebx
  1045f2:	5e                   	pop    %esi
  1045f3:	5f                   	pop    %edi
  1045f4:	5d                   	pop    %ebp
  1045f5:	c3                   	ret    
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
    return -1;
  1045f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1045fb:	eb 84                	jmp    104581 <sys_unlink+0x111>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  1045fd:	c7 04 24 95 63 10 00 	movl   $0x106395,(%esp)
  104604:	e8 a7 c4 ff ff       	call   100ab0 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104609:	c7 04 24 a7 63 10 00 	movl   $0x1063a7,(%esp)
  104610:	e8 9b c4 ff ff       	call   100ab0 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104615:	c7 04 24 83 63 10 00 	movl   $0x106383,(%esp)
  10461c:	e8 8f c4 ff ff       	call   100ab0 <panic>
  104621:	eb 0d                	jmp    104630 <sys_open>
  104623:	90                   	nop
  104624:	90                   	nop
  104625:	90                   	nop
  104626:	90                   	nop
  104627:	90                   	nop
  104628:	90                   	nop
  104629:	90                   	nop
  10462a:	90                   	nop
  10462b:	90                   	nop
  10462c:	90                   	nop
  10462d:	90                   	nop
  10462e:	90                   	nop
  10462f:	90                   	nop

00104630 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104630:	57                   	push   %edi
  104631:	56                   	push   %esi
  104632:	53                   	push   %ebx
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;
  104633:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return ip;
}

int
sys_open(void)
{
  104638:	83 ec 20             	sub    $0x20,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  10463b:	8d 44 24 18          	lea    0x18(%esp),%eax
  10463f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104643:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10464a:	e8 81 f7 ff ff       	call   103dd0 <argstr>
  10464f:	85 c0                	test   %eax,%eax
  104651:	0f 88 86 00 00 00    	js     1046dd <sys_open+0xad>
  104657:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  10465b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10465f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104666:	e8 b5 f6 ff ff       	call   103d20 <argint>
  10466b:	85 c0                	test   %eax,%eax
  10466d:	78 6e                	js     1046dd <sys_open+0xad>
    return -1;

  if(omode & O_CREATE){
  10466f:	f6 44 24 1d 02       	testb  $0x2,0x1d(%esp)
  104674:	75 72                	jne    1046e8 <sys_open+0xb8>
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104676:	8b 44 24 18          	mov    0x18(%esp),%eax
  10467a:	89 04 24             	mov    %eax,(%esp)
  10467d:	e8 ae ec ff ff       	call   103330 <namei>
  104682:	85 c0                	test   %eax,%eax
  104684:	89 c7                	mov    %eax,%edi
  104686:	74 55                	je     1046dd <sys_open+0xad>
      return -1;
    ilock(ip);
  104688:	89 04 24             	mov    %eax,(%esp)
  10468b:	e8 80 e2 ff ff       	call   102910 <ilock>
    if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
  104690:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  104695:	0f 84 7d 00 00 00    	je     104718 <sys_open+0xe8>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  10469b:	e8 00 db ff ff       	call   1021a0 <filealloc>
  1046a0:	85 c0                	test   %eax,%eax
  1046a2:	89 c6                	mov    %eax,%esi
  1046a4:	0f 84 8e 00 00 00    	je     104738 <sys_open+0x108>
  1046aa:	e8 41 f8 ff ff       	call   103ef0 <fdalloc>
  1046af:	85 c0                	test   %eax,%eax
  1046b1:	89 c3                	mov    %eax,%ebx
  1046b3:	78 7b                	js     104730 <sys_open+0x100>
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  1046b5:	89 3c 24             	mov    %edi,(%esp)
  1046b8:	e8 53 e3 ff ff       	call   102a10 <iunlock>

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  1046bd:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  1046c1:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
  f->ip = ip;
  1046c7:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  1046ca:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  1046d1:	a8 01                	test   $0x1,%al
  1046d3:	0f 94 46 08          	sete   0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  1046d7:	a8 03                	test   $0x3,%al
  1046d9:	0f 95 46 09          	setne  0x9(%esi)

  return fd;
}
  1046dd:	83 c4 20             	add    $0x20,%esp
  1046e0:	89 d8                	mov    %ebx,%eax
  1046e2:	5b                   	pop    %ebx
  1046e3:	5e                   	pop    %esi
  1046e4:	5f                   	pop    %edi
  1046e5:	c3                   	ret    
  1046e6:	66 90                	xchg   %ax,%ax

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  if(omode & O_CREATE){
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
  1046e8:	8b 44 24 18          	mov    0x18(%esp),%eax
  1046ec:	b9 02 00 00 00       	mov    $0x2,%ecx
  1046f1:	ba 01 00 00 00       	mov    $0x1,%edx
  1046f6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1046fd:	00 
  1046fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104705:	e8 26 f8 ff ff       	call   103f30 <create>
  10470a:	85 c0                	test   %eax,%eax
  10470c:	89 c7                	mov    %eax,%edi
  10470e:	75 8b                	jne    10469b <sys_open+0x6b>
  104710:	eb cb                	jmp    1046dd <sys_open+0xad>
  104712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return -1;
  } else {
    if((ip = namei(path)) == 0)
      return -1;
    ilock(ip);
    if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
  104718:	f6 44 24 1c 03       	testb  $0x3,0x1c(%esp)
  10471d:	0f 84 78 ff ff ff    	je     10469b <sys_open+0x6b>
      iunlockput(ip);
  104723:	89 3c 24             	mov    %edi,(%esp)
  104726:	e8 d5 e5 ff ff       	call   102d00 <iunlockput>
      return -1;
  10472b:	eb b0                	jmp    1046dd <sys_open+0xad>
  10472d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104730:	89 34 24             	mov    %esi,(%esp)
  104733:	e8 38 db ff ff       	call   102270 <fileclose>
    iunlockput(ip);
  104738:	89 3c 24             	mov    %edi,(%esp)
    return -1;
  10473b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
  104740:	e8 bb e5 ff ff       	call   102d00 <iunlockput>
    return -1;
  104745:	eb 96                	jmp    1046dd <sys_open+0xad>
  104747:	89 f6                	mov    %esi,%esi
  104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104750 <sys_mknod>:
  return fd;
}

int
sys_mknod(void)
{
  104750:	53                   	push   %ebx

  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  104751:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return fd;
}

int
sys_mknod(void)
{
  104756:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;

  if((len=argstr(0, &path)) < 0 ||
  104759:	8d 44 24 14          	lea    0x14(%esp),%eax
  10475d:	89 44 24 04          	mov    %eax,0x4(%esp)
  104761:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104768:	e8 63 f6 ff ff       	call   103dd0 <argstr>
  10476d:	85 c0                	test   %eax,%eax
  10476f:	78 5f                	js     1047d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
  104771:	8d 44 24 18          	lea    0x18(%esp),%eax
  104775:	89 44 24 04          	mov    %eax,0x4(%esp)
  104779:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104780:	e8 9b f5 ff ff       	call   103d20 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;

  if((len=argstr(0, &path)) < 0 ||
  104785:	85 c0                	test   %eax,%eax
  104787:	78 47                	js     1047d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  104789:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  10478d:	89 44 24 04          	mov    %eax,0x4(%esp)
  104791:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104798:	e8 83 f5 ff ff       	call   103d20 <argint>
  char *path;
  int len;
  int major, minor;

  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
  10479d:	85 c0                	test   %eax,%eax
  10479f:	78 2f                	js     1047d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
  1047a1:	0f bf 44 24 1c       	movswl 0x1c(%esp),%eax
  int len;
  int major, minor;

  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  1047a6:	31 d2                	xor    %edx,%edx
  1047a8:	b9 03 00 00 00       	mov    $0x3,%ecx
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
  1047ad:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047b1:	0f bf 44 24 18       	movswl 0x18(%esp),%eax
  1047b6:	89 04 24             	mov    %eax,(%esp)
  int len;
  int major, minor;

  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  1047b9:	8b 44 24 14          	mov    0x14(%esp),%eax
  1047bd:	e8 6e f7 ff ff       	call   103f30 <create>
  1047c2:	85 c0                	test   %eax,%eax
  1047c4:	74 0a                	je     1047d0 <sys_mknod+0x80>
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  1047c6:	89 04 24             	mov    %eax,(%esp)
  return 0;
  1047c9:	31 db                	xor    %ebx,%ebx
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  1047cb:	e8 30 e5 ff ff       	call   102d00 <iunlockput>
  return 0;
}
  1047d0:	83 c4 28             	add    $0x28,%esp
  1047d3:	89 d8                	mov    %ebx,%eax
  1047d5:	5b                   	pop    %ebx
  1047d6:	c3                   	ret    
  1047d7:	89 f6                	mov    %esi,%esi
  1047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001047e0 <sys_mkdir>:

int
sys_mkdir(void)
{
  1047e0:	53                   	push   %ebx
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
    return -1;
  1047e1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_mkdir(void)
{
  1047e6:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  1047e9:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  1047ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047f1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1047f8:	e8 d3 f5 ff ff       	call   103dd0 <argstr>
  1047fd:	85 c0                	test   %eax,%eax
  1047ff:	78 2d                	js     10482e <sys_mkdir+0x4e>
  104801:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104805:	31 d2                	xor    %edx,%edx
  104807:	b9 01 00 00 00       	mov    $0x1,%ecx
  10480c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104813:	00 
  104814:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10481b:	e8 10 f7 ff ff       	call   103f30 <create>
  104820:	85 c0                	test   %eax,%eax
  104822:	74 0a                	je     10482e <sys_mkdir+0x4e>
    return -1;
  iunlockput(ip);
  104824:	89 04 24             	mov    %eax,(%esp)
  return 0;
  104827:	31 db                	xor    %ebx,%ebx
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
    return -1;
  iunlockput(ip);
  104829:	e8 d2 e4 ff ff       	call   102d00 <iunlockput>
  return 0;
}
  10482e:	83 c4 28             	add    $0x28,%esp
  104831:	89 d8                	mov    %ebx,%eax
  104833:	5b                   	pop    %ebx
  104834:	c3                   	ret    
  104835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104840 <sys_chdir>:

int
sys_chdir(void)
{
  104840:	56                   	push   %esi
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  104841:	be ff ff ff ff       	mov    $0xffffffff,%esi
  return 0;
}

int
sys_chdir(void)
{
  104846:	53                   	push   %ebx
  104847:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  10484a:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  10484e:	89 44 24 04          	mov    %eax,0x4(%esp)
  104852:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104859:	e8 72 f5 ff ff       	call   103dd0 <argstr>
  10485e:	85 c0                	test   %eax,%eax
  104860:	78 43                	js     1048a5 <sys_chdir+0x65>
  104862:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104866:	89 04 24             	mov    %eax,(%esp)
  104869:	e8 c2 ea ff ff       	call   103330 <namei>
  10486e:	85 c0                	test   %eax,%eax
  104870:	89 c3                	mov    %eax,%ebx
  104872:	74 31                	je     1048a5 <sys_chdir+0x65>
    return -1;
  ilock(ip);
  104874:	89 04 24             	mov    %eax,(%esp)
  104877:	e8 94 e0 ff ff       	call   102910 <ilock>
  if(ip->type != T_DIR){
  10487c:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
    iunlockput(ip);
  104881:	89 1c 24             	mov    %ebx,(%esp)
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
  104884:	75 2a                	jne    1048b0 <sys_chdir+0x70>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104886:	e8 85 e1 ff ff       	call   102a10 <iunlock>
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
  10488b:	31 f6                	xor    %esi,%esi
  if(ip->type != T_DIR){
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  iput(cp->cwd);
  10488d:	e8 fe cb ff ff       	call   101490 <curproc>
  104892:	8b 40 60             	mov    0x60(%eax),%eax
  104895:	89 04 24             	mov    %eax,(%esp)
  104898:	e8 23 e3 ff ff       	call   102bc0 <iput>
  cp->cwd = ip;
  10489d:	e8 ee cb ff ff       	call   101490 <curproc>
  1048a2:	89 58 60             	mov    %ebx,0x60(%eax)
  return 0;
}
  1048a5:	83 c4 24             	add    $0x24,%esp
  1048a8:	89 f0                	mov    %esi,%eax
  1048aa:	5b                   	pop    %ebx
  1048ab:	5e                   	pop    %esi
  1048ac:	c3                   	ret    
  1048ad:	8d 76 00             	lea    0x0(%esi),%esi

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  1048b0:	e8 4b e4 ff ff       	call   102d00 <iunlockput>
    return -1;
  1048b5:	eb ee                	jmp    1048a5 <sys_chdir+0x65>
  1048b7:	89 f6                	mov    %esi,%esi
  1048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001048c0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  1048c0:	55                   	push   %ebp
  1048c1:	57                   	push   %edi
  1048c2:	56                   	push   %esi
  1048c3:	53                   	push   %ebx
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  1048c4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_exec(void)
{
  1048c9:	83 ec 7c             	sub    $0x7c,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  1048cc:	8d 44 24 64          	lea    0x64(%esp),%eax
  1048d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1048db:	e8 f0 f4 ff ff       	call   103dd0 <argstr>
  1048e0:	85 c0                	test   %eax,%eax
  1048e2:	0f 88 94 00 00 00    	js     10497c <sys_exec+0xbc>
  1048e8:	8d 44 24 68          	lea    0x68(%esp),%eax
  1048ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1048f7:	e8 24 f4 ff ff       	call   103d20 <argint>
  1048fc:	85 c0                	test   %eax,%eax
  1048fe:	78 7c                	js     10497c <sys_exec+0xbc>
    return -1;
  memset(argv, 0, sizeof(argv));
  104900:	8d 6c 24 14          	lea    0x14(%esp),%ebp
  for(i=0;; i++){
    if(i >= NELEM(argv))
  104904:	31 ff                	xor    %edi,%edi
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  104906:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  10490d:	00 
  for(i=0;; i++){
  10490e:	31 db                	xor    %ebx,%ebx
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  104910:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104917:	00 
  104918:	89 2c 24             	mov    %ebp,(%esp)
  10491b:	e8 f0 c4 ff ff       	call   100e10 <memset>
  cp->cwd = ip;
  return 0;
}

int
sys_exec(void)
  104920:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
  104927:	03 74 24 68          	add    0x68(%esp),%esi
  10492b:	e8 60 cb ff ff       	call   101490 <curproc>
  104930:	8d 54 24 6c          	lea    0x6c(%esp),%edx
  104934:	89 54 24 08          	mov    %edx,0x8(%esp)
  104938:	89 74 24 04          	mov    %esi,0x4(%esp)
  10493c:	89 04 24             	mov    %eax,(%esp)
  10493f:	e8 4c f3 ff ff       	call   103c90 <fetchint>
  104944:	85 c0                	test   %eax,%eax
  104946:	78 2f                	js     104977 <sys_exec+0xb7>
      return -1;
    if(uarg == 0){
  104948:	8b 74 24 6c          	mov    0x6c(%esp),%esi
  10494c:	85 f6                	test   %esi,%esi
  10494e:	74 38                	je     104988 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
  104950:	e8 3b cb ff ff       	call   101490 <curproc>
  104955:	8d 54 bd 00          	lea    0x0(%ebp,%edi,4),%edx
  104959:	89 54 24 08          	mov    %edx,0x8(%esp)
  10495d:	89 74 24 04          	mov    %esi,0x4(%esp)
  104961:	89 04 24             	mov    %eax,(%esp)
  104964:	e8 67 f3 ff ff       	call   103cd0 <fetchstr>
  104969:	85 c0                	test   %eax,%eax
  10496b:	78 0a                	js     104977 <sys_exec+0xb7>
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  10496d:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
  104970:	83 fb 14             	cmp    $0x14,%ebx
  104973:	89 df                	mov    %ebx,%edi
  104975:	75 a9                	jne    104920 <sys_exec+0x60>
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  104977:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  }
  return exec(path, argv);
}
  10497c:	83 c4 7c             	add    $0x7c,%esp
  10497f:	89 d8                	mov    %ebx,%eax
  104981:	5b                   	pop    %ebx
  104982:	5e                   	pop    %esi
  104983:	5f                   	pop    %edi
  104984:	5d                   	pop    %ebp
  104985:	c3                   	ret    
  104986:	66 90                	xchg   %ax,%ax
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104988:	8b 44 24 64          	mov    0x64(%esp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  10498c:	c7 44 9c 14 00 00 00 	movl   $0x0,0x14(%esp,%ebx,4)
  104993:	00 
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104994:	89 6c 24 04          	mov    %ebp,0x4(%esp)
  104998:	89 04 24             	mov    %eax,(%esp)
  10499b:	e8 60 02 00 00       	call   104c00 <exec>
}
  1049a0:	83 c4 7c             	add    $0x7c,%esp
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  1049a3:	89 c3                	mov    %eax,%ebx
}
  1049a5:	89 d8                	mov    %ebx,%eax
  1049a7:	5b                   	pop    %ebx
  1049a8:	5e                   	pop    %esi
  1049a9:	5f                   	pop    %edi
  1049aa:	5d                   	pop    %ebp
  1049ab:	c3                   	ret    
  1049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001049b0 <sys_pipe>:

int
sys_pipe(void)
{
  1049b0:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  1049b1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return exec(path, argv);
}

int
sys_pipe(void)
{
  1049b6:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  1049b9:	8d 44 24 14          	lea    0x14(%esp),%eax
  1049bd:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  1049c4:	00 
  1049c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049c9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1049d0:	e8 9b f3 ff ff       	call   103d70 <argptr>
  1049d5:	85 c0                	test   %eax,%eax
  1049d7:	78 3f                	js     104a18 <sys_pipe+0x68>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  1049d9:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  1049dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049e1:	8d 44 24 18          	lea    0x18(%esp),%eax
  1049e5:	89 04 24             	mov    %eax,(%esp)
  1049e8:	e8 e3 ee ff ff       	call   1038d0 <pipealloc>
  1049ed:	85 c0                	test   %eax,%eax
  1049ef:	78 27                	js     104a18 <sys_pipe+0x68>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  1049f1:	8b 44 24 18          	mov    0x18(%esp),%eax
  1049f5:	e8 f6 f4 ff ff       	call   103ef0 <fdalloc>
  1049fa:	85 c0                	test   %eax,%eax
  1049fc:	89 c3                	mov    %eax,%ebx
  1049fe:	78 2d                	js     104a2d <sys_pipe+0x7d>
  104a00:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104a04:	e8 e7 f4 ff ff       	call   103ef0 <fdalloc>
  104a09:	85 c0                	test   %eax,%eax
  104a0b:	78 13                	js     104a20 <sys_pipe+0x70>
      cp->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  104a0d:	8b 54 24 14          	mov    0x14(%esp),%edx
  104a11:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
  return 0;
  104a13:	31 db                	xor    %ebx,%ebx
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  104a15:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
  104a18:	83 c4 28             	add    $0x28,%esp
  104a1b:	89 d8                	mov    %ebx,%eax
  104a1d:	5b                   	pop    %ebx
  104a1e:	c3                   	ret    
  104a1f:	90                   	nop
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
  104a20:	e8 6b ca ff ff       	call   101490 <curproc>
  104a25:	c7 44 98 20 00 00 00 	movl   $0x0,0x20(%eax,%ebx,4)
  104a2c:	00 
    fileclose(rf);
  104a2d:	8b 44 24 18          	mov    0x18(%esp),%eax
    fileclose(wf);
    return -1;
  104a31:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
    fileclose(rf);
  104a36:	89 04 24             	mov    %eax,(%esp)
  104a39:	e8 32 d8 ff ff       	call   102270 <fileclose>
    fileclose(wf);
  104a3e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104a42:	89 04 24             	mov    %eax,(%esp)
  104a45:	e8 26 d8 ff ff       	call   102270 <fileclose>
    return -1;
  104a4a:	eb cc                	jmp    104a18 <sys_pipe+0x68>
  104a4c:	90                   	nop
  104a4d:	90                   	nop
  104a4e:	90                   	nop
  104a4f:	90                   	nop

00104a50 <sys_fork>:
#include "asm/x86/mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  104a50:	83 ec 1c             	sub    $0x1c,%esp
  int pid;
  struct proc *np;

  if((np = copyproc(cp)) == 0)
  104a53:	e8 38 ca ff ff       	call   101490 <curproc>
  104a58:	89 04 24             	mov    %eax,(%esp)
  104a5b:	e8 d0 c7 ff ff       	call   101230 <copyproc>
  104a60:	85 c0                	test   %eax,%eax
  104a62:	89 c2                	mov    %eax,%edx
  104a64:	74 0e                	je     104a74 <sys_fork+0x24>
    return -1;
  pid = np->pid;
  104a66:	8b 40 10             	mov    0x10(%eax),%eax
  np->state = RUNNABLE;
  104a69:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  return pid;
}
  104a70:	83 c4 1c             	add    $0x1c,%esp
  104a73:	c3                   	ret    
{
  int pid;
  struct proc *np;

  if((np = copyproc(cp)) == 0)
    return -1;
  104a74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104a79:	eb f5                	jmp    104a70 <sys_fork+0x20>
  104a7b:	90                   	nop
  104a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104a80 <sys_exit>:
  return pid;
}

int
sys_exit(void)
{
  104a80:	83 ec 0c             	sub    $0xc,%esp
  exit();
  104a83:	e8 58 ce ff ff       	call   1018e0 <exit>
  return 0;  // not reached
}
  104a88:	31 c0                	xor    %eax,%eax
  104a8a:	83 c4 0c             	add    $0xc,%esp
  104a8d:	c3                   	ret    
  104a8e:	66 90                	xchg   %ax,%ax

00104a90 <sys_wait>:

int
sys_wait(void)
{
  return wait();
  104a90:	e9 9b cf ff ff       	jmp    101a30 <wait>
  104a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104aa0 <sys_kill>:
}

int
sys_kill(void)
{
  104aa0:	83 ec 2c             	sub    $0x2c,%esp
  int pid;

  if(argint(0, &pid) < 0)
  104aa3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  104aa7:	89 44 24 04          	mov    %eax,0x4(%esp)
  104aab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104ab2:	e8 69 f2 ff ff       	call   103d20 <argint>
  104ab7:	89 c2                	mov    %eax,%edx
    return -1;
  104ab9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
  104abe:	85 d2                	test   %edx,%edx
  104ac0:	78 0c                	js     104ace <sys_kill+0x2e>
    return -1;
  return kill(pid);
  104ac2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104ac6:	89 04 24             	mov    %eax,(%esp)
  104ac9:	e8 92 cd ff ff       	call   101860 <kill>
}
  104ace:	83 c4 2c             	add    $0x2c,%esp
  104ad1:	c3                   	ret    
  104ad2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104ae0 <sys_getpid>:

int
sys_getpid(void)
{
  104ae0:	83 ec 0c             	sub    $0xc,%esp
  return cp->pid;
  104ae3:	e8 a8 c9 ff ff       	call   101490 <curproc>
  104ae8:	8b 40 10             	mov    0x10(%eax),%eax
}
  104aeb:	83 c4 0c             	add    $0xc,%esp
  104aee:	c3                   	ret    
  104aef:	90                   	nop

00104af0 <sys_sbrk>:

int
sys_sbrk(void)
{
  104af0:	83 ec 2c             	sub    $0x2c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  104af3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  104af7:	89 44 24 04          	mov    %eax,0x4(%esp)
  104afb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104b02:	e8 19 f2 ff ff       	call   103d20 <argint>
  104b07:	89 c2                	mov    %eax,%edx
    return -1;
  104b09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
  104b0e:	85 d2                	test   %edx,%edx
  104b10:	78 16                	js     104b28 <sys_sbrk+0x38>
    return -1;
  if((addr = growproc(n)) < 0)
  104b12:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104b16:	89 04 24             	mov    %eax,(%esp)
  104b19:	e8 d2 c9 ff ff       	call   1014f0 <growproc>
    return -1;
  104b1e:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  104b23:	85 c0                	test   %eax,%eax
  104b25:	0f 48 c2             	cmovs  %edx,%eax
  return addr;
}
  104b28:	83 c4 2c             	add    $0x2c,%esp
  104b2b:	c3                   	ret    
  104b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104b30 <sys_sleep>:

int
sys_sleep(void)
{
  104b30:	53                   	push   %ebx
  104b31:	83 ec 28             	sub    $0x28,%esp
  int n, ticks0;

  if(argint(0, &n) < 0)
  104b34:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  104b38:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b3c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104b43:	e8 d8 f1 ff ff       	call   103d20 <argint>
    return -1;
  104b48:	ba ff ff ff ff       	mov    $0xffffffff,%edx
int
sys_sleep(void)
{
  int n, ticks0;

  if(argint(0, &n) < 0)
  104b4d:	85 c0                	test   %eax,%eax
  104b4f:	78 5d                	js     104bae <sys_sleep+0x7e>
    return -1;
  acquire(&tickslock);
  104b51:	c7 04 24 40 21 11 00 	movl   $0x112140,(%esp)
  104b58:	e8 13 b7 ff ff       	call   100270 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104b5d:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  int n, ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  104b61:	8b 1d 80 29 11 00    	mov    0x112980,%ebx
  while(ticks - ticks0 < n){
  104b67:	85 d2                	test   %edx,%edx
  104b69:	7f 26                	jg     104b91 <sys_sleep+0x61>
  104b6b:	eb 4b                	jmp    104bb8 <sys_sleep+0x88>
  104b6d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cp->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  104b70:	c7 44 24 04 40 21 11 	movl   $0x112140,0x4(%esp)
  104b77:	00 
  104b78:	c7 04 24 80 29 11 00 	movl   $0x112980,(%esp)
  104b7f:	e8 ac cb ff ff       	call   101730 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104b84:	a1 80 29 11 00       	mov    0x112980,%eax
  104b89:	29 d8                	sub    %ebx,%eax
  104b8b:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
  104b8f:	7d 27                	jge    104bb8 <sys_sleep+0x88>
    if(cp->killed){
  104b91:	e8 fa c8 ff ff       	call   101490 <curproc>
  104b96:	8b 40 1c             	mov    0x1c(%eax),%eax
  104b99:	85 c0                	test   %eax,%eax
  104b9b:	74 d3                	je     104b70 <sys_sleep+0x40>
      release(&tickslock);
  104b9d:	c7 04 24 40 21 11 00 	movl   $0x112140,(%esp)
  104ba4:	e8 b7 b7 ff ff       	call   100360 <release>
      return -1;
  104ba9:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  104bae:	83 c4 28             	add    $0x28,%esp
  104bb1:	89 d0                	mov    %edx,%eax
  104bb3:	5b                   	pop    %ebx
  104bb4:	c3                   	ret    
  104bb5:	8d 76 00             	lea    0x0(%esi),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  104bb8:	c7 04 24 40 21 11 00 	movl   $0x112140,(%esp)
  104bbf:	e8 9c b7 ff ff       	call   100360 <release>
  return 0;
  104bc4:	31 d2                	xor    %edx,%edx
}
  104bc6:	83 c4 28             	add    $0x28,%esp
  104bc9:	89 d0                	mov    %edx,%eax
  104bcb:	5b                   	pop    %ebx
  104bcc:	c3                   	ret    
  104bcd:	90                   	nop
  104bce:	90                   	nop
  104bcf:	90                   	nop

00104bd0 <timer_init>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timer_init(void)
{
  104bd0:	83 ec 1c             	sub    $0x1c,%esp
  104bd3:	ba 43 00 00 00       	mov    $0x43,%edx
  104bd8:	b8 34 00 00 00       	mov    $0x34,%eax
  104bdd:	ee                   	out    %al,(%dx)
  104bde:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  104be3:	b2 40                	mov    $0x40,%dl
  104be5:	ee                   	out    %al,(%dx)
  104be6:	b8 2e 00 00 00       	mov    $0x2e,%eax
  104beb:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  pic_enable(IRQ_TIMER);
  104bec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104bf3:	e8 f8 eb ff ff       	call   1037f0 <pic_enable>
}
  104bf8:	83 c4 1c             	add    $0x1c,%esp
  104bfb:	c3                   	ret    
  104bfc:	90                   	nop
  104bfd:	90                   	nop
  104bfe:	90                   	nop
  104bff:	90                   	nop

00104c00 <exec>:
#include "asm/x86/x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  104c00:	55                   	push   %ebp
  104c01:	57                   	push   %edi
  104c02:	56                   	push   %esi
  104c03:	53                   	push   %ebx
  104c04:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  uint sz, sp, argp;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
  104c0a:	8b 94 24 b0 00 00 00 	mov    0xb0(%esp),%edx
  104c11:	89 14 24             	mov    %edx,(%esp)
  104c14:	e8 17 e7 ff ff       	call   103330 <namei>
  104c19:	85 c0                	test   %eax,%eax
  104c1b:	89 c3                	mov    %eax,%ebx
  104c1d:	0f 84 ed 03 00 00    	je     105010 <exec+0x410>
    return -1;
  ilock(ip);
  104c23:	89 04 24             	mov    %eax,(%esp)
  104c26:	e8 e5 dc ff ff       	call   102910 <ilock>
  // Compute memory size of new process.
  mem = 0;
  sz = 0;

  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  104c2b:	8d 44 24 3c          	lea    0x3c(%esp),%eax
  104c2f:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  104c36:	00 
  104c37:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104c3e:	00 
  104c3f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c43:	89 1c 24             	mov    %ebx,(%esp)
  104c46:	e8 05 e1 ff ff       	call   102d50 <readi>
  104c4b:	83 f8 33             	cmp    $0x33,%eax
  104c4e:	0f 86 78 03 00 00    	jbe    104fcc <exec+0x3cc>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  104c54:	81 7c 24 3c 7f 45 4c 	cmpl   $0x464c457f,0x3c(%esp)
  104c5b:	46 
  104c5c:	0f 85 6a 03 00 00    	jne    104fcc <exec+0x3cc>
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104c62:	66 83 7c 24 68 00    	cmpw   $0x0,0x68(%esp)
  104c68:	8b 7c 24 58          	mov    0x58(%esp),%edi
  104c6c:	0f 84 94 03 00 00    	je     105006 <exec+0x406>
    return -1;
  ilock(ip);

  // Compute memory size of new process.
  mem = 0;
  sz = 0;
  104c72:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  104c79:	00 
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104c7a:	31 ed                	xor    %ebp,%ebp
  104c7c:	8d 74 24 70          	lea    0x70(%esp),%esi
  104c80:	eb 15                	jmp    104c97 <exec+0x97>
  104c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104c88:	0f b7 44 24 68       	movzwl 0x68(%esp),%eax
  104c8d:	83 c5 01             	add    $0x1,%ebp
#include "defs.h"
#include "asm/x86/x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  104c90:	83 c7 20             	add    $0x20,%edi
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104c93:	39 e8                	cmp    %ebp,%eax
  104c95:	7e 4f                	jle    104ce6 <exec+0xe6>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  104c97:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  104c9e:	00 
  104c9f:	89 7c 24 08          	mov    %edi,0x8(%esp)
  104ca3:	89 74 24 04          	mov    %esi,0x4(%esp)
  104ca7:	89 1c 24             	mov    %ebx,(%esp)
  104caa:	e8 a1 e0 ff ff       	call   102d50 <readi>
  104caf:	83 f8 20             	cmp    $0x20,%eax
  104cb2:	0f 85 14 03 00 00    	jne    104fcc <exec+0x3cc>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  104cb8:	83 7c 24 70 01       	cmpl   $0x1,0x70(%esp)
  104cbd:	75 c9                	jne    104c88 <exec+0x88>
      continue;
    if(ph.memsz < ph.filesz)
  104cbf:	8b 84 24 84 00 00 00 	mov    0x84(%esp),%eax
  104cc6:	3b 84 24 80 00 00 00 	cmp    0x80(%esp),%eax
  104ccd:	0f 82 f9 02 00 00    	jb     104fcc <exec+0x3cc>
      goto bad;
    sz += ph.memsz;
  104cd3:	01 44 24 1c          	add    %eax,0x1c(%esp)
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104cd7:	83 c5 01             	add    $0x1,%ebp
  104cda:	0f b7 44 24 68       	movzwl 0x68(%esp),%eax
#include "defs.h"
#include "asm/x86/x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  104cdf:	83 c7 20             	add    $0x20,%edi
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104ce2:	39 e8                	cmp    %ebp,%eax
  104ce4:	7f b1                	jg     104c97 <exec+0x97>
  104ce6:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  104cea:	81 c7 ff 1f 00 00    	add    $0x1fff,%edi
    sz += ph.memsz;
  }

  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  104cf0:	8b 8c 24 b4 00 00 00 	mov    0xb4(%esp),%ecx
  104cf7:	8b 01                	mov    (%ecx),%eax
  104cf9:	85 c0                	test   %eax,%eax
  104cfb:	0f 84 e3 02 00 00    	je     104fe4 <exec+0x3e4>
  104d01:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
  104d05:	31 f6                	xor    %esi,%esi
  104d07:	31 ed                	xor    %ebp,%ebp
  104d09:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  104d10:	00 
  104d11:	89 cb                	mov    %ecx,%ebx
  104d13:	90                   	nop
  104d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    arglen += strlen(argv[argc]) + 1;
  104d18:	89 04 24             	mov    %eax,(%esp)
    sz += ph.memsz;
  }

  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  104d1b:	83 c5 01             	add    $0x1,%ebp
    arglen += strlen(argv[argc]) + 1;
  104d1e:	e8 dd c2 ff ff       	call   101000 <strlen>
  104d23:	8d 74 30 01          	lea    0x1(%eax,%esi,1),%esi
    sz += ph.memsz;
  }

  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  104d27:	8b 04 ab             	mov    (%ebx,%ebp,4),%eax
  104d2a:	85 c0                	test   %eax,%eax
  104d2c:	75 ea                	jne    104d18 <exec+0x118>
  104d2e:	83 c6 03             	add    $0x3,%esi
  104d31:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  104d35:	89 74 24 28          	mov    %esi,0x28(%esp)
  104d39:	83 64 24 28 fc       	andl   $0xfffffffc,0x28(%esp)
  104d3e:	8b 54 24 28          	mov    0x28(%esp),%edx
  104d42:	89 6c 24 2c          	mov    %ebp,0x2c(%esp)
  104d46:	89 6c 24 24          	mov    %ebp,0x24(%esp)
  104d4a:	8d 44 aa 04          	lea    0x4(%edx,%ebp,4),%eax

  // Stack.
  sz += PAGE;

  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  104d4e:	01 f8                	add    %edi,%eax
  104d50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  mem = kalloc(sz);
  104d55:	89 04 24             	mov    %eax,(%esp)

  // Stack.
  sz += PAGE;

  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  104d58:	89 44 24 20          	mov    %eax,0x20(%esp)
  mem = kalloc(sz);
  104d5c:	e8 df d0 ff ff       	call   101e40 <kalloc>
  if(mem == 0)
  104d61:	85 c0                	test   %eax,%eax
  // Stack.
  sz += PAGE;

  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  mem = kalloc(sz);
  104d63:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  if(mem == 0)
  104d67:	0f 84 5f 02 00 00    	je     104fcc <exec+0x3cc>
    goto bad;
  memset(mem, 0, sz);
  104d6d:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  104d71:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104d78:	00 
  104d79:	89 04 24             	mov    %eax,(%esp)
  104d7c:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  104d80:	e8 8b c0 ff ff       	call   100e10 <memset>

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104d85:	8b 7c 24 58          	mov    0x58(%esp),%edi
  104d89:	66 83 7c 24 68 00    	cmpw   $0x0,0x68(%esp)
  104d8f:	0f 84 c5 00 00 00    	je     104e5a <exec+0x25a>
  104d95:	31 ed                	xor    %ebp,%ebp
  104d97:	8d 74 24 70          	lea    0x70(%esp),%esi
  104d9b:	eb 16                	jmp    104db3 <exec+0x1b3>
  104d9d:	8d 76 00             	lea    0x0(%esi),%esi
  104da0:	0f b7 44 24 68       	movzwl 0x68(%esp),%eax
  104da5:	83 c5 01             	add    $0x1,%ebp
#include "defs.h"
#include "asm/x86/x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  104da8:	83 c7 20             	add    $0x20,%edi
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104dab:	39 e8                	cmp    %ebp,%eax
  104dad:	0f 8e a7 00 00 00    	jle    104e5a <exec+0x25a>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  104db3:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  104dba:	00 
  104dbb:	89 7c 24 08          	mov    %edi,0x8(%esp)
  104dbf:	89 74 24 04          	mov    %esi,0x4(%esp)
  104dc3:	89 1c 24             	mov    %ebx,(%esp)
  104dc6:	e8 85 df ff ff       	call   102d50 <readi>
  104dcb:	83 f8 20             	cmp    $0x20,%eax
  104dce:	0f 85 e4 01 00 00    	jne    104fb8 <exec+0x3b8>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  104dd4:	83 7c 24 70 01       	cmpl   $0x1,0x70(%esp)
  104dd9:	75 c5                	jne    104da0 <exec+0x1a0>
      continue;
    if(ph.va + ph.memsz > sz)
  104ddb:	8b 44 24 78          	mov    0x78(%esp),%eax
  104ddf:	8b 94 24 84 00 00 00 	mov    0x84(%esp),%edx
  104de6:	01 c2                	add    %eax,%edx
  104de8:	39 54 24 20          	cmp    %edx,0x20(%esp)
  104dec:	0f 82 c6 01 00 00    	jb     104fb8 <exec+0x3b8>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
  104df2:	8b 94 24 80 00 00 00 	mov    0x80(%esp),%edx
  104df9:	03 44 24 1c          	add    0x1c(%esp),%eax
  104dfd:	89 1c 24             	mov    %ebx,(%esp)
  104e00:	89 54 24 0c          	mov    %edx,0xc(%esp)
  104e04:	8b 54 24 74          	mov    0x74(%esp),%edx
  104e08:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e0c:	89 54 24 08          	mov    %edx,0x8(%esp)
  104e10:	e8 3b df ff ff       	call   102d50 <readi>
  104e15:	3b 84 24 80 00 00 00 	cmp    0x80(%esp),%eax
  104e1c:	0f 85 96 01 00 00    	jne    104fb8 <exec+0x3b8>
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  104e22:	8b 94 24 84 00 00 00 	mov    0x84(%esp),%edx
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104e29:	83 c5 01             	add    $0x1,%ebp
#include "defs.h"
#include "asm/x86/x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  104e2c:	83 c7 20             	add    $0x20,%edi
      continue;
    if(ph.va + ph.memsz > sz)
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  104e2f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104e36:	00 
  104e37:	29 c2                	sub    %eax,%edx
  104e39:	03 44 24 78          	add    0x78(%esp),%eax
  104e3d:	03 44 24 1c          	add    0x1c(%esp),%eax
  104e41:	89 54 24 08          	mov    %edx,0x8(%esp)
  104e45:	89 04 24             	mov    %eax,(%esp)
  104e48:	e8 c3 bf ff ff       	call   100e10 <memset>
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  104e4d:	0f b7 44 24 68       	movzwl 0x68(%esp),%eax
  104e52:	39 e8                	cmp    %ebp,%eax
  104e54:	0f 8f 59 ff ff ff    	jg     104db3 <exec+0x1b3>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  }
  iunlockput(ip);
  104e5a:	89 1c 24             	mov    %ebx,(%esp)
  104e5d:	e8 9e de ff ff       	call   102d00 <iunlockput>

  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  104e62:	8b 54 24 24          	mov    0x24(%esp),%edx
  104e66:	8b 44 24 20          	mov    0x20(%esp),%eax
  104e6a:	2b 44 24 28          	sub    0x28(%esp),%eax

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  104e6e:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  }
  iunlockput(ip);

  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  104e72:	f7 d2                	not    %edx
  104e74:	8d 2c 90             	lea    (%eax,%edx,4),%ebp

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  104e77:	8b 54 24 24          	mov    0x24(%esp),%edx
  for(i=argc-1; i>=0; i--){
  104e7b:	89 d3                	mov    %edx,%ebx
  104e7d:	83 eb 01             	sub    $0x1,%ebx
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  104e80:	8d 44 95 00          	lea    0x0(%ebp,%edx,4),%eax
  for(i=argc-1; i>=0; i--){
  104e84:	83 fb ff             	cmp    $0xffffffff,%ebx
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  104e87:	c7 04 01 00 00 00 00 	movl   $0x0,(%ecx,%eax,1)
  for(i=argc-1; i>=0; i--){
  104e8e:	74 53                	je     104ee3 <exec+0x2e3>
  104e90:	8d 3c 29             	lea    (%ecx,%ebp,1),%edi
  104e93:	8b 74 24 20          	mov    0x20(%esp),%esi
  104e97:	89 6c 24 28          	mov    %ebp,0x28(%esp)
  104e9b:	8b ac 24 b4 00 00 00 	mov    0xb4(%esp),%ebp
  104ea2:	89 7c 24 24          	mov    %edi,0x24(%esp)
  104ea6:	89 cf                	mov    %ecx,%edi
    len = strlen(argv[i]) + 1;
  104ea8:	8b 44 9d 00          	mov    0x0(%ebp,%ebx,4),%eax
  104eac:	89 04 24             	mov    %eax,(%esp)
  104eaf:	e8 4c c1 ff ff       	call   101000 <strlen>
  104eb4:	83 c0 01             	add    $0x1,%eax
    sp -= len;
  104eb7:	29 c6                	sub    %eax,%esi
    memmove(mem+sp, argv[i], len);
  104eb9:	89 44 24 08          	mov    %eax,0x8(%esp)
  104ebd:	8b 44 9d 00          	mov    0x0(%ebp,%ebx,4),%eax
  104ec1:	89 44 24 04          	mov    %eax,0x4(%esp)
  104ec5:	8d 04 37             	lea    (%edi,%esi,1),%eax
  104ec8:	89 04 24             	mov    %eax,(%esp)
  104ecb:	e8 d0 bf ff ff       	call   100ea0 <memmove>
    *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
  104ed0:	8b 54 24 24          	mov    0x24(%esp),%edx
  104ed4:	89 34 9a             	mov    %esi,(%edx,%ebx,4)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  104ed7:	83 eb 01             	sub    $0x1,%ebx
  104eda:	83 fb ff             	cmp    $0xffffffff,%ebx
  104edd:	75 c9                	jne    104ea8 <exec+0x2a8>
  104edf:	8b 6c 24 28          	mov    0x28(%esp),%ebp
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  104ee3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  104ee7:	8d 5d f4             	lea    -0xc(%ebp),%ebx
  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  104eea:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  104eee:	8b 8c 24 b0 00 00 00 	mov    0xb0(%esp),%ecx
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  104ef5:	89 6c 28 fc          	mov    %ebp,-0x4(%eax,%ebp,1)
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  104ef9:	89 54 28 f8          	mov    %edx,-0x8(%eax,%ebp,1)
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
  104efd:	c7 44 28 f4 ff ff ff 	movl   $0xffffffff,-0xc(%eax,%ebp,1)
  104f04:	ff 

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  104f05:	0f b6 11             	movzbl (%ecx),%edx
  104f08:	89 ce                	mov    %ecx,%esi
  104f0a:	84 d2                	test   %dl,%dl
  104f0c:	74 1b                	je     104f29 <exec+0x329>
#include "defs.h"
#include "asm/x86/x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
  104f0e:	8d 41 01             	lea    0x1(%ecx),%eax
  104f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
      last = s+1;
  104f18:	80 fa 2f             	cmp    $0x2f,%dl
  104f1b:	0f 44 f0             	cmove  %eax,%esi
  104f1e:	83 c0 01             	add    $0x1,%eax
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  104f21:	0f b6 50 ff          	movzbl -0x1(%eax),%edx
  104f25:	84 d2                	test   %dl,%dl
  104f27:	75 ef                	jne    104f18 <exec+0x318>
    if(*s == '/')
      last = s+1;
  safestrcpy(cp->name, last, sizeof(cp->name));
  104f29:	e8 62 c5 ff ff       	call   101490 <curproc>
  104f2e:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f32:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104f39:	00 
  104f3a:	05 88 00 00 00       	add    $0x88,%eax
  104f3f:	89 04 24             	mov    %eax,(%esp)
  104f42:	e8 79 c0 ff ff       	call   100fc0 <safestrcpy>

  // Commit to the new image.
  kfree(cp->mem, cp->sz);
  104f47:	e8 44 c5 ff ff       	call   101490 <curproc>
  104f4c:	8b 70 04             	mov    0x4(%eax),%esi
  104f4f:	e8 3c c5 ff ff       	call   101490 <curproc>
  104f54:	89 74 24 04          	mov    %esi,0x4(%esp)
  104f58:	8b 00                	mov    (%eax),%eax
  104f5a:	89 04 24             	mov    %eax,(%esp)
  104f5d:	e8 7e cd ff ff       	call   101ce0 <kfree>
  cp->mem = mem;
  104f62:	e8 29 c5 ff ff       	call   101490 <curproc>
  104f67:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  104f6b:	89 10                	mov    %edx,(%eax)
  cp->sz = sz;
  104f6d:	e8 1e c5 ff ff       	call   101490 <curproc>
  104f72:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  104f76:	89 48 04             	mov    %ecx,0x4(%eax)
  cp->tf->eip = elf.entry;  // main
  104f79:	e8 12 c5 ff ff       	call   101490 <curproc>
  104f7e:	8b 54 24 54          	mov    0x54(%esp),%edx
  104f82:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104f88:	89 50 30             	mov    %edx,0x30(%eax)
  cp->tf->esp = sp;
  104f8b:	e8 00 c5 ff ff       	call   101490 <curproc>
  104f90:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104f96:	89 58 3c             	mov    %ebx,0x3c(%eax)
  setupsegs(cp);
  104f99:	e8 f2 c4 ff ff       	call   101490 <curproc>
  104f9e:	89 04 24             	mov    %eax,(%esp)
  104fa1:	e8 9a c0 ff ff       	call   101040 <setupsegs>
 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
}
  104fa6:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  cp->mem = mem;
  cp->sz = sz;
  cp->tf->eip = elf.entry;  // main
  cp->tf->esp = sp;
  setupsegs(cp);
  return 0;
  104fac:	31 c0                	xor    %eax,%eax
 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
}
  104fae:	5b                   	pop    %ebx
  104faf:	5e                   	pop    %esi
  104fb0:	5f                   	pop    %edi
  104fb1:	5d                   	pop    %ebp
  104fb2:	c3                   	ret    
  104fb3:	90                   	nop
  104fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  setupsegs(cp);
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  104fb8:	8b 54 24 20          	mov    0x20(%esp),%edx
  104fbc:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104fc0:	89 54 24 04          	mov    %edx,0x4(%esp)
  104fc4:	89 04 24             	mov    %eax,(%esp)
  104fc7:	e8 14 cd ff ff       	call   101ce0 <kfree>
  iunlockput(ip);
  104fcc:	89 1c 24             	mov    %ebx,(%esp)
  104fcf:	e8 2c dd ff ff       	call   102d00 <iunlockput>
  return -1;
  104fd4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104fd9:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  104fdf:	5b                   	pop    %ebx
  104fe0:	5e                   	pop    %esi
  104fe1:	5f                   	pop    %edi
  104fe2:	5d                   	pop    %ebp
  104fe3:	c3                   	ret    
    sz += ph.memsz;
  }

  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  104fe4:	b8 04 00 00 00       	mov    $0x4,%eax
  104fe9:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  104ff0:	00 
  104ff1:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  104ff8:	00 
  104ff9:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  105000:	00 
  105001:	e9 48 fd ff ff       	jmp    104d4e <exec+0x14e>
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  105006:	bf ff 1f 00 00       	mov    $0x1fff,%edi
  10500b:	e9 e0 fc ff ff       	jmp    104cf0 <exec+0xf0>
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
    return -1;
  105010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  105015:	eb c2                	jmp    104fd9 <exec+0x3d9>
  105017:	90                   	nop
  105018:	90                   	nop
  105019:	90                   	nop
  10501a:	90                   	nop
  10501b:	90                   	nop
  10501c:	90                   	nop
  10501d:	90                   	nop
  10501e:	90                   	nop
  10501f:	90                   	nop

00105020 <kbd_getc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  105020:	ba 64 00 00 00       	mov    $0x64,%edx
  105025:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  105026:	a8 01                	test   $0x1,%al
    return -1;
  105028:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  10502d:	74 3e                	je     10506d <kbd_getc+0x4d>
  10502f:	b2 60                	mov    $0x60,%dl
  105031:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  105032:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
  105035:	3d e0 00 00 00       	cmp    $0xe0,%eax
  10503a:	0f 84 80 00 00 00    	je     1050c0 <kbd_getc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  105040:	a8 80                	test   $0x80,%al
  105042:	74 2c                	je     105070 <kbd_getc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  105044:	8b 15 5c 88 10 00    	mov    0x10885c,%edx
  10504a:	89 c1                	mov    %eax,%ecx
  10504c:	83 e1 7f             	and    $0x7f,%ecx
  10504f:	f6 c2 40             	test   $0x40,%dl
  105052:	0f 44 c1             	cmove  %ecx,%eax
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  105055:	31 c9                	xor    %ecx,%ecx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
  105057:	0f b6 80 c0 63 10 00 	movzbl 0x1063c0(%eax),%eax
  10505e:	83 c8 40             	or     $0x40,%eax
  105061:	0f b6 c0             	movzbl %al,%eax
  105064:	f7 d0                	not    %eax
  105066:	21 d0                	and    %edx,%eax
  105068:	a3 5c 88 10 00       	mov    %eax,0x10885c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  10506d:	89 c8                	mov    %ecx,%eax
  10506f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  105070:	8b 0d 5c 88 10 00    	mov    0x10885c,%ecx
  105076:	f6 c1 40             	test   $0x40,%cl
  105079:	74 05                	je     105080 <kbd_getc+0x60>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  10507b:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
  10507d:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  105080:	0f b6 90 c0 63 10 00 	movzbl 0x1063c0(%eax),%edx
  105087:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
  105089:	0f b6 88 c0 64 10 00 	movzbl 0x1064c0(%eax),%ecx
  105090:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
  105092:	89 d1                	mov    %edx,%ecx
  105094:	83 e1 03             	and    $0x3,%ecx
  105097:	8b 0c 8d c0 65 10 00 	mov    0x1065c0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  10509e:	89 15 5c 88 10 00    	mov    %edx,0x10885c
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
  1050a4:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  1050a7:	0f b6 0c 01          	movzbl (%ecx,%eax,1),%ecx
  if(shift & CAPSLOCK){
  1050ab:	74 c0                	je     10506d <kbd_getc+0x4d>
    if('a' <= c && c <= 'z')
  1050ad:	8d 41 9f             	lea    -0x61(%ecx),%eax
  1050b0:	83 f8 19             	cmp    $0x19,%eax
  1050b3:	77 1b                	ja     1050d0 <kbd_getc+0xb0>
      c += 'A' - 'a';
  1050b5:	83 e9 20             	sub    $0x20,%ecx
  1050b8:	eb b3                	jmp    10506d <kbd_getc+0x4d>
  1050ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  1050c0:	31 c9                	xor    %ecx,%ecx
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  1050c2:	83 0d 5c 88 10 00 40 	orl    $0x40,0x10885c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  1050c9:	89 c8                	mov    %ecx,%eax
  1050cb:	c3                   	ret    
  1050cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  1050d0:	8d 51 bf             	lea    -0x41(%ecx),%edx
      c += 'a' - 'A';
  1050d3:	8d 41 20             	lea    0x20(%ecx),%eax
  1050d6:	83 fa 19             	cmp    $0x19,%edx
  1050d9:	0f 46 c8             	cmovbe %eax,%ecx
  }
  return c;
  1050dc:	eb 8f                	jmp    10506d <kbd_getc+0x4d>
  1050de:	66 90                	xchg   %ax,%ax

001050e0 <kbd_intr>:
}

void
kbd_intr(void)
{
  1050e0:	83 ec 1c             	sub    $0x1c,%esp
  console_intr(kbd_getc);
  1050e3:	c7 04 24 20 50 10 00 	movl   $0x105020,(%esp)
  1050ea:	e8 c1 b7 ff ff       	call   1008b0 <console_intr>
}
  1050ef:	83 c4 1c             	add    $0x1c,%esp
  1050f2:	c3                   	ret    
  1050f3:	90                   	nop
  1050f4:	90                   	nop
  1050f5:	90                   	nop
  1050f6:	90                   	nop
  1050f7:	90                   	nop
  1050f8:	90                   	nop
  1050f9:	90                   	nop
  1050fa:	90                   	nop
  1050fb:	90                   	nop
  1050fc:	90                   	nop
  1050fd:	90                   	nop
  1050fe:	90                   	nop
  1050ff:	90                   	nop

00105100 <tvinit>:
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  105100:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  for(i = 0; i < 256; i++)
  105103:	31 c0                	xor    %eax,%eax
  105105:	ba 80 21 11 00       	mov    $0x112180,%edx
  10510a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEGMENT_KERNEL_CODE<<3, vectors[i], 0);
  105110:	8b 0c 85 20 83 10 00 	mov    0x108320(,%eax,4),%ecx
  105117:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10511e:	66 89 0c c5 80 21 11 	mov    %cx,0x112180(,%eax,8)
  105125:	00 
  105126:	c1 e9 10             	shr    $0x10,%ecx
  105129:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10512e:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  105133:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  105138:	83 c0 01             	add    $0x1,%eax
  10513b:	3d 00 01 00 00       	cmp    $0x100,%eax
  105140:	75 ce                	jne    105110 <tvinit+0x10>
    SETGATE(idt[i], 0, SEGMENT_KERNEL_CODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEGMENT_KERNEL_CODE<<3, vectors[T_SYSCALL], DPL_USER);
  105142:	a1 e0 83 10 00       	mov    0x1083e0,%eax

  initlock(&tickslock, "time");
  105147:	c7 44 24 04 d0 65 10 	movl   $0x1065d0,0x4(%esp)
  10514e:	00 
  10514f:	c7 04 24 40 21 11 00 	movl   $0x112140,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEGMENT_KERNEL_CODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEGMENT_KERNEL_CODE<<3, vectors[T_SYSCALL], DPL_USER);
  105156:	66 c7 05 02 23 11 00 	movw   $0x8,0x112302
  10515d:	08 00 
  10515f:	66 a3 00 23 11 00    	mov    %ax,0x112300
  105165:	c1 e8 10             	shr    $0x10,%eax
  105168:	c6 05 04 23 11 00 00 	movb   $0x0,0x112304
  10516f:	c6 05 05 23 11 00 ef 	movb   $0xef,0x112305
  105176:	66 a3 06 23 11 00    	mov    %ax,0x112306

  initlock(&tickslock, "time");
  10517c:	e8 ff af ff ff       	call   100180 <initlock>
}
  105181:	83 c4 1c             	add    $0x1c,%esp
  105184:	c3                   	ret    
  105185:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00105190 <idtinit>:

void
idtinit(void)
{
  105190:	83 ec 10             	sub    $0x10,%esp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  105193:	b8 80 21 11 00       	mov    $0x112180,%eax
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  105198:	66 c7 44 24 0a ff 07 	movw   $0x7ff,0xa(%esp)
  pd[1] = (uint)p;
  10519f:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  pd[2] = (uint)p >> 16;
  1051a4:	c1 e8 10             	shr    $0x10,%eax
  1051a7:	66 89 44 24 0e       	mov    %ax,0xe(%esp)

  asm volatile("lidt (%0)" : : "r" (pd));
  1051ac:	8d 44 24 0a          	lea    0xa(%esp),%eax
  1051b0:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  1051b3:	83 c4 10             	add    $0x10,%esp
  1051b6:	c3                   	ret    
  1051b7:	89 f6                	mov    %esi,%esi
  1051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001051c0 <trap>:

void
trap(struct trapframe *tf)
{
  1051c0:	83 ec 4c             	sub    $0x4c,%esp
  1051c3:	89 5c 24 3c          	mov    %ebx,0x3c(%esp)
  1051c7:	8b 5c 24 50          	mov    0x50(%esp),%ebx
  1051cb:	89 74 24 40          	mov    %esi,0x40(%esp)
  1051cf:	89 7c 24 44          	mov    %edi,0x44(%esp)
  1051d3:	89 6c 24 48          	mov    %ebp,0x48(%esp)
  if(tf->trapno == T_SYSCALL){
  1051d7:	8b 43 28             	mov    0x28(%ebx),%eax
  1051da:	83 f8 30             	cmp    $0x30,%eax
  1051dd:	0f 84 8d 01 00 00    	je     105370 <trap+0x1b0>
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  1051e3:	83 f8 21             	cmp    $0x21,%eax
  1051e6:	0f 84 6c 01 00 00    	je     105358 <trap+0x198>
  1051ec:	76 42                	jbe    105230 <trap+0x70>
  1051ee:	83 f8 2e             	cmp    $0x2e,%eax
  1051f1:	0f 84 51 01 00 00    	je     105348 <trap+0x188>
  1051f7:	83 f8 3f             	cmp    $0x3f,%eax
  1051fa:	75 3d                	jne    105239 <trap+0x79>
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  1051fc:	8b 7b 30             	mov    0x30(%ebx),%edi
  1051ff:	0f b7 73 34          	movzwl 0x34(%ebx),%esi
  105203:	e8 28 ba ff ff       	call   100c30 <cpu>
  105208:	c7 04 24 dc 65 10 00 	movl   $0x1065dc,(%esp)
  10520f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  105213:	89 74 24 08          	mov    %esi,0x8(%esp)
  105217:	89 44 24 04          	mov    %eax,0x4(%esp)
  10521b:	e8 00 b5 ff ff       	call   100720 <cprintf>
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
  105220:	e8 5b ba ff ff       	call   100c80 <lapic_eoi>
    break;
  105225:	e9 96 00 00 00       	jmp    1052c0 <trap+0x100>
  10522a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  105230:	83 f8 20             	cmp    $0x20,%eax
  105233:	0f 84 f7 00 00 00    	je     105330 <trap+0x170>
  105239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
    break;

  default:
    if(cp == 0 || (tf->cs&3) == 0){
  105240:	e8 4b c2 ff ff       	call   101490 <curproc>
  105245:	85 c0                	test   %eax,%eax
  105247:	0f 84 9b 01 00 00    	je     1053e8 <trap+0x228>
  10524d:	f6 43 34 03          	testb  $0x3,0x34(%ebx)
  105251:	0f 84 91 01 00 00    	je     1053e8 <trap+0x228>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  105257:	8b 53 30             	mov    0x30(%ebx),%edx
  10525a:	89 54 24 28          	mov    %edx,0x28(%esp)
  10525e:	e8 cd b9 ff ff       	call   100c30 <cpu>
  105263:	8b 7b 2c             	mov    0x2c(%ebx),%edi
  105266:	8b 73 28             	mov    0x28(%ebx),%esi
  105269:	89 c5                	mov    %eax,%ebp
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  10526b:	e8 20 c2 ff ff       	call   101490 <curproc>
  105270:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  105274:	e8 17 c2 ff ff       	call   101490 <curproc>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  105279:	8b 54 24 28          	mov    0x28(%esp),%edx
  10527d:	89 6c 24 14          	mov    %ebp,0x14(%esp)
  105281:	89 7c 24 10          	mov    %edi,0x10(%esp)
  105285:	89 74 24 0c          	mov    %esi,0xc(%esp)
  105289:	89 54 24 18          	mov    %edx,0x18(%esp)
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  10528d:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  105291:	81 c2 88 00 00 00    	add    $0x88,%edx
  105297:	89 54 24 08          	mov    %edx,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  10529b:	8b 40 10             	mov    0x10(%eax),%eax
  10529e:	c7 04 24 28 66 10 00 	movl   $0x106628,(%esp)
  1052a5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1052a9:	e8 72 b4 ff ff       	call   100720 <cprintf>
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
    cp->killed = 1;
  1052ae:	e8 dd c1 ff ff       	call   101490 <curproc>
  1052b3:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
  1052ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  1052c0:	e8 cb c1 ff ff       	call   101490 <curproc>
  1052c5:	85 c0                	test   %eax,%eax
  1052c7:	74 1c                	je     1052e5 <trap+0x125>
  1052c9:	e8 c2 c1 ff ff       	call   101490 <curproc>
  1052ce:	8b 40 1c             	mov    0x1c(%eax),%eax
  1052d1:	85 c0                	test   %eax,%eax
  1052d3:	74 10                	je     1052e5 <trap+0x125>
  1052d5:	0f b7 43 34          	movzwl 0x34(%ebx),%eax
  1052d9:	83 e0 03             	and    $0x3,%eax
  1052dc:	83 f8 03             	cmp    $0x3,%eax
  1052df:	0f 84 33 01 00 00    	je     105418 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  1052e5:	e8 a6 c1 ff ff       	call   101490 <curproc>
  1052ea:	85 c0                	test   %eax,%eax
  1052ec:	74 0d                	je     1052fb <trap+0x13b>
  1052ee:	66 90                	xchg   %ax,%ax
  1052f0:	e8 9b c1 ff ff       	call   101490 <curproc>
  1052f5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  1052f9:	74 15                	je     105310 <trap+0x150>
    yield();
}
  1052fb:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  1052ff:	8b 74 24 40          	mov    0x40(%esp),%esi
  105303:	8b 7c 24 44          	mov    0x44(%esp),%edi
  105307:	8b 6c 24 48          	mov    0x48(%esp),%ebp
  10530b:	83 c4 4c             	add    $0x4c,%esp
  10530e:	c3                   	ret    
  10530f:	90                   	nop
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  105310:	83 7b 28 20          	cmpl   $0x20,0x28(%ebx)
  105314:	75 e5                	jne    1052fb <trap+0x13b>
    yield();
}
  105316:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  10531a:	8b 74 24 40          	mov    0x40(%esp),%esi
  10531e:	8b 7c 24 44          	mov    0x44(%esp),%edi
  105322:	8b 6c 24 48          	mov    0x48(%esp),%ebp
  105326:	83 c4 4c             	add    $0x4c,%esp
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
  105329:	e9 d2 c3 ff ff       	jmp    101700 <yield>
  10532e:	66 90                	xchg   %ax,%ax
    return;
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
  105330:	e8 fb b8 ff ff       	call   100c30 <cpu>
  105335:	85 c0                	test   %eax,%eax
  105337:	74 7f                	je     1053b8 <trap+0x1f8>
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
    lapic_eoi();
  105339:	e8 42 b9 ff ff       	call   100c80 <lapic_eoi>
  10533e:	66 90                	xchg   %ax,%ax
    break;
  105340:	e9 7b ff ff ff       	jmp    1052c0 <trap+0x100>
  105345:	8d 76 00             	lea    0x0(%esi),%esi
  105348:	90                   	nop
  105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
  105350:	e8 4b e3 ff ff       	call   1036a0 <ide_intr>
  105355:	eb e2                	jmp    105339 <trap+0x179>
  105357:	90                   	nop
  105358:	90                   	nop
  105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
  105360:	e8 7b fd ff ff       	call   1050e0 <kbd_intr>
    lapic_eoi();
  105365:	e8 16 b9 ff ff       	call   100c80 <lapic_eoi>
    break;
  10536a:	e9 51 ff ff ff       	jmp    1052c0 <trap+0x100>
  10536f:	90                   	nop

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
  105370:	e8 1b c1 ff ff       	call   101490 <curproc>
  105375:	8b 48 1c             	mov    0x1c(%eax),%ecx
  105378:	85 c9                	test   %ecx,%ecx
  10537a:	0f 85 a8 00 00 00    	jne    105428 <trap+0x268>
      exit();
    cp->tf = tf;
  105380:	e8 0b c1 ff ff       	call   101490 <curproc>
  105385:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    syscall();
  10538b:	e8 c0 ea ff ff       	call   103e50 <syscall>
    if(cp->killed)
  105390:	e8 fb c0 ff ff       	call   101490 <curproc>
  105395:	8b 50 1c             	mov    0x1c(%eax),%edx
  105398:	85 d2                	test   %edx,%edx
  10539a:	0f 84 5b ff ff ff    	je     1052fb <trap+0x13b>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
}
  1053a0:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  1053a4:	8b 74 24 40          	mov    0x40(%esp),%esi
  1053a8:	8b 7c 24 44          	mov    0x44(%esp),%edi
  1053ac:	8b 6c 24 48          	mov    0x48(%esp),%ebp
  1053b0:	83 c4 4c             	add    $0x4c,%esp
    if(cp->killed)
      exit();
    cp->tf = tf;
    syscall();
    if(cp->killed)
      exit();
  1053b3:	e9 28 c5 ff ff       	jmp    1018e0 <exit>
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
  1053b8:	c7 04 24 40 21 11 00 	movl   $0x112140,(%esp)
  1053bf:	e8 ac ae ff ff       	call   100270 <acquire>
      ticks++;
      wakeup(&ticks);
  1053c4:	c7 04 24 80 29 11 00 	movl   $0x112980,(%esp)

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
      ticks++;
  1053cb:	83 05 80 29 11 00 01 	addl   $0x1,0x112980
      wakeup(&ticks);
  1053d2:	e8 29 c4 ff ff       	call   101800 <wakeup>
      release(&tickslock);
  1053d7:	c7 04 24 40 21 11 00 	movl   $0x112140,(%esp)
  1053de:	e8 7d af ff ff       	call   100360 <release>
  1053e3:	e9 51 ff ff ff       	jmp    105339 <trap+0x179>
    break;

  default:
    if(cp == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x\n",
  1053e8:	8b 73 30             	mov    0x30(%ebx),%esi
  1053eb:	e8 40 b8 ff ff       	call   100c30 <cpu>
  1053f0:	89 74 24 0c          	mov    %esi,0xc(%esp)
  1053f4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1053f8:	8b 43 28             	mov    0x28(%ebx),%eax
  1053fb:	c7 04 24 00 66 10 00 	movl   $0x106600,(%esp)
  105402:	89 44 24 04          	mov    %eax,0x4(%esp)
  105406:	e8 15 b3 ff ff       	call   100720 <cprintf>
              tf->trapno, cpu(), tf->eip);
      panic("trap");
  10540b:	c7 04 24 d5 65 10 00 	movl   $0x1065d5,(%esp)
  105412:	e8 99 b6 ff ff       	call   100ab0 <panic>
  105417:	90                   	nop

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();
  105418:	e8 c3 c4 ff ff       	call   1018e0 <exit>
  10541d:	e9 c3 fe ff ff       	jmp    1052e5 <trap+0x125>
  105422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105428:	90                   	nop
  105429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
      exit();
  105430:	e8 ab c4 ff ff       	call   1018e0 <exit>
  105435:	e9 46 ff ff ff       	jmp    105380 <trap+0x1c0>
  10543a:	90                   	nop
  10543b:	90                   	nop

0010543c <alltraps>:
  10543c:	1e                   	push   %ds
  10543d:	06                   	push   %es
  10543e:	60                   	pusha  
  10543f:	b8 10 00 00 00       	mov    $0x10,%eax
  105444:	8e d8                	mov    %eax,%ds
  105446:	8e c0                	mov    %eax,%es
  105448:	54                   	push   %esp
  105449:	e8 72 fd ff ff       	call   1051c0 <trap>
  10544e:	83 c4 04             	add    $0x4,%esp

00105451 <trapret>:
  105451:	61                   	popa   
  105452:	07                   	pop    %es
  105453:	1f                   	pop    %ds
  105454:	83 c4 08             	add    $0x8,%esp
  105457:	cf                   	iret   

00105458 <forkret1>:
  105458:	8b 64 24 04          	mov    0x4(%esp),%esp
  10545c:	e9 f0 ff ff ff       	jmp    105451 <trapret>
  105461:	90                   	nop
  105462:	90                   	nop
  105463:	90                   	nop

00105464 <vector0>:
  105464:	6a 00                	push   $0x0
  105466:	6a 00                	push   $0x0
  105468:	e9 cf ff ff ff       	jmp    10543c <alltraps>

0010546d <vector1>:
  10546d:	6a 00                	push   $0x0
  10546f:	6a 01                	push   $0x1
  105471:	e9 c6 ff ff ff       	jmp    10543c <alltraps>

00105476 <vector2>:
  105476:	6a 00                	push   $0x0
  105478:	6a 02                	push   $0x2
  10547a:	e9 bd ff ff ff       	jmp    10543c <alltraps>

0010547f <vector3>:
  10547f:	6a 00                	push   $0x0
  105481:	6a 03                	push   $0x3
  105483:	e9 b4 ff ff ff       	jmp    10543c <alltraps>

00105488 <vector4>:
  105488:	6a 00                	push   $0x0
  10548a:	6a 04                	push   $0x4
  10548c:	e9 ab ff ff ff       	jmp    10543c <alltraps>

00105491 <vector5>:
  105491:	6a 00                	push   $0x0
  105493:	6a 05                	push   $0x5
  105495:	e9 a2 ff ff ff       	jmp    10543c <alltraps>

0010549a <vector6>:
  10549a:	6a 00                	push   $0x0
  10549c:	6a 06                	push   $0x6
  10549e:	e9 99 ff ff ff       	jmp    10543c <alltraps>

001054a3 <vector7>:
  1054a3:	6a 00                	push   $0x0
  1054a5:	6a 07                	push   $0x7
  1054a7:	e9 90 ff ff ff       	jmp    10543c <alltraps>

001054ac <vector8>:
  1054ac:	6a 08                	push   $0x8
  1054ae:	e9 89 ff ff ff       	jmp    10543c <alltraps>

001054b3 <vector9>:
  1054b3:	6a 09                	push   $0x9
  1054b5:	e9 82 ff ff ff       	jmp    10543c <alltraps>

001054ba <vector10>:
  1054ba:	6a 0a                	push   $0xa
  1054bc:	e9 7b ff ff ff       	jmp    10543c <alltraps>

001054c1 <vector11>:
  1054c1:	6a 0b                	push   $0xb
  1054c3:	e9 74 ff ff ff       	jmp    10543c <alltraps>

001054c8 <vector12>:
  1054c8:	6a 0c                	push   $0xc
  1054ca:	e9 6d ff ff ff       	jmp    10543c <alltraps>

001054cf <vector13>:
  1054cf:	6a 0d                	push   $0xd
  1054d1:	e9 66 ff ff ff       	jmp    10543c <alltraps>

001054d6 <vector14>:
  1054d6:	6a 0e                	push   $0xe
  1054d8:	e9 5f ff ff ff       	jmp    10543c <alltraps>

001054dd <vector15>:
  1054dd:	6a 00                	push   $0x0
  1054df:	6a 0f                	push   $0xf
  1054e1:	e9 56 ff ff ff       	jmp    10543c <alltraps>

001054e6 <vector16>:
  1054e6:	6a 00                	push   $0x0
  1054e8:	6a 10                	push   $0x10
  1054ea:	e9 4d ff ff ff       	jmp    10543c <alltraps>

001054ef <vector17>:
  1054ef:	6a 11                	push   $0x11
  1054f1:	e9 46 ff ff ff       	jmp    10543c <alltraps>

001054f6 <vector18>:
  1054f6:	6a 00                	push   $0x0
  1054f8:	6a 12                	push   $0x12
  1054fa:	e9 3d ff ff ff       	jmp    10543c <alltraps>

001054ff <vector19>:
  1054ff:	6a 00                	push   $0x0
  105501:	6a 13                	push   $0x13
  105503:	e9 34 ff ff ff       	jmp    10543c <alltraps>

00105508 <vector20>:
  105508:	6a 00                	push   $0x0
  10550a:	6a 14                	push   $0x14
  10550c:	e9 2b ff ff ff       	jmp    10543c <alltraps>

00105511 <vector21>:
  105511:	6a 00                	push   $0x0
  105513:	6a 15                	push   $0x15
  105515:	e9 22 ff ff ff       	jmp    10543c <alltraps>

0010551a <vector22>:
  10551a:	6a 00                	push   $0x0
  10551c:	6a 16                	push   $0x16
  10551e:	e9 19 ff ff ff       	jmp    10543c <alltraps>

00105523 <vector23>:
  105523:	6a 00                	push   $0x0
  105525:	6a 17                	push   $0x17
  105527:	e9 10 ff ff ff       	jmp    10543c <alltraps>

0010552c <vector24>:
  10552c:	6a 00                	push   $0x0
  10552e:	6a 18                	push   $0x18
  105530:	e9 07 ff ff ff       	jmp    10543c <alltraps>

00105535 <vector25>:
  105535:	6a 00                	push   $0x0
  105537:	6a 19                	push   $0x19
  105539:	e9 fe fe ff ff       	jmp    10543c <alltraps>

0010553e <vector26>:
  10553e:	6a 00                	push   $0x0
  105540:	6a 1a                	push   $0x1a
  105542:	e9 f5 fe ff ff       	jmp    10543c <alltraps>

00105547 <vector27>:
  105547:	6a 00                	push   $0x0
  105549:	6a 1b                	push   $0x1b
  10554b:	e9 ec fe ff ff       	jmp    10543c <alltraps>

00105550 <vector28>:
  105550:	6a 00                	push   $0x0
  105552:	6a 1c                	push   $0x1c
  105554:	e9 e3 fe ff ff       	jmp    10543c <alltraps>

00105559 <vector29>:
  105559:	6a 00                	push   $0x0
  10555b:	6a 1d                	push   $0x1d
  10555d:	e9 da fe ff ff       	jmp    10543c <alltraps>

00105562 <vector30>:
  105562:	6a 00                	push   $0x0
  105564:	6a 1e                	push   $0x1e
  105566:	e9 d1 fe ff ff       	jmp    10543c <alltraps>

0010556b <vector31>:
  10556b:	6a 00                	push   $0x0
  10556d:	6a 1f                	push   $0x1f
  10556f:	e9 c8 fe ff ff       	jmp    10543c <alltraps>

00105574 <vector32>:
  105574:	6a 00                	push   $0x0
  105576:	6a 20                	push   $0x20
  105578:	e9 bf fe ff ff       	jmp    10543c <alltraps>

0010557d <vector33>:
  10557d:	6a 00                	push   $0x0
  10557f:	6a 21                	push   $0x21
  105581:	e9 b6 fe ff ff       	jmp    10543c <alltraps>

00105586 <vector34>:
  105586:	6a 00                	push   $0x0
  105588:	6a 22                	push   $0x22
  10558a:	e9 ad fe ff ff       	jmp    10543c <alltraps>

0010558f <vector35>:
  10558f:	6a 00                	push   $0x0
  105591:	6a 23                	push   $0x23
  105593:	e9 a4 fe ff ff       	jmp    10543c <alltraps>

00105598 <vector36>:
  105598:	6a 00                	push   $0x0
  10559a:	6a 24                	push   $0x24
  10559c:	e9 9b fe ff ff       	jmp    10543c <alltraps>

001055a1 <vector37>:
  1055a1:	6a 00                	push   $0x0
  1055a3:	6a 25                	push   $0x25
  1055a5:	e9 92 fe ff ff       	jmp    10543c <alltraps>

001055aa <vector38>:
  1055aa:	6a 00                	push   $0x0
  1055ac:	6a 26                	push   $0x26
  1055ae:	e9 89 fe ff ff       	jmp    10543c <alltraps>

001055b3 <vector39>:
  1055b3:	6a 00                	push   $0x0
  1055b5:	6a 27                	push   $0x27
  1055b7:	e9 80 fe ff ff       	jmp    10543c <alltraps>

001055bc <vector40>:
  1055bc:	6a 00                	push   $0x0
  1055be:	6a 28                	push   $0x28
  1055c0:	e9 77 fe ff ff       	jmp    10543c <alltraps>

001055c5 <vector41>:
  1055c5:	6a 00                	push   $0x0
  1055c7:	6a 29                	push   $0x29
  1055c9:	e9 6e fe ff ff       	jmp    10543c <alltraps>

001055ce <vector42>:
  1055ce:	6a 00                	push   $0x0
  1055d0:	6a 2a                	push   $0x2a
  1055d2:	e9 65 fe ff ff       	jmp    10543c <alltraps>

001055d7 <vector43>:
  1055d7:	6a 00                	push   $0x0
  1055d9:	6a 2b                	push   $0x2b
  1055db:	e9 5c fe ff ff       	jmp    10543c <alltraps>

001055e0 <vector44>:
  1055e0:	6a 00                	push   $0x0
  1055e2:	6a 2c                	push   $0x2c
  1055e4:	e9 53 fe ff ff       	jmp    10543c <alltraps>

001055e9 <vector45>:
  1055e9:	6a 00                	push   $0x0
  1055eb:	6a 2d                	push   $0x2d
  1055ed:	e9 4a fe ff ff       	jmp    10543c <alltraps>

001055f2 <vector46>:
  1055f2:	6a 00                	push   $0x0
  1055f4:	6a 2e                	push   $0x2e
  1055f6:	e9 41 fe ff ff       	jmp    10543c <alltraps>

001055fb <vector47>:
  1055fb:	6a 00                	push   $0x0
  1055fd:	6a 2f                	push   $0x2f
  1055ff:	e9 38 fe ff ff       	jmp    10543c <alltraps>

00105604 <vector48>:
  105604:	6a 00                	push   $0x0
  105606:	6a 30                	push   $0x30
  105608:	e9 2f fe ff ff       	jmp    10543c <alltraps>

0010560d <vector49>:
  10560d:	6a 00                	push   $0x0
  10560f:	6a 31                	push   $0x31
  105611:	e9 26 fe ff ff       	jmp    10543c <alltraps>

00105616 <vector50>:
  105616:	6a 00                	push   $0x0
  105618:	6a 32                	push   $0x32
  10561a:	e9 1d fe ff ff       	jmp    10543c <alltraps>

0010561f <vector51>:
  10561f:	6a 00                	push   $0x0
  105621:	6a 33                	push   $0x33
  105623:	e9 14 fe ff ff       	jmp    10543c <alltraps>

00105628 <vector52>:
  105628:	6a 00                	push   $0x0
  10562a:	6a 34                	push   $0x34
  10562c:	e9 0b fe ff ff       	jmp    10543c <alltraps>

00105631 <vector53>:
  105631:	6a 00                	push   $0x0
  105633:	6a 35                	push   $0x35
  105635:	e9 02 fe ff ff       	jmp    10543c <alltraps>

0010563a <vector54>:
  10563a:	6a 00                	push   $0x0
  10563c:	6a 36                	push   $0x36
  10563e:	e9 f9 fd ff ff       	jmp    10543c <alltraps>

00105643 <vector55>:
  105643:	6a 00                	push   $0x0
  105645:	6a 37                	push   $0x37
  105647:	e9 f0 fd ff ff       	jmp    10543c <alltraps>

0010564c <vector56>:
  10564c:	6a 00                	push   $0x0
  10564e:	6a 38                	push   $0x38
  105650:	e9 e7 fd ff ff       	jmp    10543c <alltraps>

00105655 <vector57>:
  105655:	6a 00                	push   $0x0
  105657:	6a 39                	push   $0x39
  105659:	e9 de fd ff ff       	jmp    10543c <alltraps>

0010565e <vector58>:
  10565e:	6a 00                	push   $0x0
  105660:	6a 3a                	push   $0x3a
  105662:	e9 d5 fd ff ff       	jmp    10543c <alltraps>

00105667 <vector59>:
  105667:	6a 00                	push   $0x0
  105669:	6a 3b                	push   $0x3b
  10566b:	e9 cc fd ff ff       	jmp    10543c <alltraps>

00105670 <vector60>:
  105670:	6a 00                	push   $0x0
  105672:	6a 3c                	push   $0x3c
  105674:	e9 c3 fd ff ff       	jmp    10543c <alltraps>

00105679 <vector61>:
  105679:	6a 00                	push   $0x0
  10567b:	6a 3d                	push   $0x3d
  10567d:	e9 ba fd ff ff       	jmp    10543c <alltraps>

00105682 <vector62>:
  105682:	6a 00                	push   $0x0
  105684:	6a 3e                	push   $0x3e
  105686:	e9 b1 fd ff ff       	jmp    10543c <alltraps>

0010568b <vector63>:
  10568b:	6a 00                	push   $0x0
  10568d:	6a 3f                	push   $0x3f
  10568f:	e9 a8 fd ff ff       	jmp    10543c <alltraps>

00105694 <vector64>:
  105694:	6a 00                	push   $0x0
  105696:	6a 40                	push   $0x40
  105698:	e9 9f fd ff ff       	jmp    10543c <alltraps>

0010569d <vector65>:
  10569d:	6a 00                	push   $0x0
  10569f:	6a 41                	push   $0x41
  1056a1:	e9 96 fd ff ff       	jmp    10543c <alltraps>

001056a6 <vector66>:
  1056a6:	6a 00                	push   $0x0
  1056a8:	6a 42                	push   $0x42
  1056aa:	e9 8d fd ff ff       	jmp    10543c <alltraps>

001056af <vector67>:
  1056af:	6a 00                	push   $0x0
  1056b1:	6a 43                	push   $0x43
  1056b3:	e9 84 fd ff ff       	jmp    10543c <alltraps>

001056b8 <vector68>:
  1056b8:	6a 00                	push   $0x0
  1056ba:	6a 44                	push   $0x44
  1056bc:	e9 7b fd ff ff       	jmp    10543c <alltraps>

001056c1 <vector69>:
  1056c1:	6a 00                	push   $0x0
  1056c3:	6a 45                	push   $0x45
  1056c5:	e9 72 fd ff ff       	jmp    10543c <alltraps>

001056ca <vector70>:
  1056ca:	6a 00                	push   $0x0
  1056cc:	6a 46                	push   $0x46
  1056ce:	e9 69 fd ff ff       	jmp    10543c <alltraps>

001056d3 <vector71>:
  1056d3:	6a 00                	push   $0x0
  1056d5:	6a 47                	push   $0x47
  1056d7:	e9 60 fd ff ff       	jmp    10543c <alltraps>

001056dc <vector72>:
  1056dc:	6a 00                	push   $0x0
  1056de:	6a 48                	push   $0x48
  1056e0:	e9 57 fd ff ff       	jmp    10543c <alltraps>

001056e5 <vector73>:
  1056e5:	6a 00                	push   $0x0
  1056e7:	6a 49                	push   $0x49
  1056e9:	e9 4e fd ff ff       	jmp    10543c <alltraps>

001056ee <vector74>:
  1056ee:	6a 00                	push   $0x0
  1056f0:	6a 4a                	push   $0x4a
  1056f2:	e9 45 fd ff ff       	jmp    10543c <alltraps>

001056f7 <vector75>:
  1056f7:	6a 00                	push   $0x0
  1056f9:	6a 4b                	push   $0x4b
  1056fb:	e9 3c fd ff ff       	jmp    10543c <alltraps>

00105700 <vector76>:
  105700:	6a 00                	push   $0x0
  105702:	6a 4c                	push   $0x4c
  105704:	e9 33 fd ff ff       	jmp    10543c <alltraps>

00105709 <vector77>:
  105709:	6a 00                	push   $0x0
  10570b:	6a 4d                	push   $0x4d
  10570d:	e9 2a fd ff ff       	jmp    10543c <alltraps>

00105712 <vector78>:
  105712:	6a 00                	push   $0x0
  105714:	6a 4e                	push   $0x4e
  105716:	e9 21 fd ff ff       	jmp    10543c <alltraps>

0010571b <vector79>:
  10571b:	6a 00                	push   $0x0
  10571d:	6a 4f                	push   $0x4f
  10571f:	e9 18 fd ff ff       	jmp    10543c <alltraps>

00105724 <vector80>:
  105724:	6a 00                	push   $0x0
  105726:	6a 50                	push   $0x50
  105728:	e9 0f fd ff ff       	jmp    10543c <alltraps>

0010572d <vector81>:
  10572d:	6a 00                	push   $0x0
  10572f:	6a 51                	push   $0x51
  105731:	e9 06 fd ff ff       	jmp    10543c <alltraps>

00105736 <vector82>:
  105736:	6a 00                	push   $0x0
  105738:	6a 52                	push   $0x52
  10573a:	e9 fd fc ff ff       	jmp    10543c <alltraps>

0010573f <vector83>:
  10573f:	6a 00                	push   $0x0
  105741:	6a 53                	push   $0x53
  105743:	e9 f4 fc ff ff       	jmp    10543c <alltraps>

00105748 <vector84>:
  105748:	6a 00                	push   $0x0
  10574a:	6a 54                	push   $0x54
  10574c:	e9 eb fc ff ff       	jmp    10543c <alltraps>

00105751 <vector85>:
  105751:	6a 00                	push   $0x0
  105753:	6a 55                	push   $0x55
  105755:	e9 e2 fc ff ff       	jmp    10543c <alltraps>

0010575a <vector86>:
  10575a:	6a 00                	push   $0x0
  10575c:	6a 56                	push   $0x56
  10575e:	e9 d9 fc ff ff       	jmp    10543c <alltraps>

00105763 <vector87>:
  105763:	6a 00                	push   $0x0
  105765:	6a 57                	push   $0x57
  105767:	e9 d0 fc ff ff       	jmp    10543c <alltraps>

0010576c <vector88>:
  10576c:	6a 00                	push   $0x0
  10576e:	6a 58                	push   $0x58
  105770:	e9 c7 fc ff ff       	jmp    10543c <alltraps>

00105775 <vector89>:
  105775:	6a 00                	push   $0x0
  105777:	6a 59                	push   $0x59
  105779:	e9 be fc ff ff       	jmp    10543c <alltraps>

0010577e <vector90>:
  10577e:	6a 00                	push   $0x0
  105780:	6a 5a                	push   $0x5a
  105782:	e9 b5 fc ff ff       	jmp    10543c <alltraps>

00105787 <vector91>:
  105787:	6a 00                	push   $0x0
  105789:	6a 5b                	push   $0x5b
  10578b:	e9 ac fc ff ff       	jmp    10543c <alltraps>

00105790 <vector92>:
  105790:	6a 00                	push   $0x0
  105792:	6a 5c                	push   $0x5c
  105794:	e9 a3 fc ff ff       	jmp    10543c <alltraps>

00105799 <vector93>:
  105799:	6a 00                	push   $0x0
  10579b:	6a 5d                	push   $0x5d
  10579d:	e9 9a fc ff ff       	jmp    10543c <alltraps>

001057a2 <vector94>:
  1057a2:	6a 00                	push   $0x0
  1057a4:	6a 5e                	push   $0x5e
  1057a6:	e9 91 fc ff ff       	jmp    10543c <alltraps>

001057ab <vector95>:
  1057ab:	6a 00                	push   $0x0
  1057ad:	6a 5f                	push   $0x5f
  1057af:	e9 88 fc ff ff       	jmp    10543c <alltraps>

001057b4 <vector96>:
  1057b4:	6a 00                	push   $0x0
  1057b6:	6a 60                	push   $0x60
  1057b8:	e9 7f fc ff ff       	jmp    10543c <alltraps>

001057bd <vector97>:
  1057bd:	6a 00                	push   $0x0
  1057bf:	6a 61                	push   $0x61
  1057c1:	e9 76 fc ff ff       	jmp    10543c <alltraps>

001057c6 <vector98>:
  1057c6:	6a 00                	push   $0x0
  1057c8:	6a 62                	push   $0x62
  1057ca:	e9 6d fc ff ff       	jmp    10543c <alltraps>

001057cf <vector99>:
  1057cf:	6a 00                	push   $0x0
  1057d1:	6a 63                	push   $0x63
  1057d3:	e9 64 fc ff ff       	jmp    10543c <alltraps>

001057d8 <vector100>:
  1057d8:	6a 00                	push   $0x0
  1057da:	6a 64                	push   $0x64
  1057dc:	e9 5b fc ff ff       	jmp    10543c <alltraps>

001057e1 <vector101>:
  1057e1:	6a 00                	push   $0x0
  1057e3:	6a 65                	push   $0x65
  1057e5:	e9 52 fc ff ff       	jmp    10543c <alltraps>

001057ea <vector102>:
  1057ea:	6a 00                	push   $0x0
  1057ec:	6a 66                	push   $0x66
  1057ee:	e9 49 fc ff ff       	jmp    10543c <alltraps>

001057f3 <vector103>:
  1057f3:	6a 00                	push   $0x0
  1057f5:	6a 67                	push   $0x67
  1057f7:	e9 40 fc ff ff       	jmp    10543c <alltraps>

001057fc <vector104>:
  1057fc:	6a 00                	push   $0x0
  1057fe:	6a 68                	push   $0x68
  105800:	e9 37 fc ff ff       	jmp    10543c <alltraps>

00105805 <vector105>:
  105805:	6a 00                	push   $0x0
  105807:	6a 69                	push   $0x69
  105809:	e9 2e fc ff ff       	jmp    10543c <alltraps>

0010580e <vector106>:
  10580e:	6a 00                	push   $0x0
  105810:	6a 6a                	push   $0x6a
  105812:	e9 25 fc ff ff       	jmp    10543c <alltraps>

00105817 <vector107>:
  105817:	6a 00                	push   $0x0
  105819:	6a 6b                	push   $0x6b
  10581b:	e9 1c fc ff ff       	jmp    10543c <alltraps>

00105820 <vector108>:
  105820:	6a 00                	push   $0x0
  105822:	6a 6c                	push   $0x6c
  105824:	e9 13 fc ff ff       	jmp    10543c <alltraps>

00105829 <vector109>:
  105829:	6a 00                	push   $0x0
  10582b:	6a 6d                	push   $0x6d
  10582d:	e9 0a fc ff ff       	jmp    10543c <alltraps>

00105832 <vector110>:
  105832:	6a 00                	push   $0x0
  105834:	6a 6e                	push   $0x6e
  105836:	e9 01 fc ff ff       	jmp    10543c <alltraps>

0010583b <vector111>:
  10583b:	6a 00                	push   $0x0
  10583d:	6a 6f                	push   $0x6f
  10583f:	e9 f8 fb ff ff       	jmp    10543c <alltraps>

00105844 <vector112>:
  105844:	6a 00                	push   $0x0
  105846:	6a 70                	push   $0x70
  105848:	e9 ef fb ff ff       	jmp    10543c <alltraps>

0010584d <vector113>:
  10584d:	6a 00                	push   $0x0
  10584f:	6a 71                	push   $0x71
  105851:	e9 e6 fb ff ff       	jmp    10543c <alltraps>

00105856 <vector114>:
  105856:	6a 00                	push   $0x0
  105858:	6a 72                	push   $0x72
  10585a:	e9 dd fb ff ff       	jmp    10543c <alltraps>

0010585f <vector115>:
  10585f:	6a 00                	push   $0x0
  105861:	6a 73                	push   $0x73
  105863:	e9 d4 fb ff ff       	jmp    10543c <alltraps>

00105868 <vector116>:
  105868:	6a 00                	push   $0x0
  10586a:	6a 74                	push   $0x74
  10586c:	e9 cb fb ff ff       	jmp    10543c <alltraps>

00105871 <vector117>:
  105871:	6a 00                	push   $0x0
  105873:	6a 75                	push   $0x75
  105875:	e9 c2 fb ff ff       	jmp    10543c <alltraps>

0010587a <vector118>:
  10587a:	6a 00                	push   $0x0
  10587c:	6a 76                	push   $0x76
  10587e:	e9 b9 fb ff ff       	jmp    10543c <alltraps>

00105883 <vector119>:
  105883:	6a 00                	push   $0x0
  105885:	6a 77                	push   $0x77
  105887:	e9 b0 fb ff ff       	jmp    10543c <alltraps>

0010588c <vector120>:
  10588c:	6a 00                	push   $0x0
  10588e:	6a 78                	push   $0x78
  105890:	e9 a7 fb ff ff       	jmp    10543c <alltraps>

00105895 <vector121>:
  105895:	6a 00                	push   $0x0
  105897:	6a 79                	push   $0x79
  105899:	e9 9e fb ff ff       	jmp    10543c <alltraps>

0010589e <vector122>:
  10589e:	6a 00                	push   $0x0
  1058a0:	6a 7a                	push   $0x7a
  1058a2:	e9 95 fb ff ff       	jmp    10543c <alltraps>

001058a7 <vector123>:
  1058a7:	6a 00                	push   $0x0
  1058a9:	6a 7b                	push   $0x7b
  1058ab:	e9 8c fb ff ff       	jmp    10543c <alltraps>

001058b0 <vector124>:
  1058b0:	6a 00                	push   $0x0
  1058b2:	6a 7c                	push   $0x7c
  1058b4:	e9 83 fb ff ff       	jmp    10543c <alltraps>

001058b9 <vector125>:
  1058b9:	6a 00                	push   $0x0
  1058bb:	6a 7d                	push   $0x7d
  1058bd:	e9 7a fb ff ff       	jmp    10543c <alltraps>

001058c2 <vector126>:
  1058c2:	6a 00                	push   $0x0
  1058c4:	6a 7e                	push   $0x7e
  1058c6:	e9 71 fb ff ff       	jmp    10543c <alltraps>

001058cb <vector127>:
  1058cb:	6a 00                	push   $0x0
  1058cd:	6a 7f                	push   $0x7f
  1058cf:	e9 68 fb ff ff       	jmp    10543c <alltraps>

001058d4 <vector128>:
  1058d4:	6a 00                	push   $0x0
  1058d6:	68 80 00 00 00       	push   $0x80
  1058db:	e9 5c fb ff ff       	jmp    10543c <alltraps>

001058e0 <vector129>:
  1058e0:	6a 00                	push   $0x0
  1058e2:	68 81 00 00 00       	push   $0x81
  1058e7:	e9 50 fb ff ff       	jmp    10543c <alltraps>

001058ec <vector130>:
  1058ec:	6a 00                	push   $0x0
  1058ee:	68 82 00 00 00       	push   $0x82
  1058f3:	e9 44 fb ff ff       	jmp    10543c <alltraps>

001058f8 <vector131>:
  1058f8:	6a 00                	push   $0x0
  1058fa:	68 83 00 00 00       	push   $0x83
  1058ff:	e9 38 fb ff ff       	jmp    10543c <alltraps>

00105904 <vector132>:
  105904:	6a 00                	push   $0x0
  105906:	68 84 00 00 00       	push   $0x84
  10590b:	e9 2c fb ff ff       	jmp    10543c <alltraps>

00105910 <vector133>:
  105910:	6a 00                	push   $0x0
  105912:	68 85 00 00 00       	push   $0x85
  105917:	e9 20 fb ff ff       	jmp    10543c <alltraps>

0010591c <vector134>:
  10591c:	6a 00                	push   $0x0
  10591e:	68 86 00 00 00       	push   $0x86
  105923:	e9 14 fb ff ff       	jmp    10543c <alltraps>

00105928 <vector135>:
  105928:	6a 00                	push   $0x0
  10592a:	68 87 00 00 00       	push   $0x87
  10592f:	e9 08 fb ff ff       	jmp    10543c <alltraps>

00105934 <vector136>:
  105934:	6a 00                	push   $0x0
  105936:	68 88 00 00 00       	push   $0x88
  10593b:	e9 fc fa ff ff       	jmp    10543c <alltraps>

00105940 <vector137>:
  105940:	6a 00                	push   $0x0
  105942:	68 89 00 00 00       	push   $0x89
  105947:	e9 f0 fa ff ff       	jmp    10543c <alltraps>

0010594c <vector138>:
  10594c:	6a 00                	push   $0x0
  10594e:	68 8a 00 00 00       	push   $0x8a
  105953:	e9 e4 fa ff ff       	jmp    10543c <alltraps>

00105958 <vector139>:
  105958:	6a 00                	push   $0x0
  10595a:	68 8b 00 00 00       	push   $0x8b
  10595f:	e9 d8 fa ff ff       	jmp    10543c <alltraps>

00105964 <vector140>:
  105964:	6a 00                	push   $0x0
  105966:	68 8c 00 00 00       	push   $0x8c
  10596b:	e9 cc fa ff ff       	jmp    10543c <alltraps>

00105970 <vector141>:
  105970:	6a 00                	push   $0x0
  105972:	68 8d 00 00 00       	push   $0x8d
  105977:	e9 c0 fa ff ff       	jmp    10543c <alltraps>

0010597c <vector142>:
  10597c:	6a 00                	push   $0x0
  10597e:	68 8e 00 00 00       	push   $0x8e
  105983:	e9 b4 fa ff ff       	jmp    10543c <alltraps>

00105988 <vector143>:
  105988:	6a 00                	push   $0x0
  10598a:	68 8f 00 00 00       	push   $0x8f
  10598f:	e9 a8 fa ff ff       	jmp    10543c <alltraps>

00105994 <vector144>:
  105994:	6a 00                	push   $0x0
  105996:	68 90 00 00 00       	push   $0x90
  10599b:	e9 9c fa ff ff       	jmp    10543c <alltraps>

001059a0 <vector145>:
  1059a0:	6a 00                	push   $0x0
  1059a2:	68 91 00 00 00       	push   $0x91
  1059a7:	e9 90 fa ff ff       	jmp    10543c <alltraps>

001059ac <vector146>:
  1059ac:	6a 00                	push   $0x0
  1059ae:	68 92 00 00 00       	push   $0x92
  1059b3:	e9 84 fa ff ff       	jmp    10543c <alltraps>

001059b8 <vector147>:
  1059b8:	6a 00                	push   $0x0
  1059ba:	68 93 00 00 00       	push   $0x93
  1059bf:	e9 78 fa ff ff       	jmp    10543c <alltraps>

001059c4 <vector148>:
  1059c4:	6a 00                	push   $0x0
  1059c6:	68 94 00 00 00       	push   $0x94
  1059cb:	e9 6c fa ff ff       	jmp    10543c <alltraps>

001059d0 <vector149>:
  1059d0:	6a 00                	push   $0x0
  1059d2:	68 95 00 00 00       	push   $0x95
  1059d7:	e9 60 fa ff ff       	jmp    10543c <alltraps>

001059dc <vector150>:
  1059dc:	6a 00                	push   $0x0
  1059de:	68 96 00 00 00       	push   $0x96
  1059e3:	e9 54 fa ff ff       	jmp    10543c <alltraps>

001059e8 <vector151>:
  1059e8:	6a 00                	push   $0x0
  1059ea:	68 97 00 00 00       	push   $0x97
  1059ef:	e9 48 fa ff ff       	jmp    10543c <alltraps>

001059f4 <vector152>:
  1059f4:	6a 00                	push   $0x0
  1059f6:	68 98 00 00 00       	push   $0x98
  1059fb:	e9 3c fa ff ff       	jmp    10543c <alltraps>

00105a00 <vector153>:
  105a00:	6a 00                	push   $0x0
  105a02:	68 99 00 00 00       	push   $0x99
  105a07:	e9 30 fa ff ff       	jmp    10543c <alltraps>

00105a0c <vector154>:
  105a0c:	6a 00                	push   $0x0
  105a0e:	68 9a 00 00 00       	push   $0x9a
  105a13:	e9 24 fa ff ff       	jmp    10543c <alltraps>

00105a18 <vector155>:
  105a18:	6a 00                	push   $0x0
  105a1a:	68 9b 00 00 00       	push   $0x9b
  105a1f:	e9 18 fa ff ff       	jmp    10543c <alltraps>

00105a24 <vector156>:
  105a24:	6a 00                	push   $0x0
  105a26:	68 9c 00 00 00       	push   $0x9c
  105a2b:	e9 0c fa ff ff       	jmp    10543c <alltraps>

00105a30 <vector157>:
  105a30:	6a 00                	push   $0x0
  105a32:	68 9d 00 00 00       	push   $0x9d
  105a37:	e9 00 fa ff ff       	jmp    10543c <alltraps>

00105a3c <vector158>:
  105a3c:	6a 00                	push   $0x0
  105a3e:	68 9e 00 00 00       	push   $0x9e
  105a43:	e9 f4 f9 ff ff       	jmp    10543c <alltraps>

00105a48 <vector159>:
  105a48:	6a 00                	push   $0x0
  105a4a:	68 9f 00 00 00       	push   $0x9f
  105a4f:	e9 e8 f9 ff ff       	jmp    10543c <alltraps>

00105a54 <vector160>:
  105a54:	6a 00                	push   $0x0
  105a56:	68 a0 00 00 00       	push   $0xa0
  105a5b:	e9 dc f9 ff ff       	jmp    10543c <alltraps>

00105a60 <vector161>:
  105a60:	6a 00                	push   $0x0
  105a62:	68 a1 00 00 00       	push   $0xa1
  105a67:	e9 d0 f9 ff ff       	jmp    10543c <alltraps>

00105a6c <vector162>:
  105a6c:	6a 00                	push   $0x0
  105a6e:	68 a2 00 00 00       	push   $0xa2
  105a73:	e9 c4 f9 ff ff       	jmp    10543c <alltraps>

00105a78 <vector163>:
  105a78:	6a 00                	push   $0x0
  105a7a:	68 a3 00 00 00       	push   $0xa3
  105a7f:	e9 b8 f9 ff ff       	jmp    10543c <alltraps>

00105a84 <vector164>:
  105a84:	6a 00                	push   $0x0
  105a86:	68 a4 00 00 00       	push   $0xa4
  105a8b:	e9 ac f9 ff ff       	jmp    10543c <alltraps>

00105a90 <vector165>:
  105a90:	6a 00                	push   $0x0
  105a92:	68 a5 00 00 00       	push   $0xa5
  105a97:	e9 a0 f9 ff ff       	jmp    10543c <alltraps>

00105a9c <vector166>:
  105a9c:	6a 00                	push   $0x0
  105a9e:	68 a6 00 00 00       	push   $0xa6
  105aa3:	e9 94 f9 ff ff       	jmp    10543c <alltraps>

00105aa8 <vector167>:
  105aa8:	6a 00                	push   $0x0
  105aaa:	68 a7 00 00 00       	push   $0xa7
  105aaf:	e9 88 f9 ff ff       	jmp    10543c <alltraps>

00105ab4 <vector168>:
  105ab4:	6a 00                	push   $0x0
  105ab6:	68 a8 00 00 00       	push   $0xa8
  105abb:	e9 7c f9 ff ff       	jmp    10543c <alltraps>

00105ac0 <vector169>:
  105ac0:	6a 00                	push   $0x0
  105ac2:	68 a9 00 00 00       	push   $0xa9
  105ac7:	e9 70 f9 ff ff       	jmp    10543c <alltraps>

00105acc <vector170>:
  105acc:	6a 00                	push   $0x0
  105ace:	68 aa 00 00 00       	push   $0xaa
  105ad3:	e9 64 f9 ff ff       	jmp    10543c <alltraps>

00105ad8 <vector171>:
  105ad8:	6a 00                	push   $0x0
  105ada:	68 ab 00 00 00       	push   $0xab
  105adf:	e9 58 f9 ff ff       	jmp    10543c <alltraps>

00105ae4 <vector172>:
  105ae4:	6a 00                	push   $0x0
  105ae6:	68 ac 00 00 00       	push   $0xac
  105aeb:	e9 4c f9 ff ff       	jmp    10543c <alltraps>

00105af0 <vector173>:
  105af0:	6a 00                	push   $0x0
  105af2:	68 ad 00 00 00       	push   $0xad
  105af7:	e9 40 f9 ff ff       	jmp    10543c <alltraps>

00105afc <vector174>:
  105afc:	6a 00                	push   $0x0
  105afe:	68 ae 00 00 00       	push   $0xae
  105b03:	e9 34 f9 ff ff       	jmp    10543c <alltraps>

00105b08 <vector175>:
  105b08:	6a 00                	push   $0x0
  105b0a:	68 af 00 00 00       	push   $0xaf
  105b0f:	e9 28 f9 ff ff       	jmp    10543c <alltraps>

00105b14 <vector176>:
  105b14:	6a 00                	push   $0x0
  105b16:	68 b0 00 00 00       	push   $0xb0
  105b1b:	e9 1c f9 ff ff       	jmp    10543c <alltraps>

00105b20 <vector177>:
  105b20:	6a 00                	push   $0x0
  105b22:	68 b1 00 00 00       	push   $0xb1
  105b27:	e9 10 f9 ff ff       	jmp    10543c <alltraps>

00105b2c <vector178>:
  105b2c:	6a 00                	push   $0x0
  105b2e:	68 b2 00 00 00       	push   $0xb2
  105b33:	e9 04 f9 ff ff       	jmp    10543c <alltraps>

00105b38 <vector179>:
  105b38:	6a 00                	push   $0x0
  105b3a:	68 b3 00 00 00       	push   $0xb3
  105b3f:	e9 f8 f8 ff ff       	jmp    10543c <alltraps>

00105b44 <vector180>:
  105b44:	6a 00                	push   $0x0
  105b46:	68 b4 00 00 00       	push   $0xb4
  105b4b:	e9 ec f8 ff ff       	jmp    10543c <alltraps>

00105b50 <vector181>:
  105b50:	6a 00                	push   $0x0
  105b52:	68 b5 00 00 00       	push   $0xb5
  105b57:	e9 e0 f8 ff ff       	jmp    10543c <alltraps>

00105b5c <vector182>:
  105b5c:	6a 00                	push   $0x0
  105b5e:	68 b6 00 00 00       	push   $0xb6
  105b63:	e9 d4 f8 ff ff       	jmp    10543c <alltraps>

00105b68 <vector183>:
  105b68:	6a 00                	push   $0x0
  105b6a:	68 b7 00 00 00       	push   $0xb7
  105b6f:	e9 c8 f8 ff ff       	jmp    10543c <alltraps>

00105b74 <vector184>:
  105b74:	6a 00                	push   $0x0
  105b76:	68 b8 00 00 00       	push   $0xb8
  105b7b:	e9 bc f8 ff ff       	jmp    10543c <alltraps>

00105b80 <vector185>:
  105b80:	6a 00                	push   $0x0
  105b82:	68 b9 00 00 00       	push   $0xb9
  105b87:	e9 b0 f8 ff ff       	jmp    10543c <alltraps>

00105b8c <vector186>:
  105b8c:	6a 00                	push   $0x0
  105b8e:	68 ba 00 00 00       	push   $0xba
  105b93:	e9 a4 f8 ff ff       	jmp    10543c <alltraps>

00105b98 <vector187>:
  105b98:	6a 00                	push   $0x0
  105b9a:	68 bb 00 00 00       	push   $0xbb
  105b9f:	e9 98 f8 ff ff       	jmp    10543c <alltraps>

00105ba4 <vector188>:
  105ba4:	6a 00                	push   $0x0
  105ba6:	68 bc 00 00 00       	push   $0xbc
  105bab:	e9 8c f8 ff ff       	jmp    10543c <alltraps>

00105bb0 <vector189>:
  105bb0:	6a 00                	push   $0x0
  105bb2:	68 bd 00 00 00       	push   $0xbd
  105bb7:	e9 80 f8 ff ff       	jmp    10543c <alltraps>

00105bbc <vector190>:
  105bbc:	6a 00                	push   $0x0
  105bbe:	68 be 00 00 00       	push   $0xbe
  105bc3:	e9 74 f8 ff ff       	jmp    10543c <alltraps>

00105bc8 <vector191>:
  105bc8:	6a 00                	push   $0x0
  105bca:	68 bf 00 00 00       	push   $0xbf
  105bcf:	e9 68 f8 ff ff       	jmp    10543c <alltraps>

00105bd4 <vector192>:
  105bd4:	6a 00                	push   $0x0
  105bd6:	68 c0 00 00 00       	push   $0xc0
  105bdb:	e9 5c f8 ff ff       	jmp    10543c <alltraps>

00105be0 <vector193>:
  105be0:	6a 00                	push   $0x0
  105be2:	68 c1 00 00 00       	push   $0xc1
  105be7:	e9 50 f8 ff ff       	jmp    10543c <alltraps>

00105bec <vector194>:
  105bec:	6a 00                	push   $0x0
  105bee:	68 c2 00 00 00       	push   $0xc2
  105bf3:	e9 44 f8 ff ff       	jmp    10543c <alltraps>

00105bf8 <vector195>:
  105bf8:	6a 00                	push   $0x0
  105bfa:	68 c3 00 00 00       	push   $0xc3
  105bff:	e9 38 f8 ff ff       	jmp    10543c <alltraps>

00105c04 <vector196>:
  105c04:	6a 00                	push   $0x0
  105c06:	68 c4 00 00 00       	push   $0xc4
  105c0b:	e9 2c f8 ff ff       	jmp    10543c <alltraps>

00105c10 <vector197>:
  105c10:	6a 00                	push   $0x0
  105c12:	68 c5 00 00 00       	push   $0xc5
  105c17:	e9 20 f8 ff ff       	jmp    10543c <alltraps>

00105c1c <vector198>:
  105c1c:	6a 00                	push   $0x0
  105c1e:	68 c6 00 00 00       	push   $0xc6
  105c23:	e9 14 f8 ff ff       	jmp    10543c <alltraps>

00105c28 <vector199>:
  105c28:	6a 00                	push   $0x0
  105c2a:	68 c7 00 00 00       	push   $0xc7
  105c2f:	e9 08 f8 ff ff       	jmp    10543c <alltraps>

00105c34 <vector200>:
  105c34:	6a 00                	push   $0x0
  105c36:	68 c8 00 00 00       	push   $0xc8
  105c3b:	e9 fc f7 ff ff       	jmp    10543c <alltraps>

00105c40 <vector201>:
  105c40:	6a 00                	push   $0x0
  105c42:	68 c9 00 00 00       	push   $0xc9
  105c47:	e9 f0 f7 ff ff       	jmp    10543c <alltraps>

00105c4c <vector202>:
  105c4c:	6a 00                	push   $0x0
  105c4e:	68 ca 00 00 00       	push   $0xca
  105c53:	e9 e4 f7 ff ff       	jmp    10543c <alltraps>

00105c58 <vector203>:
  105c58:	6a 00                	push   $0x0
  105c5a:	68 cb 00 00 00       	push   $0xcb
  105c5f:	e9 d8 f7 ff ff       	jmp    10543c <alltraps>

00105c64 <vector204>:
  105c64:	6a 00                	push   $0x0
  105c66:	68 cc 00 00 00       	push   $0xcc
  105c6b:	e9 cc f7 ff ff       	jmp    10543c <alltraps>

00105c70 <vector205>:
  105c70:	6a 00                	push   $0x0
  105c72:	68 cd 00 00 00       	push   $0xcd
  105c77:	e9 c0 f7 ff ff       	jmp    10543c <alltraps>

00105c7c <vector206>:
  105c7c:	6a 00                	push   $0x0
  105c7e:	68 ce 00 00 00       	push   $0xce
  105c83:	e9 b4 f7 ff ff       	jmp    10543c <alltraps>

00105c88 <vector207>:
  105c88:	6a 00                	push   $0x0
  105c8a:	68 cf 00 00 00       	push   $0xcf
  105c8f:	e9 a8 f7 ff ff       	jmp    10543c <alltraps>

00105c94 <vector208>:
  105c94:	6a 00                	push   $0x0
  105c96:	68 d0 00 00 00       	push   $0xd0
  105c9b:	e9 9c f7 ff ff       	jmp    10543c <alltraps>

00105ca0 <vector209>:
  105ca0:	6a 00                	push   $0x0
  105ca2:	68 d1 00 00 00       	push   $0xd1
  105ca7:	e9 90 f7 ff ff       	jmp    10543c <alltraps>

00105cac <vector210>:
  105cac:	6a 00                	push   $0x0
  105cae:	68 d2 00 00 00       	push   $0xd2
  105cb3:	e9 84 f7 ff ff       	jmp    10543c <alltraps>

00105cb8 <vector211>:
  105cb8:	6a 00                	push   $0x0
  105cba:	68 d3 00 00 00       	push   $0xd3
  105cbf:	e9 78 f7 ff ff       	jmp    10543c <alltraps>

00105cc4 <vector212>:
  105cc4:	6a 00                	push   $0x0
  105cc6:	68 d4 00 00 00       	push   $0xd4
  105ccb:	e9 6c f7 ff ff       	jmp    10543c <alltraps>

00105cd0 <vector213>:
  105cd0:	6a 00                	push   $0x0
  105cd2:	68 d5 00 00 00       	push   $0xd5
  105cd7:	e9 60 f7 ff ff       	jmp    10543c <alltraps>

00105cdc <vector214>:
  105cdc:	6a 00                	push   $0x0
  105cde:	68 d6 00 00 00       	push   $0xd6
  105ce3:	e9 54 f7 ff ff       	jmp    10543c <alltraps>

00105ce8 <vector215>:
  105ce8:	6a 00                	push   $0x0
  105cea:	68 d7 00 00 00       	push   $0xd7
  105cef:	e9 48 f7 ff ff       	jmp    10543c <alltraps>

00105cf4 <vector216>:
  105cf4:	6a 00                	push   $0x0
  105cf6:	68 d8 00 00 00       	push   $0xd8
  105cfb:	e9 3c f7 ff ff       	jmp    10543c <alltraps>

00105d00 <vector217>:
  105d00:	6a 00                	push   $0x0
  105d02:	68 d9 00 00 00       	push   $0xd9
  105d07:	e9 30 f7 ff ff       	jmp    10543c <alltraps>

00105d0c <vector218>:
  105d0c:	6a 00                	push   $0x0
  105d0e:	68 da 00 00 00       	push   $0xda
  105d13:	e9 24 f7 ff ff       	jmp    10543c <alltraps>

00105d18 <vector219>:
  105d18:	6a 00                	push   $0x0
  105d1a:	68 db 00 00 00       	push   $0xdb
  105d1f:	e9 18 f7 ff ff       	jmp    10543c <alltraps>

00105d24 <vector220>:
  105d24:	6a 00                	push   $0x0
  105d26:	68 dc 00 00 00       	push   $0xdc
  105d2b:	e9 0c f7 ff ff       	jmp    10543c <alltraps>

00105d30 <vector221>:
  105d30:	6a 00                	push   $0x0
  105d32:	68 dd 00 00 00       	push   $0xdd
  105d37:	e9 00 f7 ff ff       	jmp    10543c <alltraps>

00105d3c <vector222>:
  105d3c:	6a 00                	push   $0x0
  105d3e:	68 de 00 00 00       	push   $0xde
  105d43:	e9 f4 f6 ff ff       	jmp    10543c <alltraps>

00105d48 <vector223>:
  105d48:	6a 00                	push   $0x0
  105d4a:	68 df 00 00 00       	push   $0xdf
  105d4f:	e9 e8 f6 ff ff       	jmp    10543c <alltraps>

00105d54 <vector224>:
  105d54:	6a 00                	push   $0x0
  105d56:	68 e0 00 00 00       	push   $0xe0
  105d5b:	e9 dc f6 ff ff       	jmp    10543c <alltraps>

00105d60 <vector225>:
  105d60:	6a 00                	push   $0x0
  105d62:	68 e1 00 00 00       	push   $0xe1
  105d67:	e9 d0 f6 ff ff       	jmp    10543c <alltraps>

00105d6c <vector226>:
  105d6c:	6a 00                	push   $0x0
  105d6e:	68 e2 00 00 00       	push   $0xe2
  105d73:	e9 c4 f6 ff ff       	jmp    10543c <alltraps>

00105d78 <vector227>:
  105d78:	6a 00                	push   $0x0
  105d7a:	68 e3 00 00 00       	push   $0xe3
  105d7f:	e9 b8 f6 ff ff       	jmp    10543c <alltraps>

00105d84 <vector228>:
  105d84:	6a 00                	push   $0x0
  105d86:	68 e4 00 00 00       	push   $0xe4
  105d8b:	e9 ac f6 ff ff       	jmp    10543c <alltraps>

00105d90 <vector229>:
  105d90:	6a 00                	push   $0x0
  105d92:	68 e5 00 00 00       	push   $0xe5
  105d97:	e9 a0 f6 ff ff       	jmp    10543c <alltraps>

00105d9c <vector230>:
  105d9c:	6a 00                	push   $0x0
  105d9e:	68 e6 00 00 00       	push   $0xe6
  105da3:	e9 94 f6 ff ff       	jmp    10543c <alltraps>

00105da8 <vector231>:
  105da8:	6a 00                	push   $0x0
  105daa:	68 e7 00 00 00       	push   $0xe7
  105daf:	e9 88 f6 ff ff       	jmp    10543c <alltraps>

00105db4 <vector232>:
  105db4:	6a 00                	push   $0x0
  105db6:	68 e8 00 00 00       	push   $0xe8
  105dbb:	e9 7c f6 ff ff       	jmp    10543c <alltraps>

00105dc0 <vector233>:
  105dc0:	6a 00                	push   $0x0
  105dc2:	68 e9 00 00 00       	push   $0xe9
  105dc7:	e9 70 f6 ff ff       	jmp    10543c <alltraps>

00105dcc <vector234>:
  105dcc:	6a 00                	push   $0x0
  105dce:	68 ea 00 00 00       	push   $0xea
  105dd3:	e9 64 f6 ff ff       	jmp    10543c <alltraps>

00105dd8 <vector235>:
  105dd8:	6a 00                	push   $0x0
  105dda:	68 eb 00 00 00       	push   $0xeb
  105ddf:	e9 58 f6 ff ff       	jmp    10543c <alltraps>

00105de4 <vector236>:
  105de4:	6a 00                	push   $0x0
  105de6:	68 ec 00 00 00       	push   $0xec
  105deb:	e9 4c f6 ff ff       	jmp    10543c <alltraps>

00105df0 <vector237>:
  105df0:	6a 00                	push   $0x0
  105df2:	68 ed 00 00 00       	push   $0xed
  105df7:	e9 40 f6 ff ff       	jmp    10543c <alltraps>

00105dfc <vector238>:
  105dfc:	6a 00                	push   $0x0
  105dfe:	68 ee 00 00 00       	push   $0xee
  105e03:	e9 34 f6 ff ff       	jmp    10543c <alltraps>

00105e08 <vector239>:
  105e08:	6a 00                	push   $0x0
  105e0a:	68 ef 00 00 00       	push   $0xef
  105e0f:	e9 28 f6 ff ff       	jmp    10543c <alltraps>

00105e14 <vector240>:
  105e14:	6a 00                	push   $0x0
  105e16:	68 f0 00 00 00       	push   $0xf0
  105e1b:	e9 1c f6 ff ff       	jmp    10543c <alltraps>

00105e20 <vector241>:
  105e20:	6a 00                	push   $0x0
  105e22:	68 f1 00 00 00       	push   $0xf1
  105e27:	e9 10 f6 ff ff       	jmp    10543c <alltraps>

00105e2c <vector242>:
  105e2c:	6a 00                	push   $0x0
  105e2e:	68 f2 00 00 00       	push   $0xf2
  105e33:	e9 04 f6 ff ff       	jmp    10543c <alltraps>

00105e38 <vector243>:
  105e38:	6a 00                	push   $0x0
  105e3a:	68 f3 00 00 00       	push   $0xf3
  105e3f:	e9 f8 f5 ff ff       	jmp    10543c <alltraps>

00105e44 <vector244>:
  105e44:	6a 00                	push   $0x0
  105e46:	68 f4 00 00 00       	push   $0xf4
  105e4b:	e9 ec f5 ff ff       	jmp    10543c <alltraps>

00105e50 <vector245>:
  105e50:	6a 00                	push   $0x0
  105e52:	68 f5 00 00 00       	push   $0xf5
  105e57:	e9 e0 f5 ff ff       	jmp    10543c <alltraps>

00105e5c <vector246>:
  105e5c:	6a 00                	push   $0x0
  105e5e:	68 f6 00 00 00       	push   $0xf6
  105e63:	e9 d4 f5 ff ff       	jmp    10543c <alltraps>

00105e68 <vector247>:
  105e68:	6a 00                	push   $0x0
  105e6a:	68 f7 00 00 00       	push   $0xf7
  105e6f:	e9 c8 f5 ff ff       	jmp    10543c <alltraps>

00105e74 <vector248>:
  105e74:	6a 00                	push   $0x0
  105e76:	68 f8 00 00 00       	push   $0xf8
  105e7b:	e9 bc f5 ff ff       	jmp    10543c <alltraps>

00105e80 <vector249>:
  105e80:	6a 00                	push   $0x0
  105e82:	68 f9 00 00 00       	push   $0xf9
  105e87:	e9 b0 f5 ff ff       	jmp    10543c <alltraps>

00105e8c <vector250>:
  105e8c:	6a 00                	push   $0x0
  105e8e:	68 fa 00 00 00       	push   $0xfa
  105e93:	e9 a4 f5 ff ff       	jmp    10543c <alltraps>

00105e98 <vector251>:
  105e98:	6a 00                	push   $0x0
  105e9a:	68 fb 00 00 00       	push   $0xfb
  105e9f:	e9 98 f5 ff ff       	jmp    10543c <alltraps>

00105ea4 <vector252>:
  105ea4:	6a 00                	push   $0x0
  105ea6:	68 fc 00 00 00       	push   $0xfc
  105eab:	e9 8c f5 ff ff       	jmp    10543c <alltraps>

00105eb0 <vector253>:
  105eb0:	6a 00                	push   $0x0
  105eb2:	68 fd 00 00 00       	push   $0xfd
  105eb7:	e9 80 f5 ff ff       	jmp    10543c <alltraps>

00105ebc <vector254>:
  105ebc:	6a 00                	push   $0x0
  105ebe:	68 fe 00 00 00       	push   $0xfe
  105ec3:	e9 74 f5 ff ff       	jmp    10543c <alltraps>

00105ec8 <vector255>:
  105ec8:	6a 00                	push   $0x0
  105eca:	68 ff 00 00 00       	push   $0xff
  105ecf:	e9 68 f5 ff ff       	jmp    10543c <alltraps>
  105ed4:	90                   	nop
  105ed5:	90                   	nop
  105ed6:	90                   	nop
  105ed7:	90                   	nop
  105ed8:	90                   	nop
  105ed9:	90                   	nop
  105eda:	90                   	nop
  105edb:	90                   	nop
  105edc:	90                   	nop
  105edd:	90                   	nop
  105ede:	90                   	nop
  105edf:	90                   	nop

00105ee0 <mpmain>:

// Bootstrap processor gets here after setting up the hardware.
// Additional processors start here.
static void
mpmain(void)
{
  105ee0:	53                   	push   %ebx
  105ee1:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: mpmain\n", cpu());
  105ee4:	e8 47 ad ff ff       	call   100c30 <cpu>
  105ee9:	c7 04 24 64 66 10 00 	movl   $0x106664,(%esp)
  105ef0:	89 44 24 04          	mov    %eax,0x4(%esp)
  105ef4:	e8 27 a8 ff ff       	call   100720 <cprintf>
  idtinit();
  105ef9:	e8 92 f2 ff ff       	call   105190 <idtinit>
  if(cpu() != mp_bcpu())
  105efe:	e8 2d ad ff ff       	call   100c30 <cpu>
  105f03:	89 c3                	mov    %eax,%ebx
  105f05:	e8 66 c0 ff ff       	call   101f70 <mp_bcpu>
  105f0a:	39 c3                	cmp    %eax,%ebx
  105f0c:	74 0d                	je     105f1b <mpmain+0x3b>
    lapic_init(cpu());
  105f0e:	e8 1d ad ff ff       	call   100c30 <cpu>
  105f13:	89 04 24             	mov    %eax,(%esp)
  105f16:	e8 25 ac ff ff       	call   100b40 <lapic_init>
  setupsegs(0);
  105f1b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105f22:	e8 19 b1 ff ff       	call   101040 <setupsegs>
  xchg(&cpus[cpu()].booted, 1);
  105f27:	e8 04 ad ff ff       	call   100c30 <cpu>
  105f2c:	69 d0 cc 00 00 00    	imul   $0xcc,%eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  105f32:	b8 01 00 00 00       	mov    $0x1,%eax
  105f37:	81 c2 c0 00 00 00    	add    $0xc0,%edx
  105f3d:	f0 87 82 e0 d5 10 00 	lock xchg %eax,0x10d5e0(%edx)

  cprintf("cpu%d: scheduling\n");
  105f44:	c7 04 24 73 66 10 00 	movl   $0x106673,(%esp)
  105f4b:	e8 d0 a7 ff ff       	call   100720 <cprintf>
  scheduler();
  105f50:	e8 5b b6 ff ff       	call   1015b0 <scheduler>
