class Postage < ActiveRecord::Base
 include MultiStepModel
  has_one :year_element, :as =>:element, dependent: :destroy
  accepts_nested_attributes_for :year_element
  has_one :election_year, :through => :year_elements
  belongs_to :county, inverse_of: :postages
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