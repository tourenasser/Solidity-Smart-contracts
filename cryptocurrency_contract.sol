/**
This is a basic Solidity smart contract for a cryptocurrency. It allows users to deposit, withdraw and transfer funds. 
The contract maintains a mapping of addresses to balances, and emits a Transfer event on every transaction. 
The contract use the latest version of solidity and has a require statement to check 
the balance of the user before allowing them to withdraw or transfer funds.
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.9;

contract CryptoCurrency {
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Transfer(address(0), msg.sender, msg.value);
    }

    function withdraw(uint256 value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        msg.sender.transfer(value);
        emit Transfer(msg.sender, address(0), value);
    }

    function transfer(address recipient, uint256 value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        balances[recipient] += value;
        emit Transfer(msg.sender, recipient, value);
    }
}