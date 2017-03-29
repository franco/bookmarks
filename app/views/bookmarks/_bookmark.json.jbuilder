json.extract! bookmark, :id, :name, :url, :short_url, :site_id, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)
