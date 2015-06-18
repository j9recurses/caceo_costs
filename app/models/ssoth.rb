class Ssoth < ActiveRecord::Base
  include Responseable
  validates :ssothoutrea, :ssothwareh, :ssothelcom, :ssothphbank, 
    :ssothwebsite, :ssothcpst, :ssothoth, 
    numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 500000000,
      :allow_nil => true,
      :allow_blank => false,
      message: " Entry is not valid. Please check your entry" }
end