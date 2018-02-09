import ether from './helpers/ether';
import tokens from './helpers/tokens';
import {advanceBlock} from './helpers/advanceToBlock';
import {increaseTimeTo, duration} from './helpers/increaseTime';
import latestTime from './helpers/latestTime';
import EVMRevert from './helpers/EVMRevert';

const should = require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(web3.BigNumber))
  .should();

const Configurator = artifacts.require('Configurator.sol');
const Token = artifacts.require('InspemToken.sol');
const Presale = artifacts.require('Presale.sol');
const Mainsale = artifacts.require('Mainsale.sol');

contract('Configurator integration test', function (accounts) {
  let configurator;
  let token;
  let presale;
  let mainsale;

  before(async function () {
    // Advance to the next block to correctly read time in the solidity "now" function interpreted by testrpc
    await advanceBlock();
    configurator = await Configurator.new();
    await configurator.deploy();
    const tokenAddress = await configurator.token();
    const presaleAddress = await configurator.presale();
    const mainsaleAddress = await configurator.mainsale();
    token = await Token.at(tokenAddress);
    presale = await Presale.at(presaleAddress);
    mainsale = await Mainsale.at(mainsaleAddress);
  });

  it('contracts should have token address', async function () {
    const tokenOwner = await token.owner();
    tokenOwner.should.equal(accounts[0]);
  });
  
  it('contracts should have presale address', async function () {
    const presaleOwner = await presale.owner();
    presaleOwner.should.equal(accounts[0]);
  });  
  
  it('contracts should have mainsale address', async function () {
    const mainsaleOwner = await mainsale.owner();
    mainsaleOwner.should.equal(accounts[0]);
  });  
    
  it('presale and mainsale should have start time as described in README', async function () {
    const presaleStart = await presale.start();
    presaleStart.should.bignumber.equal((new Date('29 March 2018 13:00:00 GMT')).getTime() / 1000);
    const mainsaleStart = await mainsale.start();
    mainsaleStart.should.bignumber.equal((new Date('01 May 2018 13:00:00 GMT')).getTime() / 1000);
  });
  
  it ('presale and mainsale should have price as described in README', async function () {
    const presalePrice = await presale.price();
    presalePrice.should.bignumber.equal(tokens(5000));
    const mainsalePrice = await mainsale.price();
    mainsalePrice.should.bignumber.equal(tokens(5000));  
  });
  
  it ('presale and mainsale should have hardcap as described in README', async function () {
    const presaleHardcap = await presale.hardcap();
    presaleHardcap.should.bignumber.equal(ether(2000));
    const mainsaleHardcap = await mainsale.hardcap();
    mainsaleHardcap.should.bignumber.equal(ether(30000));  
  });

  it ('presale and mainsale should have minimal insvested limit as described in README', async function () {
    const presaleMinInvest = await presale.minInvestedLimit();
    presaleMinInvest.should.bignumber.equal(ether(0.1));
    const mainsaleMinInvest = await mainsale.minInvestedLimit();
    mainsaleMinInvest.should.bignumber.equal(ether(0.1));  
  });  

  it ('presale and mainsale should have wallets as described in README', async function () {
    const presaleWallet = await presale.wallet();
    presaleWallet.should.bignumber.equal('0x95EA6A4ec9F80436854702e5F05d238f27166A03');
    const mainsaleWallet = await mainsale.wallet();
    mainsaleWallet.should.bignumber.equal('0x95EA6A4ec9F80436854702e5F05d238f27166A03'); 
  });

  it ('Bounty wallet and founders wallet should be as described in README', async function () {
    const bountyWallet = await mainsale.bountyTokensWallet();
    bountyWallet.should.bignumber.equal('0x95EA6A4ec9F80436854702e5F05d238f27166A04');
    const foundersWallet = await mainsale.foundersTokensWallet();
    foundersWallet.should.bignumber.equal('0x95EA6A4ec9F80436854702e5F05d238f27166A05'); 
  });  
  
});
