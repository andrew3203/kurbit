pragma solidity^0.4.22;

contract KuriniyBitochek {
    string public constant name = "Kuriniy Bitochek";
    string public constant symbol = "🐔";
    uint8 public constant decimals = 18;
    address private mainAddr;
    uint256 private _totalSupply;

    mapping (address => uint256) balances;

    constructor(uint256 __totalSupply) public {
        require(msg.sender == mainAddr);
        _totalSupply = __totalSupply;
        balances[mainAddr] = __totalSupply;
    }

    function totalSupply() public constant returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balances[_from] >= _value);
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public  returns (bool success) {
        if (balances[msg.sender] >= _value) {
            emit Approval(msg.sender, _spender, _value);
            return true;
        } 
        return false;
    }

    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
        emit Approval(_owner, _spender, balances[_owner]);
        return balances[_owner];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}