// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repoistory,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./TokenDEX.sol";
import "./TokenCC.sol";
import "./EtherPricerConstant.sol";

contract DEXtest {

	function test() public payable {
 		require (msg.value > 15 ether, "Must call with more than 15 ether");
        TokenCC cc = new TokenCC();
        TokenDEX dex = new TokenDEX();
        EtherPricerConstant pricer = new EtherPricerConstant();
        cc.approve(address(dex),cc.totalSupply());

        // initial deposit of 10 ETH and 100 TC
	    try dex.createPool{value: 10 ether}(100*10**cc.decimals(), 0, 1000, address(cc), address(pricer)) {
            // do nothing
        } catch Error(string memory reason) {
            require (false, string(abi.encodePacked("createPool() call reverted: ",reason)));
        }
        require(dex.k() == 1e31, "k value not correct after createPool()");
        // the next line assumes you are sending in 10 ETH; adjust as necessary,
        // but this amount matches the worked-out example in the homework description
        require(dex.etherLiquidity() == 10 * 1e18, "x value not correct after createPool()");
        // the next line assumes that you are putting in 100 TC; adjust as necessary,
        // but this amount matches the worked-out example in the homework description
        require(dex.tokenLiquidity() == 100 * 10**(cc.decimals()), "y value not correct after createPool()");

        // insert code for the example's transaction 1 here

        // insert code for the example's transaction 2 here

        // insert code for the addLiquidity() example here

        // finish up
        require(false,"end fail"); // huh?
	}

    receive() external payable { } // see note in the HW description

}