#
# An example Makefile (GNU Make) to build our Shared C code from Go
#
OS = $(shell uname)
EXT = .dll
ifeq ($(OS), Darwin)
	EXT = .dynlib 
endif
ifeq ($(OS), Linux)
	EXT = .so
endif

build: foo$(EXT) foo.go
	go build -o foo$(EXT) -buildmode=c-shared

test: build
	python3 foo_test.py

clean:
	rm foo$(EXT) *.h *.pyc __pycache__
