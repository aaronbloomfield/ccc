// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.24;

interface IDebts {

	// holds in the necessary information about each alias / entry
	struct Entry {
		uint id;			// the index in the 'entries' mapping
		string thealias;	// their string alias
		string name;		// their string name
		address addr;		// their account address
		int balance;		// how much they owe (if negative) or are owed (if positive)
	}

	// allow notification when a debt is entered
	event paidEvent();

	// allow notification when an alias is entered
	event aliasAddedEvent();


	// holds all the alias entry structs from above; as we are going to call
	// this from Javascript, which will not know about the Entry struct type,
	// we have to return a tuple of all the Entry fields (which is what the
	// automatic getter function will do); create it via:
	// mapping (uint => Entry) public entries;
	function entries(uint) external returns (uint, string memory, string memory, address, int);

	// holds true if that account address has an entry in 'entries'; create it
	// via:
	// mapping (address => bool) public addressHasEntry;
	function addressHasEntry(address) external returns (bool);

	// holds true if that alias has an entry in 'entries'; create it via:
	// mapping (string => bool) public aliasHasEntry;
	function aliasHasEntry(string memory) external returns (bool);

	// given an alias, this will give the index into the 'entries' array for
	// that alias; create it via:
	// mapping (string => uint) public findByAlias;
	function findByAlias(string memory) external returns (uint);

	// given an account address, this will give the index into the 'entries'
	// array for that account address; create it via:
	// mapping (address => uint) public findByAddress;
	function findByAddress(address) external returns (uint);

	// how many alias exist in the 'entries' mapping; create it via:
	// uint public num_entries;
	function num_entries() external returns (uint);

	// add an alias and associated name to the mapping; the address is assumed
	// to be msg.sender
	function addAlias (string memory _alias, string memory _name) external;

	// enter a debt, in either direction, between the current account and the
	// provided alias
	function payToAlias (string memory _alias, int amount) external;

	// the implementation for this is provdied in Debts.sol, and it's usage is
	// explained later in the course
    function supportsInterface(bytes4 interfaceId) external pure returns (bool);

}
