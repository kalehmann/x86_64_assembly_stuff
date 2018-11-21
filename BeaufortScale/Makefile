beaufortscale: beaufortscale.o
	gcc -Wall beaufortscale.o -o beaufortscale

%.o: %.asm
	nasm -f elf64 -o $@ -g $<
clean:
	rm *.o
