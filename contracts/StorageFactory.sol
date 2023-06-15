// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _singleStorageIndex, uint256 _singleStorageNo) public {
        simpleStorageArray[_singleStorageIndex].store(_singleStorageNo);
        
    }

    function sfGet(uint256 _singleStorageIndex) view public returns(uint256){
        return simpleStorageArray[_singleStorageIndex].retrieve();
    }   
}
