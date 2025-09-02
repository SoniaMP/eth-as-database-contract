// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Company {
    mapping(address => string[]) private companies;

    event CompanyRegistered(address indexed owner, string vatNumber);

    function registerCompany(string memory _vatNumber) public {
        require(bytes(_vatNumber).length > 0, "VAT number cannot be empty");

        string[] storage vatNumbers = companies[msg.sender];
        for (uint i = 0; i < vatNumbers.length; i++) {
            if (
                keccak256(bytes(vatNumbers[i])) == keccak256(bytes(_vatNumber))
            ) {
                revert("Company VAT number already registered");
            }
        }
        vatNumbers.push(_vatNumber);

        emit CompanyRegistered(msg.sender, _vatNumber);
    }

    function getCompanies() public view returns (string[] memory) {
        return
            companies[msg.sender].length > 0
                ? companies[msg.sender]
                : new string[](0);
    }
}
