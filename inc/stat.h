/*
 * stat.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef STAT_H_
#define STAT_H_

struct stat {
  int dev;     // Device number
  uint ino;    // Inode number on device
  short type;  // Type of file
  short nlink; // Number of links to file
  uint size;   // Size of file in bytes
};

#endif /* STAT_H_ */
