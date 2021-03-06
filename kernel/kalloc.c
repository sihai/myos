/*
 * kalloc.c
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

// Physical memory allocator, intended to allocate
// memory for user processes. Allocates in 4096-byte "pages".
// Free list is kept sorted and combines adjacent pages into
// long runs, to make it easier to allocate big segments.
// One reason the page size is 4k is that the x86 segment size
// granularity is 4k.

#include "type.h"
#include "defs.h"
#include "param.h"
#include "spinlock.h"

struct spinlock kalloc_lock;

struct run {
  struct run *next;
  int length; // bytes
};
struct run *freelist;

// Initialize free list of physical pages.
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  extern int end;
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  kfree(start, mem * PAGE);
}

// Free the length bytes of memory pointed at by v,
// which normally should have been returned by a
// call to kalloc(length).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int length)
{
  struct run *r, *rend, **rp, *p, *pend;

  if(length <= 0 || length % PAGE)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, length);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + length);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->length);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->length = length + r->length;
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->length += length;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->length += r->next->length;
        r->next = r->next->next;
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->length = length;
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
}

// Allocate n bytes of physical memory.
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
// 这个函数操作链表有搞头，有深度，我靠
char*
kalloc(int n)
{
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
    if(r->length == n){
      *rp = r->next;
      release(&kalloc_lock);
      return (char*)r;
    }
    if(r->length > n){
      r->length -= n;
      p = (char*)r + r->length;
      release(&kalloc_lock);
      return p;
    }
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
