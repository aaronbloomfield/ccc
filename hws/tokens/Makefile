doc:
	cd ../..; make
	source-highlight -s cpp -d *.sol solution/*.sol
	dot -Tsvg -O inheritance.dot
	/bin/mv -f inheritance.dot.svg inheritance.dot.1.svg

test:
	solc ERC20.sol
	solc ERC721.sol
	