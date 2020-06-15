json.extract! election, :id, :year, :district_id, :election_type, :created_at, :updated_at
json.url election_url(election, format: :json)
