// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Company} from "../src/Company.sol";

contract CompanyTest is Test {
    Company company;
    address user1 = address(0xAAA);

    function setUp() public {
        company = new Company();
    }

    function test_RegisterCompany() public {
        vm.startPrank(user1);
        company.registerCompany("B12312312");

        string[] memory companies = company.getCompanies();
        assertEq(companies.length, 1);
        assertEq(companies[0], "B12312312");
    }


    function test_RevertIfNameIsEmpty() public {
        vm.startPrank(user1);
        vm.expectRevert("VAT number cannot be empty");
        company.registerCompany("");
    }

    function test_GetEmptyNameForUnregisteredAddress() public {
        vm.prank(user1);
        string[] memory companies = company.getCompanies();
        assertEq(companies.length, 0);
    }

    function test_EmitEventOnRegister() public {
        vm.expectEmit(true, false, false, true);
        emit Company.CompanyRegistered(user1, "B12312312");

        vm.prank(user1);
        company.registerCompany("B12312312");
    }

    function test_GetCompanyByOwner() public {
        vm.startPrank(user1);
        company.registerCompany("B12312312");

        string[] memory companies = company.getCompanies();
        assertEq(companies.length, 1);
        assertEq(companies[0], "B12312312");
    }

    function test_GetEmptyCompanies() public {
        vm.startPrank(user1);
        string[] memory companies = company.getCompanies();
        assertEq(companies.length, 0);
    }
}