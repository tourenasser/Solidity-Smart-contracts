/**
 * This contract creates a cryptocurrency with the following features:
 * The owner of the contract is the address that deploys it.
 * The contract has a mapping called "balanceOf" that tracks the balance of each address.
 * The contract has a constructor function that is executed when the contract is deployed. This function sets the owner of the contract to the address that deployed it and gives that address a balance of 10000 units of the cryptocurrency.
 * The contract has a "transfer" function that allows the caller to transfer a specified number of units of the cryptocurrency to another address. This function checks that the caller has enough balance to make the transfer and that the transfer amount is greater than zero.
 * The contract has a "getBalance" function that allows the caller to check their own balance.
 * The contract has a "mint" function that allows the owner to mint new units of the cryptocurrency and add them to their own balance.
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.9;

pragma solidity ^0.8.0;

contract Coin {
    address public owner;
    mapping(address => uint) public balanceOf;

    constructor() public {
        owner = msg.sender;
        balanceOf[msg.sender] = 10000;
    }

    function transfer(address payable _to, uint _value) public {
        require(balanceOf[msg.sender] >= _value && _value > 0);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    function getBalance() public view returns (uint) {
        return balanceOf[msg.sender];
    }

    function mint(uint _value) public {
        require(msg.sender == owner);
        balanceOf[msg.sender] += _value;
    }
}