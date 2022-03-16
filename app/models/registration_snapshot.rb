class RegistrationSnapshot < ApplicationRecord
  belongs_to :statistical_datum
  delegate :district, to: :statistical_datum

  def democrat_percentage
    (registered_dem.to_f / total_registered) * 100
  end

  def republican_percentage
    (registered_rep.to_f / total_registered) * 100
  end

  def other_percentage
    ((total_registered - (registered_rep.to_f + registered_dem.to_f)) / total_registered) * 100
  end

  def registration_advantage
    democrat_percentage - republican_percentage
  end

  def absolute_registration_advantage
    registration_advantage*-1
  end

  def display_registration_advantage
    if registration_advantage > 0 
      "D+ #{ActionController::Base.helpers.number_with_precision(registration_advantage.abs, precision: 2)}"
    else
      "R+ #{ActionController::Base.helpers.number_with_precision(registration_advantage.abs, precision: 2)}"
    end
  end
end
