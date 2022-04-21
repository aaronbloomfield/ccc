// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

import "./TokenCC.sol";
import "./TokenDEX.sol";
import "./EtherPricerConstant.sol";

contract Arbitrage {

    mapping (uint => address) public dexes;
    uint public num_dexes;
    address public tokencc;
    address deployer;
    address public etherpricer;
    
    constructor() {
        deployer = msg.sender;
    }

    // creates the DEXes and the TokenCC, and sends the ETH and TC
    function setup(uint numdex, uint amt_eth, uint amt_tc) public payable {
        require (msg.value > numdex * amt_eth * 1 ether, "Must supply enough eth");
        tokencc = address(new TokenCC());
        num_dexes = numdex;
        etherpricer = address(new EtherPricerConstant());
        // create and fund the DEXes
        for ( uint i = 0; i < num_dexes; i++ ) {
            if ( dexes[i] == address(0) )
                dexes[i] = address(new TokenDEX());
            else
                revert();
            TokenCC(tokencc).approve(dexes[i],amt_tc * 10**TokenCC(tokencc).decimals());
            TokenDEX(dexes[i]).createPool{value: amt_eth * 1 ether}(amt_tc * 10**TokenCC(tokencc).decimals(), 
                                     3, 1000, tokencc, etherpricer);
        }
    }

    // this performs a few transactions on the DEXes; it's not done as part of
    // setup() due to gas costs
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
