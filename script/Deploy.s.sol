// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Company.sol";
import "../src/Product.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        Company company = new Company();
        Product product = new Product();

        console.log("DEPLOYED_COMPANY:%s", address(company));
        console.log("DEPLOYED_PRODUCT:%s", address(product));

        vm.stopBroadcast();
    }
}
