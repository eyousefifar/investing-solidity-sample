// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CompanyInvestment {
    struct Investor {
        address payable investorAddress;
        uint256 investedAmount;
        uint256 kpiThreshold;
        bool active;
    }

    mapping(address => Investor) public investors;
    address public companyAddress;
    uint256 public totalInvestedAmount;
    uint256 public totalKpiThreshold;
    bool public companyKpiMet;
    bool public investmentClosed;

    event InvestmentReceived(address indexed investor, uint256 amount);
    event KpiThresholdUpdated(uint256 newThreshold);
    event KpiMet();

    constructor(address _companyAddress, uint256 _kpiThreshold) {
        companyAddress = _companyAddress;
        totalKpiThreshold = _kpiThreshold;
        companyKpiMet = false;
        investmentClosed = false;
    }

    modifier onlyCompany() {
        require(msg.sender == companyAddress, "Only the company can call this function");
        _;
    }

    modifier investmentOpen() {
        require(!investmentClosed, "Investment period is closed");
        _;
    }

    function invest() external payable investmentOpen {
        require(msg.value > 0, "Investment amount must be greater than zero");
        Investor storage investor = investors[msg.sender];
        if (investor.investorAddress == address(0)) {
            investor.investorAddress = payable(msg.sender);
            investor.active = true;
        }
        investor.investedAmount += msg.value;
        totalInvestedAmount += msg.value;

        emit InvestmentReceived(msg.sender, msg.value);
    }

    function updateKpiThreshold(uint256 _newThreshold) external onlyCompany {
        totalKpiThreshold = _newThreshold;
        emit KpiThresholdUpdated(_newThreshold);
    }

    function updateKpiStatus(bool _kpiMet) external onlyCompany {
        require(!investmentClosed, "Investment period is closed");
        require(!companyKpiMet, "KPI already met");

        companyKpiMet = _kpiMet;
        if (_kpiMet) {
            emit KpiMet();
        }
    }

    function closeInvestment() external onlyCompany {
        require(!investmentClosed, "Investment period is already closed");
        investmentClosed = true;
    }

    function withdrawInvestment() external {
        Investor storage investor = investors[msg.sender];
        require(investor.active, "Investor does not exist");
        require(companyKpiMet, "Company has not met the KPI threshold");
        require(investmentClosed, "Investment period is still open");

        uint256 amountToWithdraw = investor.investedAmount;
        investor.investedAmount = 0;
        investor.active = false;

        (bool success, ) = investor.investorAddress.call{value: amountToWithdraw}("");
        require(success, "Failed to send Ether");

        totalInvestedAmount -= amountToWithdraw;
    }
}

