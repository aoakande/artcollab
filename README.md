# ArtCollab: Decentralized Artist Collaboration Platform

## Overview
ArtCollab revolutionizes digital art collaboration by leveraging the Stacks blockchain to ensure fair attribution and automatic revenue distribution for collaborative artwork. Built with Clarity smart contracts, it provides a trustless platform for artists to work together while maintaining transparent ownership and revenue sharing.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/aoakande/artcollab.git
cd artcollab

# Install dependencies
npm install

# Run local Stacks blockchain
clarinet integrate

# Deploy contracts (local)
clarinet deploy
```

## Smart Contract Integration

### 1. Submit an Art Contribution

```clarity
;; Example: Submit a new contribution
(contract-call? .contribution-manager submit-contribution 
    u1  ;; artwork-id
    "concept"  ;; contribution-type
    "ipfs://QmXzK..." ;; metadata-url
    u20  ;; weight (percentage)
)
```

### 2. Check Contribution Status

```clarity
;; Example: Get contribution details
(contract-call? .contribution-manager get-contribution u1)
```

### 3. Revenue Distribution

```clarity
;; Example: Distribute revenue for artwork
(contract-call? .revenue-distribution distribute-artwork-revenue 
    u1  ;; artwork-id
    u1000  ;; amount in STX
)
```

## Contract Architecture

### Contribution Manager
- Tracks individual contributions
- Validates contribution types
- Manages contribution weights

### Ownership Contract
- Calculates ownership shares
- Manages ownership transfers
- Tracks total contributions

### Revenue Distribution
- Automatic revenue splitting
- Real-time distribution
- Multiple payment support

## Development Setup

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) - Stacks smart contract development tool
- [Node.js](https://nodejs.org/) (v14 or higher)
- [Hiro Wallet](https://wallet.hiro.so/) for testing

### Local Development

1. Install Clarinet:
```bash
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.0.0/clarinet-linux-x64.tar.gz | tar xz
sudo mv clarinet /usr/local/bin
```

2. Initialize Project:
```bash
clarinet new artcollab
cd artcollab
```

3. Test Contracts:
```bash
clarinet test
```

### Contract Deployment

1. Local Testing:
```bash
clarinet deploy --local
```

2. Testnet Deployment:
```bash
clarinet deploy --testnet
```

## Testing

Run the test suite:
```bash
clarinet test tests/contribution-manager_test.clar
```

Example test output:
```
✓ Should allow contribution submission
✓ Should validate contribution types
✓ Should track ownership correctly
✓ Should distribute revenue fairly
```

## Frontend Integration

```typescript
// Example: Submit contribution using frontend
import { openContractCall } from '@stacks/connect';

const submitContribution = async () => {
  const functionArgs = [
    uintCV(1), // artwork-id
    stringAsciiCV('concept'), // contribution-type
    stringAsciiCV('ipfs://QmXzK...'), // metadata-url
    uintCV(20), // weight
  ];

  const options = {
    contractAddress: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
    contractName: 'contribution-manager',
    functionName: 'submit-contribution',
    functionArgs,
    network: 'testnet',
  };

  await openContractCall(options);
};
```

## Project Structure
```
artcollab/
├── contracts/
│   ├── contribution-manager.clar    # Contribution tracking
│   ├── ownership-manager.clar       # Ownership management
│   └── revenue-distribution.clar    # Revenue distribution
├── tests/
│   └── contribution-manager_test.clar
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   └── contracts/
│   └── public/
└── docs/
```

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## Common Issues & Solutions

### Issue: Contract Deployment Fails
Solution: Ensure you have sufficient STX balance and correct network selected

### Issue: Contribution Submission Fails
Solution: Check contribution type matches allowed types: "concept", "linework", "coloring", "background", "details"

## License
MIT License - see LICENSE.md

## Support
For technical questions, open an issue or contact the maintainers:
- GitHub Issues
- Discord Community (Coming soon)
