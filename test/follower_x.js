const FollowerX = artifacts.require("FollowerX");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("FollowerX", function (/* accounts */) {
  it("should assert true", async function () {
    await FollowerX.deployed();
    return assert.isTrue(true);
  });
});
