//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AttestationEntrypointBase.sol";
import "./bases/FeeManagerBase.sol";

/**
 * @title Automata DCAP Attestation With Fee
 * @notice This contract collects a fee, based on a certain % of transaction fee
 * needed to perform DCAP attestation.
 */
contract AutomataDcapAttestationFee is FeeManagerBase, AttestationEntrypointBase {
    constructor(address owner) AttestationEntrypointBase(owner) {}

    function setBp(uint16 _newBp) public override onlyOwner {
        super.setBp(_newBp);
    }

    function withdraw(address beneficiary, uint256 amount) public override onlyOwner {
        super.withdraw(beneficiary, amount);
    }

    function verifyAndAttestOnChain(bytes calldata rawQuote)
        external
        payable
        collectFee
        returns (bool success, bytes memory output)
    {
        (success, output) = _verifyAndAttestOnChain(rawQuote, 0);
    }

    function verifyAndAttestWithZKProof(
        bytes calldata output,
        ZkCoProcessorType zkCoprocessor,
        bytes calldata proofBytes
    ) external payable collectFee returns (bool success, bytes memory verifiedOutput) {
        (success, verifiedOutput) = _verifyAndAttestWithZKProof(output, zkCoprocessor, proofBytes, 0);
    }

    function verifyAndAttestOnChain(bytes calldata rawQuote, uint32 tcbEvaluationDataNumber)
        external
        payable
        collectFee
        returns (bool success, bytes memory output)
    {
        (success, output) = _verifyAndAttestOnChain(rawQuote, tcbEvaluationDataNumber);
    }

    function verifyAndAttestWithZKProof(
        bytes calldata output,
        ZkCoProcessorType zkCoprocessor,
        bytes calldata proofBytes,
        uint32 tcbEvaluationDataNumber
    ) external payable collectFee returns (bool success, bytes memory verifiedOutput) {
        (success, verifiedOutput) = _verifyAndAttestWithZKProof(output, zkCoprocessor, proofBytes, tcbEvaluationDataNumber);
    }
}
