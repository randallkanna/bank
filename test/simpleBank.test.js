var SimpleBank = artifacts.require("./SimpleBank.sol");

contract('SimpleBank', function(accounts) {

  const owner = accounts[0]
  const alice = accounts[1];
  const bob = accounts[2];

  beforeEach(function() {
    return SimpleBank.new()
    .then(function(instance) {
      bank = instance;
    });
  });

  it("should put 1000 tokens in the first and second account", async () => {
    await bank.enroll({from: alice});
    await bank.enroll({from: bob});

    const aliceBalance = await bank.balance({from: alice});
    assert.equal(aliceBalance, 1000, 'enroll balance is incorrect, check balance method or constructor');

    const bobBalance = await bank.balance({from: bob});
    assert.equal(bobBalance, 1000, 'enroll balance is incorrect, check balance method or constructor');

    const ownerBalance = await bank.balance({from: owner});
    assert.equal(ownerBalance, 0, 'only enrolled users should have balance, check balance method or constructor')
  });

  it("should deposit correct amount", async () => {
    const deposit = web3.toBigNumber(2);

    await bank.enroll({from: alice});
    await bank.enroll({from: bob});

    await bank.deposit({from: alice, value: deposit});
    const balance = await bank.balance({from: alice});

    assert.equal(deposit.plus(1000).toString(), balance, 'deposit amount incorrect, check deposit method');

    const expectedEventResult = {accountAddress: alice, amount: deposit};

    const LogDepositMade = await bank.allEvents();
    const log = await new Promise(function(resolve, reject) {
        LogDepositMade.watch(function(error, log){ resolve(log);});
    });

    const logAccountAddress = log.args.accountAddress;
    const logAmount = log.args.amount.toNumber();

    assert.equal(expectedEventResult.accountAddress, logAccountAddress, "LogDepositMade event accountAddress property not emmitted, check deposit method");
    assert.equal(expectedEventResult.amount, logAmount, "LogDepositMade event amount property not emmitted, check deposit method");
  });

  it("should withdraw correct amount", async () => {
    const deposit = web3.toBigNumber(2);
    const initialAmount = 1000;

    await bank.enroll({from: alice});
    await bank.enroll({from: bob});

    await bank.deposit({from: alice, value: deposit});
    await bank.withdraw(deposit, {from: alice});

    const balance = await bank.balance({from: alice});
    console.log('balance: ' + balance)
    console.log('initialamount: ' + initialAmount.toString())

    assert.equal(initialAmount.toString(), balance, 'withdraw amount incorrect, check withdraw method');
  });

  // it("should not let the same user enroll twice", async () => {
  //   try {
  //     await contract.enroll({from: alice});
  //     await contract.enroll({from: alice});
  //     assert.ok(false, 'should throw an error when the same user tries to enroll twice')
  //   } catch(error) {
  //     assert.ok(true, 'expected throw')
  //   }
  // });
});
