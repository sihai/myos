/*
 * fsvar.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef FSVAR_H_
#define FSVAR_H_

// in-core file system types

struct inode {
  uint dev;           // Device number
  uint inum;          // Inode number
  int ref;            // Reference count
  int flags;          // I_BUSY, I_VALID

  short type;         // copy of disk inode
  short major;
  short minor;
  short nlink;
  uint size;
  uint addrs[NADDRS];
};

#define I_BUSY 0x1
#define I_VALID 0x2

#endif /* FSVAR_H_ */
