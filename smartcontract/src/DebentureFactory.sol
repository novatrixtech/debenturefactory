// SPDX-License-Identifier: GPL-3
pragma solidity 0.8.20;

import "./Debenture.sol";

contract DebentureFactory {
    event DebentureCreated(address indexed issuer, address indexed debenture);

    DebentureX[] public debentures;
    uint256 public debentureCount;

    function createDebenture(
        uint256 initialSupply_,
        string memory name_,
        string memory symbol_,
        string memory issuer_,
        uint256 expirationDate_,
        address custodian_
    ) external returns (address) {
        DebentureX debenture = new DebentureX(
            initialSupply_,
            name_,
            symbol_,
            issuer_,
            expirationDate_,
            custodian_
        );
        emit DebentureCreated(msg.sender, address(debenture));
        debentures.push(debenture);
        debentureCount++;
        return address(debenture);
    }
}