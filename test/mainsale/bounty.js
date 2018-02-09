import ether from '../helpers/ether';
import tokens from '../helpers/tokens';
import {advanceBlock} from '../helpers/advanceToBlock';
import {increaseTimeTo, duration} from '../helpers/increaseTime';
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
    this.hardcap = ether(30000);
    this.minInvestedLimit = ether(0.1);

    token = await Token.new();
    crowdsale = await Crowdsale.new();
    await crowdsale.setPrice(this.price);
    await crowdsale.setHardcap(this.hardcap);
    await crowdsale.setStart(this.start);
    await crowdsale.setMinInvestedLimit(this.minInvestedLimit);
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

  it('should correctly calculate bonuses for founders, bounty', async function () {
    await crowdsale.sendTransaction({value: ether(0.1), from: wallets[0]});
    await crowdsale.sendTransaction({value: ether(99), from: wallets[2]});
    await crowdsale.finish({from: wallets[1]});
    const firstInvestorTokens = await token.balanceOf(wallets[0]);
    const secondInvestorTokens = await token.balanceOf(wallets[2]);
    const foundersTokens = await token.balanceOf(wallets[3]);
    const bountyTokens = await token.balanceOf(wallets[4]);
    const totalTokens = firstInvestorTokens
      .plus(secondInvestorTokens)
      .plus(foundersTokens)
      .plus(bountyTokens);
    assert.equal(foundersTokens.div(totalTokens), 0.15);
    assert.equal(bountyTokens.div(totalTokens), 0.05);
  });
}
