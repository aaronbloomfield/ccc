// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.21;

import "./IERC165.sol";

interface IEtherPriceOracle is IERC165 {

	// The name (really a description) of the implementing contract
	function name() external pure returns (string memory);

	// The currency symbol this is being reported in, such as '$'
	function symbol() external pure returns (string memory);

	// How many decimals this is being reported in; for cents, it's 2
	function decimals() external pure returns (uint);

	// The current price, in cents, of the (fake) ether
	function price() external view returns (uint);

	// also supportsInterface() from IERC165.sol
}
