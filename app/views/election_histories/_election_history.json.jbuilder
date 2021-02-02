json.extract! election_history, :id, :cycle, :election_type, :election_date, :number_winners, :total_votes, :district_id, :created_at, :updated_at
json.url election_history_url(election_history, format: :json)
