/*
 * asm.h
 *
 *  Created on: Jan 24, 2012
 *      Author: sihai
 */

#ifndef ASM_H_
#define ASM_H_

//
// macros to create x86 segments from assembler
//

#define SEGMENT_NULL_ASM			\
	.word 0, 0;			\
	.byte 0, 0, 0, 0

#define SEGMENT_ASM(type, base, limit)					\
	.word (((limit) >> 12) & 0xffff), ((base) & 0xffff); 		\
	.byte (((base) >> 16) & 0xff), (0x90 | (type)), 		\
	(0xC0 | (((limit) >> 28) & 0xf)), (((base) >> 24) & 0xff)

#define STA_X 0x8 		// Executable segment
#define STA_E 0x4 		// Expand down (non?executable segments)
#define STA_C 0x4 		// Conforming code segment (executable only)
#define STA_W 0x2 		// Writeable (non?executable segments)
#define STA_R 0x2 		// Readable (executable segments)
#define STA_A 0x1 		// Accessed

#endif /* ASM_H_ */
