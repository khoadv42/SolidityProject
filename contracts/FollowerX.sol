// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import './Follower.sol';

contract FollowerX {
  Follower public follower;
  uint256 newValue;

  constructor(address _followerAddress) {
    follower = Follower(_followerAddress);
  }

}
