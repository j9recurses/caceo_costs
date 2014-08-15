class YearElement < ActiveRecord::Base
  belongs_to :election_year, :foreign_key=>"election_year_id"
  belongs_to :element, :polymorphic => true
end
