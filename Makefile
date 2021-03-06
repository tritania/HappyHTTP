# to build for windows, use make WIN32=1

CC = clang++
EXE = test
SRCS = test.cpp happyhttp.cpp
LIB = libHappyHTTP.a

CXXFLAGS = -ggdb
LDFLAGS =

ifdef WIN32
# need to link with winsock2
LDFLAGS += -lws2_32
EXE = test.exe
endif

OBJS = $(patsubst %.cpp,%.o,$(SRCS) )


# -------------


$(EXE): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	
lib:
	$(CC) $(CFLAGS) -g -O -c $(SRCS) $(LDFLAGS)
	ar -cvq libHappyHTTP.a happyhttp.o

clean:
	rm -f $(OBJS)
	rm -f .depend
	rm -f $(LIB)
	rm -f $(EXE)


# automatically generate dependencies from our .cpp files
# (-MM tells the compiler to just output makefile rules)
depend:
	$(CC) -MM $(CPPFLAGS) $(CXXFLAGS) $(SRCS) > .depend

ifeq ($(wildcard .depend),.depend)
include .depend
endif



