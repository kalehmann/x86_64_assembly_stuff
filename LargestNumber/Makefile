largestnumber: largestnumber.o
	gcc -Wall largestnumber.o -o largestnumber

%.o: %.asm
	nasm -f elf64 -o $@ -g $<
clean:
	rm *.o
