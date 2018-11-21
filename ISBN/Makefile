isbn: isbn.o
	gcc -Wall isbn.o -o isbn

%.o: %.asm
	nasm -f elf64 -o $@ -g $<
clean:
	rm *.o
