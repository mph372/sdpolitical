json.extract! itemized_expenditure, :id, :expenditure_id, :date, :description, :amount, :created_at, :updated_at
json.url itemized_expenditure_url(itemized_expenditure, format: :json)
