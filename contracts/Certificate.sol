// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Certificate {
    uint256 public certificateCount;

    struct Cert {
        string student;
        string course;
        string org;
        address issuer;
        uint256 issuedAt;
    }

    mapping(uint256 => Cert) public certificates;
    mapping(address => uint256[]) private byIssuer;

    // Event with indexed certId & issuer (easier filtering)
    event CertificateIssued(
        uint256 indexed certId,
        string student,
        string course,
        string org,
        address indexed issuer,
        uint256 issuedAt
    );

    // ✅ Issue a certificate (issuer is msg.sender automatically)
    function issueCertificate(
        string calldata student,
        string calldata course,
        string calldata org
    ) external returns (uint256) {
        require(bytes(student).length > 0, "Student required");
        require(bytes(course).length > 0, "Course required");
        require(bytes(org).length > 0, "Organization required");

        certificateCount++;

        certificates[certificateCount] = Cert({
            student: student,
            course: course,
            org: org,
            issuer: msg.sender,        // ✅ no need to pass issuer
            issuedAt: block.timestamp
        });

        byIssuer[msg.sender].push(certificateCount);

        emit CertificateIssued(
            certificateCount,
            student,
            course,
            org,
            msg.sender,
            block.timestamp
        );

        return certificateCount;
    }

    // ✅ Get all cert IDs issued by a specific address
    function getCertIdsByIssuer(address issuer)
        external
        view
        returns (uint256[] memory)
    {
        return byIssuer[issuer];
    }

    // ✅ Get full certificate details
    function getCertificate(uint256 certId)
        external
        view
        returns (Cert memory)
    {
        return certificates[certId];
    }
}
