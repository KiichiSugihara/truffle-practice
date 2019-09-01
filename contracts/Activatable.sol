// Contract: judge  contract on-off


pragma solidity ^0.5.10;

import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Activatable is Ownable {

    event Deactivate(address indexed _sender);
    event Activate(address indexed _sender);


    bool public active = false;


    modifier whenActive() {
        require(active,'Deactive');
        _;
    }


    modifier whenNotActive() {
        require(!active,'Active');
        _;
    }


    function deactivate() public whenActive onlyOwner {
        active = false;
        emit Deactivate(msg.sender);
    }


    function activate() public whenNotActive onlyOwner {
        active = true;
        emit Activate(msg.sender);
    }
}
