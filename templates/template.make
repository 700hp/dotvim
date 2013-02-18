CC := gcc
CFLAGS := -Wall -Werror -Wextra -pedantic -O3
LDFLAGS := 

PROG := main
OBJS := main.o

all: $(PROG)

$(PROG): $(OBJS)

clean:
	rm -rf $(PROG) $(OBJS)

.PHONY: all clean
