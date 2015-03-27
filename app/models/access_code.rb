class AccessCode < ActiveRecord::Base
  belongs_to :county, inverse_of: :access_code
end
