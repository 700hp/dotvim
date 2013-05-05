PROG := main

all: build

build: $(PROG)

clean:
	rm -rf $(PROG)

.PHONY: all clean
