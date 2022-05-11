//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract ERC1155 {
    //tokenId, Address of account
    mapping(uint256 => mapping(address => uint256)) internal _balances;

    //owner, operator ->  is this person an operator for that owner
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    event ApprovalForAll(address indexed _owner, address indexed _operator,bool _isApproved);

    event TransferSingle(address indexed _operator,address indexed from, address indexed to, uint256 id, uint256 amount);

    event TransferBatch(address _operator, address _from, address _to, uint256[] ids, uint256[] amounts);

    //get the balances of the account tokens
    function balanceOf(address account, uint256 tokenId)
        public
        view
        returns (uint256)
    {
        require(account != address(0), "Zero Address");
        return _balances[tokenId][account];
    }

    //balance of batch
    //get the balance of multiple accounts token
    function balanceOfBatch(address[] memory accounts,uint256[] memory tokenIds) returns (uint256[] memory) public view {


        require(accounts.length == id.length, "account and ids are not of same length");

        //dynamic array
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for(uint256 i =0; i< accounts.length;i++)
        {
            batchBalances[i] = balanceOf(accounts[i],tokenIds[i]);
        }
        return batchBalances;
    }


    //check if an address is an operator for another address
    function isApprovedForAll(address account, address operator) public view returns(bool)
    {

        return _operatorApprovals[account][operator];           //check if given input operator is an operator for that account
    }

    //enables or disables an operator to manage all of msg.senders assests
    function setApprovalForAll(address operator, bool approved) {
        _operatorApprovals[msg.sender][operator] = approved;   //here msg.sender is the owner only owner can call this function
        emit ApprovalForAll(msg.sender,operator,approved);
    }

    //transfer NFT from one owner to another here amount is the no of the NFT'S
    //here amount is no of copies that NFT have
    function _transfer(address from, address to, uint256 id, uint256 amount) private 
    {
        uint256 fromBalance = _balances[id][from];
        require(fromBalance>=amount, "Insufficient balance");
        _balances[id][from] = fromBalance - amount;
        _balances[id][to] += amount; 
    }

    // only difference between transfer and safeTransferForm is one paramenter  data
    function safeTransferForm(address from, address to, uint256 id, uint256 amount,bytes memory data){
        require(from==msg.sender || isApprovedForAll(from,msg.sender),"Msg.sender is not the owner or approver " );
        _transfer(from,to,id,amount);
        require(to != address(0),"to address is zero");
        emit TransferSingle(msg.sender,from,to,id,amount);
        require(_checkOnERC1155Received(data),"Receiver is not implemented");


    }

    function _checkOnERC1155Received(bytes memory data) private pure returns (bool)
    {
        //dummy function 
        return true;
    }

    function _checkOnBatchERC1155Received(bytes memory data) private pure returns(bool)
    {
        //dummy function
        return true;
    }

    //SafeBatchTransaferForm()
    function SafeBatchTransaferForm(address from,address to,  uint256[] memory ids,uint256[] memory amounts, bytes memory data)private {

        for(uint256 i=0; i < ids.length;i++)
        {
            uint256 id = ids[i];
            uint256 amount  = amounts[i];
            _transfer(from,to,id,amount);
            emit TransferBatch(msg.sender, from, to, ids, amounts);

        }

        require(_checkOnBatchERC1155Received(data),"Receiver is not implemented");

    }

    // supportInterface()
    //ERC165 complaint
    //we want to tell every one we support the ERC1155 functions
    //for telling them we use special code called as interface
    //interfaceId: Special code == 0xdab67a26
    function supportInterface(bytes4 interfaceId) public pure virtual returns(bool)
    {
        return (interfaceId==0xdab67a26);               //if true it tells the world yes we support ERC1155 Function
    }


}
