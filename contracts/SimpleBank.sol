pragma solidity ^0.4.13;
contract SimpleBank {

  mapping (address => uint) private balances;

  address public owner;

  event LogDepositMade(address accountAddress, uint amount);

  function SimpleBank() {
    owner = msg.sender;
  }

  function enroll() public returns (uint) {
    balances[msg.sender] += 1000;

    return balances[msg.sender];
  }

  function deposit() public payable returns (uint) {
    balances[msg.sender] += msg.value;

    emit LogDepositMade(msg.sender, msg.value);

    return balances[msg.sender];
  }

  /// @notice Withdraw ether from bank
  /// @dev This does not return any excess ether sent to it
  /// @param withdrawAmount amount you want to withdraw
  /// @return The balance remaining for the user
  function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
      /* If the sender's balance is at least the amount they want to withdraw,
         Subtract the amount from the sender's balance, and try to send that amount of ether
         to the user attempting to withdraw. IF the send fails, add the amount back to the user's balance
         return the user's balance.*/

  }

  function balance() public constant returns (uint) {
    return balances[msg.sender];
  }

  function () {
      revert();
  }
}
