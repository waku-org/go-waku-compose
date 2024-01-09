#!/bin/sh

if test -f $(pwd)/keystore/keystore.json; then
  echo "keystore/keystore.json already exists. Use it instead of creating a new one."
  echo "Exiting"
  exit 1
fi

if test -f .env; then
  echo "Using .env file"  
  . $(pwd)/.env
fi
 
# TODO: Set go-waku release when ready

docker run -v $(pwd)/keystore:/keystore/:Z wakuorg/go-waku:v0.9.0 generate-rln-credentials \
--eth-client-address=${ETH_CLIENT_ADDRESS} \
--eth-account-private-key=${ETH_TESTNET_KEY} \
--eth-contract-address=0xF471d71E9b1455bBF4b85d475afb9BB0954A29c4 \
--cred-path=/keystore/keystore.json \
--cred-password="${RLN_RELAY_CRED_PASSWORD}"

