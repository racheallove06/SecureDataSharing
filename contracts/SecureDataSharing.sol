// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureDataSharing {
    address public owner;

    struct Researcher {
        bool isVerified;
        bool hasAccess;
    }

    mapping(address => Researcher) public researchers;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function verifyResearcher(address _researcher) public onlyOwner {
        researchers[_researcher] = Researcher(true, false);
    }

    function grantAccess(address _researcher) public onlyOwner {
        require(researchers[_researcher].isVerified, "Researcher must be verified");
        researchers[_researcher].hasAccess = true;
    }

    function revokeAccess(address _researcher) public onlyOwner {
        require(researchers[_researcher].isVerified, "Researcher must be verified");
        researchers[_researcher].hasAccess = false;
    }

    function hasAccess(address _researcher) public view returns (bool) {
        return researchers[_researcher].hasAccess;
    }
}
