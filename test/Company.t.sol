// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CompanyRegistry} from "../src/Company.sol";

contract CompanyTest is Test {
    CompanyRegistry private companyRegistry;

    function setUp() public {
        companyRegistry = new CompanyRegistry();
    }

    function testCreateCompany() public {
        string memory companyName = "TestCompany";
        companyRegistry.createCompany(companyName);

        (string memory retrievedName, address owner) = companyRegistry.getCompany(0);
        assertEq(retrievedName, companyName);
        assertEq(owner, address(this));
    }

    function testGetNonExistentCompany() public {
        vm.expectRevert("Company does not exist");
        companyRegistry.getCompany(1);
    }
    
}