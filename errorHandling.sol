// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract TokenAgreement {
    address private holder;
    uint public overallSupply;
    mapping (address => uint) public balances;

    constructor() {
        holder = msg.sender;
        overallSupply = 100000;
        balances[holder] = overallSupply;
    }

    function transfer(address receiver, uint amount) public {
        require(msg.sender!= address(0), "The sender is invalid");
        require(receiver!= address(0), "The receiver is invalid");
        require(balances[msg.sender] >= amount, "the balance is not sufficient");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

    function mint(uint amount) public {
        require(msg.sender == holder, "Tokens can only be mint by the holder.");
        require(amount > 0, "Amount must be greater than 0");
        overallSupply += amount;
        balances[holder] += amount;
    }

    function burn(uint amount) public {
        require(msg.sender == holder, "Tokens can only burn by the holder");
        require(amount > 0, "Amount must be greater than zero");
        require(balances[holder] >= amount, "the balance is not sufficient");
        overallSupply -= amount;
        balances[holder] -= amount;
        assert(balances[holder] >= 0);
    }

    function getBalance() public view returns (uint) {
        assert(balances[msg.sender] >= 0);
        return balances[msg.sender];
    }
}
