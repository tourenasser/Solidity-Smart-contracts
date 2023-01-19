/**
 * This smart contract if related to products supply chain. 
 * It defines a Product struct that contains the owner, name, price, and quantity of a product. 
 * It also has a mapping from product ID to product struct, a product ID counter and a few functions to create and purchase a product.
 * The contract has a function createProduct that allows the user to create a new product, this function takes three arguments _name, _price, _quantity.
 * A purchaseProduct function that allows the user to purchase a product by providing its ID as an argument, this function checks 
 * if the product exists, if the product is still available and if the msg.value is greater than or equal to the product price.
 * Once the user pass all the check, the smart contract will transfer the funds to the owner, decrement the quantity of the product.
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";

contract supplyProducts {
    
    using Counters for counters.counter;    

    // Product struct
    struct Product {
        address owner;
        string name;
        uint256 price;
        uint256 quantity;
    }

    // Mapping from product ID to product struct
    mapping(uint256 => Product) public products;

    // Product ID counter
    uint256 public productCounter;

    // Create a new product
    function createProduct(string memory _name, uint256 _price, uint256 _quantity) public {
        // Increment product ID counter
        productCounter++;
        // Create new product with current ID
        products[productCounter] = Product(msg.sender, _name, _price, _quantity);
    }

    // Purchase a product
    function purchaseProduct(uint256 _productId) public payable {
        // Get the product struct
        Product storage product = products[_productId];
        // Check if product exists
        require(_productId <= productCounter);
        // Check if the product is still available
        require(product.quantity > 0);
        // Check if the msg.value is greater than or equal to the product price
        require(msg.value >= product.price);
        // Transfer funds to the owner
        product.owner.transfer(msg.value);
        // Decrement the quantity of the product
        product.quantity--;
    }
}
