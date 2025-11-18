// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/ReputationRegistry.sol";
import "../src/IdentityRegistry.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract ReputationRegistryTest is Test {
    IdentityRegistry idRegistry;
    ReputationRegistry repRegistry;

    address owner;
    uint userPK = 0x8b3a350cf5c34c9194ca85829a2df0ec3153be0318b5e2d3348e872092edffba; // random test user
    address user = vm.addr(userPK);
    uint256 agentId;

    function setUp() public {
        // 1. Deploy Identity Registry
        idRegistry = new IdentityRegistry();

        // Set owner (anvil default account 0)
        owner = vm.addr(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );

        // 2. Register owner as identity/agent
        vm.prank(owner);
        uint agentId = idRegistry.register();

        console.log("agentId",agentId);

        agentId = 0; // IdentityRegistry auto-assigned = 1

        // 3. Deploy ReputationRegistry
        repRegistry = new ReputationRegistry(address(idRegistry));
    }

    function testGiveFeedback() public {
        vm.deal(user, 1 ether);
        vm.startPrank(user);

        uint8 score = 88;
        bytes32 tag1 = keccak256("service");
        bytes32 tag2 = keccak256("quality");
        string memory feedbackUri = "ipfs://feedback_123";
        bytes32 feedbackHash = keccak256("my feedback hash");

        // ---------- BUILD FEEDBACK AUTH ----------
        uint64 indexLimit = 10;
        uint256 expiry = block.timestamp + 1 days;

        bytes memory encoded = abi.encode(
            agentId,
            user,
            indexLimit,
            expiry,
            block.chainid,
            address(idRegistry),
            user
        );

        // HASH -> SIGN
        bytes32 messageHash = MessageHashUtils.toEthSignedMessageHash(
            keccak256(encoded)
        );

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPK, messageHash);
        bytes memory signature = abi.encodePacked(r, s, v);

        // final payload = 224 bytes struct + signature
        bytes memory feedbackAuth = bytes.concat(encoded, signature);

        // ---------- CALL giveFeedback ----------
        repRegistry.giveFeedback(
            agentId,
            score,
            tag1,
            tag2,
            feedbackUri,
            feedbackHash,
            feedbackAuth
        );

        vm.stopPrank();

        // ---------- ASSERT ----------
        (uint8 storedScore, bytes32 storedTag1, , bool revoked) = repRegistry
            .readFeedback(agentId, user, 1);

        assertEq(storedScore, score);
        assertEq(storedTag1, tag1);
        assertEq(revoked, false);
    }
}
