#!/usr/bin/env bash
set -euo pipefail

term="${1:?Usage: selver-search.sh <term> [noOfResults]}"
n="${2:-6}"

encoded_term=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$term")

curl -s "https://eucs2.klevu.com/cloud-search/n-search/search?ticket=klevu-14410928010151845&term=${encoded_term}&responseType=json&noOfResults=${n}&paginationStartsFrom=0&klevuSort=rel&enablePartialSearch=true&showOutOfStockProducts=false" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
records = data.get('result', [])
results = []
for r in records:
    results.append({
        'name': r.get('name', ''),
        'sku': r.get('sku', ''),
        'salePrice': r.get('salePrice', ''),
        'currency': r.get('currency', 'EUR'),
        'url': r.get('url', ''),
        'image': r.get('image', ''),
    })
print(json.dumps(results, indent=2, ensure_ascii=False))
"
