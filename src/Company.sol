// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CompanyRegistry {
    struct Company {
        uint256 id;
        string hashName;
        address owner;
    }
    uint256 private nextId = 0;
    mapping(uint256 => Company) private companies;

    event CompanyCreated(string hashName, address owner);

    function createCompany(string memory _hashName) public {
        require(bytes(_hashName).length > 0, "Company name cannot be empty");

        companies[nextId] = Company({
            id: nextId,
            hashName: _hashName,
            owner: msg.sender
        });

        emit CompanyCreated(_hashName, msg.sender);
        nextId++;
    }

    function getCompany(uint256 _id) public view returns (string memory, address) {
        Company storage company = companies[_id];
        require(company.owner != address(0), "Company does not exist");
        return (company.hashName, company.owner);
    }
}
