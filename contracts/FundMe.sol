// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
error WithdrawError();
error InsufficientAmt();


// gas to deploy: 788,292
// gas to deploy after using Constant & Immutable keywords: 777,569
// gas to deploy after replacing `revert` with `if + revert + error`: 698,209 😮 That's a huge drop! 
contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD=5e18; // 5 * 10^18 ;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; // funder & amountFunded are used to give more context to both sides of the mapping (they are not variables)
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        if(msg.value.getConversionRate() <= MINIMUM_USD) {
            revert InsufficientAmt();
        }    
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
        
        for(uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++) {
            address funder = funders[fundersIndex];
            addressToAmountFunded[funder] = 0;
        }

        // resetting the funders array
        funders = new address[](0);

        // withdraw funds
        // Method 1: using transfer
            /* payable(msg.sender).transfer(address(this).balance); */
        // Method 2: using send
            /*  bool didSend = payable(msg.sender).send(address(this).balance);
                require(didSend, "Withdraw was not successful"); */

        // Method 3: using call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        if(!callSuccess) {
            revert WithdrawError();
        }
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    modifier onlyOwner() {
        if(msg.sender != i_owner) {
            revert NotOwner();
        } 
        _;
    }
}