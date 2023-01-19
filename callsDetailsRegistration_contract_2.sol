
// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract mobileCallsRegistry is ERC721 {

  // mapping of call details to token ID
  mapping(uint256 => CallDetails) private callDetails;
  // struct to store call details
  struct CallDetails {
    address caller; 
    address callee;
    uint256 callDuration;
    uint256 callTimestamp;
  }

  // event to emit when a new call is registered
    event newCallRegistered(address caller, address callee, uint256 callDuration, uint256 callTimestamp);

  // function to register a new call
  function registerCall(address _caller, address _callee, uint256 _callDuration) public {
    require(_caller != address(0) && _callee != address(0), "Invalid caller or wrong callee address.");
    require(_callDuration > 0, "Call duration must be greater than 0 seconde.");

    // generate a new token ID for the call
    uint256 tokenId = totalSupply() + 1;

    // add the call details to the mapping
    callDetails[tokenId] = CallDetails(_caller, _callee, _callDuration, now);

    // mint the new token and assign it to the caller
    _mint(msg.sender, tokenId);

    // emit event
    emit NewCallRegistered(_caller, _callee, _callDuration, now);
  }

  // function to retrieve call details for a specific token ID
  function getCallDetails(uint256 _tokenId) public view returns (address, address, uint256, uint256) {
    require(_tokenId > 0 && _tokenId <= totalSupply(), "Invalid token ID.");
    CallDetails memory call = callDetails[_tokenId];
    return (call.caller, call.callee, call.callDuration, call.callTimestamp);
  }

}


