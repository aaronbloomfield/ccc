doc:
	touch index.md
	cd ../..; make -s
	source-highlight -s cpp -d *.sol
	/bin/rm -f CourseGradebook.sol.html
	source-highlight -d gradebook.py
	../maketabs.py
