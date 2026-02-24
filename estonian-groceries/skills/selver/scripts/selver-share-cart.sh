#!/usr/bin/env bash
set -euo pipefail

cart_id="${1:?Usage: selver-share-cart.sh <cartId>}"

response=$(curl -s -X POST "https://www.selver.ee/api/ext/tkg-sales/share-cart/generate?token=&storeCode=et" \
  -H "Content-Type: application/json" \
  -d "{\"guestMaskedCartId\":\"${cart_id}\"}")

hash=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin)['result'])")

echo "https://www.selver.ee/cart/restore-share/${hash}"
