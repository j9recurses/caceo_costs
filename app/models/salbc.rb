class Salbc < ActiveRecord::Base
 include MultiStepModel
  has_one :year_element, :as =>:element, dependent: :destroy
  accepts_nested_attributes_for :year_element
  has_one :election_year, :through => :year_elements
  validates :county_id, presence: true
  belongs_to :county, inverse_of: :salbcs
  validates :election_year_id, presence: true
  validates :salbcsec, :sabcoth, :salbcpsrp, :salbcpsop, 
    :salbctsrp, :salbctsop, :salbcbeps, :salbcbepsp, 
    :salbcbets, :salbcbetsp, :salbchrsps, :salbchrsts, :salbcnvbmp,
    numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 30000000,  
      :allow_nil => true, 
      :allow_blank => false,  
      message: " Entry is not valid. Please check your entry"  }
end