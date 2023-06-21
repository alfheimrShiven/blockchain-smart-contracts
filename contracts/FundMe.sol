// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 minUSD=5e18; // 5 * 10^18 ;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; // funder & amountFunded are used to give more context to both sides of the mapping (they are not variables)


    function fund() public payable {
        require(msg.value.getConversionRate() >= minUSD, "Didn't send enough!!");   
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
    // function withdraw() {}
}