json.extract! document, :id, :name, :description, :expires, :expiration_type, :days_of_validity, :allow_modify_expiration, :observations, :renewal_methodology, :start_date, :end_date, :active, :created_at, :updated_at
json.url document_url(document, format: :json)
