// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 minUSD;
    AggregatorV3Interface internal priceFeed;

    constructor(){
        /**
        * Network: Sepolia
        * Data Feed: ETH/USD (contract address to get value of ETH in USD)
        * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        */
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        minUSD = 5e18;
    }

    function fund() public payable {
        require(getConversionRate(msg.value) >= minUSD, "Didn't send enough!!");   
    }

    function getVersion() public view returns(uint256) {
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        // We need: Address of the contract, ABI (Interface) 
        (,int256 ethInUSD,,,) = priceFeed.latestRoundData();
        return uint256(ethInUSD * 1e10); // converting eth in wei
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint ethAmountInUSD = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUSD;
    }


    // function withdraw() {}
}