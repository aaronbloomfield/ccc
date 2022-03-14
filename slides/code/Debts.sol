// SPDX-License-Identifier: CC BY-SA

pragma solidity ^0.8.7;

contract Debts {

	struct Entry {
		uint id;
		string thealias;
		string name;
		address addr;
		int balance;
	}

	// a mapping has all keys, so we can't call `keys()` (or similar)
	mapping (string => uint) public findByAlias;
	mapping (address => uint) public findByAddress;
	mapping (string => bool) public hasEntry;
	mapping (uint => Entry) public entries;
	uint public num_aliases;

	constructor() {
		// go over initialization here to save time with later transactions
		// address checksum issues
	}

	function addAlias (string memory _alias, string memory _name) public {
		addAlias(_alias,_name,msg.sender);
	}

	function addAlias (string memory _alias, string memory _name, address _account) private {
		require(!hasEntry[_alias]);
		findByAlias[_alias] = num_aliases;
		findByAddress[_account] = num_aliases;
		hasEntry[_alias] = true;
		entries[num_aliases] = Entry(num_aliases,_alias,_name,_account,0);
		num_aliases++;
	}

	function payToAlias (string memory _alias, int amount) public {
		// limit amounts
		require (amount >= -100 && amount <= 100, "Amounts must be between -100 and 100");
		// get who it's from, make sure they have an alias/entry
		uint from = findByAddress[msg.sender];
		require(msg.sender == entries[from].addr);
		// get who it's to, make sure they have an alias/entry
		uint to = findByAlias[_alias];
		require(keccak256(bytes(_alias)) == keccak256(bytes(entries[to].thealias))); // go over the lack of string comparison
		// adjust amounts
		entries[from].balance += amount;
		entries[to].balance -= amount;
	}
}