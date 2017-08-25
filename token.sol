pragma solidity ^0.4.0;
pragma solidity ^0.4.13;

contract Token
{
	mapping(address => uint) public balances;
	//function transfer_to (address reciever,address sender, uint token) returns (bool done);
	//function balance_check(address owner)  returns (uint total);

	function Token(uint seed)
	{
		balances[msg.sender] = seed;
	}
	event Transfer_to(address reciever, address sender , uint token);

	function balance_check(address owner)  returns (uint total)
	{
		
		uint balance =  balances[owner];
		return balance;
		
	


	}




	function transfer_to(address reciever, address sender, uint token) returns (bool success)
	{
		if(balances[msg.sender] < token)
		{
		return false;
		}
		if(balances[msg.sender]>= token)
		{
		balances[msg.sender] = balances[msg.sender] - token;
		balances[reciever] = balances[reciever]+token;
		Transfer_to( reciever, sender, token);
		return true;
		}
		


	}
}


contract Key
{


	
	
	event Init_registration(address Owner);
	mapping(address => bytes32) public key_store;
	

	function registration() returns (bool success)
	{

		address Owner = msg.sender;
		Init_registration(Owner);

		return true;


	}
	function key_selection(address Sender)  returns (bytes32 key)

	{ 
		uint i =  0;
		if(registration())
		{
			key  = sha3(i,Sender);
			key_store[Sender] = key;
			return key;

		}

	}
	function receive_key(address owner_account, address sender_address,uint amount) returns (bool success)
	{
		Token t = Token(owner_account);

		if(t.transfer_to(owner_account,sender_address,amount))
		{
			key_store[owner_account] = key_store[sender_address];
			key_store[sender_address] = 0x00;
			return true;

		}
		else
		{
			revert();
		}


	}

}