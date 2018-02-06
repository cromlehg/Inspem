pragma solidity ^0.4.18;

import './MintableToken.sol';

contract InspemToken is MintableToken {

  string public constant name = "Inspem";

  string public constant symbol = "INP";

  uint32 public constant decimals = 18;

}
