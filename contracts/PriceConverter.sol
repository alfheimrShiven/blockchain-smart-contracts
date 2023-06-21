// SPDX-License-Indentifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    
    function getPrice() internal view returns(uint256){
        // We need: Address of the contract, ABI (Interface) 
        (,int256 ethInUSD,,,) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        return uint256(ethInUSD * 1e10); // converting usd value coming with 8dp in wei
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint ethAmountInUSD = (ethAmount * ethPrice) / 1e18; // converting back to wei
        return ethAmountInUSD;
    }
}