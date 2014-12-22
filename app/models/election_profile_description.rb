class ElectionProfileDescription < ActiveRecord::Base
  def election_profile?
    true
  end

  def comment?
    false
  end

  def salary?
    false
  end

  def service_supply?
    false
  end
end
