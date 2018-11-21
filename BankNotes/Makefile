banknotes: banknotes.o
	gcc -Wall banknotes.o -o banknotes

%.o: %.asm
	nasm -f elf64 -o $@ -g $<

clean:
	rm *.o
