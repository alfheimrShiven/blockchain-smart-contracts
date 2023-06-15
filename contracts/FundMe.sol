// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 minUSD;
    AggregatorV3Interface internal priceFeed;

    constructor(){
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        minUSD = 50;
    }

    function fund() public payable {
        require(msg.value >= minUSD, "Didn't send enough!!");   
    }

    function getVersion() public view returns(uint256) {
        return priceFeed.version();
    }

    // function withdraw() {}
}