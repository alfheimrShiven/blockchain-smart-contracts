// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // type
     struct People {
        uint256 favoriteNumber;
        string name   ; 
    }

    // variables
    uint256 public favoriteNumber;
    People[] public people;


    mapping(string => uint256) public nameToFavoriteNumber;

    //functions 

    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }

    // view function
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    // pure function
    // function calc() public pure returns(uint256) {
    //     return (2+3);
    // }

    // memory(temp), calldata(temp), storage(permanent)
    function addPeople(uint256 _favoriteNumber, string memory _name) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }   
} 

// 0xd9145CCE52D386f254917e481eB44e9943F39138