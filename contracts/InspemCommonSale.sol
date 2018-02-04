pragma solidity 0.4.18;

import './ReferersRewardFeature.sol';
import './RetrieveTokensFeature.sol';
import './StagedCrowdsale.sol';

contract InspemCommonSale is StagedCrowdsale, RetrieveTokensFeature, ReferersRewardFeature {

  function calculateTokens(uint _invested) internal returns(uint) {
    uint milestoneIndex = currentMilestone(start);
    Milestone storage milestone = milestones[milestoneIndex];
    uint tokens = _invested.mul(price).div(1 ether);
    if(milestone.bonus > 0) {
      tokens = tokens.add(tokens.mul(milestone.bonus).div(percentRate));
    }
    return tokens;
  }

  function endSaleDate() public view returns(uint) {
    return lastSaleDate(start);
  }

}

