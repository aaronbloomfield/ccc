Gradebook Smart Contract
=========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))

<!--

    What to provide on the Canvas landing page:

    - url to the blockchain explorer
    - the deployed course gradebook contract address
    - a note where to find the gradebook abi

-->


### Overview

I need a new gradebook!  Because Canvas and my favorite spreadsheet programs are just not doing the job anymore.  So I've decided to keep everybody's grades in a public blockchain.  Your task is to implement this gradebook for me.

Admittedly, keeping a gradebook of private grades on a public blockchain is not the most realistic use of smart contracts.  But it will introduce you to the concepts involved in developing more complicated smart contracts.  And there are many very similar applications that would only require a few tweaks to the gradebook contract.  For example, there are organizations that coordinate through blockchains, and they have to keep some information on members; while not grades, it involves the same concepts.

The gradebook will need to have the following functionalities:

- ONLY the instructor can designate others as teaching assistants
- Assignments can be created; each assignment has a maximum score; that maximum score must be positive (not zero)
- Grades for students can be entered and updated for a given assignment (only unsigned integers)
- Only instructors and teaching assistants can create assignments and enter/update grades
- Anybody can look up any student's grades (again, these are only *fake* grades)
- Anybody can get a grade or a student's average score

Writing this homework will require completion of the following assignments:

- [Connecting to the private Ethereum blockchain](../ethprivate/index.html) ([md](../ethprivate/index.md))
- [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md))

You will also need to be familiar with the [Ethereum slide set](../../slides/ethereum.html#/) and the [Solidity slide set](../../slides/solidity.html#/).

In addition to your source code, you will submit an edited version of [gradebook.py](gradebook.py.html) ([src](gradebook.py)).

### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here. So far there aren't any significant changes to report.


### Part 1: IGradebook interface

#### IGradebook Interface

Formally, your contract will need to be named `Gradebook`, and saved in a file named `Gradebook.sol`.  It will need to implement the [IGradebook.sol](IGradebook.sol.html) ([src](IGradebook.sol)) interface, which is as follows.  **NOTE:** the interface file itself has many more details and specifications in the comments; most of the comments were stripped from what is shown below.

```
// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.24;

// See the actual IGradebook.sol file, linked to above, for much more detailed comments

interface IGradebook {

    event assignmentCreationEvent (uint indexed _id);

    event gradeEntryEvent (uint indexed _id);

    // The following six methods are done for you automatically -- as long as
    // you make the appropriate variable public, then Solidity will create
    // the getter function for you
    
    function tas(address ta) external returns (bool);

    function max_scores(uint id) external returns (uint);

    function assignment_names(uint id) external returns (string memory);

    function scores(uint id, string memory userid) external returns (uint);

    function num_assignments() external returns (uint);

    function instructor() external returns (address);

    // The following five functions are ones you must implement

    function designateTA(address ta) external;

    function addAssignment(string memory name, uint max_score) external returns (uint);

    function addGrade(string memory student, uint assignment, uint score) external;

    function getAverage(string memory student) external view returns (uint);

    function requestTAAccess() external;

    // The implementation for the following is provided in the HW description

    function supportsInterface(bytes4 interfaceId) external view returns (bool);

}
```

#### The `supportsInterface()` function

We will see the use of `supportsInterface()` in a future lecture and in a future assignment.  For now, you should use this *exact* implementation:

```
function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return interfaceId == type(IGradebook).interfaceId || interfaceId == 0x01ffc9a7;
}
```

#### IGradebook ABI


The ABI for `IGradebook.sol` is as follows, can can be copied by clicking on: <script>insertCopyLink('[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"_id","type":"uint256"}],"name":"assignmentCreationEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"_id","type":"uint256"}],"name":"gradeEntryEvent","type":"event"},{"inputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"max_score","type":"uint256"}],"name":"addAssignment","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"student","type":"string"},{"internalType":"uint256","name":"assignment","type":"uint256"},{"internalType":"uint256","name":"score","type":"uint256"}],"name":"addGrade","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"assignment_names","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ta","type":"address"}],"name":"designateTA","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"student","type":"string"}],"name":"getAverage","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"instructor","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"max_scores","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"num_assignments","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"requestTAAccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"userid","type":"string"}],"name":"scores","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ta","type":"address"}],"name":"tas","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"}]');</script>

<pre><code style='white-space:initial'>[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"_id","type":"uint256"}],"name":"assignmentCreationEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"_id","type":"uint256"}],"name":"gradeEntryEvent","type":"event"},{"inputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"max_score","type":"uint256"}],"name":"addAssignment","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"student","type":"string"},{"internalType":"uint256","name":"assignment","type":"uint256"},{"internalType":"uint256","name":"score","type":"uint256"}],"name":"addGrade","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"assignment_names","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ta","type":"address"}],"name":"designateTA","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"student","type":"string"}],"name":"getAverage","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"instructor","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"max_scores","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"num_assignments","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"requestTAAccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"userid","type":"string"}],"name":"scores","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"ta","type":"address"}],"name":"tas","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"}]
</code></pre>




### Implementation details

- Students are all identified by a single string; we'll use UVA userids (you can make fake, but believable, UVA userids for your testing)
- All entered grades are unsigned integers
- One cannot have a grade higher than the max score; this should be checked via a `require()`
- The max score must be a positive integer (not zero)
- While averages can be non-integers, we will return the (truncated) integer value that is 100 times the average.  So if somebody's average was 86.265%, the returned average would be 8626.
- The instructor is assumed to be the account that deploys the smart contract; thus, the only task the constructor needs to do is set the `instructor` field to `msg.sender`
- Your contract opening line MUST be: `contract Gradebook is IGradebook {`
- Your particular compiler version *may* require your methods to all have the `override` qualifier, since they are overriding what is specified in the `IGradebook` interface.  It's good practice to put that qualifier in there even if the compiler does not explicitly require it.
- If a student does not have an entry for a given assignment, then their grade for that assignment is 0; remember that mappings return 0 if a key is not found
- Note that ONLY the instructor can designate other TAs
- The `supportsInterface()` function should be exactly as is specified above
- The `requestTAAccess()` will grant *anybody* who calls it TA access; it's not realistic in a contract deployed on a public blockchain, but we need it to test your code (the details are in the IGradebook.sol comments for that function)
- Your gradebook MUST index assignments starting from 0 so that our auto-grading scripts will work.  Thus, the first assignment created will have an index of 0, the second an index of 1, etc.

The first six methods (after the two events) in the [IGradebook.sol](IGradebook.sol.html) ([src](IGradebook.sol)) interface are getter functions.  As long as you set the visibility of the field in the contract as `public`, then the getter method is created for you, as [discussed in the lecture slides](../../slides/solidity.html#/getters).  For example, for the getter function `function num_assignments() external returns (uint)`, the appropriate field declaration would be `uint public override num_assignments;`.  The lecture slide set explains this a bit more.

The two events, listed at the top of the interface, should be emitted at the appropriate time.  The `addAssignment()` function should emit the `assignmentCreationEvent()` event upon successful completion, and the `addGrade()` function should emit the `gradeEntryEvent()` event upon successful completion.  It's a good idea to emit the events *after* any `require()` calls!  It is often the case (but not required) that the event emission is done at the very end of the function.

#### Address checksums

Note that Remix may complain if an Ethernet address is not [checksummed](../../slides/ethereum.html#/checksum).  Remix will provide, in the error, the checksummed address -- you can use that value (cut-and-paste it into your code) instead to silence this warning.  You can also use [ethsum.netlify.app](https://ethsum.netlify.app/) to checksum an Ethernet address.

Also note that compilation warnings will appear to Gradescope as a compilation error.  Thus, you will have to remove them by the time you submit your assignment.


### Part 2: Testing and Deployment


#### Testing

You will invariably run into issues testing and debugging your code.  We have a few tips and tricks.

- Use `require()`.  A lot.  And be sure to use the [two-parameter version of `require()`](../../slides/solidity.html#/require).
- Keep in mind the [Solidity testing & debugging ideas](../../slides/solidity.html#/debugging) from the lecture slides
- Once you have tested it in the Javascript deployment environment, you will want to test it on our private blockchain, as described in the [dApp introduction](../dappintro/index.html) assignment.  Remember that, in Remix, when you initiate a transaction (orange button) -- rather than a call (blue button) -- you can then view it on the explorer (once it is mined into the blockchain and the explorer updates).
- Don't be afraid to deploy it multiple times to the course blockchain -- that's what it is there for.  A dozen deployments is fine, but if you start approaching a hundred or so, we are going to wonder what is going on.  You will only submit the most recent (and -- presumably -- fully working) deployment when you submit the assignment.
- In Remix you are going to end up calling a bunch of functions to initialize your smart contract for testing -- for example, to create a few assignments, add some scores, etc.  Once you know those functions work properly, you can put them in the constructor, as such.  This will save you time, but **BE SURE** to remove those lines once you are finished testing it and prior to submission.  For example:
  ```
  designateTA(0x0123456789abcdef0123456789abcdef01234567);
  addAssignment("HW1",10);
  addAssignment("HW2",10);
  addGrade("mst3k",0,5);
  addGrade("mst3k",1,10);
  ```
- Another option is to put those calls in a separate function called `setup()` (or similar).  This way, with one click, all of your contract setup will occur, and you don't have to pollute the constructor.


#### Deployment

Once done, you will need to deploy your CoruseGradebook smart contract to our private Ethereum blockchain. Save the contract address, as you will need to submit that, below.  It's okay if you deploy it multiple times (for testing, debugging, errors, etc.).  Just submit the address of the last one you deployed.

On the deployed contract, you do not need to designate anybody as a TA -- we are going to make ourselves a TA in your gradebook via the `requestTAAccess()` function, so make sure that works properly.


### Part 3: Your average

I've deployed a gradebook with your (fake) grades.  The address for that smart contract is on the Canvas landing page.  You will need to find out your overall average as well as a few other items of information.  Your scores are kept by your UVA userid.  These scores are fake, and were randomly generated, so don't feel bad if your score(s) are low.

There are two ways you can access the gradebook on the blockchain.  One is through Remix, like was done in the [dApp introduction assignment](../dappintro/index.html) ([md](../dappintro/index.md)) -- you load the IGradebook.sol interface, and then enter the address of the deployed Gradebook contract into the 'At Address' text box in the deployment window.  The other way is through geth, as in the [live coding example in class](../../slides/solidity.html#/debtor) -- the geth commands start about 8 slides down in that slide column.  For this you will also need the ABI.  You can compile the IGradebook.sol interface in Remix, and then copy the ABI -- after you compile it, the copy ABI link is at the very bottom of the compilation pane.  Note that you may have to reformat that ABI a bit -- what you copy is on many lines, and you may have to reformat it to one line.

The steps to access the gradebook via Remix are:

- In Remix, compile the IGradebook.sol file (yes, the interface file)
- Make sure you are connected to the course blockchain via the "External Http Provider" deployment environment in Remix
- In the Deployment pane in Remix, enter the address for the contract (on the Canvas landing page) into the text box next to the ‘At Address’ button, and click that button
- You should be able to interact with the contract this way

The steps to access the gradebook via a geth terminal are (adapted from [here](../../solidity.html#/geth)):

- Enter `var addr = "0xffffffffffffffffffffffffffffffffffffffff";`, but with the *real* contract address on the Canvas landing page
- Enter `var abi = [...];`, but with the *real* ABI of IGradebook from the Canvas landing page.  Do not put this in quotes, and do not put this in extra square brackets!
- Enter `var interface = eth.contract(abi);`
- Enter `var contract = interface.at(addr);`
- You can call a `view` or `pure` function via: `contract.function.call()`; parameters, if any, go in the parenthesis of `call()`
- You can send a transaction function call via:
    - First unlocking your account: `personal.unlockAccount(eth.coinbase,"password",0)`
    - The transaction itself via: `contract.addAlias.sendTransaction("mst3k", "Your Name", {from:eth.coinbase, gas:1000000})`
        - This assumes the parameters to the function in Solidity are two strings: the userid and the name (this was from the [Debts example in class](../../slides/solidity.html#/debtor))
        - The `{from:eth.coinbase, gas:1000000}` should stay the same

The information you need to obtain is:

- What is your (fake) average?  Recall that it reports an integer that is 100 times your average so 1234 means your average is 12.34%.  If `1234` is returned by the function, then you should enter `12.34` into gradebook.py.
- What are the maximum number of points on the assignment with index 3?
- What is YOUR score on the assignment with index 3?

### Submission

You will need to fill in the various values from this assignment into the [gradebook.py](gradebook.py.html) ([src](gradebook.py)) file.  That file clearly indicates all the values that need to be filled in.  That file, along with your Solidity source code, are the only two files that must be submitted.  The `sanity_checks` dictionary is intended to be a checklist to ensure that you perform the various other aspects to ensure this assignment is fully submitted.

There are *two* forms of submission for this assignment; you must do both.

Submission 1:  You must deploy your smart contract to our private Ethereum blockchain -- this was probably done above.  It's fine if you deploy it a few times because you were testing it, messed something up, or whatever.  But the final deployment should not have any other transactions to the deployed contract.

Submission 2: You should submit your `Gradebook.sol` file, as well as your `gradebook.py` file, and ONLY those two files, to Gradescope.  All your Solidity code should be in that first file, and you should specifically import the IGradebook interface.  That interface file will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, valid values in auction.py, etc.).
