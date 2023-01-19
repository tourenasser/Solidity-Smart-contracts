/**
 * This contract allows for the management of an inventory by authorized users. 
 * The owner of the contract can add or remove users from the list of authorized users. 
 * Authorized users can add, update, or remove items from the inventory, 
 * as well as view the entire inventory. The inventory is stored as a mapping
 

// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract InventoryManagement {
    // Store the owner of the contract
    address public owner;

    // Store the inventory items
    mapping (address => Item[]) public inventory;

    // Store the users who have access to the inventory
    mapping (address => bool) public users;

    // Struct to store information about an item in the inventory
    struct Item {
        string name;
        uint quantity;
    }

    constructor() public {
        // Set the owner of the contract to the address that deployed it
        owner = msg.sender;
    }

    // Function to add a user to the list of authorized users
    function addUser(address _user) public {
        require(msg.sender == owner, "Only the owner can add users.");
        users[_user] = true;
    }

    // Function to remove a user from the list of authorized users
    function removeUser(address _user) public {
        require(msg.sender == owner, "Only the owner can remove users.");
        require(users[_user] == true, "User is not an authorized user.");
        users[_user] = false;
    }

    // Function to add an item to the inventory
    function addItem(string memory _name, uint256 _quantity) public {
        require(users[msg.sender] == true, "Unauthorized user.");
        Item memory newItem = Item(_name, _quantity);
        inventory[msg.sender].push(newItem);
    }

    // Function to update the quantity of an item in the inventory
    function updateItem(string memory _name, uint256 _quantity) public {
        require(users[msg.sender] == true, "Unauthorized user.");
        for (uint i = 0; i < inventory[msg.sender].length; i++) {
            if (inventory[msg.sender][i].name == _name) {
                inventory[msg.sender][i].quantity = _quantity;
                return;
            }
        }

        // If the item does not exist, add it to the inventory
        addItem(_name, _quantity);
    }

    // Function to remove an item from the inventory
    function removeItem(string memory _name) public {
        require(users[msg.sender] == true, "Unauthorized user.");
        for (uint i = 0; i < inventory[msg.sender].length; i++) {
            if (inventory[msg.sender][i].name == _name) {
                delete inventory[msg.sender][i];
                return;
            }
        }

        // If the item does not exist, do nothing
    }

    // Function to view the entire inventory
    function viewInventory() public view returns (Item[] memory) {
        require(users[msg.sender] == true, "Unauthorized user.");
        return inventory[msg.sender];
    }
}
