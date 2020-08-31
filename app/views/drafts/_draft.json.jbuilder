json.extract! draft, :id, :title, :content, :category_id, :approval_status_id, :created_at, :updated_at
json.url draft_url(draft, format: :json)
