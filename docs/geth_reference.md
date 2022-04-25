Geth Command Summary
====================

[Go up to the main CCC docs page](index.html) ([md](index.md))


##### Geth from the command line

| Action | Command |
|----|------------|
| Run geth | `geth --datadir ./data/ --networkid 12345678 --maxpeers 1` |
| Run geth with http server flags | `geth --datadir ./data/ --networkid 12345678 --maxpeers 1 --http --http.corsdomain="package://6fd22d6fe5549ad4c4d8fd3ca0b7816b.mod" --http.api web3,eth,debug,personal,net --vmdebug --allow-insecure-unlock` |
| Attach to node (opens prompt) | `geth attach path/to/geth.ipc` |
| Attach to node with preload script | `geth --preload preload.js attach path/to/geth.ipc` |

##### Commands in geth

| Action | Command |
|----|------------|
| Get account balance (wei) | `eth.getBalance(eth.coinbase)` |
| Get account balance (eth) | `web3.fromWei(eth.getBalance(eth.coinbase), "ether")` |
| Current block number | `eth.blockNumber` |
| Unlock account | `personal.unlockAccount(eth.coinbase);` |
| Unlock account until geth exits | `personal.unlockAccount(eth.coinbase, "password", 0)` |
| Send money | `eth.sendTransaction({from:eth.coinbase, to:'0xaddress', value:web3.toWei(1,"ether"), gas:21000});` |
| Get info on transaction | `eth.getTransactionReceipt("0xtransactionhash")` |
| Pending transactions | `eth.pendingTransactions` |

##### Calling a contract

| Action | Command |
|----|------------|
| Set contract address | `var addr = '0xaddress';` |
| Set ABI | `var abi = [...];` |
| Create interface | `var interface = eth.contract(abi);` |
| Get contract | `var contract = interface.at(addr);` |
| Show variable's value | `contract.num_entries.call()` |
| Get value from mapping | `contract.entries.call(0)` |
| Get field from struct from mapping | `contract.entries.call(0)[2]` |
| Call `view` or `pure` method with no parameters | `contract.methodName.call()` |
| Call `view` or `pure` method with one parameter | `contract.methodName.call(2)` |
| Unlock account | `personal.unlockAccount(eth.coinbase,"password",0)` |
| Call method via transaction (requires mining) | `contract.methodName.sendTransaction("param1","param2", {from:eth.coinbase, gas:1000000})` |


##### Preloading a script

Create a preload.js script such as the one below, and then start geth's attach with the `--preload preload.js` parameter, as described above.

```
function mineOneBlock() {
	var start = eth.blockNumber;
	miner.start();
	while ( start == eth.blockNumber );
	miner.stop();
	return eth.blockNumber;
}

function checkAllBalances() { 
	// this function from https://stackoverflow.com/questions/32312884/how-do-i-get-the-balance-of-an-account-in-ethereum
	var i =0;
	var total = 0;
	for ( var i = 0; i < eth.accounts.length; i++ ) {
		var e = eth.accounts[i];
		console.log("  eth.accounts["+i+"]: " +  e + " \tbalance: " + web3.fromWei(eth.getBalance(e), "ether") + " ether");
		 total += parseFloat(web3.fromWei(eth.getBalance(e), "ether"));
	}
	console.log("Total: " + total + " ETH");
}
```
