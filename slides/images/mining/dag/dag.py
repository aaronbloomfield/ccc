#!/usr/bin/python3

import random, sys

utxos = []
txnchance = 0.3
seed = -1
ranks = 10
spacing = 0.25

if len(sys.argv) >= 2:
	ranks = int(sys.argv[1])
if len(sys.argv) == 3:
	seed = int(sys.argv[2])
if len(sys.argv) > 3:
	exit(1)

if seed == -1:
	seed = random.randrange(sys.maxsize)
random.seed(seed)

print("digraph G {\nnode [shape=point];\n/*",ranks,"ranks, seed of",seed,"*/")

for rank in range(0,ranks):
	txns = []
	cb = "r"+str(rank)+"c"
	utxos.append(cb)
	txns.append(cb)
	print(cb+" [color=red,pos=\"0,-" + str(rank) + "!\"];")
	txnum = 0
	for utxo in utxos:
		if random.random() < txnchance:
			if utxo in txns:
				continue
			for _ in range(0,random.randint(1,4)):
				name = "r" + str(rank) + "t" + str(txnum)
				print(name+" [pos=\"" + str(spacing*(txnum+1)) + ",-" + str(rank) + "!\"];")
				print (utxo + " -> " + name + " [color=\"grey\"];")
				utxos.append(name)
				txns.append(name)
				txnum += 1
			utxos.remove(utxo)


	print("{rank=same " + " ".join(txns) + "};")
	print ("/* seed",seed,"; size of nodes in this rank:",len(txns),"*/\n")

print ("}")


"""

to create a graph with a given seed:

clear;./dag.py 20 853 > dag.dot;dot -Kfdp -n -Tpng -o dag.dot.1.png dag.dot; tail -3 dag.dot | head -1; eog dag.dot.1.png

to check for the lowest number of nodes at the bottom level:

date;seq 1 1000 | awk '{print "./dag.py 20 "$1" | tail -3 | head -1"}' | bash > output.txt; awk '{print $11}' output.txt | sort -n | head -1;date

to create a sequence of 20 images:

seq 1 20 | awk '{print "./dag.py "$1" 8086 > dag.dot;dot -Kfdp -n -Tpng -o dag.dot."$1".png dag.dot"}' | bash

"""
