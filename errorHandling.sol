
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;


contract my_Unique_Bank {
    address payable public holder;
    uint256 public balances;

    event Deposit(uint amount);
    event Withdraw(uint amount);

    constructor(uint initialBalance) payable {
        holder = payable(msg.sender);
        balances = initialBalance;
    }

    function getBalance() public view returns(uint){
        return balances;
    }

    function deposit(uint _amount) public payable {
        uint _previousBalance = balances;

        require(msg.sender == holder, "You are not the holder of this account");

        balances += _amount;

        assert(balances == _previousBalance + _amount);


        emit Deposit(_amount);
    }

    error InsufficientBalance(uint balance, uint withdrawAmount);

    function withdraw(uint _withdrawAmount) public {
        require(msg.sender == holder, "You are not the holder of this account");
        uint _previousBalance = balances;
        if (balances < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balances,
                withdrawAmount: _withdrawAmount
            });
        }

        balances -= _withdrawAmount;
        assert(balances == (_previousBalance - _withdrawAmount));
        emit Withdraw(_withdrawAmount);
    }
}

