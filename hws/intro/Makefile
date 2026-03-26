ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight *.sh *.py *.java
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sh.html *.py.html *.java.html
	/bin/rm -f *.todel
	../maketabs.py
