all: go

go: clean bitly
	./bitly

bitly: bitly.o
	gcc -O2 -Wall -Wno-unused bitly.o -L/opt/local/lib -lm -lspl -o bitly

bitly.o: bitly.c
	gcc -O2 -Wall -Wno-unused -I/opt/local/include -c bitly.c

bitly.c:
	spl2c < bitly.spl > bitly.c

clean:
	rm -f bitly bitly.o bitly.c
