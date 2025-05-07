#!/bin/bash

source .env
set -e

GREEN='\e[32m'
RESET='\e[0m'

cd verifier_kill_sheep

# Declare all contracts
echo -e "$GREEN\n==> Declare KillSheep$RESET"
DECLARED_CLASSHASH=$(starkli declare --watch \
    --account $ACCOUNT_SRC \
    --rpc $RPC_URL \
    --keystore $KEYSTORE_SRC \
    --keystore-password $KEYSTORE_PASSWORD \
    ./target/dev/verifier_UltraKeccakHonkVerifier.contract_class.json)

echo -e "$GREEN\nDeclared Classhash: $DECLARED_CLASSHASH$RESET"

