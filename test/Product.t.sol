// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Product} from "../src/Product.sol";

contract ProductTest is Test {
    Product product;
    address user1 = address(0xAAA);

    function setUp() public {
        product = new Product();
    }

    function test_AddProduct() public {
        vm.startPrank(user1);
        product.addProduct("B12312312", 1);

        uint256[] memory productsList = product.getProducts("B12312312");
        assertEq(productsList.length, 1);
        assertEq(productsList[0], 1);
    }

    function test_RevertIfVatNumberIsEmpty() public {
        vm.startPrank(user1);
        vm.expectRevert("Company VAT number cannot be empty");
        product.addProduct("", 1);
    }

    function test_RevertIfProductIdIsZero() public {
        vm.startPrank(user1);
        vm.expectRevert("Product ID must be greater than zero");
        product.addProduct("B12312312", 0);
    }

    function test_GetProductsForUnregisteredVatNumber() public {
        vm.prank(user1);
        uint256[] memory productsList = product.getProducts("B12312312");
        assertEq(productsList.length, 0);
    }

    function test_GetProducts () public {
        vm.startPrank(user1);
        product.addProduct("B12312312", 1);
        product.addProduct("B12312312", 2);

        uint256[] memory productsList = product.getProducts("B12312312");
        assertEq(productsList.length, 2);
        assertEq(productsList[0], 1);
        assertEq(productsList[1], 2);
    }

    function test_GetProductsEmpty() public {
        vm.startPrank(user1);
        uint256[] memory productsList = product.getProducts("B12312312");
        assertEq(productsList.length, 0);
    }
}
