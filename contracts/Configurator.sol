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
    //owner = 0x95EA6A4ec9F80436854702e5F05d238f27166A03;

    token = new InspemToken();

    presale = new Presale();

    presale.addMilestone(14, 100);
    presale.addMilestone(14, 50);
    presale.setWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A03);
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
    mainsale.setWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A03);
    mainsale.setFoundersTokensWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A05);
    mainsale.setBountyTokensWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A04);
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

