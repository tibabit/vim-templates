######################################################################
# @author      : {{NAME}} ({{EMAIL}})
# @file        : {{FILE}}
# @created     : {{TIMESTAMP}}
######################################################################

IDIR =./include
CC=gcc
CFLAGS=-I$(IDIR)

ODIR=obj

LIBS=

_OBJ = main.o {{CURSOR}}
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

main: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o
