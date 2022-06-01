class Vendor < ApplicationRecord
    has_many :transactions

    def generate_full_name
        contrib_full_name = "#{first_name} #{last_name}"
        update_attributes(full_name: contrib_full_name)
    end

    def vendor_cleanup
        if transactions.count == 0
          self.class.delete(id)
        end
      end

      def vendor_merge
        Vendor.all.each do |c|
          if full_name.downcase.similar(c.full_name.downcase) > 90
            c.transactions.each do |t|
              t.update_attributes(vendor_id: id)
            end
            c.full_name.titlecase
          end
        end
      end  

end
