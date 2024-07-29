// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract Follower is ERC721 {
  struct OwnerInfo {
    uint256 tokenId;
    uint256 createdAt;
  }

  uint256 public _tokenId;
  mapping(address => OwnerInfo) _ownerList;
  string public _tokenURI;
  address private _authorAddress;
  uint256 totalSupply;

  function getTotalSupply() public view returns (uint256) {
    return totalSupply;
  }

  function increment() private {
    _tokenId++;
  }

  modifier isAuthor() {
    require(_authorAddress == msg.sender, 'Not Allow Method!');
    _;
  }

  modifier isOwnerNft() {
    require(
      _ownerList[msg.sender].tokenId > 0 && _ownerList[msg.sender].tokenId < _tokenId + 1,
      'You have not nft!'
    );
    _;
  }

  function getTokenId() public view isOwnerNft returns (uint256) {
    return _ownerList[msg.sender].tokenId;
  }

  function getCreateAt() public view isOwnerNft returns (uint256) {
    return _ownerList[msg.sender].createdAt;
  }

  constructor() ERC721('Follower', 'F') {
    _tokenId = 0;
    _tokenURI = 'http://103.101.162.72:3000';
    _authorAddress = msg.sender;
  }

  event callSetTokenURI(string tokenURI);

  function setTokenURI(string memory tokenURI2) public isAuthor {
    emit callSetTokenURI(tokenURI2);
    _tokenURI = tokenURI2;
  }

  event callTokenURI(uint256 tokenId);

  function tokenURI(uint256 tokenUri) public view virtual override(ERC721) returns (string memory) {
    return _tokenURI;
  }

  event callSafeMintSuccess(address ownerAddress, uint _tokenId, uint256);

  function safeMint() public {
    require(_ownerList[msg.sender].tokenId == 0, 'You are minted!');
    increment();
    uint256 createAt = block.timestamp;
    _ownerList[msg.sender] = OwnerInfo(_tokenId, createAt);
    _safeMint(msg.sender, _tokenId);
    emit callSafeMintSuccess(msg.sender, _tokenId, createAt);
    totalSupply++;
  }
}
