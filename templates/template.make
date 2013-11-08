CC := gcc
MKDIR := mkdir -p
CFLAGS := -Wall -Werror -Wextra -pedantic
PROGS := bin/main
OBJS := $(patsubst src/%.c,obj/%.o, $(wildcard src/*.c))

.PHONY: all clean

all: build

build: $(PROGS)

clean:
	rm -rf $(PROGS) $(OBJS)

bin/main: obj/main.o

$(PROGS):
	@$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

obj/%.o : src/%.c
	@$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) -c -MD -o $@ $<
