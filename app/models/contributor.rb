class Contributor < ApplicationRecord
  has_many :transactions

def generate_full_name
  contrib_full_name = "#{first_name} #{last_name}"
  update_attributes(full_name: contrib_full_name)
end

def contributor_cleanup
  if transactions.count == 0
    self.class.delete(id)
  end
end

def contributor_merge
  Contributor.all.each do |c|
    if full_name.downcase.similar(c.full_name.downcase) > 90
      c.transactions.each do |t|
        t.update_attributes(contributor_id: id)
      end
      c.full_name.titlecase
      c.save
    end
  end
end



end
