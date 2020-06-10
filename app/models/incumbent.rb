class Incumbent < ApplicationRecord
    belongs_to :district
    mount_uploader :image, IncumbentUploader

    def calculated_age
        now = Time.now.utc.to_date
        now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
    end
end
