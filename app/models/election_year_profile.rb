class ElectionYearProfile < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true

  #find all the election years and make show if they have been worked on or are finished
  def self.get_all_years(user)
    years = ElectionYearProfile.all.order('election_dt DESC')
    myyears = Array.new()
    years.each do |y|
      #grab the category statuses
       election_profile_started = ElectionProfile.where(election_year_profile_id: y, county: 1, started: 1)
       election_profile_complete = ElectionProfile.where(election_year_profile_id: y, county: 1, complete: 1)
      single = Hash.new()
      single[:id] = y[:id]
      single[:year] = y[:year]
      if election_profile_started.size > 0
        single[:started] ="<span style=\"color:blue\"> &#10004</span>"
      else
        single[:started] ="<span style=\"color:red\">&#x2717</span>"
      end
     if election_profile_complete.size > 0
        single[:done] = "<span style=\"color:blue\"> &#10004</span>"
      else
        single[:done] =  "<span style=\"color:red\">&#x2717</span>"
      end
      #grab the costs for each category type
       costs_ary =  Category.where(election_year_id: y, county: user[:county]).pluck(:model_total)
      myyears  << single
    end
    puts myyears.inspect
    return myyears
  end


end
