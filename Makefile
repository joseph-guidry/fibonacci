all: fibonacci

fibonacci: fibonacci.s
	nasm -g -felf64 fibonacci.s && gcc fibonacci.o -s -o fibonacci

clean:
	rm *.o fibonacci
