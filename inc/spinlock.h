/*
 * spinlock.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef SPINLOCK_H_
#define SPINLOCK_H_

// Mutual exclusion lock.
struct spinlock {
  uint locked;   // Is the lock held?

  // For debugging:
  char *name;    // Name of lock.
  int  cpu;      // The number of the cpu holding the lock.
  uint pcs[10];  // The call stack (an array of program counters)
                 // that locked the lock.
};

#endif /* SPINLOCK_H_ */
