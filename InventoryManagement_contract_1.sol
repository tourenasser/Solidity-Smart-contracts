// This contract is on inventory management
 

// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract InventoryManagement {
    address owner;
    
    // Keep track of all the addresses that are authorized to make changes to the inventory.
    mapping (address => bool) authenticatedUsers;
    
    // Store the name and quantity of an item in the inventory
    struct Item {
        string name;
        uint256 quantity;
    }

    // Store all the items in the inventory using the item name as the key
    mapping (string => Item) inventory;

    // Set the owner of the contract to the address that deployed it and adds the owner to the authenticatedUsers mapping.
    constructor() public {
        owner = msg.sender;
        authenticatedUsers[owner] = true;
    }
    
    // Allow only the owner of the contract to execute a function.
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Allow only authenticated users to execute a function.
    modifier onlyAuthenticated() {
        require(authenticatedUsers[msg.sender] == true);
        _;
    }

    // Add a new user to the authenticatedUsers mapping.
    function addUser(address _user) public onlyOwner {
        authenticatedUsers[_user] = true;
    }

    // Remove a user from the authenticatedUsers mapping.
    function removeUser(address _user) public onlyOwner {
        authenticatedUsers[_user] = false;
    }

    // Add a new item to the inventory or increases the quantity of an existing item.
    function addInventory(string _name, uint _quantity) public onlyAuthenticated {
        require(_quantity > 0);
        inventory[_name].name = _name;
        inventory[_name].quantity += _quantity;
    }

    // Remove a certain quantity of an existing item from the inventory.
    function removeInventory(string _name, uint _quantity) public onlyAuthenticated {
        require(_quantity > 0);
        require(_quantity <= inventory[_name].quantity);
        inventory[_name].quantity -= _quantity;
    }

    // Allow anyone to view the name and quantity of an item in the inventory.
    function checkInventory(string _name) public view returns (string, uint) {
        return (inventory[_name].name, inventory[_name].quantity);
    }
}

