// SPDX-License-Identifier: GPL-3
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DebentureX is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit {

    string public issuer;
    string public issuerTaxId;
    string public issuerCountry;
    string public issuerShareholderMeetingDetails;
    string public collateralDetails;
    uint256 public expirationDate;
    uint256 public sellPeriod;
    uint256 public interestRate;
    uint256 public interestRatePenalty;
    bool public isDebenturePaid;
    address public custodian;
    address public paymentToken;
    string constant debentureType = "book-entry";
    string constant debentureClass = "TBD";
    string public riskRating;
    address public riskRatingAgency;

    // Add penalty and interest rate
    
    event DebenturePaid();
    event DebentureClaimed();
    event DebentureRelevantInfo(string info);

    constructor(
      uint256 initialSupply_,
      string memory name_,
      string memory symbol_,
      string memory issuer_,
      string memory issuerTaxId_,
      string memory issuerCountry_,
      string memory issuerShareholderMeetingDetails_,
      string memory collateralDetails_,
      string memory riskRating_,
      uint256 memory interestRate_,
    uint256 memory interestRatePenalty_,
      uint256 expirationDate_,
      uint256 sellPeriod_,
        address riskRatingAgency_,
      address custodian_,
      address paymentToken_
    )
        ERC20(name_, symbol_)
        Ownable(custodian_)
        ERC20Permit(name_)
    {
        _mint(msg.sender, initialSupply_ * 10 ** decimals());
        issuer = issuer_;
        issuerTaxId = issuerTaxId_;
        issuerCountry = issuerCountry_;
        issuerShareholderMeetingDetails = issuerShareholderMeetingDetails_;
        collateralDetails = collateralDetails_;
        expirationDate = expirationDate_;
        custodian = custodian_; 
        paymentToken = paymentToken_;               
        sellPeriod = sellPeriod_;
        riskRating = riskRating_;
        riskRatingAgency= riskRatingAgency_,
        interestRate = interestRate_;
        interestRatePenalty = interestRatePenalty_;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }

    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    function actualValue() public view returns (uint256) {
        uint256 formulaToBeDefined = 0;
        return balanceOf(msg.sender) + formulaToBeDefined;
    }

    // paymentOrClaim function to be defined
    function paymentOrClaim() public view returns (bool) {
        if (expirationDate < block.timestamp) {
            return false;
        }
        return true;
    }

    function changeCustodian(address newCustodian) public onlyOwner {
        custodian = newCustodian;
        owner = custodian;
    }

    function updateRiskRating(string memory newRiskRating) public  {
        require(riskRatingAgency == msg.sender, "Only the risk rating agency can update the risk rating");
        riskRating = newRiskRating;
    }

    function registerRelevantInfo(string memory info) public onlyOwner {
        emit DebentureRelevantInfo(info);
    }
}
