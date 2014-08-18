class Category < ActiveRecord::Base
  has_many :election_years, :as => :yearable

  def self.get_completed_or_started(election_year_id, county, cost_type)
    @categories = Category.where(election_year_id: election_year_id, county: county, cost_type: cost_type ).uniq
    @checked_categories = Array.new()
    @total = 0
    @categories.each do | c|
      @category = Hash.new()
      if c[:started]
        @category[:started] = "<span style=\"color:blue\"> &#10004</span>"
      else
        @category[:started] = "<span style=\"color:red\">&#x2717</span>"
      end
      if c[:complete]
        @category[:complete] = "<span style=\"color:blue\"> &#10004</span>"
      else
        @category[:complete] = "<span style=\"color:red\">&#x2717</span>"
      end
      cname = c[:name].sub("Salaries related to", '').titleize
      @category[:linkto] =   "link_to '" +  cname   +"'," + c[:model_name] + "_path(:election_year_id => " +  election_year_id.to_s  + ",:category_id => "  + c[:id].to_s + ")"
       if  c[:model_total].nil?
        @category[:model_total] = 0
        @total = @total +@category[:model_total]
      else
       @category[:model_total] = c[:model_total]
       @total = @total +@category[:model_total]
      end
     @checked_categories  << @category
    end
      return @checked_categories, @total
  end
  end

