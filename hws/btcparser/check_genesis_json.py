#!/usr/bin/python3

import sys, json

# this checks that the JSON produced by a BTC parsing program matches what is
# expected in this assignment

# the required command-line parameter is the file name
assert(len(sys.argv)==2)

json = json.load(open(sys.argv[1]))

# checking the block list
assert('blocks' in json) # needs to be present
assert(isinstance(json['blocks'],list)) # needs to be a list
assert(len(json['blocks']) >= 1) # only one block is listed, but you are allowed an empty "trailing" block

# checking the height
assert('height' in json) # needs to be present
assert(isinstance(json['height'],int)) # needs to be an int
assert(json['height']==1)

# get the first (and only) block
block = json['blocks'][0]

# block data: check that the keys are present, are the right types, and have
# the right values
header = {
	"height": 0,
	"version": 1,
	"previous_hash": "0000000000000000000000000000000000000000000000000000000000000000",
	"merkle_hash": "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b",
	"timestamp": 1231006505,
	"nbits": "1d00ffff",
	"nonce": 2083236893,
	"txn_count": 1,
}
for k,v in header.items():
	assert(k in block)
	assert(isinstance(block[k],type(header[k])))
	assert(header[k]==block[k])

# check that the transactions is present
assert('transactions' in block)
assert(isinstance(block['transactions'],list))
assert(len(block['transactions'])==1)
txn = block['transactions'][0]

# check everything other than the txn_inputs and txn_outputs
txn_data = {
	"version": 1,
	"txn_in_count": 1,
	"txn_out_count": 1,
	"lock_time": 0
}
for k,v in txn_data.items():
	assert(k in txn)
	assert(isinstance(txn[k],type(txn_data[k])))
	assert(txn_data[k]==txn[k])

# check the txn inputs
assert('txn_inputs' in txn)
assert(len(txn['txn_inputs'])==1)
txninput = txn['txn_inputs'][0]
txn_in_data = {
	"utxo_hash": "0000000000000000000000000000000000000000000000000000000000000000",
	"index": 4294967295,
	"input_script_size": 77,
	"input_script_bytes": "736b6e616220726f662074756f6c69616220646e6f63657320666f206b6e697262206e6f20726f6c6c65636e61684320393030322f6e614a2f33302073656d6954206568544504011d00ffff04",
	"sequence": 4294967295
}
for k,v in txn_in_data.items():
	assert(k in txninput)
	assert(isinstance(txninput[k],type(txn_in_data[k])))
	assert(txn_in_data[k]==txninput[k])

# check the txn outputs
assert('txn_outputs' in txn)
assert(len(txn['txn_outputs'])==1)
txnoutput = txn['txn_outputs'][0]
txn_out_data = {
	"satoshis": 5000000000,
	"output_script_size": 67,
	"output_script_hex": "4104678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5fac"
}
for k,v in txn_out_data.items():
	assert(k in txnoutput)
	assert(isinstance(txnoutput[k],type(txn_out_data[k])))
	assert(txn_out_data[k]==txnoutput[k])
