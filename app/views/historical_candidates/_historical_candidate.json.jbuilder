json.extract! historical_candidate, :id, :election_history_id, :first_name, :last_name, :votes, :is_winner, :created_at, :updated_at
json.url historical_candidate_url(historical_candidate, format: :json)
