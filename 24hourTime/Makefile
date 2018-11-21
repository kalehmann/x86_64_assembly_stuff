24hourtime: 24hourTime.o
	gcc -Wall 24hourTime.o -o 24hourtime

%.o: %.asm
	nasm -f elf64 -o $@ -g $<

clean:
	rm *.o
