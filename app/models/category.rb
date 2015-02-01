class Category < ActiveRecord::Base
  has_many :election_years, :as => :yearable
end