#!/usr/bin/env bash
set -euo pipefail

cart_id=$(curl -s -X POST "https://www.selver.ee/api/cart/create?storeCode=et" \
  -H "Content-Type: application/json" \
  | python3 -c "import sys, json; print(json.load(sys.stdin)['result'])")

echo "$cart_id"
