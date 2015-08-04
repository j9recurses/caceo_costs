class Salmed < ActiveRecord::Base
  include Responseable
  # validates :salmedprep, :salmedhandl, :salmedpsrp, :salmedpsop, 
  #   :salmedtsrp, :salmedtsop, :salmedbe, :salmedbep, :salmedbeps, 
  #   :salmedbets, :salmedhrsps, :salmedhrsts, 
  #   numericality: { only_integer: true, 
  #     :greater_than_or_equal_to => 0, 
  #     :less_than_or_equal_to  => 500000000, 
  #     :allow_nil => true, 
  #     :allow_blank => false, 
  #     message: " Entry is not valid. Please check your entry" }
end