class Salpp < ActiveRecord::Base
  include Responseable
  validates :salppsurvey, :salpporder, :salppve, :salppdelve, 
    :salpppay, :salpppubnot, :salppoth, :salpppsrp, :salpppsop, 
    :salpptsrp, :salpptsop, :salppbeps, :salppbets, 
    :salpphrsps, :salpphrsts, 
    numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 500000000,  
      :allow_nil => true, 
      :allow_blank => false, 
      message: " Entry is not valid. Please check your entry"  }
end