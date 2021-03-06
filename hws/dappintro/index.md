dApp Introduction
=================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

### Overview

This homework will take you through the process of compiling, deploying, and running a decentralized application (dApp) on our private Ethereum blockchain.  This assignment does not focus on the programming aspects of Solidity -- that's in a future assignment, as well as the lectures.

Giving credit where credit is due: The particular smart contract being used here was inspired by the one in [this github repo](https://github.com/dappuniversity/election) by Dapp University (disclaimer: they are not an actual accredited university; but they do have great online tutorials). 

### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### Pre-requisites

You will have to have completed the [connecting to the private Ethereum blockchain](../ethprivate/index.html) assignment.  You should have a few (fake) ETH.  For some of the tasks below you will need to launch your geth node, connecting to the course server, and start up a geth Javascript terminal; how to do all that is all described in the [connecting to the private Ethereum blockchain](../ethprivate/index.html) assignment.  You will also need to launch a geth terminal, which is also described in the that assignment.

If you have not successfully completed the [connecting to the private Ethereum blockchain](../ethprivate/index.html) assignment then you will not be able to complete this assignment.

Warning to Mac OS X users: there is one part in this assignment that Safari seems to have issues with.  This part is indicated when you get to it, and you may have to switch to a different browser (Firefox or Chrome) to complete that part.


### Introduction

To deploy and run a smart contract, you need to be able to the standard development tasks -- editing, compilation, and testing.  The last one -- testing -- is tricky, as you have to be running in an environment that simulates a blockchain and (fake) accounts with (fake) ETH.  Once it's compiled, you have to then be able to load it onto the blockchain, whether that blockchain is simulated (for testing) or real (for deployment).

For the development tasks, we are going to use [Remix](http://remix.ethereum.org), which is an IDE designed specifically for Solidity smart contracts on an Ethereum blockchain.  You can use it online at [remix.ethereum.org](http://remix.ethereum.org), or you can download the latest version on your computer via [remix's github repo](https://github.com/ethereum/remix-desktop/releases).  Each method has it's pros and cons.  The online site is quick to use, doesn't require installation, but does not save your changes -- you have to save it locally, or edit it locally and then copy/paste it into Remix.  If you do want to go this route, we suggest editing your code with [sublime](https://www.sublimetext.com/) with the [Ethereum package](https://packagecontrol.io/packages/Ethereum) installed.  The other option -- installing Remix locally -- requires going through the installation process, but makes it easier to develop locally.  We recommend the latter (download and install), but the choice is yours.  The directions herein will apply to both options.  Note that all of these tools (the Remix IDE and Sublime with the Ethereum package) are already installed on the VirtualBox image.  Remix's source code is [available on github](https://github.com/ethereum/remix-project), and it is [released under the MIT license](https://github.com/ethereum/remix-project/blob/master/LICENSE); some of the Remix images are included herein.

Remix allows you to develop, compile, and test your code on a simulated blockchain with fake accounts.  It cannot, all by itself, deploy to a blockchain.  For that, we are going to use geth.  We will connect Remix to geth for our deployment, and geth will be the conduit to deploy to the blockchain.  More on that later in this assignment.

There are many different tool chains that one can use to compile and deploy smart contracts -- Truffle and Ganache, command-line compilation with solc and deployment with geth, etc.  We had to pick one, and Remix seemed the most logical choice.  We will see how to interact with the blockchain through geth in an in-class activity in the [Solidity lecture slide set](../../slides/solidity.html#/).

The same process described herein can be used to deploy on the real Ethereum blockchain.  The only difference is that you would run geth to connect to the real Ethereum blockchain, rather than our private course blockchain.  Everything else stays the same.


### Code base

For this assignment we will be providing the Solidity code to use: [Choices.sol](Choices.sol.html) ([src](Choices.sol)).  The code will allow voting for *something* via the blockchain -- an election, your favorite color, or anything else.  Election dApps are fairly common as first examples of Solidity programs.  Note that while you should be able to gain a rough idea of what is going on in the code, the tasks herein are not to understand the code, but to be able to compile and deploy it.  Understanding the code, and writing your own, is in the next assignment and upcoming course lectures (one of the lectures will even go over this exact code base).

That being said, you will need to make a small modification to the code.  Edit the [Choices.sol](Choices.sol.html) ([src](Choices.sol)) file to add your own Choices.  In particular, you should ONLY change the `addChoices()` calls in the constructor -- you can add more or take some away, as needed.  It is important that you do not change any other code in the contract, else it will not work properly when we are testing and grading it!  Please choose something that is not controversial -- there are many great ways to fight for, and to voice opinions for, things that others may find controversial.  Our private Ethereum blockchain for this course is not one of them.


### Task 1: Use Remix

Remix is the IDE for developing Ethereum smart contracts in Solidity.  Remix provides easy to read compiler error messages and makes it really easy to test your smart contract as you are developing it.  You can either use the online editor at [remix.ethereum.org](http://remix.ethereum.org) or you can install it locally via the [Remix download page](https://github.com/ethereum/remix-desktop/releases).  It is already installed on the VirtualBox image.  The web interface on [remix.ethereum.org](http://remix.ethereum.org) is designed to look just like the IDE, and you are welcome to use either -- the directions herein apply the same to both.  However, if you do use the web interface, make sure you save your text file back to your computer.

1. Load up Remix.  The far left column has four icons at the top -- the Remix logo (<img src="img/remixLogo.webp" class='icon'>), the file explorer icon (<img src="img/fileManager.webp" class='icon'>), the compilation icon (<img src="img/solidityLogo.webp" class='icon'>), and the deploy & run icon (<img src="img/deployAndRun.webp" class='icon'>).  At various times in this tutorial, you may see a debugging icon (<img src="img/debuggerLogo.webp" class='icon'>) beneath these four, but we are not going to focus on the debugger in this assignment.  On the bottom are two more icons -- the plugin manager (<img src="img/pluginManager.webp" class='icon'>) and settings (<img src="img/settings.webp" class='icon'>).
2. Click on the file explorer icon (<img src="img/fileManager.webp" class='icon'>), right click on the contracts folder (if it exists; if not, pick a directory where you want to store the files), and select 'New File' -- name it 'Choices.sol'.  Copy and paste the [Choices.sol](Choices.sol.html) ([src](Choices.sol)) program there.
3. Next we are going to compile it -- click on the compilation icon (<img src="img/solidityLogo.webp" class='icon'>).  You may notice a green check mark on the compilation icon -- it might automatically compile it as you type (this does not seem to be consistent across all platforms).  Click on the compilation icon, and click "Compile Choices.sol".  It should compile without errors.
    - Remix does allow for compiler optimizations, but we are not going to explore them in this assignment.  For now, don't select any optimizations (meaning leave it as the default options).
4. Click on the "deploy & run" icon (<img src="img/deployAndRun.webp" class='icon'>).  For the Environment, we will stay with "Javascript VM (London)", which means that Remix will simulate, in Javascript, a fake Ethereum blockchain and 10 fake accounts for us.  You can see the accounts in the 'Account' drop-down list.
5. Click the orange "Deploy" button.  It's now running on the (simulated) Ethereum blockchain, deployed from the selected (and also simulated) account shown in the "Account" drop-down list.
6. Test out the deployment
    - Look under "Deployed Contracts", below the "Deploy" button -- click on the arrow to the left of "Choices at ...".  It will show you various buttons to test out your smart contract.
    - Click on "num_choices".  The console (under the code window; you can make it bigger to see what's going on) will state, "call to Choices.num_choices".  The line below that will have a "Debug" button and a down arrow -- click on that arrow.  In the various items that appear, you will see a "decoded output" field that lists the number of choices for this smart contract.
    - The "choices" button requires a number -- put any valid number in there (non-negative and less than the number of choices), and click that button.  Again, if you expand the returned result, under "decoded output", you will see the values in the Choice struct that was returned.  Note the number of votes is 0.
	- Let's vote!  Pick the same option you picked above, enter that value into the box.  Then click on the orange "vote" button.
	    - Note that this button is orange, whereas the others are blue.  Orange indicates that it has to send a transaction to the blockchain, and that transaction has to be mined into the blockchain before it takes effect.  The blue buttons are read-only, and do not require mining a transaction into the blockchain.  Fortunately, this simulated environment will auto-mine that transaction.
	- View the output.  You'll notice that there is nothing in the "decoded output" field (this method basically had a `void` return type), but there is now a "transaction hash" field.  Because it was a (simulated) transaction, the transaction hash is reported back.
	- Pull up the data on that choice (enter the same choice number next to "choices", and click that blue "choices" button).  You will notice that the number of votes is now 1.
	- Try to vote again, for any choice.  Notice that it doesn't work -- the console states that "The transaction has been reverted to the initial state".  This particular smart contract prevents double-voting.  It does this by keeping track of who has voted (in the `voters` mapping on line 19), and then ensuring that the current voter has not already voted (the first line of the `vote()` method via a `require()` call).  If a `require()` call fails, then the state of everything is reverted back to what it was before the transaction occurs (although you still lose your gas fees).
	- Switch accounts (choose a different one in the drop-down list under "Account"), and try to vote -- this time it will work, since that (new) account number has not already voted.
7. Explore compilation again
    - Click on the compilation icon (<img src="img/solidityLogo.webp" class='icon'>).  At the bottom of the left pane click on "Compilation Details".  This is showing all the results of the compilation.
    - Expand the 'bytecode' button.  There is a lot here, and we can ignore most of it.  Scroll down to the very bottom of what just appeared -- the two fields we care about are the "object" field and the "opcodes" field.
    - The bytecode -> opcodes field are the Ethereum bytecode that the smart contract was compiled down to.  This is similar in concept to the Bitcoin Script, although it has the ability to perform looks (via `JUMP` commands and similar), and is a lot more complex.
    - The Bytecode -> object field is the raw hex of the compiled program itself -- the bytecodes were compiled to their hexadecimal equivalents.  This very long string (over 4,000 bytes) is what is actually loaded onto the blockchain.  When we deploy our code to the blockchain, below, you will be able to see that bytecode in the transaction.
    - Back in the left-hand pane, under the "Compilation Details" button is a link to copy the ABI -- click on the copy icon.  In any editor, paste that into a blank file.  This is the Application Binary Interface -- it specifies how to interact with the smart contract.  Think of it like a C++ header file -- it gives the interface, but not the implementation.  One cannot interact with a smart contract without having the ABI.  As you scroll through the ABI, you will notice that all the fields and method are listed there, along with all the various types.
        - **THIS IS IMPORTANT!**  In future assignments, when you are going to write your own smart contracts, you will need to submit the ABI for each of them along with the source code.  Without the ABI, we will not be able to interact with your smart contract!
8. Explore Remix on your own.  You are going to be spending a lot of time developing smart contracts in Remix. Spending a bit of time learning how it works, and becoming comfortable with the interface, will save you a lot of time in the future.


### Task 2: Deployment from Remix

At this point we can edit, compile, and test our program on Remix.  We have also made changes to the `addChoice()` calls in the Choices.sol constructor.  Now we are going to use Remix to deploy to our private Ethereum blockchain.

#### Start geth

We need to start geth, as we did in the [connecting to the private Ethereum blockchain](../ethprivate/index.html) assignment.  However, we need to add a few more command-line parameters:

- `--http`: This enables the HTTP-RPC server.  What this means is that it will open a port (8545) that programs -- in our case, Remix -- can connect to to interact with geth (and, eventually, deploy to the blockchain)
    - RPC stands for Remote Procedure Call.  It's a way for one program to call a procedure running in some other program.  In this case, the client is trying to call the procedure, and the geth node is receiving, and then executing, the procedure call.
- `--http.corsdomain="https://remix.ethereum.org"`: This allows that particular site to connect to the HTTP-RPC server.  Normally all sites are blocked for security reasons, so we have to specifically grant permission for individual sites to connect.
    - **NOTE:** if you are using the Remix IDE, you will have to enter some other value instead of `https://remix.ethereum.org`; the pop-up window in Remix (that pop-up window is described below) will tell you what the value is.  For now, use the the flag as specified here, and know that you will have to make a change to it below; the assignment steps below will tell you when and how.
    - We do NOT recommend using the `--dev console` flags
- `--http.api web3,eth,debug,personal,net`: These are the APIs that are made available on the HTTP-RPC server.  For example, by enabling `eth` (one of the ones listed), then `eth.blockNumber` can be called.  This is only for the HTTP-RPC server; an attached geth node has access to all the APIs.
- `--vmdebug`: This records information useful for debugging, which is an option that Remix will allow us to do.
- `--allow-insecure-unlock`: This will allow us to unlock our `eth.coinbase` account via `personal.unlockAccount()`.  Normally this is disabled if the HTTP-RPC server is enabled.  Our particular configuration does not allow any *other* machines to connect to the HTTP-RPC server, and our (fake) ETH is not worth any money, so it is safe enough for us to use for this course.

Our full geth call will look like the following.  Recall that you have to change the `/path/to/ethprivate` path to match your directory, and you have to change the chainID (aka the networkid) to match the one for our private Ethereum blockchain.

```
geth --datadir /path/to/ethprivate --networkid 12345678 --maxpeers 1 --http --http.corsdomain="https://remix.ethereum.org" \
     --http.api web3,eth,debug,personal,net --vmdebug --allow-insecure-unlock
```

The backslash (`\`) is to handle word wrap on the page -- those two lines work on Linux and Mac OS X, but you may have to put it all on one line (removing the backslash (`\`) in Windows.  This will start the local node.  In particular, you will see a line that says, "HTTP server started", which is what our additional options did.  Note that these particular options will only allow Remix that is running -- either as a stand-alone IDE or through the browswer -- *on the same machine* to connect.  So you can't run geth in VirtualBox (or on Amazon AWS) and Remix on your host machine, for example.

Now that geth is started, we have to attach to it IN A SEPARATE WINDOW via `geth attach /path/to/geth.ipc` (or, in Windows, either `geth attach ipc:\\\\.\\pipe\\geth.ipc` or `geth attach \\.\pipe\geth.ipc`).  Wait for it to finish sync'ing (check `eth.syncing`).  Then `eth.blockNumber` should (more or less) match the highest block number on our Ethereum blockchain explorer.

Just to check: at this point, you should have TWO geth processes running in separate windows.  The first is the full node with the various `--http` options. The second is a geth terminal via `geth attach`.

#### Configure Remix

You should have Choices.sol loaded into Remix, and you should have made the modifications to the `addChoices()` calls in the constructor.  You should have compiled it WITHOUT optimizations.

Read these instructions through before starting them!

1. Change to the Remix deployment tab.
    - Under 'Environment' select "Web3 Provider".  The pop-up window will tell you the options to run geth with, and you have already done that, above.  Ensure that the "Web3 Provider Endpoint", in the pop-up box, says `http://127.0.0.1:8545`.
        - If you are using the Remix IDE, the pop-up window in Remix will tell you what you should use as your endpoint value (meaning what value to put after the `--http.corsdomain` flag).  See a screen shot of that value [here](remix-cors.webp).  You should restart the geth node with that flag.
        - Click OK to close that pop-up window
        - Note to Mac OS X users: if you are doing this assignment on remix.etherem.org in Safari, then this is the part that Safari seems to have issues with.  If it is not working for you, then please switch to a different browser (Firefox or Chrome both seem to work fine).  You can then cut-and-paste your code from Remix in Safari to remix in Firefox / Chrome.
    - Underneath the "Environment" drop-down box, it should now say, "Custom (12345678) network", with the chain number of our private blockchain instead of 12345678.
    - You should see your geth account address(es) populated in the "Account" drop-down box, with your `eth.coinbase` one selected
    - If there are any entries listed under "Deployed contracts" (in the left-hand pane), you can delete them -- this way we won't mix up any previous deployments with the one we are about to do
2. Unlock your account in geth
    - In the geth terminal, run the `personal.unlockAccount()` command.  You can run it as `personal.unlockAccount(eth.coinbase,"password",0)` -- filling in your own password -- to unlock it until the end of the session.  It should report back `true`.
3. Hit Deploy!
    - This what this party is all about!  Click the orange Deploy button.
    - The Remix console (under the editing box) should say, "creation of Choices pending... view on etherscan"
    - Note that this submitted it as a transaction, but it is not (yet) in the blockchain
4. Mine it into the blockchain
    - In real Ethereum, we would have to wait a bit for it to be mined into the blockchain.  But we can do that ourselves on our private Ethereum blockchain.
    - In the geth console, run `txpool.status` to see how many pending transactions there are.  And view that transaction via `eth.pendingTransactions`
        - Note that if other students are running through this tutorial at the same time you are, they may end up mining it into the blockchain for you, and perhaps even before you can view it via those commands
    - Make a note of the blocknumber via `eth.blockNumber` and your balance in (fake) ETH via `web3.fromWei(eth.getBalance(eth.coinbase), "ether")`
    - Mine it into the blockchain via `miner.start()`, wait a few seconds, then enter `miner.stop()`
        - Make sure that the block number has increased via your mining -- if the difficulty is too high, then it may take a bit longer to mine
5. See what happened
    - Look at your new balance via `web3.fromWei(eth.getBalance(eth.coinbase), "ether")`.  One would normally expect that gas fees are deducted.  However, our gas is set so low (possibly to zero), and you are mining to get it into the blockchain, that you balance will actually have gone *up*.
		- Look back at the Remix console -- it will say something like, `[block:12345 txIndex:0] from: 0x123...bcdef to: Choices.(constructor) value: 0 wei data: 0x608...57221 logs: 0 hash: 0x123...bcdef`
			- Save the block number (shown in the previous line as 12345), as you will need to submit that
		- Click on the arrow to the right of the "Debug" button in the console -- this will list the details of the transaction that was mined into the blockchain
		- Make a note of the transaction hash, as you will need to submit that value as well
		- The *contract address* is listed in the left-hand pane, under the deploy button (in the "Deployed Contracts") section)
		    - Save the contract address -- there is a copy icon to easily copy it -- as you will need to submit that
		- You can view the information for that transaction on our blockchain explorer -- the block that contained the transaction that deployed your smart contract, the transaction itself, and the account that is the contract address
		    - You may have to wait up to 5 minutes for the explorer to refresh
6. Call some methods on your contract
    - If you expand the specific deployed contract, you can see the various methods that it provides.  Call the blue buttoned methods, which are the ones that are read-only methods (and thus do not require writing a transaction to the blockchain) -- choices, num_choices, voters, and unnecessaryFunction.
        - To see if you have voted, click the copy icon to the right of your account drop-down box, then paste that into the 'voters' box and click 'voters' -- it should show false, but you will have to click on the down arrow to the right of the 'debug' button that appeared
    - Vote for your choice!  Enter a number in the 'vote' box for your choice, and click 'vote'
    		- You will see "transact to Choices.vote pending ..." in the console -- it's waiting for the transaction to make it onto the blockchain
    		- Run `miner.start()` and then `miner.stop()`
    		- In the console, click the down-arrow to the right of the 'debug' button that appeared -- it lists the transaction hash.  You can view that on the explorer as well
            - You will need to submit the block number and transaction hash where you voted
    - You can call 'voters' again with your coinbase account; it should return true this time
7. Don't close down Remix!
    - You are going to need it open and with the Choices.sol compiled, for task 4, below


### Task 3: View a web page

We wanted to show you that you can create a web page to interact with a smart contract on the blockchain.  The Javascript of the web page uses the web3 library, which is what allows you to connect to the blockchain from Javascript.  In our case, we use it to connect to a node running geth.  The URL for this web page is on the Collab landing page -- once there, enter your smart contract's contract address (with the leading `0x`) for your deployed smart contract, and it will display the choices.

On the course blockchain explorer, you can find other contract addresses -- look at the transactions page, and see what has something listed in the 'contract address' column.  You can then enter that address into the web page to see what choices your classmates selected.  Note that you won't know who deployed that particular smart contract.  Note that this web page will only work with the version of the Choices code shown here, and only if there are no compilation optimizations.  Specifically, it will only work with a smart contract that has the same ABI that the Choices.sol generates; you can see that ABI in the Javascript source code of the web page.  Some of the earlier contracts on the blockchain are earlier versions of Choices.sol or different contracts.  But most of the recent ones should work.

How this all works is beyond the scope of this assignment, but will be something we will be going over later in the semester.  Feel free to look over the Javascript code in that web page -- the only other requirement is that a local geth node has to be running with a few specific flags to enable this web page to connect to it.  One can also have a web page initiate a transaction onto the blockchain, such as casting a vote -- we will see that later as well; that requires a browser plugin, such as [MetaMask](https://metamask.io/), that allows for posting of transactions from a web page using a specific Ethereum account.



### Task 4: Vote!

I have loaded the Choices smart contract onto our private Ethereum blockchain, and you all must vote!  The only information I will tell you is that the contract address for this is on the Collab landing page.  It's the same Choices.sol code that we have been using throughout this assignment, albeit with different choices.  You have to figure out what the options are, and then vote for one.  You will need to submit the block number and transaction hash where you voted.

In Remix, you can call a different contract *with the same codebase*.  In particular, it has to have the same ABI.  On the Collab landing page is the address of a deployed Choices contract -- copy that address.  In Remix, above the "Deployed contracts" list is a blue "At Address" button -- copy the contract address there, and click that button.  This now gives us a connection to a different Choices contract.  Use this to vote.  Remember that you have to mine your vote to the blockchain for it to take effect.

Note that Remix may complain that the address is not [checksummed](../../slides/ethereum.html#/checksum).  This is a warning, not an error, and it should still work fine.  Remix will provide, in the warning, the checksummed address -- you are welcome to use that instead to silence this warning.

The assumption is that the account you will vote with is your `eth.coinbase` account.  (It's fine if you want to use a different account, but when you submit your information at the end of this assignment, be sure to submit the account that you used for the deployment and voting.) As your account information will be in the `voters` mapping, we will be able to determine who has voted and who has not.  We won't know who voted for what, though, since that information is not kept by this smart contract.  (Well, mostly.  We could look up who voted for what, since it's on the blockchain, but that's a hassle we aren't going to do that.)  You get credit for this part as along as you vote on my smart contract; it does not matter what you vote for.



### Closing down

Please turn off your geth node when you are done with this assignment.  You can always turn it back on again when needed.

### Submission & Grading

To test your program, we will look at your deployed Choices smart contract on our private blockchain.  We will check that you did the various tasks (deployed the contract, modified the options, voted for an option for your own contract,  voted for an option on our contract, etc.).

You will need to submit your information via a Google form, the link to which is on the Collab landing page. You will need to submit the following items:

- Your name & UVA userid
- Your account number from `eth.coinbase`.  The assumption is that you did your tasks from this account (deployed your contract, the votes, etc.); if you did it from a different account, submit that account address.
- From task 2, you should submit information about the smart contract you deployed.  If you mined it to the blockchain multiple times, that's fine -- pick the most recent one (where you voted), and submit that one.  You should submit:
    - The transaction hash of the contract transaction 
    - The contract address for the contract (this can be the checksummed version or all lower-case)
    - The block number where this transaction was mined
- Also from task 2, the transaction hash and the block number where you voted on YOUR Choices contract
- From task 4, the transaction hash and the block number where you voted for MY Choices contract
- How many hours (as a floating-point number) this assignment took you to complete.  Please be honest here -- I'm using this to judge workload, and this will have no impact on your grade for this assignment.
