class Postage < ActiveRecord::Base
  include Responseable
  validates :county_id, presence: true
  validates :election_year_id, presence: true
  validates :sspossbal, :ssposuo, :ssposvbmo, :ssposvbmi, :ssposvbmoth, :ssposoth, 
    numericality: { only_integer: true,
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to  => 30000000,
      :allow_nil => true,
      :allow_blank => false,
      message: " Entry is not valid. Please check your entry" }
end