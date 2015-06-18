class Salcan < ActiveRecord::Base
  include Responseable
  validates :salcanprep, :salcanproc, :slacanoth, :salcanpsrp, 
    :salcanpsop, :salcantsrp, :salcantsop, :salcanbeps, :salcanbepsp, 
    :salcanbets, :salcanbetsp, :salcanhrsps, :salcanhrsts, 
    numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 500000000,  
      :allow_nil => true, 
      :allow_blank => false,  
      message: " Entry is not valid. Please check your entry" }
end