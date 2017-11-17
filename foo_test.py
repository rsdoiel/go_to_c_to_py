#!/usr/bin/env python3

#
# Simple example to see where my String copy from Go to C to Python breaks
# Down.
#
import ctypes
import sys

if sys.platform == 'linux':
    foo = ctypes.CDLL('./foo.so')
elif sys.platform == 'darwin':
    foo = ctypes.CDLL('./foo.dynlib')
else:
    # I guess we have windows
    foo = ctypes.CDLL('./foo.dll')

foo.blahblah.argstype = [ ctypes.c_char_p, ctypes.c_int ]
foo.blahblah.restype = ctypes.c_wchar_p

#
# Now we do our testing.
#
for i in range(10):
    c_s = foo.blahblah(b'hello world', i+1)
    print("PY MSG:", c_s)
    #s = c_s.decode()
    #print("PY MSG:", s)

