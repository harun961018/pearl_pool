// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./interfaces/IGuage.sol";
import "./interfaces/IPairFactory.sol";
import "./interfaces/IRouter.sol";

import "./utils/Ownable.sol";
import "./utils/SafeERC20.sol";

contract test is Ownable {
  using SafeERC20 for IERC20;

  address public rewardToken;
  address public pairFactory;
  address public router;

  mapping (address => bool) public managers;
  mapping (address => bool) public operators;
  modifier onlyManager() {
    require(managers[msg.sender], "LC pool: !manager");
    _;
  }

  event increaseliquidity(uint256 amount0, uint256 amount1, uint256 liquidity);
  event decreaseliquidity(uint256 amount0, uint256 amount1);
  constructor (
    address _reward,
    address _pairFactory,
    address _router
  ) {

    require(_reward != address(0), "LC pool: reward");
    require(_pairFactory != address(0), "LC pool: pairFactory");
    require(_router != address(0), "LC pool: router");

    rewardToken = _reward;
    pairFactory = _pairFactory;
    router = _router;
    managers[msg.sender] = true;
  }

  receive() external payable {
  }

  function _increaseLiquidity_test(
    address[2] calldata tokens,
    bool stable,
    uint256 amount0ToAdd,
    uint256 amount1ToAdd,
    uint256[2] calldata minAmounts
  ) external returns (uint256 liquidity, uint256 amount0, uint256 amount1) {
    uint256 deadline = block.timestamp + 10000;
    _approveTokenIfNeeded(tokens[0], router, amount0ToAdd);
    _approveTokenIfNeeded(tokens[1], router, amount1ToAdd);
    (amount0, amount1, liquidity) = IRouter(router).addLiquidity(
        tokens[0],
        tokens[1],
        stable,
        amount0ToAdd,
        amount1ToAdd,
        minAmounts[0],
        minAmounts[1],
        address(this),
        deadline
    );

    emit increaseliquidity(amount0, amount1, liquidity);
    // address pair = IPairFactory(pairFactory).getPair(tokens[0], tokens[1], stable);
    // _approveTokenIfNeeded(pair, guage, liquidity);
    // IGuage(guage).deposit(liquidity);
  }

  function _decreaseLiquidity_test(
    address[2] calldata tokens,
    bool stable,
    uint256 liquidity,
    uint256 amount0Min,
    uint256 amount1Min
  ) external returns (uint256 amount0, uint256 amount1) {
    uint256 deadline = block.timestamp + 10000;
    // IGuage(guage).withdraw(liquidity);
    address pair = IPairFactory(pairFactory).getPair(tokens[0], tokens[1], stable);
    _approveTokenIfNeeded(pair, router, liquidity);
    (amount0, amount1) = IRouter(router).removeLiquidity(tokens[0], tokens[1], stable, liquidity, amount0Min, amount1Min, address(this), deadline);
    emit decreaseliquidity(amount0, amount1);
  }

  function _approveTokenIfNeeded(address token, address spender, uint256 amount) private {
    if (IERC20(token).allowance(address(this), spender) < amount) {
      IERC20(token).safeApprove(spender, 0);
      IERC20(token).safeApprove(spender, type(uint256).max);
    }
  }

  function getPairIndex(address pair) public view returns(uint256) {
    uint256 pairLength = IPairFactory(pairFactory).allPairsLength();
    uint256 index = 0;
    while (index < pairLength) {
      if (pair == IPairFactory(pairFactory).allPairs(index)) {
        index++;
        return index;
      }
      index++;
    }
    index = 0;
    return index;

  }

}
