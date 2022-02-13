main:
	seq 1 20 | awk '{print "./dag.py "$$1" 8086 > dag.dot;dot -Kfdp -n -Tpng -o dag.dot."$$1".png dag.dot"}' | bash
	seq 1 20 | awk '{print "./dag.py "$$1" 8086 > dag.dot;dot -Kfdp -n -Tsvg -o dag.dot."$$1".svg dag.dot"}' | bash

full:
	./dag.py > dag.dot
	make main
	eog dag.dot.1.png
