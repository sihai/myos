/*
 * param.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef PARAM_H_
#define PARAM_H_

#define NPROC        128  // maximum number of processes
#define PAGE       4096  // granularity of user-space memory allocation
#define KSTACKSIZE PAGE  // size of per-process kernel stack
#define NCPU          8  // maximum number of CPUs
#define NOFILE       16  // open files per process
#define NFILE       128  // open files per system
#define NBUF         16  // size of disk block cache
#define NINODE       64  // maximum number of active i-nodes
#define NDEV         16  // maximum major device number
#define ROOTDEV       1  // device number of file system root disk

#endif /* PARAM_H_ */
