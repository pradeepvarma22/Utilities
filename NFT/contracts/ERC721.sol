//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

//https://eips.ethereum.org/EIPS/eip-721

contract ERC721 {
    //list of users having nft's
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(uint256=> address) private _tokenApprovals;
    //1st address is the owner of NFT 2nd address is the operator[opensea] 3rd parameter is can we give access to operator true/false
    mapping(address=>(address=>bool)) private _operatorApprovals;
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

    /*
    setApprovalForAll:
        When you sell NFTs on a Marketplace, you need to authorize this marketplace to transfer sold items from
        your address to the buyer's address.
        This is what SetApprovalForAll is used for: because you trust the marketplace, you "approve" it to sell
        your NFTs (not all your NFTs, but the NFTs you own in the context of this contract).
        The marketplace is what is called the "operator" in the context of this API.
        MAP:_operatorApprovals: where operators are stored here
     */
    event ApprovalForAll(address indexed _ownerOfNFT,address indexed _operatorLikeOpenSea,bool _approved);
    
    function setApprovalForAll(address operator,bool approved) public{
        //here msg.sender is the owner for NFT tokenId for temporary we are using msg.sender
        //operator: opensea we want to give permissions or revoke permissions approved: true/false
        _operatorApprovals[msg.sender][operator]=approved;
        emit ApprovalForAll(msg.sender,operator,approved);
    }

    //check if address is an operator for an another address
    function isApprovedForAll(address owner,address operator) public view returns(bool){
        return _operatorApprovals[owner][operator];
    }
    
    /*
        Approves another address to transfer the given token ID
        The zero address indicates there is no approved address.
        There can only be one approved address per token at a given time.
        Approve function Can only be called by the token owner or an approved operator.
        @param to address to be approved for the given token ID
        @param tokenId uint256 ID of the token to be approved
        MAP:_tokenApprovals
    */
    event Approval(address indexed _owner,address indexed _to,uint256 _tokenId);
    function approve(address to,uint256 tokenId) public{
        address owner = ownerOf(tokenId);
        //tokenId nft can be send by only owner or opensea operator
        require(msg.sender == owner || isApprovedForAll(owner,msg.sender), "Msg.sender is not the owner or an approved operator");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner,to,tokenId);
    }
    
    //gets the approved address for a single NFT
    function getApproved() public view(uint256 tokenId) returns(address)
    {
        //token id exists or not ?
        require(_owners[tokenId]!=address(0), "Token Id Does not exits");
        return _tokenApprovals[tokenId];
    }

    event Transfer(address _from,address _to,uint256 tokenId);
    //Transafers ownership of an NFT
    function transferFrom(address from,address to,uint256 tokenId) public 
    {
        address owner = ownerOf(tokenId);
        require(
            msg.sender==owner||
            getApproved(tokenId) == msg.sender ||
            isApproved(owner,msg.sender),
            "Msg.sender is not the owner or approved for transfer"
        );
        require(owner==from, "From Address is not the owner");
        require(to!=address(0),"address is zero");
        require(_owner(tokenId)!=address(0),"tokenId does not exits");
        //remove previous owners by setting it to 0 address
        approve(address(0),tokenId);
        _balances[from] -=1;
        _balances[to] +=1;
        _owners[tokenId] = to;
        emit Transfer(from,to,tokenId);
    }

    
    // function safeTransferFrom()
    // function safeTransferFrom()



}
