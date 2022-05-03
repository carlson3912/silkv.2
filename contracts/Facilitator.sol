pragma solidity >=0.4.22 <0.9.0;

contract Facilitator{
 mapping(address => bool) public approvedMerchants;
 mapping(address => bool) public manufacturers;
 mapping(address => mapping (uint32 => uint256)) public manufacturingCost;
 mapping(address => uint256) public balanceOf;
 uint256 public totalSupply;
 
 function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "can't divide by zero");
        uint256 c = a / b;
        return c;
    }

 function changeCosts(uint32 itemID, uint256 newPrice){
     require(approvedMerchants[msg.sender] == true);
     manufacturingCost[msg.sender][itemID] = newPrice;
 }

 function changeManu(address store, bool typeOf){
    require (balanceOf[msg.sender] > totalSupply /2);
    if (typeOf == true){
        manufacturers[store] = true;
    }
    else{
        manufaturers[store] = false;
    }
 }

 function changeStore(address store, bool typeOf){
    require (balanceOf[msg.sender] > totalSupply /2);
    if (typeOf == true){
        approvedMerchants[store] = true;
    }
    else{
        approvedMerchants[store] = false;
    }
 }

 function buyItem(address store, uint256 itemID){
     require (approvedMerchants[store] == true);
     var(manu, newID, profit) = store.purchase(msg.sender, itemID);
     uint256 cost = manufacturingCost[manu][newID];
     require(msg.value >= profit + cost);
     require(manufacturers[manu] == true);
     payable(manu).transfer(cost);
     uint256 storeReward = 0.05 * profit;
     mint(store, storeReward);
     payable(store).transfer(profit-storeReward);
     }

    function mint(address target, uint256 profit) internal {
        uint256 tokenValue = div(address(this).balance-profit, totalSupply);
        uint256 answer = div(profit, silkValue);
        totalSupply += answer;
        balanceOf[target] += answer;
    }
}