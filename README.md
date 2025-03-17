# E-Catalog API

[![CI](https://github.com/doston9471/e-catalog/actions/workflows/ci.yml/badge.svg)](https://github.com/doston9471/e-catalog/actions/workflows/ci.yml)

A Ruby on Rails API for managing an electronic catalog system. This application provides endpoints for managing brands, product lines, models, shops, and items.

## System Requirements

- Ruby 3.4.2
- MongoDB 4.4+
- Bundler

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/doston9471/e-catalog.git
cd e-catalog
```

2. Install dependencies:
```bash
bundle install
```

3. Set up MongoDB:
Make sure MongoDB is running locally or set the `MONGODB_URL` environment variable to point to your MongoDB instance.

4. Start the server:
```bash
rails server
```

## API Endpoints

### Brands
- `GET /api/v1/brands` - List all brands
- `POST /api/v1/brands` - Create a brand
- `GET /api/v1/brands/:id` - Get a brand
- `PATCH /api/v1/brands/:id` - Update a brand
- `DELETE /api/v1/brands/:id` - Delete a brand

### Product Lines
- `GET /api/v1/product_lines` - List all product lines
- `POST /api/v1/product_lines` - Create a product line
- `GET /api/v1/product_lines/:id` - Get a product line
- `PATCH /api/v1/product_lines/:id` - Update a product line
- `DELETE /api/v1/product_lines/:id` - Delete a product line

### Models
- `GET /api/v1/models` - List all models
- `POST /api/v1/models` - Create a model
- `GET /api/v1/models/:id` - Get a model
- `PATCH /api/v1/models/:id` - Update a model
- `DELETE /api/v1/models/:id` - Delete a model

### Shops
- `GET /api/v1/shops` - List all shops
- `POST /api/v1/shops` - Create a shop
- `GET /api/v1/shops/:id` - Get a shop
- `PATCH /api/v1/shops/:id` - Update a shop
- `DELETE /api/v1/shops/:id` - Delete a shop

### Items
- `GET /api/v1/items` - List all items
- `POST /api/v1/items` - Create an item
- `GET /api/v1/items/:id` - Get an item
- `PATCH /api/v1/items/:id` - Update an item
- `DELETE /api/v1/items/:id` - Delete an item

## API Examples

Here are some example CURL requests to test the API endpoints:

### Brands

```bash
# List all brands
curl http://localhost:3000/api/v1/brands

# Create a brand
curl -X POST http://localhost:3000/api/v1/brands \
  -H "Content-Type: application/json" \
  -d '{"brand": {"name": "Apple", "description": "Consumer electronics company"}}'

# Get a specific brand
curl http://localhost:3000/api/v1/brands/BRAND_ID

# Update a brand
curl -X PATCH http://localhost:3000/api/v1/brands/BRAND_ID \
  -H "Content-Type: application/json" \
  -d '{"brand": {"description": "Updated description"}}'

# Delete a brand
curl -X DELETE http://localhost:3000/api/v1/brands/BRAND_ID
```

### Product Lines

```bash
# Create a product line
curl -X POST http://localhost:3000/api/v1/product_lines \
  -H "Content-Type: application/json" \
  -d '{"product_line": {"name": "iPhone", "category": "Smartphones", "brand_id": "BRAND_ID"}}'

# List product lines
curl http://localhost:3000/api/v1/product_lines

# Update a product line
curl -X PATCH http://localhost:3000/api/v1/product_lines/PRODUCT_LINE_ID \
  -H "Content-Type: application/json" \
  -d '{"product_line": {"category": "Mobile Devices"}}'
```

### Models

```bash
# Create a model
curl -X POST http://localhost:3000/api/v1/models \
  -H "Content-Type: application/json" \
  -d '{
    "model": {
      "name": "iPhone 15 Pro",
      "product_line_id": "PRODUCT_LINE_ID",
      "specifications": {
        "screen_size": "6.1 inches",
        "storage": "256GB",
        "color": "Natural Titanium"
      }
    }
  }'

# List models
curl http://localhost:3000/api/v1/models

# Update a model
curl -X PATCH http://localhost:3000/api/v1/models/MODEL_ID \
  -H "Content-Type: application/json" \
  -d '{
    "model": {
      "specifications": {
        "color": "Black Titanium"
      }
    }
  }'
```

### Shops

```bash
# Create a shop
curl -X POST http://localhost:3000/api/v1/shops \
  -H "Content-Type: application/json" \
  -d '{"shop": {"name": "iStore", "website_url": "https://istore.example.com"}}'

# List shops
curl http://localhost:3000/api/v1/shops

# Update a shop
curl -X PATCH http://localhost:3000/api/v1/shops/SHOP_ID \
  -H "Content-Type: application/json" \
  -d '{"shop": {"website_url": "https://new-istore.example.com"}}'
```

### Items

```bash
# Create an item
curl -X POST http://localhost:3000/api/v1/items \
  -H "Content-Type: application/json" \
  -d '{
    "item": {
      "shop_id": "SHOP_ID",
      "model_id": "MODEL_ID",
      "characteristics": {
        "color": "Natural Titanium",
        "storage": "256GB"
      },
      "prices": [
        {
          "amount": 999.99,
          "currency": "USD"
        },
        {
          "amount": 899.99,
          "currency": "EUR"
        }
      ]
    }
  }'

# List items
curl http://localhost:3000/api/v1/items

# Update an item
curl -X PATCH http://localhost:3000/api/v1/items/ITEM_ID \
  -H "Content-Type: application/json" \
  -d '{
    "item": {
      "prices": [
        {
          "amount": 899.99,
          "currency": "USD"
        }
      ]
    }
  }'
```

Note: Replace `BRAND_ID`, `PRODUCT_LINE_ID`, `MODEL_ID`, `SHOP_ID`, and `ITEM_ID` with actual IDs from your database.

## Data Models

### Brand
- name (string, required, unique)
- description (string)
- has many product lines

### Product Line
- name (string, required)
- category (string, default: "Mobile Phones")
- belongs to brand
- has many models

### Model
- name (string, required)
- specifications (hash)
- belongs to product line

### Shop
- name (string, required, unique)
- website_url (string, required)
- has many items

### Item
- characteristics (hash)
- prices (array of price objects)
- belongs to shop
- belongs to model

## Development

### Running Tests
```bash
rails test
```

### Running RuboCop
```bash
bundle exec rubocop
```

## CI/CD

This project uses GitHub Actions for continuous integration, running:
- RuboCop for code style checking
- Rails tests
- Dependabot for dependency updates

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -am 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
