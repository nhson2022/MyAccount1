json.extract! article, :id, :title, :active, :created_at, :updated_at
json.url admin_article_url(article, format: :json)
