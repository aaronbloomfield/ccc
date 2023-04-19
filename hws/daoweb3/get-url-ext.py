# to run this, first: `pip install web3 pysha3`
import sys, web3, sha3

# sanity checks
assert len(sys.argv) == 2, "Must supply one parameter, the eth.coinbase account"
assert int(web3.__version__.split('.')[0]) >= 6, "You must install web3 version 6.0.0 or greater to run this code"

# compute and print out the suffix
checksummed = web3.Web3.to_checksum_address(sys.argv[1])
hash = sha3.keccak_256(bytes(checksummed,'ASCII'))
suffix = hash.hexdigest()[:8]
print("dao_"+suffix+".html")
