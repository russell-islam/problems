CC          = gcc
CFLAGS      += -I include/
SRCS = main.c
DEPSDIR     = deps
DEPS        = $(addprefix $(DEPSDIR)/,${SRCS:.c=.d})
OBJS        = ${SRCS:.c=.o}

$(shell `mkdir -p $(DEPSDIR)`)

all : main

main: $(OBJS)
	$(CC) $(CFLAGS) -o main $(OBJS)


%.o : %.c
	$(CC) $(CFLAGS) -c $<

$(DEPSDIR)/%.d : %.c
	@$(CC) -M $(CFLAGS) $< > $@.$$$$;                   \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

clean:
	rm -rf $(DEPSDIR) $(OBJS)

-include $(DEPS)

.PHONY : clean
