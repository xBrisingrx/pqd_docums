json.extract! ticket_book, :id, :name, :status, :active, :created_at, :updated_at
json.url ticket_book_url(ticket_book, format: :json)
