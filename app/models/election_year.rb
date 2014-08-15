class ElectionYear < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true
  has_many :year_elements, dependent: :destroy
  has_many :postages, :through => :year_elements, :source => :element, :source_type => 'postages' , dependent: :destroy


  #find all the election years and make show if they have been worked on or are finished
  def self.get_all_years(user)
    years = ElectionYear.all.order('year DESC')
    myyears = Array.new()
    total_election_year_costs = 0
    years.each do |y|
      #grab the category statuses
       category_started = Category.where(election_year_id: y, county: user[:county], started: 1)
       category_complete = Category.where(election_year_id: y, county: user[:county], complete: 0)
      single = Hash.new()
      single[:id] = y[:id]
      single[:year] = y[:year]
      if category_started.size > 0
        single[:started] ="<span style=\"color:blue\"> &#10004</span>"
      else
        single[:started] ="<span style=\"color:red\">&#x2717</span>"
      end
      if category_complete.size == 0
        single[:done] = "<span style=\"color:blue\"> &#10004</span>"
      else
        single[:done] =  "<span style=\"color:red\">&#x2717</span>"
      end
      #grab the costs for each category type
       costs_ary =  Category.where(election_year_id: y, county: user[:county]).pluck(:model_total)
       #convert the nils to 0, then add
       category_costs = costs_ary.map {|e| e ? e : 0}
       single[:total_year_costs]  = category_costs.sum
       total_election_year_costs = total_election_year_costs + (category_costs.sum)
      myyears  << single
    end
    return myyears,   total_election_year_costs
  end


end
