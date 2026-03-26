ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight -s cpp -d *.sol
	/bin/rm -f Auctioneer.sol.html
	source-highlight -d auction.py
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html *.py.html
	/bin/rm -f *.todel
	../maketabs.py

sync:
	/bin/cp -f ../tokens/IERC165.sol ../tokens/IERC721.sol ../tokens/IERC721Metadata.sol .
