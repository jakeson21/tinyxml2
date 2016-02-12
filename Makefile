# the compiler to use.
CC=g++
src =$(wildcard *.cpp)
OBJS =$(src:.cpp=.o)

LIBB =/usr/lib/ lib
LDFLAGS = $(addprefix -L,$(LIBB))
# LDFLAGS += -static -ltinyxml2

LIBS = -ltinyxml2

INCLUDES =
EXECUTABLE=xmltest

# options I'll pass to the compiler.
CXXFLAGS =-std=c++11 -Wall -c ${INCLUDES}
DEBUG    =-std=c++11 -Wall -g -c ${INCLUDES}

all: lib $(EXECUTABLE)

$(EXECUTABLE): $(EXECUTABLE).o
	$(CC) $^ $(LDFLAGS) $(LIBS) -o $(EXECUTABLE)

$(EXECUTABLE).o: $(EXECUTABLE).cpp
	$(CC) $(CXXFLAGS) $^
	
tinyxml2.o: tinyxml2.cpp tinyxml2.h
	$(CC) $(CXXFLAGS) tinyxml2.cpp

debug: CXXFLAGS=$(DEBUG)
debug: all

lib: tinyxml2.o
	ar rvs lib/libtinyxml2.a tinyxml2.o

.PHONY: clean
clean:
	rm -f *.o xmltest ./lib/*.a

