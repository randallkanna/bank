pragma solidity ^0.4.13;
contract SimpleBank {

  mapping (address => uint) private balances;

  address public owner;
  address[] public customers;
  mapping(address => bool) isACustomer;

  struct Customer {
    address user;
  }

  event LogDepositMade(address accountAddress, uint amount);

  constructor() {
    owner = msg.sender;
  }

  function checkCustomerIsNotEnrolled(address customer) public constant returns(bool) {
    return isACustomer[customer];
  }

  function enroll() public returns (uint) {
    require(!checkCustomerIsNotEnrolled(msg.sender));

    balances[msg.sender] += 1000;

    customers.push(msg.sender);

    return balances[msg.sender];
  }

  function deposit() public payable returns (uint) {
    balances[msg.sender] += msg.value;

    emit LogDepositMade(msg.sender, msg.value);

    return balances[msg.sender];
  }

  function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
    require(withdrawAmount <= balances[msg.sender]);

    balances[msg.sender] -= withdrawAmount;

    msg.sender.transfer(withdrawAmount);

    return balances[msg.sender];
  }

  function balance() public constant returns (uint) {
    return balances[msg.sender];
  }

  function () {
      revert();
  }
}
