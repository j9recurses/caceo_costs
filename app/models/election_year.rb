class ElectionYear < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true
  has_many :year_elements, dependent: :destroy
  #has_many :postages, :through => :year_elements, :source => :element, :source_type => 'postages' , dependent: :destroy


  #find all the election years and make show if they have been worked on or are finished

  #find all the election years and make show if they have been worked on or are finished
  def self.get_all_years(user)
    total_election_year_costs = 0
    years = ElectionYear.all.order('election_dt DESC').pluck(:year_dt).uniq
    total_categories = CategoryDescription.all.pluck(:name).uniq
    total_categories = total_categories.size
    myyears = Array.new()
    years.each do |y|
       election_yr_overview = Hash.new()
        election_yr_overview[:year_dt] = y.to_s
        year_elections_ids =  ElectionYear.where(year_dt: y).pluck(:id)
       election_year_started_yr = Category.where( county: user[:county], started: 1, election_year_id: year_elections_ids)
       election_year_complete_yr = Category.where( county: user[:county], complete: 1,  election_year_id: year_elections_ids)
      if election_year_started_yr.size > 0
        election_yr_overview[:started] ="<span style=\"color:blue\"> &#10004</span>"
      else
        election_yr_overview[:started] ="<span style=\"color:red\">&#x2717</span>"
      end
     puts election_year_complete_yr.size
     if election_year_complete_yr.size == total_categories
        election_yr_overview[:done] = "<span style=\"color:blue\"> &#10004</span>"
      else
        election_yr_overview[:done] =  "<span style=\"color:red\">&#x2717</span>"
      end
     year_elections =  ElectionYear.where(year_dt: y)
       all_years_electionz = Array.new
    year_elections.each do |ye|
      single = Array.new()
      single << ye[:id]
      single <<  ye[:year]
      election_year_started= Category.where( county: user[:county], started: 1, election_year_id: ye[:id])
      election_year_complete= Category.where( county: user[:county], complete: 1, election_year_id: ye[:id])
      if election_year_started.size > 0
        single<< "<span style=\"color:blue\"> &#10004</span>"
      else
        single<<"<span style=\"color:red\">&#x2717</span>"
      end
     if election_year_complete.size == total_categories
         single<<"<span style=\"color:blue\"> &#10004</span>"
      else
         single<<   "<span style=\"color:red\">&#x2717</span>"
      end
       costs_ary =  Category.where(election_year_id: ye, county: user[:county]).pluck(:model_total)
       #convert the nils to 0, then add
       category_costs = costs_ary.map {|e| e ? e : 0}
       yearlytotalcosts =  category_costs.sum
        total_election_year_costs = total_election_year_costs + (category_costs.sum)
       single << yearlytotalcosts
       all_years_electionz << single
    end
    election_yr_overview[:all_years_electionz] = all_years_electionz
    myyears  << election_yr_overview
  end
    return myyears,  total_election_year_costs
  end


end
