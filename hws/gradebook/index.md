Gradebook Smart Contract
=========================

[Go up to the CCC HW page](../index.html) ([md](../index.md))



### Overview

I need a new gradebook!  Because Collab and my favorite spreadsheet programs are just not doing the job anymore.  So I've decided to keep everybody's grades in a public blockchain.  Your task is to implement this gradebook for me.

Note: I'm not going to to keep *real* grades in the gradebook.  In addition to the fact that doing so would violate your privacy, it would also be a violation of [FERPA](https://www2.ed.gov/policy/gen/guid/fpco/ferpa/index.html).  So only fake grades will be kept herein.

Admittedly, a gradebook of private grades being kept on a public blockchain is not the most realistic use of smart contracts.  But it will introduce you to the concepts involved in developing smart contracts.  And there are many very similar applications that would only require a few tweaks to the gradebook contract.  There are organizations that coordinate through blockchains, and they have to keep some information on members; while not grades, it involves the same concepts.


### Changelog

Any changes to this page will be put here for easy reference.  Typo fixes and minor clarifications are not listed here.  So far there aren't any significant changes to report.


### Pre-requisites

Writing this homework will require completion of the following assignments:

- [Connecting to the private Ethereum blockchain](../ethprivate/index.html) ([md](../ethprivate/index.md))
- [dApp introduction](../dappintro/index.html) ([md](../dappintro/index.md))

You will also need to be familiar with the [Ethereum slide set](../../slides/ethereum.html#/), and the [Solidity slide set](../../slides/solidity.html#/).


### Part 1: Write the CourseGradebook smart contract

#### Overview

The gradebook will need to have the following functionalities:

- Assignments can be created; each assignment has a maximum score
- Grades for students can be entered and updated for a given assignment
- Anybody can look up any student's grades (again, these are only *fake* grades)
- The instructor can designate others as teaching assistants
- Only instructors and teaching assistants can create assignments and enter/update grades
- Anybody can get a student's average score

#### Interface

Formally, your contract will need to be named `CourseGradebook`, and saved in a file named `CourseGradebook.sol`.  It will need to implement the [Gradebook.sol](Gradebook.sol.html) ([src](Gradebook.sol)) interface, which is as follows.  **NOTE:** the interface file itself has many more details in the comments; most of the comments were stripped for what is below.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// See the actual Gradebook.sol file, linked to above, for much more detailed comments

interface Gradebook {

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

    // The following four functions are ones you must implement

    function designateTA(address ta) external;

    function addAssignment(string memory name, uint max_score) external returns (uint);

    function addGrade(string memory student, uint assignment, uint score) external;

    function getAverage(string memory student) external view returns (uint);

}
```

#### Implementation details

- Students are all identified by a single string; we'll use UVA userids
- All entered grades are (unsigned) integers
- One cannot have a grade higher than the max score; this should be checked via a `require()`
- While averages can be non-integers, we will return the (truncated) integer value that is 100 times the average.  So if somebody's average was 86.265%, the returned average would be 8626.
- The only task the constructor needs to do is set the `instructor` field to `msg.sender`
- Your contract opening line MUST be: `contract CourseGradebook is Gradebook {`
- All of your methods and fields will have to have the `override` qualifier, since they are overriding what is specified in the `Gradebook` interface

The first six methods (after the two events) are getter functions.  As long as you set the visibility of the field in the contract as `public`, then the getter method is created for you, as [discussed in the lecture slides](../../slides/solidity.html#/getters).  For example, for the getter function `function num_assignments() external returns (uint)`, the appropriate field declaration would be `uint public override num_assignments;`.  The lecture slide details this a bit more.

The two events, listed at the top of the interface, should be emitted at the appropriate time.  The `addAssignment()` function should emit `assignmentCreationEvent()` event, and the `addGrade()` function should emit the `gradeEntryEvent()` event.  Be sure to emit the events *after* any `require()` calls!


#### Testing

You will invariably run into issues testing and debugging your code.  We have a few tips and tricks.

- Use `require()`.  A lot.  And be sure to use the [two-parameter version of `require()`](../../slides/solidity.html#/require).
- Keep in mind the [Solidity testing & debugging ideas](../../slides/solidity.html#/debugging) from the lecture slides
- Once you have tested it in the Javascript deployment environment, you will want to interact with our private blockchain, as described in the [dApp introduction](../dappintro/index.html) assignment.  Remember that, in Remix, when you initiate a transaction (orange button) -- rather than a call (blue button) -- you will have to mine it into the blockchain.  Via a `geth attach` terminal, run `miner.start()` and then `miner.stop()`.
- In Remix you are going to end up calling a bunch of functions to initialize your smart contract for testing -- for example, to create a few assignments, add some scores, etc.  Once you know those functions work properly, you can put them in the constructor, as such.  This will save you time, but **BE SURE** to remove those lines once you are finished testing it and prior to submission.

```
designateTA(0x0123456789abcdef0123456789abcdef01234567);
addAssignment("HW1",10);
addAssignment("HW2",10);
addGrade("mst3k",0,5);
addGrade("mst3k",1,10);
```

#### Deployment

Once done, you will need to deploy your CoruseGradebook smart contract to our private Ethereum blockchain. Save the contract address, as you will need to submit that, below.  It's okay if you deploy it multiple times (for testing, debugging, errors, etc.).  Just submit the address of the last one you deployed.

You need to designate me as a TA for your gradebook.  The address to designate is on the Collab landing page.  Other than that one call to `designateTA()`, you should not make any other calls to the deployed smart contract.  If you make other calls, please re-deploy it, re-call `designateTA()`, and submit that deployed contract address.


### Part 2: What is your average?

I've deployed a gradebook with your (fake) grades.  The address for that smart contract is on the Collab landing page.  You will need to find out your overall average as well as a few other items of information.  Your scores are kept by your UVA userid.  These scores are fake, and were randomly generated, so don't feel bad if your score(s) are low.


There are two ways you can access the gradebook on the blockchain.  One is through Remix, like was done in the [dApp introduction assignment](../dappintro/index.html) ([md](../dappintro/index.md)) -- you load the Gradebook.sol interface, and then enter the address of the deployed Gradebook contract into the 'At Address' text box in the deployment window.  The other way is through geth, like we did in the [live coding example in class](../../slides/solidity.html#/debtor) -- the geth commands start about 8 slides down in that column.  For this you will also need the ABI.  You can compile the Gradebook.sol interface, and then copy the ABI -- after you compile it, the copy ABI link is at the very bottom of the compilation pane.  Note that you may have to reformat that ABI a bit -- what you copy is on many lines, and you may have to reformat it to one line.

### Submission

There are *three* forms of submission for this assignment; you must do all three.

Submission 1: You should submit your `CourseGradebook.sol` file, and ONLY that file, to Gradescope.  All your code should be in that file, and you should specifically import the `Gradebook` interface.  That interface file will be placed in the same directory on Gradescope when you submit.  **NOTE:** Gradescope cannot test this assignment, as it does not have access to the private blockchain. So it can only check that the right file was submitted and that it compiles.  Thus, you should ignore any score that Gradescope presents, as it is not running any actual tests other than compilation.

Submission 2:  You must deploy your smart contract to our private Ethereum blockchain -- this was probably done above.  It's fine if you deploy it a few times because you were testing it, screwed something up, or whatever.  But the final deployment should not have any data other than the one call to `designateTA()`.

Submission 3: You will need to submit your information via a Google form, the link to which is on the Collab landing page. You will need to submit the following items:

- Your name & UVA userid
- Your account number from `eth.coinbase`.  The assumption is that you did your tasks from this account (deployed your contract, the votes, etc.); if you did it from a different account, submit that account address instead.
- The smart contract address for your deployed CourseGradebook contract
- A few questions about your average in my gradebook, from part 2
