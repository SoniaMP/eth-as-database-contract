// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Product {
    mapping(address => mapping(string => uint256[])) private products;

    event ProductAdded(address indexed owner, string vatNumber, uint256 productId);

    function addProduct(string memory _vatNumber, uint256 productId) public {
        require(bytes(_vatNumber).length > 0, "Company VAT number cannot be empty");
        require(productId > 0, "Product ID must be greater than zero");

        products[msg.sender][_vatNumber].push(productId);
        emit ProductAdded(msg.sender, _vatNumber, productId);
    }

    function getProducts(string memory _vatNumber) public view returns (uint256[] memory) {
        return products[msg.sender][_vatNumber];
    }
}
