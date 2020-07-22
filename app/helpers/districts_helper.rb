module DistrictsHelper
    def measure_a_spread(district)
    if district.measure_a_difference > 0
        "#{spread.truncate(2)}% above countywide" 
      elsif district.measure_a_difference < 0 
        "#{spread.truncate(2)}% below countywide" 
      end
    end
end
