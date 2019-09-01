// Contract: generate rooms

pragma solidity ^0.5.10;


import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Pausable.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";
import "./Room.sol";

contract RoomFactory is Destructible, Pausable {

  event RoomCreated(
    address indexed _creator,
    address _room,
    uint256 _depositedValue
  );

  function createRoom() external payable whenNotPaused {
    // var constructor = new Room;
    // address newRoom = constructor.value(msg.value)(msg.sender);
    address newRoom = (new Room).value(msg.value)(msg.sender);
    emit RoomCreated(msg.sender,newRoom, msg.value);
  }
}
