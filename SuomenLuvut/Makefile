suomenluvut: suomenluvut.o
	gcc -Wall suomenluvut.o -o suomenluvut

%.o: %.asm
	nasm -f elf64 -o $@ -g $<

clean:
	rm *.o
