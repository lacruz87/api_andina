json.extract! product, :id, :sku, :desc, :stock, :cjxpallet, :created_at, :updated_at
json.url product_url(product, format: :json)
