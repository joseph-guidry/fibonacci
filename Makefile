all: fibonacci

fibonacci: fibonacci.s
	nasm -felf64 fibonacci.s && gcc fibonacci.o -s -o fibonacci

clean:
	rm *.o fibonacci
