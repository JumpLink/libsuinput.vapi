.PHONY: all clean

all:
	valac --vapidir=./.. ../libsuinput.vapi --pkg linux --pkg posix -X -lsuinput mouse.vala -o mouse.o

clean: 
	rm -f mouse.o core *.c