// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.34;

import "./IDebts.sol";

contract Debts is IDebts {

	/*
	// Imported from the interface:

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
	*/

	// holds all the alias entry structs from above
	mapping (uint => Entry) public override entries;

	// holds true if that account address has an entry in 'entries'
	mapping (address => bool) public override addressHasEntry;

	// holds true if that alias has an entry in 'entries'
	mapping (string => bool) public override aliasHasEntry;

	// given an alias, this will give the index into the 'entries' array for that alias
	mapping (string => uint) public override findByAlias;

	// given an account address, this will give the index into the 'entries' array for that account address
	mapping (address => uint) public override findByAddress;

	// how many alias exist in the 'entries' mapping
	uint public override num_entries;


	// we don't have to do much here
	constructor() {
	}


	function addAlias (string memory _alias, string memory _name) virtual override public {
		// ensure that the alias name does not already exist
		require(!aliasHasEntry[_alias], "string entry name already exists");
		// ensure that the sender doesn't already have an alias
		require(!addressHasEntry[msg.sender], "your address already has an alias");
		// add an entry in the mapping of whether that string alias exists
		aliasHasEntry[_alias] = true;
		// add an entry in the mapping of whether a given account address has an alias
		addressHasEntry[msg.sender] = true;
		// add an entry in the mapping from alias strings to alias indices
		findByAlias[_alias] = num_entries;
		// add an entry in the mapping from account addresses to alias indices
		findByAddress[msg.sender] = num_entries;
		// add the alias entry itself
		entries[num_entries] = Entry(num_entries,_alias,_name,msg.sender,0);
		// increment the number of aliases so far
		num_entries++;
		// emit the event
		emit aliasAddedEvent();
	}


	function payToAlias (string memory _alias, int amount) virtual override public {
		// limit amounts from -100 to +100
		require (amount >= -100 && amount <= 100, "amounts must be between -100 and 100");
		// amount cannot be zero
		require (amount != 0, "amount cannot be zero");
		// ensure that the caller has an alias
		require(addressHasEntry[msg.sender], "your address does not have an alias");
		// ensure that the 'to' has an alias entry
		require(aliasHasEntry[_alias], "string entry name does not exist");
		// get the alias index of who it's from, as we know they already exist
		uint from = findByAddress[msg.sender];
		// get who it's to as we know they already exist
		uint to = findByAlias[_alias];
		// one cannot enter a debt to themselves
		require(entries[to].addr!=msg.sender, "you cannot enter a debt to yourself");
		// adjust amounts on both ends
		entries[from].balance += amount;
		entries[to].balance -= amount;
		// emit the event
		emit paidEvent();
	}


	function supportsInterface(bytes4 interfaceId) external override pure returns (bool) {
		return interfaceId == type(IDebts).interfaceId || interfaceId == 0x01ffc9a7;
	}

}
