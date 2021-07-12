json.extract! candidate, :id, :campaign_id, :person_id, :ballot_status, :campaign_email, :campaign_phone, :campaign_twitter, :campaign_facebook, :campaign_website, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
