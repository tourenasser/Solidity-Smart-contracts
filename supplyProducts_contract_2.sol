/**
 * This is a basic example of a Supply Chain smart contract using the Solidity programming language. 
 * This contract allows for the creation, transfer, and viewing of items on the supply chain using a mapping to store the 
 * items and an array to keep track of the item IDs. 
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract SupplyGoods {

    struct Item {
        string name;
        uint quantity;
        address owner;
    }

    mapping (bytes32 => Item) items;
    bytes32[] itemIds;

    function addItem(bytes32 _id, string memory _name, uint _quantity) public {
        require(msg.sender == owner);
        Item memory newItem = Item({
            name: _name,
            quantity: _quantity,
            owner: msg.sender
        });
        items[_id] = newItem;
        itemIds.push(_id);
    }

    function transferItem(bytes32 _id, address _to) public {
        require(msg.sender == items[_id].owner);
        Item memory item = items[_id];
        item.owner = _to;
        items[_id] = item;
    }

    function viewItem(bytes32 _id) public view returns (string memory, uint, address) {
        Item memory item = items[_id];
        return (item.name, item.quantity, item.owner);
    }
}
