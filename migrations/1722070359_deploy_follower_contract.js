const Follower = artifacts.require('Follower');
const FollowerX = artifacts.require('Followerx');
module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(Follower);
  _deployer.deploy(FollowerX);
};
