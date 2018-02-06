

import './InspemCommonSale.sol';

contract Mainsale is InspemCommonSale {

  address public foundersTokensWallet;

  address public bountyTokensWallet;

  uint public foundersTokensPercent;

  uint public bountyTokensPercent;

  function setFoundersTokensPercent(uint newFoundersTokensPercent) public onlyOwner {
    foundersTokensPercent = newFoundersTokensPercent;
  }

  function setBountyTokensPercent(uint newBountyTokensPercent) public onlyOwner {
    bountyTokensPercent = newBountyTokensPercent;
  }

  function setFoundersTokensWallet(address newFoundersTokensWallet) public onlyOwner {
    foundersTokensWallet = newFoundersTokensWallet;
  }

  function setBountyTokensWallet(address newBountyTokensWallet) public onlyOwner {
    bountyTokensWallet = newBountyTokensWallet;
  }

  function finish() public onlyOwner {
    uint summaryTokensPercent = bountyTokensPercent.add(foundersTokensPercent);
    uint mintedTokens = token.totalSupply();
    uint allTokens = mintedTokens.mul(percentRate).div(percentRate.sub(summaryTokensPercent));
    uint foundersTokens = allTokens.mul(foundersTokensPercent).div(percentRate);
    uint bountyTokens = allTokens.mul(bountyTokensPercent).div(percentRate);
    mintTokens(foundersTokensWallet, foundersTokens);
    mintTokens(bountyTokensWallet, bountyTokens);
    token.finishMinting();
  }

}
