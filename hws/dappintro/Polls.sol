// SPDX-License-Identifier: CC BY-SA
// This file is part of the https://github.com/aaronbloomfield/ccc repo

pragma solidity ^0.8.7;

import "./PollsInterface.sol";

// A smart contract to allow voting on something.
contract Polls is PollsInterface {

	// struct Choice is defined in PollsInterface.sol, so we can't re-define
	// it here, and is defined as:
	//
	// struct Choice {
	//   uint id;
	//   string name;
	//   uint votes;
	// }

	// The following two events are defined in PollsInterface.sol, so we can't
	// re-define them here.  They are defined as:
	//
	// event votedEvent (uint indexed _id);
	// event choiceAddedEvent (uint indexed _id);

	// A mapping to keep track of who has voted; the fact that it is public
	// means that a getter function called voted() will also be defined.  As
	// this voted() function is implementing the one specified in
	// PollsInterface.sol, we have to put the 'override' keyword here.
	mapping (address => bool) public override voted;

	// A mapping to store the various chioces.  Because the type of this
	// mapping (Chioce storage) is ever so slightly different than what is
	// returned from the choices() function defined in PollsInterface.sol
	// (Choices memory), we can't declare this as public to get an getter
	// function.
	mapping (uint => Choice) internal _choices;

	// This is the getter function for the above mapping that solves the type
	// difference (i.e., that "Choices storage" != "Choices memory").  As
	// this choices() function is implementing the one specified in
	// PollsInterface.sol, we have to put the 'override' keyword here.
	function choices(uint i) public view override returns (Choice memory) {
		return _choices[i];
	}

	// How many choices have been added?  It's public, so we get a free getter
	// function called num_choices().  As this num_choices() function is
	// implementing the one specified in PollsInterface.sol, we have to put
	// the 'override' keyword here.
	uint public override num_choices;

	// The constructor, which runs when it's first deployed to the blockchain;
	// this adds our voting choices.
	// YOU HAVE TO CHANGE THE CODE HEREIN -- make up your own choices
	constructor() {
		addChoice("red");
		addChoice("orange");
		addChoice("yellow");
		addChoice("green");
		addChoice("blue");
		addChoice("purple");
	}

	// The function that adds a choice to be voted upon.  It implements the
	// function of the same name from PollsInterface.sol, so we put
	// the 'override' keyword here.
	function addChoice (string memory _name) public override {
		_choices[num_choices] = Choice(num_choices, _name, 0);
		emit choiceAddedEvent(num_choices);
		num_choices++;
	}

	// The function that allows one to vote; it checks if that account has
	// already voted, and prevents double voting.  It implements the function
	// of the same name from PollsInterface.sol, so we put the 'override'
	// keyword here.
	function vote (uint _id) public override {
		require(!voted[msg.sender], "sender has already voted");
		require(_id >= 0 && _id < num_choices, "invalid vote selection");
		voted[msg.sender] = true;
		_choices[_id].votes++;
		emit votedEvent(_id);
	}

	// This function is, as its name implies, unnecessary; it is there to show
	// a read-only function -- meaning one that does not modify the state of
	// the object at all.  As it is not defined in PollsInterface.sol, we do
	// not need the 'override' keyword here.
	function unnecessaryFunction() public view returns (string memory) {
		return _choices[0].name;
	}

	// We'll see the necessity and use of this function later, when we talk
	// about Tokens.  For now, keep this function exactly as-is.  As it is
	// not defined in PollsInterface.sol, we do not need the 'override'
	// keyword here.
	function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
		return interfaceId == type(PollsInterface).interfaceId || interfaceId == 0x01ffc9a7;
	}

}
