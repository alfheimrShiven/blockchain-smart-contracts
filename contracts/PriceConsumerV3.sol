// SPDX-License-Indentifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
 * Network: Sepolia
 * Data Feed: ETH/USD
 * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
 */

    constructor(){
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function getLatestPrice() public view returns(int256) {
       (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    ) = priceFeed.latestRoundData();

    return answer;
    }

    function getDecimals() public view returns(uint8){
        uint8 decimalPlaces = priceFeed.decimals();
        return decimalPlaces;
    }
}

