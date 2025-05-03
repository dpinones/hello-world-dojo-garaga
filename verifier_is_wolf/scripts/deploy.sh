#!/bin/bash

source .env
set -e

GREEN='\e[32m'
RESET='\e[0m'

# Declare all contracts
echo -e "$GREEN\n==> Declare MainContract$RESET"
DECLARED_CLASSHASH=$(starkli declare --watch \
    --account $ACCOUNT_SRC \
    --rpc $RPC_URL \
    --keystore $KEYSTORE_SRC \
    --keystore-password $KEYSTORE_PASSWORD \
    ./target/dev/verifier_is_wolf_UltraKeccakHonkVerifier.contract_class.json)

echo -e "$GREEN\nDeclared Classhash: $DECLARED_CLASSHASH$RESET"