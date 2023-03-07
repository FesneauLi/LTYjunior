# objects = main.o test.o print.o

# vmlinux:  $(objects)
# 	cc -o edit $(objects)

# main.o: print.h sbi.h
# 	cc -c main.c
# test.o: print.h def.h
# 	cc -c test.c
# print.o: print.h sbi.h
# 	cc -c print.c 

# .PHONY : clean
# clean:
# 	-rm edit $(objects)

C_SRC       = $(sort $(wildcard *.c))
OBJ		    = $(patsubst %.c,%.o,$(C_SRC))

file = print.o
all:$(OBJ)
	
%.o:%.c
	${GCC} ${CFLAG} -c $<
clean:
	$(shell rm *.o 2>/dev/null)
