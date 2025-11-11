// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {IdentityRegistry} from "../src/IdentityRegistry.sol";
import {ReputationRegistry} from "../src/ReputationRegistry.sol";
import {ValidationRegistry} from "../src/ValidationRegistry.sol";

// forge script script/DeployContract.s.sol \
//   --rpc-url $BASE_SEPOLIA_RPC_URL \
//   --broadcast \
//   --verify \
//   --etherscan-api-key $ETHERSCAN_API_KEY \
//   --private-key $PRIVATE_KEY --broadcast

contract DeployAndVerifyScript is Script {
    function run() external {
        vm.startBroadcast();

        IdentityRegistry identityRegistry = new IdentityRegistry();
        ReputationRegistry reputationRegistry = new ReputationRegistry(address(identityRegistry));
        ValidationRegistry validationRegistry = new ValidationRegistry(address(identityRegistry));

        vm.stopBroadcast();

        console2.log("IdentityRegistry:", address(identityRegistry));
        console2.log("ReputationRegistry:", address(reputationRegistry));
        console2.log("ValidationRegistry:", address(validationRegistry));
    }
}
