Gradebook Smart Contract
=========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))



### Overview

I need a new gradebook!  Because Collab and my favorite spreadsheet programs are just not doing the job anymore.  So I've decided to keep everybody's grades in a public blockchain.  Your task is to implement this gradebook for me.

Admittedly, keeping a gradebook of private grades being kept on a public blockchain is not the most realistic use of smart contracts.  But it will introduce you to the concepts involved in developing smart contracts.  And there are many very similar applications that would only require a few tweaks to the gradebook contract.  There are organizations that coordinate through blockchains, and they have to keep some information on members; while not grades, it involves the same concepts.

The gradebook will need to have the following functionalities:

- The instructor *OR* the teaching assistants can designate others as teaching assistants
- Assignments can be created; each assignment has a maximum score
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

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  <!-- So far there aren't any significant changes to report. -->

- Oct 11: added two more required entries to the `sanity_checks` dictionary in [gradebook.py](gradebook.py.html) ([src](gradebook.py)): `'supportsInterface_is_correct'` and `'contract_opening_line_is_correct'`


### Part 1: IGradebook interface

#### IGradebook Interface

Formally, your contract will need to be named `Gradebook`, and saved in a file named `Gradebook.sol`.  It will need to implement the [IGradebook.sol](IGradebook.sol.html) ([src](IGradebook.sol)) interface, which is as follows.  **NOTE:** the interface file itself has many more details and specifications in the comments; most of the comments were stripped from what is below.

```
// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.16;

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

We will see the use of `supportsInterface()` in a future lecture and a later assignment.  For now, you should use this exact implementation:

```
function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return interfaceId == type(IGradebook).interfaceId || interfaceId == 0x01ffc9a7;
}
```



### Implementation details

- Students are all identified by a single string; we'll use UVA userids (you can make fake but believable UVA userids for your testing)
- All entered grades are unsigned integers
- One cannot have a grade higher than the max score; this should be checked via a `require()`
- While averages can be non-integers, we will return the (truncated) integer value that is 100 times the average.  So if somebody's average was 86.265%, the returned average would be 8626.
- The instructor is assumed to be the account that deploys the smart contract; thus, the only task the constructor needs to do is set the `instructor` field to `msg.sender`
- Your contract opening line MUST be: `contract Gradebook is IGradebook {`
- All of your methods and fields will have to have the `override` qualifier, since they are overriding what is specified in the `IGradebook` interface
- If a student does not have an entry for a given assignment, then their grade for that assignment is 0; remember that mappings return 0 if a key is not found
- Note that BOTH the instructor and TAs can designate other TAs
- The `supportsInterface()` function should be exactly as is specified above
- The `requestTAAccess()` will grant *anybody* TA access; it's not realistic in a contract deployed on a public blockchain, but we need it to test your code (the details are in the IGradebook.sol comments for that function)

The first six methods (after the two events) in the [IGradebook.sol](IGradebook.sol.html) ([src](IGradebook.sol)) interface are getter functions.  As long as you set the visibility of the field in the contract as `public`, then the getter method is created for you, as [discussed in the lecture slides](../../slides/solidity.html#/getters).  For example, for the getter function `function num_assignments() external returns (uint)`, the appropriate field declaration would be `uint public override num_assignments;`.  The lecture slide details this a bit more.

The two events, listed at the top of the interface, should be emitted at the appropriate time.  The `addAssignment()` function should emit the `assignmentCreationEvent()` event, and the `addGrade()` function should emit the `gradeEntryEvent()` event.  Be sure to emit the events *after* any `require()` calls!  It is often the case (but not required) that the event emission is done at the very end of the function.

#### Address checksums

Note that Remix may complain if an Ethernet address is not [checksummed](../../slides/ethereum.html#/checksum).  This is a warning, not an error, and it will still work fine.  But you still have to remove the warning, otherwise the compilation when you submit it will appear to fail.  Remix will provide, in the warning, the checksummed address -- you are welcome to use that value (cut-and-paste it into your code) instead to silence this warning.  You can also use [ethsum.netlify.app](https://ethsum.netlify.app/) to checksum an Ethernet address.


### Part 2: Testing and Deployment


#### Testing

You will invariably run into issues testing and debugging your code.  We have a few tips and tricks.

- Use `require()`.  A lot.  And be sure to use the [two-parameter version of `require()`](../../slides/solidity.html#/require).
- Keep in mind the [Solidity testing & debugging ideas](../../slides/solidity.html#/debugging) from the lecture slides
- Once you have tested it in the Javascript deployment environment, you will want to interact with our private blockchain, as described in the [dApp introduction](../dappintro/index.html) assignment.  Remember that, in Remix, when you initiate a transaction (orange button) -- rather than a call (blue button) -- you can then view it on the explorer (once it is mined into the blockchain and the explorer updates).
- In Remix you are going to end up calling a bunch of functions to initialize your smart contract for testing -- for example, to create a few assignments, add some scores, etc.  Once you know those functions work properly, you can put them in the constructor, as such.  This will save you time, but **BE SURE** to remove those lines once you are finished testing it and prior to submission.  For example:
  ```
designateTA(0x0123456789abcdef0123456789abcdef01234567);
addAssignment("HW1",10);
addAssignment("HW2",10);
addGrade("mst3k",0,5);
addGrade("mst3k",1,10);
```

#### Deployment

Once done, you will need to deploy your CoruseGradebook smart contract to our private Ethereum blockchain. Save the contract address, as you will need to submit that, below.  It's okay if you deploy it multiple times (for testing, debugging, errors, etc.).  Just submit the address of the last one you deployed.

On the deployed contract, you do not need to designate anybody as a TA -- we are going to make ourselves a TA in your gradebook via the `requestTAAccess()` function, so make sure that works properly.


### Part 3: Your average

I've deployed a gradebook with your (fake) grades.  The address for that smart contract is on the Collab landing page.  You will need to find out your overall average as well as a few other items of information.  Your scores are kept by your UVA userid.  These scores are fake, and were randomly generated, so don't feel bad if your score(s) are low.

There are two ways you can access the gradebook on the blockchain.  One is through Remix, like was done in the [dApp introduction assignment](../dappintro/index.html) ([md](../dappintro/index.md)) -- you load the IGradebook.sol interface, and then enter the address of the deployed Gradebook contract into the 'At Address' text box in the deployment window.  The other way is through geth, like we did in the [live coding example in class](../../slides/solidity.html#/debtor) -- the geth commands start about 8 slides down in that slide column.  For this you will also need the ABI.  You can compile the IGradebook.sol interface, and then copy the ABI -- after you compile it, the copy ABI link is at the very bottom of the compilation pane.  Note that you may have to reformat that ABI a bit -- what you copy is on many lines, and you may have to reformat it to one line.

The steps to access the gradebook via Remix are:

- In Remix, compile the IGradebook.sol file (yes, the interface file)
- Make sure you are connected to the course blockchain via the "External Http Provider" deployment environment in Remix
- In the Deployment pane in Remix, enter the address for the contract (on the Collab landing page) into the text box next to the ‘At Address’ button, and click that button
- You should be able to interact with the contract this way

The steps to access the gradebook via a geth terminal are (adapted from [here](../../solidity.html#/geth)):

- Enter `var addr = "0xffffffffffffffffffffffffffffffffffffffff";`, but with the *real* contract address on the Collab landing page
- Enter `var abi = [...];`, but with the *real* ABI of IGradebook from the Collab landing page.  Do not put this in quotes, and do not put this in extra square brackets!
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

You will need to fill in the various values from this assignment into the [gradebook.py](gradebook.py.html) ([src](gradebook.py)) file.  That file clearly indicates all the values that need to be filled in.  That file, along with your Solidity source code, are the only files that must be submitted.  The `sanity_checks` dictionary is intended to be a checklist to ensure that you perform the various other aspects to ensure this assignment is fully submitted.

There are *two* forms of submission for this assignment; you must do both.

Submission 1:  You must deploy your smart contract to our private Ethereum blockchain -- this was probably done above.  It's fine if you deploy it a few times because you were testing it, messed something up, or whatever.  But the final deployment should not have any other calls to the deployed contract.

Submission 2: You should submit your `Gradebook.sol` file, as well as your `gradebook.py` file, and ONLY those two files, to Gradescope.  All your Solidity code should be in that first file, and you should specifically import the IGradebook interface.  That interface file will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot fully test this assignment, as it does not have access to the private blockchain. So it can only do a few sanity tests (correct files submitted, successful compilation, valid values in auction.py, etc.).
