// Contract: express a room

pragma solidity ^0.5.10;

import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Pausable.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

contract Room is Destructible, Pausable {

    //状態変数 rewardSent
    mapping(uint256 => bool) public rewardSent;

    event Deposited(
        address indexed _depositor,
        uint256 _depositedValue
    );

    event RewardSent(
        address indexed _dest,
        uint256 _reward,
        uint256 _id
    );

    event RefundedToOwner(
        address indexed _dest,
        uint256 _refundedBalance
    );

    constructor(address _creator) public payable {
        owner = _creator;
    }


    function deposit() external payable whenNotPaused {
        require(msg.value > 0, "0 Ehter");
        emit Deposited(msg.sender, msg.value);
    }

    function sendReward(uint256 _reward, address _dest, uint256 _id) external onlyOwner {
        require(!rewardSent[_id],"You have Sent");
        require(_reward > 0,"Need: reward > 0");
        require(address(this).balance >= _reward,"yours < reward");
        require(_dest != address(0),"please init address");
        require(_dest != owner,"address is owner");

        rewardSent[_id] = true;
        _dest.transfer(_reward);
        emit RewardSent(_dest, _reward, _id);
    }

    function refundToOwner() external onlyOwner {
        require(address(this).balance > 0, "refund is 0");

        uint256 refundedBalance = address(this).balance;
        owner.transfer(refundedBalance);
        emit RefundedToOwner(msg.sender, refundedBalance);
    }
}
