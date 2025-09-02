#!/bin/bash

RPC_URL="http://localhost:8545"


# Ask for private key dinamically
read -s -p "Insert private key: " PRIVATE_KEY
echo ""

echo "Deploying contracts..."

# Deploy Company and capture address
OUTPUT=$(forge script script/Deploy.s.sol \
    --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast)

COMPANY_ADDRESS=$(echo "$OUTPUT" | grep "DEPLOYED_COMPANY" | awk -F':' '{print $2}')
PRODUCT_ADDRESS=$(echo "$OUTPUT" | grep "DEPLOYED_PRODUCT" | awk -F':' '{print $2}')

echo "✅ Company deployed at: $COMPANY_ADDRESS"
echo "✅ Product deployed at: $PRODUCT_ADDRESS"


