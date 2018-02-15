pragma solidity 0.4.19;

/**
 * @title Recorder — record a message into the blockchain
 */

contract Recorder {
  event Record(
    address _from,
    string _message
  );
  
  /**
   * @notice Sends the contract a message
   * to record into the blockchain
   * @param message  message to record
   */
  function record(string message) {
    Record(msg.sender, message);
  }
}