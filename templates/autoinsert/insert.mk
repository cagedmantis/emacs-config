EXECUTABLE=

CC= gcc

CFLAGS= -g -Wall -std=c99
LDLIBS= 

OUTFILE= $(EXECUTABLE)

OBJS   = $(EXECUTABLE).o

$(OUTFILE) : $(OBJS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean :
	rm -f  $(OUTFILE) $(OBJS) *~ *.o
