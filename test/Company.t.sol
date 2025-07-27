// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CompanyRegistry} from "../src/Company.sol";

contract CompanyTest is Test {
    CompanyRegistry company;
    address companyOwner = address(0xAAA);
    address attacker = address(0xCCC);

    function setUp() public {
        company = new CompanyRegistry();
    }

    function test_CreateCompany() public {
        company.createCompany("vat123", "TestCompany", companyOwner);

        (string memory vatNumber, string memory name, address owner) = company
            .getCompany(0);

        assertEq(vatNumber, "vat123");
        assertEq(name, "TestCompany");
        assertEq(owner, companyOwner);
    }

    function test_UpdateCompany_ByCompanyOwner() public {
        company.createCompany("vat123", "TestCompany", companyOwner);

        vm.prank(companyOwner);
        company.updateCompany(0, "UpdatedCompany");

        (, string memory name, ) = company.getCompany(0);
        assertEq(name, "UpdatedCompany");
    }

    function test_Revert_UpdateCompany_ByAttacker() public {
        company.createCompany("vat123", "TestCompany", companyOwner);

        vm.expectRevert(
            "Not authorized: Only the company owner can call this function"
        );
        vm.prank(attacker);
        company.updateCompany(0, "HackedCompany");
    }

    function test_DeleteCompany_ByCompanyOwner() public {
        company.createCompany("vat123", "TestCompany", companyOwner);

        vm.prank(companyOwner);
        company.deleteCompany(0);

        (, string memory name, address owner) = company.getCompany(0);

        assertEq(name, "");
        assertEq(owner, address(0));
    }
}
