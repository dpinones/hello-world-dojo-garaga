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

echo "sozo build && sozo inspect && sozo migrate"
sozo -P sepolia build && sozo -P sepolia inspect && sozo -P sepolia migrate

echo -e "\n✅ Setup finish!"

