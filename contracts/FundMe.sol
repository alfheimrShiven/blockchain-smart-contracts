// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minUSD=5e18; // 5 * 10^18 ;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; // funder & amountFunded are used to give more context to both sides of the mapping (they are not variables)
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= minUSD, "Didn't send enough!!");   
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
        // resetting the addressToAmountFunded mapping
        for(uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++) {
            address funder = funders[fundersIndex];
            addressToAmountFunded[funder] = 0;
        }

        // resetting the funders array
        funders = new address[](0);

        // withdraw funds
        // Method 1: transfer
            /* payable(msg.sender).transfer(address(this).balance); */
        // Method 2: send
            /*  bool didSend = payable(msg.sender).send(address(this).balance);
                require(didSend, "Withdraw was not successful"); */

        // Method 3: call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdraw was not successful");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can withdraw!");
        _;
    }
}