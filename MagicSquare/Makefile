magicsquare: magicsquare.o
	gcc -Wall magicsquare.o -o magicsquare

%.o: %.asm
	nasm -f elf64 -o $@ -g $<
clean:
	rm *.o
