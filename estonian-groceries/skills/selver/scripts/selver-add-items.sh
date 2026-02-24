#!/usr/bin/env bash
set -euo pipefail

cart_id="${1:?Usage: selver-add-items.sh <cartId> <sku1:qty1> [sku2:qty2] ...}"
shift

if [ $# -eq 0 ]; then
  echo "Error: at least one sku:qty pair required" >&2
  exit 1
fi

items_json="["
first=true
for pair in "$@"; do
  sku="${pair%%:*}"
  qty="${pair##*:}"
  if [ "$first" = true ]; then
    first=false
  else
    items_json+=","
  fi
  items_json+="{\"sku\":\"${sku}\",\"qty\":${qty}}"
done
items_json+="]"

body="{\"cartId\":\"${cart_id}\",\"cartItems\":${items_json}}"

curl -s -X POST "https://www.selver.ee/api/ext/tkg-sales/cart/add-cart-items?cartId=${cart_id}&storeCode=et" \
  -H "Content-Type: application/json" \
  -d "$body"
