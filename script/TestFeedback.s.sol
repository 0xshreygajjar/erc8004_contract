// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.20;

// import "forge-std/Script.sol";
// import "../src/ReputationRegistry.sol";
// import "../src/IIdentityRegistry.sol";

// contract GiveFeedbackScript is Script {

//     // --------------------------------------------------
//     // 🔧 UPDATE THESE BEFORE RUNNING
//     // --------------------------------------------------
//     address constant IDENTITY_REGISTRY    = 0x5f63c5784DFE968f06d5e6ba16cB6018163827Be;
//     address constant REPUTATION_REGISTRY = 0xB5e54dAA8C8a7B99C59923cD26E1Afc2927F5342;
//     uint256 constant AGENT_ID            = 1;

//     // Signer that signs FeedbackAuth (must be agent owner or approved operator)
//     uint256 constant AUTH_SIGNER_PRIVATE_KEY = 0xYourPrivateKeyForSigner;

//     // Sender that submits giveFeedback() transaction
//     uint256 constant TX_SENDER_PRIVATE_KEY   = 0xYourPrivateKeyForClient;
//     // --------------------------------------------------


//     function run() external {

//         // --------------------------------------------------
//         // Load accounts
//         // --------------------------------------------------
//         address authSigner = vm.addr(AUTH_SIGNER_PRIVATE_KEY);
//         address txSender   = vm.addr(TX_SENDER_PRIVATE_KEY);

//         console2.log("Auth Signer (must be agent owner):", authSigner);
//         console2.log("Client (tx sender):", txSender);

//         // --------------------------------------------------
//         // Start broadcast as tx sender
//         // --------------------------------------------------
//         vm.startBroadcast(TX_SENDER_PRIVATE_KEY);

//         ReputationRegistry registry = ReputationRegistry(REPUTATION_REGISTRY);

//         // --------------------------------------------------
//         // Prepare FeedbackAuth
//         // --------------------------------------------------
//         uint64 indexLimit = 10;
//         uint256 expiry    = block.timestamp + 1 hours;

//         // encode struct
//         bytes memory encodedStruct = abi.encode(
//             AGENT_ID,
//             txSender,
//             indexLimit,
//             expiry,
//             block.chainid,
//             IDENTITY_REGISTRY,
//             authSigner
//         );

//         // sign encoded struct
//         bytes32 messageHash = keccak256(encodedStruct).toEthSignedMessageHash();
//         (uint8 v, bytes32 r, bytes32 s) = vm.sign(AUTH_SIGNER_PRIVATE_KEY, messageHash);
//         bytes memory signature = abi.encodePacked(r, s, v);

//         // final calldata payload
//         bytes memory feedbackAuth = bytes.concat(encodedStruct, signature);

//         // --------------------------------------------------
//         // Feedback payload
//         // --------------------------------------------------
//         uint8 score = 90;
//         bytes32 tag1 = keccak256("TEST");
//         bytes32 tag2 = keccak256("FLOW");
//         string memory feedbackUri = "ipfs://hello-feedback";
//         bytes32 feedbackHash = keccak256("feedback-hash-test");

//         // --------------------------------------------------
//         // Execute giveFeedback
//         // --------------------------------------------------
//         registry.giveFeedback(
//             AGENT_ID,
//             score,
//             tag1,
//             tag2,
//             feedbackUri,
//             feedbackHash,
//             feedbackAuth
//         );

//         console2.log("✔ giveFeedback() executed successfully on Base Sepolia");

//         vm.stopBroadcast();
//     }
// }
