/*
 * buf.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef BUF_H_
#define BUF_H_

struct buf {
  int flags;
  uint dev;
  uint sector;
  struct buf *prev; // LRU cache list
  struct buf *next;
  struct buf *qnext; // disk queue
  uchar data[512];
};
#define B_BUSY  0x1  // buffer is locked by some process
#define B_VALID 0x2  // buffer has been read from disk
#define B_DIRTY 0x4  // buffer needs to be written to disk


#endif /* BUF_H_ */
