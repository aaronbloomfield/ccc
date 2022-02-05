#!/usr/bin/python3
# see the homework description for how to use this
import sys
assert (len(sys.argv)==3)
data = bytearray(sys.stdin.buffer.read())
data[int(sys.argv[1])] = int(sys.argv[2])
sys.stdout.buffer.write(bytes(data))
