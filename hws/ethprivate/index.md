Connecting to the Private Ethereum Blockchain
=============================================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

We will be developing applications for the Ethereum blockchain.  We won't be using the actual Ethereum blockchain for a number of reasons (cost, legal issues, speed, etc.).  Instead, we are going to use a private Ethereum blockchain -- a test network -- that has been set up for this class.  This assignment is to connect to it, explore it, and perform a few operations.

### Pre-requisites

This document assumes that you have a recent version of Python 3 installed, and that you can install Python packages through `pip` (or `pip3`).  This is already taken care of in the VirtualBox image.  Don't worry if you don't know Python -- we give you the exact code to use.

This document also assumes you can install packages on your machine (also not needed for the VirtualBox image).


### Part 1: Install geth

This is already taken care of in the VirtualBox image, and you can skip to step 2 if you are using the VB image.

You will need to [install geth](https://geth.ethereum.org/docs/install-and-build/installing-geth).  The instructions differ depending on your OS.

Geth, which stands for Go Ethereum, is a command-line interface to run an Ethereum node.  This particular implementation is written in the Go programming language.

**WARNING:** DO NOT JUST RUN `geth`!  Doing so will connect to the default Ethereum network, and will proceed to download the ENTIRE Ethereum blockchain, which is around 500 Gb for a "light" node and over 1 Tb for a "full" node.  It also takes a full week (at least) to synchronize all that data.

### Part 2: Connect to the private blockchain

Step 1: Create a directory to hold the blockchain info -- this can be anywhere you want, but we'll call it `/path/to/ethprivate` herein.

Step 2: In that data directory, copy the [genesis.json](genesis.json) file in this repo to that directory.  This file lists the parameters for our private blockchain (the difficulty, the chain ID, etc.).  It has the following contents:

```
{
        "config": {
                "chainId": 12345678,
                "homesteadBlock": 0,
                "byzantiumBlock": 0,
                "constantinopleBlock": 0,
                "eip150Block": 0,
                "eip155Block": 0,
                "eip158Block": 0
        },
        "difficulty": "0x400",
        "gasLimit": "0x8000000",
        "alloc": {},
        "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
}
```

Step 3: You have to change the `chainId` value on that line.  The value we are using for our class is listed in the Collab workspace's landing page.  Nothing herein will work properly if you don't change that value!

Step 4: Initialize geth with the following command (you have to change three things before you run it):

```
geth --identity "mst3k" --datadir /path/to/ethprivate/ init /path/to/ethprivate/genesis.json
```
What you have to change in that command:

- For the identity, replace mst3k with your userid.  That's the node identity, and it will be easier to figure out who is who when it's based on the userid rather than, say, your computer's hostname.
- In two places, replace `/path/to/ethprivate` with the path to your actual data directory.  

You should see about a dozen lines of output, and the last one should say "Successfully wrote genesis state".  If not, then this needs to be fixed before continuing.

Step 5: Create a `geth/static-nodes.json` file in your data directory.  The `geth/` sub-directory will have been created by the previous step.  This file lists a static node so you can connect to our blockchain -- one of the departmental servers will be used for this purpose.  As we don't want to make that public, you can find that file linked to from the Collab landing page.  Make sure it goes into the `geth/` sub-directory!

Step 6: Start geth.  Run the following command, changing the data directory to your own, and changing the networkid value to the `chainId` value that you set in the genesis.json file, above.

```
geth --datadir /path/to/ethprivate --networkid 12345678 --maxpeers 1
```

Once running, it should list a peer count (on the right) of at least 1.  It will take a minute or so for that to happen.  Assuming it does, you are now connected our private Ethereum blockchain!

### Part 3: Explore geth

What is running from part 2 is the Ethereum node, but that is not interactive.  You should leave it running while you perform the next few parts of this assignment.

To enter commands via the keyboard, you have to "attach" to the local Ethereum node.  You do this by entering the following command:

```
geth attach /path/to/ethprivate/geth.ipc
```

If you are in the same directory as geth.ipc, you may have to enter `./geth.ipc` as the file name.  Note that this won't work unless the geth node, from the previous step, is running.  You will then get a prompt, which is just a greater-than sign.  This is a JavaScript console.

If you have this installed on Windows, when you start the geth node, you will see output like [this](geth-on-windows.png) -- the circled command is how you connect to the geth.ipc file (putting `geth attach` before it).  It will likely be one of the following:

```
geth attach \\.\pipe\geth.ipc
geth attach ipc:\\\\.\\pipe\\geth.ipc
```



That command rendered correctly -- it has three sets of backslahses -- 4, then 2, then 2.  And run it from the directory that your geth.ipc file is in.  As before, note that this won't work unless the geth node, from the previous step, is running.  

In either case, you will then get a prompt, which is just a greater-than sign.  This is a JavaScript console.

First, let's wait for it to sync.  Since you have saved the static-nodes.json file, it will connect to the course server and start downloading all the blocks in the blockchain.  This may take some time, but hopefully less than 5 minutes.

As it is sync'ing, you can try these commands:

- `eth.blockNumber` will return the highest block number in the blockchain that is on your computer.  If it is returning zero, then it is not sync'ed (or is not trying to sync).
- `eth.syncing` will either return 'false' if it is not syncing, or a JSON dictionary if it is.
  - If `eth.blockNumber` is 0 and `eth.syncing` is false, then it is not sync'ing, perhaps due to a networking connection issue.  This will always be the case right after geth starts and before it has had a chance to connect to peers.
  - If `eth.syncing` is false and `eth.blockNumber` is non-zero, then, most likely, it has completed syncing (it could also be that geth just started, and it hasn't had a chance to start sync'ing yet).
  - If `eth.syncing` returns a JSON dictionary, then it is in the process of sync'ing.
    - The `currentBlock` value, aka `eth.syncing.currentBlock` is the highest block it has sync'ed so far; this is also the value that `eth.blockNumber` returns
    - The `highestBlock` value, aka `eth.syncing.highestBlock`, is what it is working on sync'ing up to
    - Once `currentBlock` reaches `highestBlock`, then the sync'ing will be complete
  - You can use this command to print out the syncing status: `console.log ("at " + eth.blockNumber + " of " + eth.syncing.highestBlock + " blocks; " + (eth.syncing.highestBlock-eth.blockNumber) + " blocks left to sync")`
- `admin.peers.length` will tell you how many peers you are connected to -- it should be at least 1.  Because you ran it with the `--maxpeers 1`, it probably won't be greater than 1.  If you enter this right after you start up geth, it may return 0, as it is still connecting to the peer(s).
- `admin.peers` will print information on each of those peers.  Once established, it should list exactly one peer -- the course server, whose 'enode' specification is the same as the static-nodes.json file that you downloaded.

Once it is sync'ed, here are some commands for you to try out:

- `personal.newAccount()` will generate an Ethereum account for you.  You SHOULD enter password -- if you leave the password field blank, then anybody in the class can use your account.  It will give you an account address back, such as 0x0123456789abcdef0123456789abcdef01234567.  Let's only create one account for now!
- You can get that account number anytime via `eth.coinbase`
- You can check the balance in your account by `eth.getBalance("0x0123456789abcdef0123456789abcdef01234567")` -- it should be zero at this point
  - Or try: `eth.getBalance(eth.coinbase)`
- To get money into the account, we need to mine some (fake) ETH.  As the difficulty was set very low (as per the genesis.json file, above), we can use the CPU for this mining.  To do this, run `miner.start()`
- Let that run for a little while -- say 10 seconds or so -- and then run `miner.stop()`
    - YOU CANNOT LEAVE THE MINER RUNNING ON THE DEPARTMENTAL MACHINES
    - Note that each successfully mined block adds 2 (fake) ETH to your account
- **DO NOT MINE EXCESSIVELY!!!**  You don't need very much (fake) ETH for this course.  10 (fake) ETH or so is more that enough.  It's okay if you have more, but I don't want to see any accounts with thousands or millions of (fake) ETH; that will make me very cranky.  The reason is that if you mine excessively, two bad things will happen:
  1. The block chain will dramatically increase in size, which will just make it take longer for everybody else to sync, and is unnecessary
  2. The difficulty will go up, which will make it harder for everybody else to mine
- Check your balance again -- it will list some insanely high number, such as 80000000000000000000.  You are rich!!!
    - Not really.  That's in wei, which is $10^{18}$ of an (fake) ETH.  So that's really 80 (fake) ETH.  Which would still be worth a lot, but this is our private network, so it's still worth $0.
    - You can get your account balance in (fake) ETH via `web3.fromWei(eth.getBalance(eth.coinbase), "ether")`
- Get the current block number: `eth.blockNumber`.  Note that other people may be doing this at the same time, so the block number may be higher than what you expected due to your mining.  Our setup receives 2 (fake) ETH per block mined.
- You can list your accounts via `eth.accounts` -- it will likely only list the one you created above.  And `eth.coinbase` lists the primary account you created first.

### Part 4: Extract private key

We need to get the private key of the account you created, as we will need that later for our dApp development later on.  The private key is encrypted in a .json file in the keystore/ sub-directory of your geth data directory.  It will have a name like: UTC--2022-01-08T19-53-08.823103866Z--0123456789abcdef0123456789abcdef01234567.  Note that the last part of that name ("0123456789abcdef0123456789abcdef01234567") matches the Ethereum address we obtained and that is returned from `eth.coinbase`.

First, ensure that the `web3` Python package is installed -- run `pip install web3` or `pip3 install web3`.  This is NOT installed on the VirtualBox image, so you will have to install it there as well.

Run python (or python3, depending on your OS).  Note that we are going back to Python, and will come back to geth later.  In Python, enter the following two lines, changing the values as appropriate to the file name (with full path) and the password for the Ethereum account you created in geth:

```
password="password"
filename="/path/to/ethprivate/keystore/UTC--2022-01-08T19-53-08.823103866Z--0123456789abcdef0123456789abcdef01234567"
```

Next, cut-and-paste the following code into your Python terminal.:

```
from web3.auto import w3
keyfile = open(filename)
encrypted_key = keyfile.read()
private_key = w3.eth.account.decrypt(encrypted_key,password)
import binascii
binascii.b2a_hex(private_key)
```

When you run it, it will look like the following:

```
$ python3
Python 3.8.10 (default, Nov 26 2021, 20:14:08) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> password='password'
>>> filename='/path/to/ethprivate/keystore/UTC--2022-01-08T19-53-08.823103866Z--0123456789abcdef0123456789abcdef01234567'
>>> from web3.auto import w3
>>> keyfile = open(filename)
>>> encrypted_key = keyfile.read()
>>> private_key = w3.eth.account.decrypt(encrypted_key,password)
>>> import binascii
>>> binascii.b2a_hex(private_key)
b'0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
>>> 
$
```

The private key is the hex line at the end -- you should remove the leading `b'` and trailing `'`.

Save this private key somewhere, as you will need it in future assignments.  Normally we would never save this in plaintext, but the (fake) ETH on this system are still worth $0.


### Part 5: Send me some money!!!!

Next you are going to send me some money via the geth command line.  We are done with Python for this assignment, and have to go back to the geth prompt (via `geth attach /path/to/ethprivate/geth.ipc`) for this.

To send (fake) ETH, you have to first unlock your account:

```
personal.unlockAccount("0x0123456789abcdef0123456789abcdef01234567");
```

This will prompt you for your password.  You have to replace the address shown with your account address (via `eth.accounts`);

You can also use `eth.coinbase`, which should be the same account.  By default it unlocks for 5 minutes; you can unlock it until geth exits via: `personal.unlockAccount(eth.coinbase, "password", 0)`

You can then send me 1 (fake) ETH:

```
eth.sendTransaction({from:eth.coinbase, to:'0xffffffffffffffffffffffffffffffffffffffff', value:web3.toWei(1,"ether"), gas:21000});
```

You have to replace the 'to' field with my address.  My address can be found on the Collab landing page.  Note that we replaced your account address with `eth.coinbase`.  This will print out a hex string -- save it!  That's the hash of the transaction, and we'll need it shortly.  It will be something like: 0xabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd.

Further steps to do in the geth console:

- Check your balance via `eth.getBalance("0x0123456789abcdef0123456789abcdef01234567")` -- you will notice that the balanace has not changed, since the transaction was not mined into a block.  Get the block number by `eth.blockNumber`
- You can see your pending transaction via `eth.pendingTransactions`
    - Note that if others in the class are doing this at the same time, it may have been mined before you could check the pending transactions
    - And it may be the case that somebody mined it into the blockchain before you had a chance to enter `eth.pendingTransactions`
- Start mining via `miner.start()`, wait 5-10 seconds, and then stop mining via `miner.stop()`.
- Check your balance via `eth.getBalance(eth.coinbase)` and the block number by `eth.blockNumber`.  You will notice you have more money than before, but no longer a multiple of 2 (the amount mined per block) -- you will have 1 less than a multiple of 2, since you just sent me 1 (fake) ETH.  Also notice that the mining process did not deduct gas fees.
- You can also get your account balance in (fake) ETH via: `web3.fromWei(eth.getBalance(eth.coinbase), "ether")`
- Get information on the mined transaction: `eth.getTransactionReceipt("0xabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd")` -- replace the hash there with the transaction hash you recorded, above.
  - Note the block number, which you will have to submit along with the transaction hash


### Part 6: Explore geth on your own

You should explore geth on your own.  When you start geth (via `geth attach geth.ipc`), it lists the modules available:

```
Welcome to the Geth JavaScript console!

instance: Geth/v1.10.15-stable-8be800ff/linux-amd64/go1.17.5
coinbase: 0x0123456789abcdef0123456789abcdef01234567
at block: 52 (Sat Jan 08 2022 21:49:04 GMT-0500 (EST))
 datadir: /home/crypto/ethprivate
 modules: admin:1.0 debug:1.0 eth:1.0 ethash:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0

To exit, press ctrl-d or type exit
> 
```

The modules are listed on the 7th line (admin, debug, eth, ethash, miner, net, personal, rpc, txpool, and web3).  In the console, type the start of the module, a period, and hit the Tab key -- it will show you all the possible completions.  If you type in the name and it's a function, it will tell you that.  And if you try to run the function with no parameters, and it needs parameters, it will tell you that as well.  Lastly, it's a JavaScript console, so you can use any JavaScript programming, if you happen to know JavaScript.  (You won't need to know JavaScript for this course).

You are also welcome to mine more (fake) ETH into your account, but please don't go crazy -- if there is too much mining, it will make the difficulty harder, which will cause problems when other students want to mine their own (fake) ETH.

### Part 7: Blockchain Explorer

We have a web-based blockchain explorer for our private Ethereum blockchain.  The link to that is on the Collab landing page.  Browse that site, and play around with the search functionality.  Directions for how to use it are on the main page.  Note that the site updates every 5 minutes, so if you make a transaction, it will not be immediately visible there -- the time of the last update is listed on the main page (the bottom bullet under 'Statistics').

Find the web page that contains the transaction (not the block!) where you send me the 1 (fake) ETH; you will need to submit this URL.

### Closing down

If you are not actively using it, you should shut your geth node down.  ITS has given permission to do all this, but they do perform port scans on all machines, so no need to raise their hackles by keeping a geth node up and running.  You can easily re-launch it when you need it again for a future assignment.  Likewise for the console from part (3); if you close down the geth node, the console won't work.

### Submission

You will need to submit your information via a Google form, the link to which is on the Collab landing page.  You will need to submit the following items:

- Your Ethereum account number from part (3).  Note that this is public information.
  - We are NOT asking for the private key from part (4) -- even though it's not worth anything, you should always be in the habit of never sharing private keys.
- The transaction ID when you sent me the (fake) ETH in part (5)
- The block number that the mined transaction, from part (5), where you sent me some (fake) ETH
- The URL to the page that contains the transaction (not the block!) where you sent me 1 (fake) ETH, from part (7)
