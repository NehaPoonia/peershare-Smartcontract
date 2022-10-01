// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ECDSA.sol";

// smart contract to add new user, new cars and any ride on the blockchain
contract Peershare {
    mapping(string => string) userSignature;

    function addUser(string calldata userHash, string memory signature)
        public
        returns (string memory)
    {
        // Verify if the user is unique in blockchain
        if (bytes(userSignature[userHash]).length > 0) {
            //console.log(userSignature[userHash]);
            //user already exists
            return string("user already exists");
        }

        // Add user signature
        userSignature[userHash] = signature;

        return string("new user added");
    }

    // TODO: add new car to blockchain
}
