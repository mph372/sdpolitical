json.extract! campaign, :id, :district_id, :election_date, :election_type, :number_of_winners, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
