CC=clang++ # g++
CCFLAGS=-std=c++11 -Wall
OBJS=test_ddm_fpt_lib.o ddm_fpt_lib.o
LIB_CCFLAGS=-std=c++11 -Wall -O3 -shared -fPIC -Wno-format-security

default: all
all: test_ddm_fpt_lib
clean: clean_ddm_fpt_lib clean_test_ddm_fpt_lib
.PHONY: clean

t1: t1.c ddm_fpt_lib.so
	$(CC) $(CCFLAGS) -o $@ t1.c ddm_fpt_lib.so

ddm_fpt_lib.o: ddm_fpt_lib.cpp ddm_fpt_lib.h
	$(CC) $(CCFLAGS) -c ddm_fpt_lib.cpp -o $@

ddm_fpt_lib.dylib: ddm_fpt_lib.cpp carlo.cpp
	$(CC) $(LIB_CCFLAGS) -o $@ ddm_fpt_lib.cpp carlo.cpp

ddm_fpt_lib.so: ddm_fpt_lib.cpp carlo.cpp
	$(CC) $(LIB_CCFLAGS) -o $@ ddm_fpt_lib.cpp carlo.cpp

test_ddm_fpt_lib.o: test_ddm_fpt_lib.cpp ddm_fpt_lib.h
	$(CC) $(CCFLAGS) -c test_ddm_fpt_lib.cpp -o $@

test_ddm_fpt_lib: test_ddm_fpt_lib.o ddm_fpt_lib.o
	$(CC) $(CCFLAGS) test_ddm_fpt_lib.o ddm_fpt_lib.o -o $@

clean_ddm_fpt_lib:
	rm -rf ddm_fpt_lib.o

clean_test_ddm_fpt_lib:
	rm -rf test_ddm_fpt_lib.o

# on MacOS, run make ddm_fpt_lib.dylib
# on Linux: make ddm_fpt_lib.so