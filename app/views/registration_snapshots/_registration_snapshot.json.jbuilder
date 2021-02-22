json.extract! registration_snapshot, :id, :snapshot_date, :total_registered, :registered_dem, :registered_rep, :registered_other, :StatisticalData_id, :created_at, :updated_at
json.url registration_snapshot_url(registration_snapshot, format: :json)
