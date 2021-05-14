// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Fraktal1155 is Ownable{

  //maps the 1155 id from the shares tokens to the NFT id.
  mapping (uint => uint) tokenIdToShares;
  mapping(uint => uint) sharesIdToToken;

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  uint mintingFee;

  //Track owner address -> tokenId int -> send to address -> shares voted
  mapping (address => (uint => (address => uint))) private transferVotes;


  //EVENTS
  event Minted(uint nftId, uint sharedId, string URI);
  event TransferedContractOwner();
  event FeeSet(uint fee);

  constructor() public {
    mintingFee = 0;
  }

  function mint(address _to, string memory tokenURI) public{
    //mint a new NFT, owned by this contract, with tokenURI
    _tokenIds.increment();
    _mint(address(this), _tokenIds.current(), 1, tokenURI);

    tokenIdToShares[_tokenIds.current()] = _tokenIds.current() + 1;
    sharesIdToToken[_tokenIds.current() + 1] = _tokenIds.current();

    //mint 100% of the shares for _to address
    _tokensIds.increment();
    _mint(_to, _tokenIds.current(), 10000, string(sharesIdToNFT[_tokenIds.current()])); //2 decimal places.
  }

  //TODO
  //getter shares id from tokenreverse

  /*
   * Lookup the owner of an NFT and get the percentage of their ownership.
   * returns percentage with 2 decimal places. Divide by 100 to get natural percent
   */
  function getPercentByNFT(address _owner, uint _id) external view returns(uint percent){
      //return _balances[tokenIdToShares[_id]][_owner];
      return balanceOf(_owner, tokenIdToShares[_id]);
  }

  function setFee(uint _mintingFee) public onlyOwner{
    mintingFee = _mintingFee;
    FeeSet(mintingFee);
  }

  /*
   * Users can lock their shares in order to vote on transfering the entire NFT to one address
   */
   mapping (address => (uint => uint)) lockedShares;

  function lockSharesTransfer(uint _tokenId, uint numShares, address _to) {
    //Owner must have this many shares.
    require(getPercentByNFT(msg.sender, _tokenId) - lockedshares[msg.sender][_tokenId] >= numShares);
    //Track owner address -> tokenId int -> send to address -> shares voted
    mapping (address => (uint => (address => uint))) private
    transferVotes[];
    //TODO lock the existing shares.
  }

  function unlockSharesTransfer(uint _tokenId, uint numShares, address _to){

  }

  function getLockedTransferShares(uint _tokenId) public view returns (uint) {
    return
  }

  function getLockedTransferShares(uint _tokenId, address _to) public view returns (uint) {

  }

  function processFullShareTransfer() {

  }

  function transfer() { //override default 1155
    //require shares arent locked being sent for the FT
    //require all shares are locked for the same send for the NFT
  }

}
