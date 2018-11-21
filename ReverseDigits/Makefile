reversedigits: reversedigits.o
	gcc -Wall reversedigits.o -o reversedigits

%.o: %.asm
	nasm -f elf64 -o $@ -g $<

clean:
	rm *.o
