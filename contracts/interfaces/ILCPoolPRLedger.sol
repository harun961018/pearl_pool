// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface ILCPoolPRLedger {
  // token0 -> token1 ->  poolId
  function poolToId(address token0, address token1, bool stable) external view returns(uint256);
  function setPoolToId(address token0, address token1, bool stable, uint256 poolId) external;

  function getLastRewardAmount(uint256 poolId) external view returns(uint256);
  function getUserLiquidity(address account, uint256 poolId, uint256 basketId) external view returns(uint256);

  function updateInfo(
    address acc,
    uint256 pId,
    uint256 bId,
    uint256 liquidity,
    uint256 reward,
    uint256 rewardAfter,
    uint256 exLp,
    bool increase
  ) external;

  function getSingleReward(address acc, uint256 pId, uint256 bId, uint256 currentReward, bool cutfee)
    external view returns(uint256, uint256);
  function getReward(address account, address lcPoolPR, uint256[] memory tokenId, address[] memory guage, uint256[] memory basketIds) external view
    returns(uint256[] memory, uint256[] memory);
  function poolInfoLength(uint256 poolId) external view returns(uint256);
  function reInvestInfoLength(uint256 poolId) external view returns(uint256);
}
