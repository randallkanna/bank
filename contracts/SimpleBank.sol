pragma solidity ^0.4.13;
contract SimpleBank {

  mapping (address => uint) private balances;

  address public owner;

  event LogDepositMade(address accountAddress, uint amount);

  function SimpleBank() {
    owner = msg.sender;
  }

  function enroll() public returns (uint){
    uint amountToSend = 1000;

    balances[msg.sender] += amountToSend;

    return balances[msg.sender];
  }

  function deposit() public payable returns (uint) {
      /* msg.sender.transfer(msg.value); */
    balances[msg.sender] += msg.value;

    emit LogDepositMade(msg.sender, msg.value);

    return balances[msg.sender];
  }

  function withdraw(uint withdrawAmount) public returns (uint remainingBalance) {
    require(balances[msg.sender] >= withdrawAmount);

    balances[msg.sender] += withdrawAmount;

    return balances[msg.sender];
  }

  function balance() public constant returns (uint) {
    return balances[msg.sender];
  }

  function () {
      revert();
  }
}
