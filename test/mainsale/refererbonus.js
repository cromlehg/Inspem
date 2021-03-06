import ether from '../helpers/ether';
import tokens from '../helpers/tokens';
import {advanceBlock} from '../helpers/advanceToBlock';
import {duration} from '../helpers/increaseTime';
import latestTime from '../helpers/latestTime';
import EVMRevert from '../helpers/EVMRevert';

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(web3.BigNumber))
  .should();

export default function (Token, Crowdsale, wallets) {
  let token;
  let crowdsale;

  before(async function () {
    // Advance to the next block to correctly read time in the solidity "now" function interpreted by testrpc
    await advanceBlock();
  });

  beforeEach(async function () {
    this.start = latestTime();
    this.duration = 28;
    this.end = this.start + duration.days(this.duration);
    this.afterEnd = this.end + duration.seconds(1);
    this.price = tokens(5000);
    this.hardcap = ether(2000);
    this.minInvestedLimit = ether(0.1);
    this.refererPercent = 5;

    token = await Token.new();
    crowdsale = await Crowdsale.new();
    await crowdsale.setPrice(this.price);
    await crowdsale.setHardcap(this.hardcap);
    await crowdsale.setStart(this.start);
    await crowdsale.setMinInvestedLimit(this.minInvestedLimit);
    await crowdsale.setRefererPercent(this.refererPercent);
    await crowdsale.setWallet(wallets[2]);
    await crowdsale.setToken(token.address);
    await crowdsale.addMilestone(7, 30);
    await crowdsale.addMilestone(7, 20);
    await crowdsale.addMilestone(7, 10);
    await crowdsale.addMilestone(7, 0);
    await crowdsale.setFoundersTokensWallet(wallets[3]);
    await crowdsale.setFoundersTokensPercent(15);
    await crowdsale.setBountyTokensWallet(wallets[4]);
    await crowdsale.setBountyTokensPercent(5);
    await crowdsale.transferOwnership(wallets[1]);
    await token.setSaleAgent(crowdsale.address);
    await token.transferOwnership(wallets[1]);
  });

  it('should add referer bonus', async function () {
    await crowdsale.sendTransaction({value: ether(1), from: wallets[6], data: wallets[5]});
    const refbalance = await token.balanceOf(wallets[5]);
    const balance = await token.balanceOf(wallets[6]);
    refbalance.should.be.bignumber.equal(balance * 0.05);
  });

  it('should works normal if referer is not specified', async function () {
    await crowdsale.sendTransaction({value: ether(1), from: wallets[6], data: ''}).should.be.fulfilled;
    const balance = await token.balanceOf(wallets[6]);
    balance.should.be.bignumber.equal(this.price.times(1.3));
  });

  it('investor сannot accrue bonus to himself', async function () {
    await crowdsale.sendTransaction({value: ether(1), from: wallets[6], data: wallets[6]}).should.be.rejectedWith(EVMRevert);
  });

  it('token contract сannot get referer bonus', async function () {
    const referer = token.address;
    await crowdsale.sendTransaction({value: ether(1), from: wallets[6], data: referer}).should.be.rejectedWith(EVMRevert);
  });

  it('crowdsale contract сannot get referer bonus', async function () {
    const referer = crowdsale.address;
    await crowdsale.sendTransaction({value: ether(1), from: wallets[6], data: referer}).should.be.rejectedWith(EVMRevert);
  });
}
