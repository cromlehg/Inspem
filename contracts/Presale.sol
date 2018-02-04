pragma solidity 0.4.18;

import './InspemCommonSale.sol';
import './NextSaleAgentFeature.sol';

contract Presale is NextSaleAgentFeature, InspemCommonSale {

  function finish() public onlyOwner {
    token.setSaleAgent(nextSaleAgent);
  }

}
