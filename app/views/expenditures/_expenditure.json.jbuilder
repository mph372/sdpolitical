json.extract! expenditure, :id, :expenditure_date, :description, :amount, :person_id, :measure_id, :is_support, :is_amendment, :created_at, :updated_at
json.url expenditure_url(expenditure, format: :json)
