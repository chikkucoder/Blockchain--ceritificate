# 🚀 Vercel Deployment Guide - CertChain Validator

## Prerequisites

1. **GitHub Account** - Your code should be in a GitHub repository
2. **Vercel Account** - Sign up at [vercel.com](https://vercel.com)
3. **Smart Contract Deployed** - Deploy your contract to a testnet/mainnet (e.g., Sepolia, Polygon, etc.)
4. **MetaMask** - Users will connect their own wallets

---

## 📋 Step-by-Step Deployment

### Step 1: Deploy Smart Contract to Testnet

Before deploying frontend, deploy your contract to a public network:

#### Option A: Deploy to Sepolia Testnet

1. Get Sepolia ETH from faucet: https://sepoliafaucet.com/
2. Update `hardhat.config.js` with Sepolia network config
3. Deploy contract:
   ```bash
   npx hardhat run scripts/deploy.js --network sepolia
   ```
4. **Save the deployed contract address!** (e.g., `0x1234...abcd`)

#### Option B: Deploy to Other Networks

- **Polygon Mumbai**: https://faucet.polygon.technology/
- **BSC Testnet**: https://testnet.binance.org/faucet-smart
- **Arbitrum Goerli**: https://bridge.arbitrum.io/

---

### Step 2: Prepare Your Repository

1. **Commit all changes** to your GitHub repository:
   ```bash
   git add .
   git commit -m "Prepare for Vercel deployment"
   git push origin main
   ```

2. **Verify these files exist:**
   - ✅ `vercel.json` (root directory)
   - ✅ `client/.env.example` (for reference)
   - ✅ `client/src/config/contractConfig.js`

---

### Step 3: Deploy to Vercel

1. **Go to [vercel.com](https://vercel.com)** and login

2. **Click "Add New Project"**

3. **Import your GitHub repository**

4. **Configure Project Settings:**
   - **Framework Preset**: Create React App
   - **Root Directory**: `client`
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`

5. **Add Environment Variables** (Click "Environment Variables"):

   ```
   REACT_APP_CONTRACT_ADDRESS=0xYOUR_DEPLOYED_CONTRACT_ADDRESS
   REACT_APP_NETWORK_NAME=sepolia
   REACT_APP_CHAIN_ID=11155111
   REACT_APP_URL=https://your-app.vercel.app
   ```

   **Important Chain IDs:**
   - Ethereum Mainnet: `1`
   - Sepolia Testnet: `11155111`
   - Polygon Mainnet: `137`
   - Polygon Mumbai: `80001`
   - BSC Mainnet: `56`
   - Arbitrum One: `42161`

6. **Click "Deploy"** 🚀

---

### Step 4: Update ABI File (After Contract Deployment)

After deploying to testnet, update your contract ABI:

1. Copy ABI from `artifacts/contracts/Certificate.sol/Certificate.json`
2. Update `client/src/abi/CertificateABI.json` with:
   ```json
   {
     "address": "0xYOUR_DEPLOYED_CONTRACT_ADDRESS",
     "abi": [/* your contract ABI */]
   }
   ```
3. Commit and push changes
4. Vercel will auto-deploy!

---

### Step 5: Configure MetaMask Network (For Users)

Your users need to add the network in MetaMask:

#### For Sepolia Testnet:
- **Network Name**: Sepolia
- **RPC URL**: `https://sepolia.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161`
- **Chain ID**: `11155111`
- **Currency Symbol**: ETH
- **Block Explorer**: `https://sepolia.etherscan.io`

---

## 🔧 Troubleshooting

### Contract Not Found Error

If users see "No contract at address" error:

1. Verify environment variables in Vercel dashboard
2. Check contract address is correct
3. Ensure contract is deployed on the network specified in `REACT_APP_CHAIN_ID`
4. Redeploy Vercel app after fixing env vars

### MetaMask Connection Issues

1. Users must connect MetaMask to the same network as your contract
2. Add network switch button (already implemented in `IssueCertificateTab.js`)
3. Check browser console for detailed errors

### Build Failures

```bash
# Test build locally first
cd client
npm run build
```

If build fails:
- Check for missing dependencies
- Verify all imports are correct
- Check console error messages in Vercel logs

---

## 🎯 Post-Deployment Checklist

- [ ] Contract deployed to testnet/mainnet
- [ ] Environment variables set in Vercel
- [ ] App builds and deploys successfully
- [ ] Can connect MetaMask wallet
- [ ] Can issue certificates
- [ ] Can verify certificates
- [ ] Can view certificates
- [ ] QR codes work correctly
- [ ] Mobile view working

---

## 🌐 Custom Domain (Optional)

1. Go to Vercel project settings
2. Click "Domains"
3. Add your custom domain (e.g., `certchain.yourdomain.com`)
4. Update DNS records as instructed
5. Update `REACT_APP_URL` environment variable

---

## 📱 Production Best Practices

### Security

1. **Never commit private keys** to GitHub
2. Use environment variables for all sensitive data
3. Enable HTTPS (Vercel does this automatically)
4. Implement proper access controls in smart contract

### Performance

1. Optimize images and assets
2. Enable caching in Vercel
3. Use CDN for static assets
4. Monitor gas costs on mainnet

### User Experience

1. Show clear error messages
2. Add loading states
3. Implement transaction confirmations
4. Provide network switching prompts

---

## 🆘 Support

### Useful Links

- **Vercel Docs**: https://vercel.com/docs
- **Hardhat Docs**: https://hardhat.org/docs
- **Ethers.js Docs**: https://docs.ethers.io/
- **MetaMask Docs**: https://docs.metamask.io/

### Common Commands

```bash
# Test locally
cd client
npm start

# Build for production
npm run build

# Deploy contract to testnet
npx hardhat run scripts/deploy.js --network sepolia

# Verify contract on Etherscan
npx hardhat verify --network sepolia YOUR_CONTRACT_ADDRESS
```

---

## 🎉 Success!

Your CertChain Validator is now live on Vercel! 

**Next Steps:**
1. Share your app URL with users
2. Guide users to add your contract network to MetaMask
3. Monitor transactions on block explorer
4. Collect feedback and iterate

**Example Deployed Apps:**
- Main App: `https://certchain-validator.vercel.app`
- Certificate Verification: `https://certchain-validator.vercel.app/verify`

---

**Note**: This is a testnet deployment. For production mainnet deployment, ensure thorough security audits of your smart contract!
