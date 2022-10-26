ASMSRC = calls.asm start.asm
ASMOBJ = $(ASMSRC:.asm=.o)
CSRC = greet.c
COBJ = $(CSRC:.c=.o)

VPATH = asm c

ASM = nasm
CC = gcc

%.o: %.asm
	$(ASM) -f elf32 -Wall $< -o $@

greet.o: greet.c
	$(CC) -Wall -c -m32 $< -o $@

greet: $(COBJ) $(ASMOBJ)
	$(LD) -m elf_i386 $^ -o $@
	rm $^
