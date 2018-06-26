pragma solidity ^0.4.13;
contract SimpleBank {

  mapping (address => uint) private balances;

  address public owner;
  /* address[] public customers; */

    /* struct Donater {
    uint256 amountDonated;
    uint256 numberSelected;
    address charity;
  }

  mapping(address => Donater) public donaterInfo; */

  event LogDepositMade(address accountAddress, uint amount);

  constructor() {
    owner = msg.sender;
  }

  /* function checkDonaterExists(address donater) public constant returns(bool) {
    for(uint256 i = 0; i < donaters.length; i++){
      if(donaters[i] == donater) return true;
    }

    return false;
  } */

  function enroll() public returns (uint) {
    balances[msg.sender] += 1000;

    /* customers.push(msg.sender); */

    return balances[msg.sender];
  }

  function deposit() public payable returns (uint) {
    balances[msg.sender] += msg.value;

    emit LogDepositMade(msg.sender, msg.value);

    return balances[msg.sender];
  }

  function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
    require(withdrawAmount <= balances[msg.sender]);

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
