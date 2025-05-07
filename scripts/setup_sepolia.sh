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

# Guardar resultado de sozo inspect
inspect_result=$(sozo inspect)
world_address=$(echo "$inspect_result" | awk '/World/ {getline; getline; print $3}')

echo -e "\n✅ Init Torii!"
torii --world $world_address --http.cors_origins "*"

echo -e "\n✅ Todo listo!"
