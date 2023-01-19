/**
 * This contract allows users to register calls by calling the registerCall function and passing 
 * in the address of the receiver and the duration of the call. The function stores the call details in a mapping of 
 * call history for the caller, and emits a NewCall event with the details of the call. 
 * The getCallHistory function can be used to retrieve the call history for a given user.
* /


// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract CallRegistry {
    struct Call {
        address caller;
        address receiver;
        uint timestamp;
        uint256 duration;
    }

    mapping(address => Call[]) private calls;

    event NewCall(address caller, address receiver, uint timestamp, uint256 duration);

    function registerCall(address receiver, uint duration) public {
        Call memory newCall = Call({
            caller: msg.sender,
            receiver: receiver,
            timestamp: now,
            duration: duration
        });

        calls[msg.sender].push(newCall);
        emit NewCall(msg.sender, receiver, now, duration);
    }

    function getCallHistory(address user) public view returns (Call[] calldata) {
        return calls[user];
    }
}
