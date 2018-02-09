pragma solidity ^0.4.18;

import './ownership/Ownable.sol';
import './InspemToken.sol';
import './Presale.sol';
import './Mainsale.sol';

contract Configurator is Ownable {

  MintableToken public token;

  Presale public presale;

  Mainsale public mainsale;

  function deploy() public onlyOwner {

    token = new InspemToken();

    presale = new Presale();

    presale.addMilestone(14, 100);
    presale.addMilestone(14, 50);
    presale.setWallet(0x16Af606E2f396DDdde61809A2C73b8E64A81c1Ea);
    presale.setStart(1522328400);
    presale.setPrice(5000000000000000000000);
    presale.setHardcap(2000000000000000000000);
    token.setSaleAgent(presale);
    commonConfigure(presale, token);

    mainsale = new Mainsale();

    mainsale.addMilestone(7, 30);
    mainsale.addMilestone(7, 20);
    mainsale.addMilestone(7, 10);
    mainsale.addMilestone(7, 0);
    mainsale.setPrice(5000000000000000000000);
    mainsale.setWallet(0xb24EDbc6d7EDa33af4A91d57c621e5eB86c02BcF);
    mainsale.setFoundersTokensWallet(0xAFA1bFDF3112d4d3e9CaC4A100a0eBf22231878c);
    mainsale.setBountyTokensWallet(0x3c0260Ce19363350264D23Fd1A48F50001dBb5ee);
    mainsale.setStart(1525179600);
    mainsale.setHardcap(30000000000000000000000);
    mainsale.setFoundersTokensPercent(15);
    mainsale.setBountyTokensPercent(5);
    commonConfigure(mainsale, token);

    presale.setNextSaleAgent(mainsale);

    token.transferOwnership(owner);
    presale.transferOwnership(owner);
    mainsale.transferOwnership(owner);
  }

  function commonConfigure(address saleAddress, address _token) internal {
    InspemCommonSale sale = InspemCommonSale(saleAddress);
    sale.setRefererPercent(5);
    sale.setMinInvestedLimit(100000000000000000);
    sale.setToken(_token);
  }

}

