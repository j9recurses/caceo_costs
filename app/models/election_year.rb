class ElectionYear < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true
  has_many :year_elements, dependent: :destroy
  #has_many :postages, :through => :year_elements, :source => :element, :source_type => 'postages' , dependent: :destroy
  default_scope { order(election_dt: :desc) }

  def direct_cost_table_names
    GeneralSurvey::DIRECT_COST_SURVEYS.map { |t| t.to_s.underscore.pluralize }
  end

  def direct_cost_questions
    @total_direct_cost_questions ||= CategoryDescription
      .where( table_name: direct_cost_table_names )
      .where.not('label LIKE "%Percent%" AND table_name != "salbals"')
      .where(question_type: nil)
  end

  # memo an array of open surveys for this election; else return empty array
  def direct_cost_surveys_for( user )
    @direct_cost_surveys ||= GeneralSurvey::DIRECT_COST_SURVEYS.map { |klass|
      klass.where( election_year_id: id, county_id: user.county_id ).last
    }.compact
  end

  def surveys_open?( user )
    !direct_cost_surveys_for( user ).blank?
  end

  # return nil if there are no open surveys
  def total_direct_cost_for(user)
    @total_direct_cost ||= direct_cost_surveys_for( user ).inject(0) do |mem, surv| 
      mem + GeneralSurvey.new(surv).total
    end
  end

  def direct_cost_answers_count( user )
    @total_direct_cost_answers ||= direct_cost_surveys_for( user ).inject(0) { |mem, surv|
      mem + GeneralSurvey.new( surv ).count_answers
    }
  end

  def percent_answered_direct_cost( user )
    @percent_answered_direct_cost ||= if direct_cost_answers_count( user )
      ((Float(direct_cost_answers_count( user )) / Float(direct_cost_questions.count)) * 100).to_i
    else
      0
    end
  end

    # if e.direct_cost_answers_count( u )
    #   Float(e.direct_cost_answers_count( u )) / Float(e.direct_cost_questions.count)
    # else
    #   0
    # end


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
       election_year_started_yr = Category.where( county: user[:county_id], started: 1, election_year_id: year_elections_ids)
       election_year_complete_yr = Category.where( county: user[:county_id], complete: 1,  election_year_id: year_elections_ids)
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
      election_year_started= Category.where( county: user[:county_id], started: 1, election_year_id: ye[:id])
      election_year_complete= Category.where( county: user[:county_id], complete: 1, election_year_id: ye[:id])
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
       costs_ary =  Category.where(election_year_id: ye, county: user[:county_id]).pluck(:model_total)
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
