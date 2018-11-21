# frozen_string_literal: true

json.extract! list, :id, :name, :position, :created_at, :updated_at
json.url list_url(list, format: :json)
