json.extract! committee, :id, :name, :jurisdiction_id, :type, :candidate_id, :incumbent_id, :measure_id, :support, :is_active, :created_at, :updated_at
json.url committee_url(committee, format: :json)
