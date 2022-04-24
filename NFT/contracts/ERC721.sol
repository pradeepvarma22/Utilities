//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

//https://eips.ethereum.org/EIPS/eip-721

contract ERC721 {
    //list of users having nft's
    mapping(address => uint256) internal _balances;

    //number of nfts assigned to owner
    function balanceOf(address owner) public view returns (uint256) {
        //owner is not a zero address
        require(owner != address(0), "owner is zero address");
        return _balances[owner];
    }

    //event Transfer()
    //event Approval()
    //event ApprovalForAll()
    //function ownerOf()
    //function safeTransferFrom()
    //function safeTransferFrom()
    //function transferFrom()
    //function approve()
    //function setApprovalForAll()
    //function getApproved()
    //function isApprovedForAll()
}
