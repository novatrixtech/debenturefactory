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
        string memory issuerTaxId_,
        string memory issuerCountry_,
        string memory issuerShareholderMeetingDetails_,
        string memory collateralDetails_,
        uint256 expirationDate_,
        address custodian_,
        address paymentToken_
    ) external returns (address) {
        DebentureX debenture = new DebentureX(
            initialSupply_,
            name_,
            symbol_,
            issuer_,
            issuerTaxId_,
            issuerCountry_,
            issuerShareholderMeetingDetails_,
            collateralDetails_,
            expirationDate_,
            custodian_,
            paymentToken_
        );
        debentures.push(debenture);
        debentureCount++;
        emit DebentureCreated(msg.sender, address(debenture));
        return address(debenture);
    }    
}