// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IGuage {
  function deposit(uint256 amount) external;
  function withdraw(uint256 amount) external;
  function withdrawAllAndHarvest() external;
  function balanceOf(address account) external view returns (uint256);
  function earned(address account) public view returns (uint256);
  function getReward() external;
  function rewards(address account) external view returns (uint256);
}