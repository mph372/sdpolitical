class Incumbent < ApplicationRecord
    belongs_to :district
    mount_uploader :image, IncumbentUploader
end
