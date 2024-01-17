module DistrictsHelper
  # Removed the duplicate methods and consolidated them
  def party_bar_class(party)
    case party
    when 'DEM'
      'dem-bar'
    when 'REP'
      'rep-bar'
    when 'OTHER'
      'other-bar'
    else
      'default-bar-class' # Define a default class if necessary
    end
  end

  def party_text_class(party)
    # This method now just returns 'percentage-badge' as the text color is white for all
    'percentage-badge'
  end

  def bar_color(party)
    case party
    when 'DEM'
      '#0F609B' # Blue color for Democrats
    when 'REP'
      '#A61B1B' # Red color for Republicans
    when 'OTHER'
      '#7069FA' # Purple color for Others
    else
      '#ddd' # Default color
    end
  end

  def render_active_candidates(district_scope)
    if district_scope.campaigns.active.present?
      render partial: 'shared/candidates', locals: {
        district: district_scope,
        candidates: district_scope.campaigns.active.last.candidates,
        campaign: district_scope.campaigns.active.last
      }
    end
  end

  # Helper method to calculate registration advantage
  def calculate_registration_advantage(registration_snapshot)
    # Ensure that there are no nil values
    total_registered = registration_snapshot.total_registered.to_f
    registered_dem = registration_snapshot.registered_dem.to_f
    registered_rep = registration_snapshot.registered_rep.to_f

    # Avoid division by zero if total_registered is zero
    if total_registered > 0
      # Calculate the percentage difference
      advantage = (registered_dem - registered_rep) / total_registered * 100
    else
      # Return zero or another appropriate value if no voters are registered
      advantage = 0
    end

    advantage
  end


end
