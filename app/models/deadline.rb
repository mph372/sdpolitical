class Deadline < ApplicationRecord

    def countdown
        (self.deadline_date - Date.today).to_i
    end
end
