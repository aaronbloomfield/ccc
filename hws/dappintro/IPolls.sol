// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.7;


// This is an interface that specifies a common API for a Polls contract.
interface IPolls {

	// the data that will be stored on the blockchain -- a tuple containing
	// the ID of the choice, the name of the choice, and how many votes it
	// has received
	struct Choice {
		uint id;
		string name;
		uint votes;
	}

	// a mapping to keep track of who has voted
	function voted(address a) external returns (bool);

	// a mapping to store the various chioces
	function choices(uint i) external returns (Choice memory);

	// how many choices have been added?
	function num_choices() external returns (uint);

	// the function that adds a choice to be voted upon
	function addChoice (string memory _name) external;

	// the function that allows one to vote; it checks if that account has
	// already voted, and prevents double voting
	function vote (uint _id) external;

	// an event when somebody votes
	event votedEvent (uint indexed _id);

	// an event when a choice is added
	event choiceAddedEvent (uint indexed _id);

}
