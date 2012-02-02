/*
 * file.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef FILE_H_
#define FILE_H_

struct file {
  enum { FD_CLOSED, FD_NONE, FD_PIPE, FD_INODE } type;
  int ref; // reference count
  char readable;
  char writable;
  struct pipe *pipe;
  struct inode *ip;
  uint off;
};

#endif /* FILE_H_ */
