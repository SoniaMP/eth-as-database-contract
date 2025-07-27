// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CompanyRegistry {
    struct Company {
        uint256 id;
        string vatNumber;
        string name;
        address owner;
    }

    uint256 private nextId = 0;
    mapping(uint256 => Company) private companies;

    event CompanyCreated(string vatNumber, string name, address owner);
    event CompanyUpdated(uint256 indexed id, string name);

    modifier onlyCompanyOwner(uint256 _id) {
        require(
            companies[_id].owner == msg.sender,
            "Not authorized: Only the company owner can call this function"
        );
        _;
    }

    function createCompany(
        string memory _vatNumber,
        string memory _name,
        address _owner
    ) public {
        require(bytes(_name).length > 0, "Company name cannot be empty");

        companies[nextId] = Company({
            id: nextId,
            vatNumber: _vatNumber,
            name: _name,
            owner: _owner
        });

        emit CompanyCreated(_vatNumber, _name, _owner);
        nextId++;
    }

    function getCompany(
        uint256 _id
    ) public view returns (string memory, string memory, address) {
        Company storage company = companies[_id];
        return (company.vatNumber, company.name, company.owner);
    }

    function updateCompany(
        uint256 _id,
        string memory _newName
    ) public onlyCompanyOwner(_id) {
        require(bytes(_newName).length > 0, "Company name cannot be empty");

        Company storage company = companies[_id];
        company.name = _newName;

        emit CompanyUpdated(_id, _newName);
    }

    function deleteCompany(uint256 _id) public onlyCompanyOwner(_id) {
        Company storage company = companies[_id];
        require(company.owner != address(0), "Company does not exist");

        Company storage companyToDelete = companies[_id];
        companyToDelete.vatNumber = "";
        companyToDelete.name = "";
        companyToDelete.owner = address(0);

        emit CompanyUpdated(_id, "");
    }
}
