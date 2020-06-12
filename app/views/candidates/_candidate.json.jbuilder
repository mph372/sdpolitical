json.extract! candidate, :id, :district_id, :birth_date, :party, :professional_career, :email, :campaign_website, :twitter, :facebook, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
