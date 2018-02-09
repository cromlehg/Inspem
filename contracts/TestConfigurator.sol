pragma solidity ^0.4.18;

import 'localhost/ownership/Ownable.sol';

contract InspemToken {
   function setSaleAgent(address newSaleAgent) public;
   function transferOwnership(address newOwner) public;
}

contract Presale {
    function setNextSaleAgent(address newMainsale) public;
    function setWallet(address newWallet) public;
    function setStart(uint newStart) public;
    function setHardcap(uint newHardcap) public;
    function addMilestone(uint period, uint bonus) public;
    function setDirectMintAgent(address newDirectMintAgent) public;
    function setMinPrice(uint newMinPrice) public;
    function setPrice(uint newPrice) public;
    function transferOwnership(address newOwner) public;
}

contract Mainsale {
    function setFoundersTokensWallet(address newsFoundersTokensWallet) public;
    function setFoundersTokensPercent(uint newFoundersTokensPercent) public;
    function setBountyTokensWallet(address newBountyTokensWallet) public;
    function setBountyTokensPercent(uint newBountyTokensPercent) public;
    function setWallet(address newWallet) public;
    function setStart(uint newStart) public;
    function setHardcap(uint newHardcap) public;
    function addMilestone(uint period, uint bonus) public;
    function setDirectMintAgent(address newDirectMintAgent) public;
    function setMinPrice(uint newMinPrice) public;
    function setPrice(uint newPrice) public;
    function transferOwnership(address newOwner) public;
}

contract InspemCommonSale {
    function setRefererPercent(uint newRefererPercent) public;
    function setMinInvestedLimit(uint newMinInvestedLimit) public;
    function setToken(address newToken) public;
}

contract TestConfigurator is Ownable {

    InspemToken public token;
    Presale public presale;
    Mainsale public mainsale;
	
    function setToken(address _token) public onlyOwner {
      token = InspemToken(_token);
    }

    function setPresale(address _presale) public onlyOwner {
      presale = Presale(_presale);
    }

    function setMainsale(address _mainsale) public onlyOwner {
      mainsale = Mainsale(_mainsale);
    }	
	
    function commonConfigure(address saleAddress, address _token) internal {
      InspemCommonSale sale = InspemCommonSale(saleAddress);
      sale.setRefererPercent(5);
      sale.setMinInvestedLimit(10000000000000000);
      sale.setToken(_token);
    }
	
   function deploy() public onlyOwner {
      
      commonConfigure(presale, token);
      presale.addMilestone(14, 100);
      presale.addMilestone(14, 50);
      presale.setStart(1517576400);
      presale.setPrice(5000000000000000000000);
      presale.setHardcap(2000000000000000000000);
      presale.setWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A03);
      
      token.setSaleAgent(presale);
      presale.setNextSaleAgent(mainsale);
	  
      commonConfigure(mainsale, token);
      mainsale.addMilestone(7, 30);
      mainsale.addMilestone(7, 20);
      mainsale.addMilestone(7, 10);
      mainsale.addMilestone(7, 0);
      mainsale.setStart(1516021200);
      mainsale.setPrice(5000000000000000000000);
      mainsale.setHardcap(30000000000000000000000);
      mainsale.setWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A03);
      mainsale.setFoundersTokensWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A05);
      mainsale.setBountyTokensWallet(0x95EA6A4ec9F80436854702e5F05d238f27166A04);
      mainsale.setFoundersTokensPercent(15);
      mainsale.setBountyTokensPercent(5);
	  
      token.transferOwnership(owner);
      presale.transferOwnership(owner);
      mainsale.transferOwnership(owner);
    }
}	
	
