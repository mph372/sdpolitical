class HistoricalCandidate < ApplicationRecord
  belongs_to :election_history, optional: true
  belongs_to :person, optional: true
end
