// SPDX-License-Identifier: GPL-3.0-or-later

// This file is part of the http://github.com/aaronbloomfield/ccc repository,
// and is released under the GPL 3.0 license.

pragma solidity ^0.8.16;

import "./TokenCC.sol";
import "./TokenDEX.sol";
import "./EtherPricerConstant.sol";

contract Arbitrage {

    mapping (uint => address payable) public dexes;
    uint public num_dexes;
    address public tokencc;
    address deployer;
    address public etherpricer;
    
    constructor() {
        deployer = msg.sender;
        tokencc = address(new TokenCC());
        etherpricer = address(new EtherPricerConstant());
    }

    // creates the DEXes and the TokenCC, and sends the ETH and TC; to avoid
    // this using too high gas, it can be called multiple times, each time
    // adding more DEXes
    function setup(uint numdex, uint amt_eth, uint amt_tc) public payable {
        require (msg.value > numdex * amt_eth * 1 ether, "Must supply enough eth");
        // create and fund the DEXes
        for ( uint i = num_dexes; i < num_dexes+numdex; i++ ) {
            dexes[i] = payable(address(new TokenDEX()));
            TokenCC(tokencc).approve(dexes[i],amt_tc * 10**TokenCC(tokencc).decimals());
            TokenDEX(dexes[i]).createPool{value: amt_eth * 1 ether}(amt_tc * 10**TokenCC(tokencc).decimals(), 
                                     3, 1000, tokencc, etherpricer);
        }
        num_dexes += numdex;
    }

    // this performs a few transactions on the DEXes; it's not done as part of
    // setup() due to gas costs; must have created 5 DEXes else this will revert
    function configureDEXes() public payable {
        require (msg.value > 10 ether, "Must supply enough eth");
        // excahnge with the DEXes
        uint balance = TokenCC(tokencc).balanceOf(address(this));
        TokenDEX(dexes[1]).exchangeEtherForToken{value: 1 ether}();
        TokenDEX(dexes[2]).exchangeEtherForToken{value: 2 ether}();
        TokenDEX(dexes[3]).exchangeEtherForToken{value: 3 ether}();
        TokenDEX(dexes[4]).exchangeEtherForToken{value: 4 ether}();
        // give the sender the TC obtained
        uint xferamt = TokenCC(tokencc).balanceOf(address(this)) - balance;
        TokenCC(tokencc).transfer(msg.sender,xferamt);
    }

    // this will give some TC to the deployer, since this contract owns the
    // TokenCC contract
    function getTC(uint amt) public {
        require(deployer == msg.sender, "Only the deployer can call this");
        TokenCC(tokencc).transfer(msg.sender,amt*10**TokenCC(tokencc).decimals());
    }

    // this allows this contract to receive a payment
    receive() external payable { }

}
