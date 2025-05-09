#!/bin/bash

set -e

cd contracts
# Limpiar carpetas antiguas si existen
if [ -d "target" ]; then
    rm -rf "target"
fi

if [ -d "manifests" ]; then
    rm -rf "manifests"
fi

echo "sozo -P sepolia build && sozo -P sepolia inspect && sozo -P sepolia migrate"
sozo -P sepolia build && sozo -P sepolia inspect && sozo -P sepolia migrate

echo -e "\n✅ Setup finish!"

# 
# slot d create --tier basic hunter torii --rpc https://starknet-sepolia.public.blastapi.io/rpc/v0_7 --world 0x00eb8bdd3fa6d122b7b4586f43894074e69a93a7d14197e24c99147e9318e2b8 -v v1.2.1
