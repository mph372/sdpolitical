json.extract! person, :id, :district_id, :title, :first_name, :last_name, :birthdate, :party, :first_elected, :prior_elected, :salary, :professional_career, :congressional_district, :assembly_district, :senate_district, :supe_district, :birthplace, :email, :twitter, :facebook, :phone, :term, :on_ballot, :image, :term_expires, :seeking_office, :official_website, :campaign_website, :is_incumbent, :created_at, :updated_at
json.url person_url(person, format: :json)
