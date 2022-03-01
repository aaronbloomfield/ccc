// SPDX-License-Identifier: CC BY-SA
// This file is part of the https://github.com/aaronbloomfield/ccc repo

pragma solidity ^0.8.7;

contract Choices {

	struct Choice {
		uint id;
		string name;
		uint votes;
	}

	mapping (address => bool) public voters;
	mapping (uint => Choice) public choices;
	uint public num_choices;

	event votedEvent (uint indexed _id);
	event choiceAddedEvent (uint indexed _id);

	constructor() {
		addChoice("red");
		addChoice("orange");
		addChoice("yellow");
		addChoice("green");
		addChoice("blue");
		addChoice("purple");
	}

	function addChoice (string memory _name) public {
		choices[num_choices] = Choice(num_choices, _name, 0);
		emit choiceAddedEvent(num_choices);
		num_choices++;
	}

	function vote (uint _id) public {
		require(!voters[msg.sender], "sender has already voted");
		require(_id >= 0 && _id < num_choices, "invalid vote selection");
		voters[msg.sender] = true;
		choices[_id].votes++;
		emit votedEvent(_id);
	}

	function unnecessaryFunction() public view returns (string memory) {
		return choices[0].name;
	}

}
