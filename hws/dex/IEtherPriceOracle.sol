// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./IERC165.sol";

interface IEtherPriceOracle is IERC165 {

	// The name (really a description) of the implementing contract
	function name() external view returns (string memory);

	// The currency symbol this is being reported in, such as '$'
	function symbol() external view returns (string memory);

	// How many decimals this is being reported in; for cents, it's 2
	function decimals() external view returns (uint);

	// The current price of the (fake) ether
	function price() external view returns (uint);

	// also supportsInterface() from IERC165.sol
}
