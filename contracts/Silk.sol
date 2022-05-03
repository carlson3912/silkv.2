pragma solidity >=0.4.22 <0.9.0;

contract Silk{
    uint256 public totalSupply = 0;
    string public name = "Silk Token";
    string public symbol = "SILK";
    string public standard = "Silk Token v1.0";
    mapping(address => uint256) public balanceOf;
    address admin = 0x27B4A532dCfa500A9B27Aa186f8bdf09a6aF1F4E;
    mapping(address => mapping(address => uint256)) public allowance;


function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "can't divide by zero");
        uint256 c = a / b;
        return c;
    }
function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

event BurnSilk(
        address _sender,
        uint256 _silk,
        uint256 _reward
    );
event Mint(
        address indexed _to,
        uint256 _value
    );

event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

event Purchase(
        address indexed customer,
        uint256 cost,
        uint256 silk
);

 event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

function transfer(address _to, uint256 _value) public returns (bool success){
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value); 
        return true;
    }


function mint(address _to, uint256 _value) internal returns (bool success){
        uint256 temp = _value / 10;
        balanceOf[admin] += temp;
        balanceOf[_to] += _value;
        totalSupply += _value;
        totalSupply += temp;
        emit Mint(_to, _value);
        return true;
    }

function approve(address _spender, uint256 _value) public returns (bool success){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }



function burn(uint256 _value) public returns(uint256 percentage){
        require(balanceOf[msg.sender] >= _value);
        uint256 answer = div(mul(address(this).balance,  _value),  totalSupply);
        balanceOf[msg.sender] -= _value;
        payable(msg.sender).transfer(answer);
        totalSupply -= _value;
        emit BurnSilk(msg.sender, _value, answer);

    }

function purchase(address customer) public payable returns (bool success){
    if (totalSupply == 0){
        mint(customer, 1000);
    }
    else{
    require(msg.sender == admin);
    uint256 silkValue = div(address(this).balance-msg.value, totalSupply);
    uint256 answer = div(msg.value, silkValue);
    uint256 reward = answer;
    mint(customer, answer);
    emit Purchase(customer, msg.value, answer);
    return true;
    }
}

function fallback() external payable { 
    
}

// function getBalance(address user) public returns(uint256 answer){
//     uint256 answer = balanceOf[user];
//     return answer;

// }

}