BASE_ZEP_URL	= https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts
doc:
	touch index.md
	cd ../..; make -s
	source-highlight -s cpp -d *.sol
	dot -Tsvg -O inheritance.dot
	/bin/mv -f inheritance.dot.svg inheritance.dot.1.svg
	source-highlight -d tokens.py
	-solc --abi INFTManager.sol > INFTManager.abi
	../maketabs.py

test:
	solc ERC20.sol
	solc ERC721.sol

sync:
	wget -q -O ERC20.sol $(BASE_ZEP_URL)/token/ERC20/ERC20.sol
	wget -q -O IERC20.sol $(BASE_ZEP_URL)/token/ERC20/IERC20.sol
	wget -q -O IERC20Metadata.sol $(BASE_ZEP_URL)/token/ERC20/extensions/IERC20Metadata.sol
	wget -q -O IERC721.sol $(BASE_ZEP_URL)/token/ERC721/IERC721.sol
	wget -q -O ERC721.sol $(BASE_ZEP_URL)/token/ERC721/ERC721.sol
	wget -q -O IERC721Receiver.sol $(BASE_ZEP_URL)/token/ERC721/IERC721Receiver.sol
	wget -q -O IERC721Metadata.sol $(BASE_ZEP_URL)/token/ERC721/extensions/IERC721Metadata.sol
	wget -q -O Address.sol $(BASE_ZEP_URL)/utils/Address.sol
	wget -q -O Context.sol $(BASE_ZEP_URL)/utils/Context.sol
	wget -q -O Strings.sol $(BASE_ZEP_URL)/utils/Strings.sol
	wget -q -O Math.sol $(BASE_ZEP_URL)/utils/math/Math.sol
	wget -q -O SignedMath.sol $(BASE_ZEP_URL)/utils/math/SignedMath.sol
	wget -q -O ERC165.sol $(BASE_ZEP_URL)/utils/introspection/ERC165.sol
	wget -q -O IERC165.sol $(BASE_ZEP_URL)/utils/introspection/IERC165.sol
	sed -i s_"\.\./\.\./utils/introspection"_._g ERC721.sol IERC721.sol
	sed -i s_"\./extensions"_._g ERC20.sol ERC721.sol
	sed -i s_"\./introspection"_._g ERC721.sol IERC721.sol
	sed -i s_"\.\./../utils"_._g ERC20.sol ERC721.sol
	sed -i s_"\./math"_._g Strings.sol
	sed -i s_"\.\./"_./_g IERC20Metadata.sol IERC721Metadata.sol
	source-highlight -s cpp -d *.sol
