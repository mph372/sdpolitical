class Contributor < ApplicationRecord
  has_many :transactions

def generate_full_name
  contrib_full_name = "#{first_name} #{last_name}"
  update_attributes(full_name: contrib_full_name)
end

end
