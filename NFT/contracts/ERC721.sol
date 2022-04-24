//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

//https://eips.ethereum.org/EIPS/eip-721

contract ERC721 {
    //list of users having nft's
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;

    //number of nfts assigned to owner
    function balanceOf(address owner) public view returns (uint256) {
        //owner is not a zero address
        require(owner != address(0), "owner is zero address");
        return _balances[owner];
    }

    //Finds the owner of an NFT where we give input as [Unique NFT id] like tokenId
    //before calling this function we need a track who owns this NFT [_owner map]
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        //documentation: check owner!= zero address:  if token is assigned to zero address it consider as invalid
        require(owner != address(0), "TokenId does not exit");
        return owner;
    }

    //event Transfer()
    //event Approval()
    //event ApprovalForAll()
    //function safeTransferFrom()
    //function safeTransferFrom()
    //function transferFrom()
    //function approve()
    //function setApprovalForAll()
    //function getApproved()
    //function isApprovedForAll()
}
