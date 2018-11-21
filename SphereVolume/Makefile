main: main.c v_sphere.o
	gcc -Wall main.c v_sphere.o -o spherevolume

%.o: %.asm
	nasm -f elf64 -o $@ -g $<

clean:
	rm *.o
