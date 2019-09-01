// Contract: generate rooms

pragma solidity ^0.5.10;

import "./Room.sol";

contract RoomFactory {
  function createRoom() external payable {
    // var constructor = new Room;
    // address newRoom = constructor.value(msg.value)(msg.sender);
    address newRoom = (new Room).value(msg.value)(msg.sender);
  }
}
