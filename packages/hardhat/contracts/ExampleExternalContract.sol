// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

contract ExampleExternalContract {


  bool public completed;

  address private sender;

  modifier authorised {
    bool completed = sender == msg.sender;
    require(completed, "Unauthorised");
    _;
  }

  function complete() public payable {
    completed = true;
    sender = msg.sender;
  }

  function redeposit() public authorised {

    uint256 contractBalance = address(this).balance;

    (bool sent, bytes memory data) = sender.call{value: contractBalance }("");

    require(sent, "RIP; redeposit failed :( ");

    completed = false;

  }

}
