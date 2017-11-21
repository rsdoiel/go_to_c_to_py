#
# An example Makefile (GNU Make) to build our Shared C code from Go
#

PROJECT = foo

VERSION = $(shell grep -m 1 'Version =' $(PROJECT).go | cut -d\`  -f 2)

BRANCH = $(shell git branch | grep '* ' | cut -d\  -f 2)

OS = $(shell uname)

# Fallback is Windows, I have no idea is this is reasonable, I don't
# have a Windows box or tablet.
EXT = .dll
# Usual supects for shared libraries
ifeq ($(OS), Linux)
	EXT = .so
endif
ifeq ($(OS), Darwin)
	EXT = .dynlib 
endif

build: foo$(EXT)

foo$(EXT): foo.go
	go build -o foo$(EXT) -buildmode=c-shared


test: build
	python3 foo_test.py

clean:
	rm foo$(EXT) *.h *.pyc __pycache__

status:
	git status

save:
	if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

