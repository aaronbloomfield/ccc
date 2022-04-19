Web3.py Introduction
====================

[Go up to the main CCC docs page](index.html) ([md](index.md))

### Web3.py

This section is an introduction to using web3 in Python.

##### Starting Python

Run Python.  You can put these commands into a script file, or type these commands directly into a Python interpreter.

You will need to install two packages via `pip` or `pip3`: the packages are `web3` and `hexbytes` (note that the former may install the latter on your system).

You should always start with the following import lines:

```
from web3 import Web3
from hexbytes import HexBytes
```

All the code below assumes those two import lines are present.

##### Connect to the blockchain

In Python, you can connect to the blockchain in a few different ways.  The difference is if you are going to connect via the geth.ipc file or through the course server endpoint.

If you are using the geth.ipc file:

```
w3 = Web3(Web3.IPCProvider('/path/to/geth.ipc'))
```

This assumes you have started up a node as per the [Private Ethereum Blockchain assignment](../ethprivate/index.html) ([md]((../ethprivate/index.md)).

Note: it is unclear how to do this in Windows, as I do not have a Windows machine that I can test this on.  When/if I find out how, I will update this section.

To connect via the course server:

```
w3 = Web3(Web3.WebsocketProvider('wss://<your-provider-url>'))
```

The full URL for the course server is on the Collab landing page.

To see if you are connected, you can try:

- `w3.isConnected()`, which should return `True`
- `w3.eth.get_block('latest')`, which should return the latest block

##### Calling a `view` or `pure` function on a smart contract

Calling a `view` or `pure` function is much like with geth -- we define an address and an ABI variable, then create the interface and then the contract.  For this example, we'll call a method on our TokenDEX contract.

You'll need to determine the address of your TokenDEX -- you can use the one you submitted to the dex.php listing.  Define the following variables:

```
address='0x0123456789abcdef0123456789abcdef01234567'
abi='[...]'
```

For the `abi` variable, you can copy it from the Collab landing page.  Note that this ABI value is in single quotes, which is unlike how we do it via the geth Javascript terminal.

We can then create the contract instance in one command:

```
contract = w3.eth.contract(address=address, abi=abi)
```

From there, we can call a function on it:

```
contract.functions.k().call()
```

Notice that we have to put parenthesis after both the method name of `k` and after the `call`.  Parameters, if there were any, would go in the parenthesis after the method name, not in the `call()` parentheses.

##### Transactions

In geth, we would unlock our account with our password, and then call `sendTransaction()`.  To do this in Python is a bit more complicated.

First, we need the private key in decrypted form.  This was done in the [Private Ethereum Blockchain assignment](ethprivate/index.html) ([md](ethprivate/index.md)) in part 4 -- if you don't have that decrypted private key saved, or if you changed accounts, then re-do that section.  Your private key will be of the form `b'0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'`.  Save it via:

```
private_key = hexbytes.HexBytes('0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
```

You will note that this is a slightly different form than what you got when you decrypted your key -- the hex byte data is the same, it just is in a `hexbytes.HexBytes()` constructor.

We also need to define our account address that we have the private key for:

```
my_address='0x0123456789abcdef0123456789abcdef01234567';
```

This address has to be in correct check-summed form -- you can run it through [ethsum.netlify.app](https://ethsum.netlify.app/) to get the check-summed version.

Once we have the private key, we have to take three steps: create the transaction, sign it, and then transmit it to the blockchain.

Let's first create the transaction:

```
transaction = contract.functions.getTokenCCAbbreviation().buildTransaction({
    'gas': 70000,
    'gasPrice': w3.toWei('10', 'gwei'),
    'from': my_address,
    'nonce': w3.eth.get_transaction_count(my_address)
    })
```

Other fields could be added as well -- if we wanted to send some wei in with the transaction, such as to a `payable` function, then we would add a `value` key with the (integer) wei amount as the value.

If all we wanted to do was to just pay ETH, and not call a function, we would just create a dict:

```
transaction = {
    'nonce': w3.eth.get_transaction_count(my_address),
    'to': '0x0123456789abcdef0123456789abcdef01234567',
    'value': w3.toWei(1, 'ether'),
    'gas': 21000,
    'gasPrice': web3.toWei('10', 'gwei')
}
```

We then sign that transaction:

```
signed_txn = w3.eth.account.signTransaction(transaction, private_key=private_key)
```

Lastly, we send it to the network

```
ret = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
```

That's it!  The transaction was sent to the blockchain.

##### Transaction details

The return value of `sendRawTransaction()` was saved into the `ret` variable.  We can then get that transaction information:

```
w3.eth.wait_for_transaction_receipt(ret)
```

This is the transaction *receipt*, which has slightly different information than the transaction itself.  In particular, it will wait (block) until the transaction is mined into a block.  If the `status` field is 0, then the transaction was not successful for some reason. Those reasons can include: a reversion (such as a failed `require()`, insufficient funds, insufficient gas, etc.

We can also get the raw transaction information itself:

```
w3.eth.get_transaction(ret)
```

This is the same information that you can find in the blockchain explorer.


##### Gas estimation

Web3 can estimate how much gas your transaction will use.  Once you have created your transaction object, you can just call: `gas = w3.eth.estimateGas(transaction)`.  Note that this is an *estimate*, not a fully accurate count.  In particular, if there is an if/else path, then it can't always know which path it will take.  Although an estimate, it is sufficient for our purposes.  Lastly, note that this is the amount of gas, and once you supply it with a amount of wei per gas, you can convert that into a actual price in ether.


##### Reverts

It turns out it is often (but not always!) possible to get the reason for a reversion.  The code below will attempt to do just that (code adapted from [here](https://snakecharmers.ethereum.org/web3py-revert-reason-parsing/)).


```
def printRevertReason(w3,txhash):
    # adapted from https://snakecharmers.ethereum.org/web3py-revert-reason-parsing/
    tx = w3.eth.get_transaction(txhash)
    replay_tx = {
        'to': tx['to'],
        'from': tx['from'],
        'value': tx['value'],
        'data': tx['input'],
    }
    # replay the transaction locally:
    try:
        w3.eth.call(replay_tx, tx.blockNumber - 1)
    except Exception as e: 
        print(e)
```

This function is provided in the config.py code given with the homework.


##### Limitations

There does not seem to be a viable way to get the return value of a *transaction*, only of a *call*.


##### Read more

The functionality of web3.py is similar to what we know of from geth, but the formatting of the function calls is different.  You can see full API [here](https://web3py.readthedocs.io/en/latest/index.html).

