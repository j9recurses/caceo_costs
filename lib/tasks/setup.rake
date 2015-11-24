require 'csv'

def to_bool(str)
  return true if str == true || str =~ (/^(true|t|yes|y|1)$/i)
  return false if str == false || str.blank? || str =~ (/^(false|f|no|n|0)$/i)
  raise ArgumentError.new("invalid value for Boolean: \"#{str}\"")
end

namespace :caceo do
  namespace :setup do
    desc "generate access codes for counties"
    task county_access: :environment do
      County.all.each do |county|
        AccessCode.create(county: county, 
          user_access_code: SecureRandom.urlsafe_base64(8), 
          access_type: 'county_user')
      end
    end
  end
end