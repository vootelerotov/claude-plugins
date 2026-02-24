# Selver Grocery Shopping

Build a Selver.ee grocery cart through conversation.

## Trigger

Activate when the user wants to:
- Shop for groceries at Selver
- Build a Selver shopping cart
- Search for products on Selver.ee
- Create a shareable Selver cart link

## allowed-tools

- Bash(*selver-search.sh*)
- Bash(*selver-create-cart.sh*)
- Bash(*selver-add-items.sh*)
- Bash(*selver-share-cart.sh*)

## Workflow

1. **Search** for products the user wants using `selver-search.sh`
2. **Present results** — show name, price, and SKU; let the user confirm or refine
3. **Create a cart** with `selver-create-cart.sh` (do this once, reuse the cart ID)
4. **Add confirmed items** with `selver-add-items.sh` (batch all items in one call)
5. **Generate a share link** with `selver-share-cart.sh`
6. **Present the URL** so the user can open it in their browser to review/checkout

Always confirm product choices with the user before adding to cart. If a search returns multiple close matches, ask which one they want.

**Note:** The share link merges into the user's existing Selver cart in the browser. Advise the user to clear their selver.ee cart first if they want a clean start.

## Scripts

All scripts are in the `scripts/` directory relative to this file.

### selver-search.sh

Search for products by keyword.

```
selver-search.sh <term> [noOfResults]
```

- `term` — search query (e.g. "piim", "leib", "Kalev šokolaad")
- `noOfResults` — optional, defaults to 6

Returns JSON with product results. Each result has: `name`, `sku`, `salePrice`, `currency`, `url`, `image`.

### selver-create-cart.sh

Create a new guest cart. No arguments.

```
selver-create-cart.sh
```

Returns the cart ID string. Save this — you need it for adding items and sharing.

### selver-add-items.sh

Add one or more items to a cart.

```
selver-add-items.sh <cartId> <sku1:qty1> [sku2:qty2] ...
```

- `cartId` — the cart ID from `selver-create-cart.sh`
- `sku:qty` pairs — product SKU and quantity separated by colon

Returns the API response with cart contents.

### selver-share-cart.sh

Generate a shareable link for a cart.

```
selver-share-cart.sh <cartId>
```

Returns the full URL that opens a pre-filled cart on selver.ee.
