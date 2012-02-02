/*
 * dev.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef DEV_H_
#define DEV_H_

struct devsw {
  int (*read)(struct inode*, char*, int);
  int (*write)(struct inode*, char*, int);
};

extern struct devsw devsw[];

#define CONSOLE 1

#endif /* DEV_H_ */
