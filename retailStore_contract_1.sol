/**
 * This smart contract allows for a retail store to manage products, customer balances, and store employees. 
 * The store owner is able to add products to the store, add and remove employees, and check employee and customer balances. 
 * Customers are able to buy products by spending their credit and check their own balance. 
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract manageRetailStore is Ownable {

    address owner;
    mapping (address => uint256) public customerBalances;
    mapping (address => bool) public isStoreEmployee;
    
    Product[] public products;
    address[] public storeEmployees;

    struct Product {
        uint256 id;
        string name;
        uint256 quantity;
        uint256 price;
    }

    constructor() public {
        owner = msg.sender;
    }

    function addProduct(string memory _name, uint256 _quantity, uint256 _price) external onlyOwner {
        require(isStoreEmployee[msg.sender], "Access denied: Only store employees can add products. Thanks");
        products.push(Product(products.length + 1, _name, _quantity, _price));
    }

    function buyProduct(uint256 _productId, uint256 _quantity) public payable {
        require(customerBalances[msg.sender] >= _quantity * products[_productId].price, "Insufficient funds.");
        require(products[_productId].quantity >= _quantity, "The product is out of stock.");
        
	products[_productId].quantity -= _quantity;
        customerBalances[msg.sender] -= _quantity * products[_productId].price;
        msg.sender.transfer(_quantity * products[_productId].price);
    }

    function addEmployee(address _employee) external onlyOwner {
        require(msg.sender == owner, "Access denied: Only the owner can add employees.");
        isStoreEmployee[_employee] = true;
        storeEmployees.push(_employee);
    }

    function removeEmployee(address _employee) external onlyOwner {
        require(msg.sender == owner, "Access denied: Only the owner can remove employees.");
        isStoreEmployee[_employee] = false;
    }
}
