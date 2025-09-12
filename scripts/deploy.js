// scripts/deploy.js
const fs = require("fs");
const path = require("path");
const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("🚀 Deploying contracts with account:", deployer.address);

  // Get contract factory
  const Certificate = await hre.ethers.getContractFactory("Certificate");

  // Deploy contract
  const certificate = await Certificate.deploy();
  await certificate.waitForDeployment();

  // Get deployed address
  const address = await certificate.getAddress();
  console.log("✅ Certificate contract deployed to:", address);

  // ✅ Save ABI + address to frontend
  const contractsDir = path.join(__dirname, "..", "frontend", "src", "abi");

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir, { recursive: true });
  }

  // Get ABI using Hardhat's artifacts
  const artifact = await hre.artifacts.readArtifact("Certificate");

  const data = {
    address,
    abi: artifact.abi,
  };

  fs.writeFileSync(
    path.join(contractsDir, "CertificateABI.json"),
    JSON.stringify(data, null, 2)
  );

  console.log("📁 ABI + address saved to frontend/src/abi/CertificateABI.json");
}

// Run
main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
