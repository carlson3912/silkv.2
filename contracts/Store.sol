pragma solidity >=0.4.22 <0.9.0;
import './Silk.sol';

contract Store{
    struct Product{
        uint256 supply;
        address manufacturer;
        uint64 manuID;
        uint256 profit;
    }

    mapping (uint256 => Product) Products;
    Silk public tokenInstance;
    address admin = 0x75702ff96FB57b16006857e4671E3DFb6199757a;
    
    function purchase(address customer, uint256 itemID) public payable returns(address, uint64, uint256){
        Product item = Products[itemID]; 
        require(item.supply > 0);
        tokenInstance.purchase{msg.value}(customer);
        return (item.manufacturer, item.manuID, item.profit);

    }

    function addProduct(uint256 itemID, uint256 supply, address manufacturer, uint64 manuID, uint256 profit) public{
        require(msg.sender = admin);
        Product item = Products(supply, manufacturer, manuID, profit);
        Products[itemID] = item;
    }


}