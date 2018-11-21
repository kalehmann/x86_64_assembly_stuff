stackbufferoverflow: stackbufferoverflow.o
	gcc -Wall stackbufferoverflow.o -o stackbufferoverflow

%.o: %.asm
	nasm -f elf64 -o $@ -g $<
	
clean:
	rm *.o
