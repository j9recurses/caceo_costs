class Salbal < ActiveRecord::Base
  include Responseable
  validates :salbaldesign, :salbaltrans, :salbalorder, 
    :salbalmail, :salbalother, :salbalpsrp, :salbalpsop, 
    :salbaltsrp, :salbaltsop, :salbalbeps, :salbalbepsp, 
    :salbalbets, :salbalbetsp, :salbalhrsps, :salbalhrsts, 
    numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 500000000, 
      :allow_nil => true, :allow_blank => false, 
      message: " Entry is not valid. Please check your entry" }
end
