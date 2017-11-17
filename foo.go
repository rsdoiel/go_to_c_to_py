package main

/*
#include <stdio.h>
#include <stdlib.h>

extern void c_msg(char*);
*/
import "C"
import "unsafe"
import (
	"fmt"
	"strings"
)

const Version = `v0.0.0`

//export blahblah
func blahblah(cStr *C.char, cCnt C.int) *C.char {
	// Convert our cStr into a Go string
	s := C.GoString(cStr)
	// Convert our C int into a Go integer
	cnt := int(cCnt)
	fmt.Printf("GO MSG: %q cCnt: %d\n", s, cnt)
	C.c_msg(cStr)

	sArray := []string{}
	for i := 1; i <= cnt; i++ {
		sArray = append(sArray, fmt.Sprintf("%d: %s", i, s))
	}
	// Write our array of strings back to s then convert to hand back
	// to our C shared library.
	s = strings.Join(sArray, ", ")
	// Now copy back into C space with a deferred free...
	cResult := C.CString(s)
	defer C.free(unsafe.Pointer(cResult))
	fmt.Printf("GO MSG: %q\n", s)
	C.c_msg(cResult)
	// Now return our C String to C's processing space
	return cResult
}

func main() {}
