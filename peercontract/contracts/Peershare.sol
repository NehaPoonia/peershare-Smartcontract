// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ECDSA.sol";

contract Peershare {

  // Store the signature of the car owner
  // [CarHash => OwnerSignature]
  mapping(bytes32 => bytes) ownerSignature;

  // Store the signature of the car borrower
  // [CarHash => BorrowerSignature]
  mapping(bytes32 => bytes) borrowerSignature;

  /// Add new block on when car is added
  /// @param  carHash   Unique hash code for the car
  /// @param  signature Signature that was signed by the owner of the car
  /// @return  True if success, else throw error 
  function addCar(bytes32 carHash, bytes memory signature) public returns (bool) {

    // Get signer from signature
    address signer = ECDSA.recover(
      ECDSA.toEthSignedMessageHash(
        keccak256(abi.encodePacked(carHash, msg.sender))
      ), signature
    );

    // Verify if the sender is the owner
    require(
      signer == msg.sender,
      "Unauthorised Signer"
    );

    // Add owner's signature
    ownerSignature[carHash] = signature;

    return true;

  }
}