// SPDX-License-Identifier: CC BY-SA
// This file is part of the https://github.com/aaronbloomfield/ccc repo

pragma solidity ^0.8.7;


// a smart contract to allow voting on something
contract Choices {

	// the data that will be stored on the blockchain -- a tuple containing
	// the ID of the choice, the name of the choice, and how many votes it
	// has received
	struct Choice {
		uint id;
		string name;
		uint votes;
	}

	// a mapping to keep track of who has voted
	mapping (address => bool) public voters;

	// a mapping to store the various chioces
	mapping (uint => Choice) public choices;

	// how many choices have been added?
	uint public num_choices;

	// an event when somebody votes
	event votedEvent (uint indexed _id);

	// an event when a choice is added
	event choiceAddedEvent (uint indexed _id);

	// the constructor, which runs when it's first deployed to the blockchain;
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

	// the function that adds a choice to be voted upon
	function addChoice (string memory _name) public {
		choices[num_choices] = Choice(num_choices, _name, 0);
		emit choiceAddedEvent(num_choices);
		num_choices++;
	}

	// the function that allows one to vote; it checks if that account has
	// already voted, and prevents double voting
	function vote (uint _id) public {
		require(!voters[msg.sender], "sender has already voted");
		require(_id >= 0 && _id < num_choices, "invalid vote selection");
		voters[msg.sender] = true;
		choices[_id].votes++;
		emit votedEvent(_id);
	}

	// this function is, as its name implies, unnecessary; it is there to show
	// a read-only function -- meaning one that does not modify the state of
	// the object at all
	function unnecessaryFunction() public view returns (string memory) {
		return choices[0].name;
	}

}
