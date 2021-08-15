json.extract! word, :id, :word, :definition, :status, :user_id, :created_at, :updated_at
json.url word_url(word, format: :json)
