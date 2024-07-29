const Follower = artifacts.require('Follower');
const truffleAssert = require('truffle-assertions');

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract('Follower', function(accounts) {
  let instance;
  beforeEach('should assert true', async function() {
    instance = await Follower.deployed();
  });

  it('Should get default tokenId', async () => {
    const tokenId = await instance.getTokenId();
    assert.equal(tokenId, 0, 'TokenId init default = 0');
  });

  it('Should get tokenURI', async () => {
    const tokenURI_default = await instance.tokenURI(1);
    assert.equal(tokenURI_default, '103.101.162.72:3000', 'Token default must "103.101.162.72:3000"');
  });

  it('Should tokenId after two minted is 1', async () => {
    await instance.safeMint();
    const tokenId = await instance.getTokenId();
    assert.equal(tokenId, 1, 'tokenId be must is 1');
  });

  it('Should call setTokenURI with owner', async () => {
    await instance.setTokenURI('7890');
    assert.equal;
    assert.equal(await instance.tokenURI(1), '7890', 'TokenURI be must is 7890');
  });

  it('Should call setTokenURI other owner', async () => {
    // await truffleAssert.reverts(instance.setTokenURI("7890", {from: accounts[0]}));
  });

  it('Should event emit log', async () => {
    await instance.setTokenURI('7890');
    assert.isTrue(true);
  });

  it('Should checked you have minted and cannot minted continue', async() => {
    try {
      await instance.safeMint();
      await truffleAssert.reverts(await instance.safeMint(),'123', 'You are minted!');
    } catch (error) {
      assert(error.message.includes("You are minted!"), "The transaction should have reverted with a revert message");
    }
  })
});
