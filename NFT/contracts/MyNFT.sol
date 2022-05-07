//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./ERC721.sol";

contract MyContract {
    string public name;
    string public symbol;
    uint256 public tokenCount;
    //token id with mete data url
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    //tokenURI: returns a url that points to metadata: location for nft or properties of the NFT
    //returns url that points to metadata
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "TokenID doesnot exit");
        return _tokenURIs[tokenId];
    }

    //Mint:create a new  NFT inside our collection[MyContract]
    //here MyContract is a collection of tokens
    function mint(string memory _tokenURI) public {
        tokenCount += 1; //tokenId
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount); //this is an minting event not transfering from two people
    }

    //supportInterface
    //EIP:165 proposal
    //Query if a contract implements another interface
    //  @return `true` if the contract implements `interfaceID` and
    //  `interfaceID` is not 0xffffffff, `false` otherwise

    function supportInterface(bytes4 interfaceId)
        public
        pure
        virtual
        returns (bool)
    {
        return (interfaceId == 0x80ac58cd);
    }
}
