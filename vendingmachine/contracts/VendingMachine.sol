// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine {

    // state variables
    //address type holds 24 byte value (ETH address)
    address public owner;
    // object with key/values being the same type
    //number of donuts each address owns
    mapping (address => uint) public donutBalances;

    // set the owner as the address that deployed the contract
    // set the initial vending machine balance to 100
    constructor() {
      // sender contains the eth address that has originated the call(sender of the message (current call))
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }
    // view and not modify data from block chain
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    // Let the owner restock the vending machine
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock.");
        donutBalances[address(this)] += amount;
    }

    // Purchase donuts from the vending machine
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ETH per donut");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to complete this purchase");
        donutBalances[address(this)] -= amount;
        // purchasers account
        donutBalances[msg.sender] += amount;
    }
}
