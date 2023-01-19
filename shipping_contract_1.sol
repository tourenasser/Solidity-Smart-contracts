/**
 * This smart contract allows creating new products, updating their condition and shipping the products. 
 * It has a struct called 'Product' which contains product details like id, name, origin and condition. 
 * Also, there is a mapping from product id to product struct. 
 * It also have some events like ProductCreated, ProductUpdated for emitting events when some action is performed on the products.
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;


contract productSupChain {
    
   // Create a product struct
    struct Product {
        uint256 id;
        string name;
        string origin;
        string condition;
    }

    // Mapping from product id to product struct
    mapping(uint256 => Product) public products;

    // Events
    event ProductCreated(uint256 id, string name, string origin);
    event ProductUpdated(uint256 id, string condition);

    // Create a new product
    function createProduct(string memory name, string memory origin) public {
        uint256 id = products.length + 1;
        products[id] = Product(id, name, origin, "created");
        emit ProductCreated(id, name, origin);
    }

    // Update a product's condition
    function updateProduct(uint256 id, string memory condition) public {
        require(products[id].condition != "shipped", "The Product is already shipped");
        products[id].condition = condition;
        emit ProductUpdated(id, condition);
    }

    // Ship a product
    function shipProduct(uint256 id) public {
        require(products[id].condition != "shipped", "Product already shipped");
        products[id].condition = "shipped";
        emit ProductUpdated(id, "shipped");
    }
}