json.extract! transaction, :id, :candidate_committees_id, :uploads_id, :transaction_type, :entity_type, :entity_last_name, :entity_first_name, :entity_addr1, :entity_addr2, :entity_city, :entity_state, :entity_zip, :entity_employer, :entity_occupation, :transaction_date, :amount, :expense_code, :description, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
