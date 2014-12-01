class SurveyPersistor
  include SurveySortable

  def initialize(survey_data, election_year = nil, category = nil)
    @survey_data = survey_data
    @election_year = election_year
  end
  attr_accessor :survey_data, :election_year

  def save
    if election_profile?
      # do something
    else
      save_success = survey_data.save
      # a year_element, aka lookup table entry for election_year/survey, is created when survey is created
      election_success = election_year ? election_year.year_elements.find_or_create_by( element: survey_data ) : true
      status_success = update_status
      save_success && election_success && status_success
    end
  end

  def destroy
    survey_data.destroy
    remove_category_status unless election_profile?
  end

  def completed_ratio
    all_columns = klass.column_names.size
    non_nil_attrs = survey_data.attributes.inject(0) do |sum, pair|
      pair[1] ? sum + 1 : sum
    end
    non_nil_attrs.to_f / all_columns.to_f
  end

  def update_status
    if election_profile?
      complete = completed_ratio < 0.5 ? false : true
      survey_data.update_attributes( complete: complete, started: true)
    else
      complete = completed_ratio < 0.75 ? false : true
      category.update_attributes( complete: complete, started: true, model_total: survey_total )
    end
  end

  def remove_category_status
    category.update_attributes( complete: false, started: false, model_total: nil)
  end

  def klass
    @klass ||= survey_data.class
  end

  def category
    @category ||= Category.find_by(election_year_id: survey_data.election_year_id, county: survey_data.county,  model_name: "#{survey_data.class.downcase}s")
  end

  def self.category_status(category_id, model_stuff)
    model_fields =  Salpw.column_names
    model_fields_size = model_fields.size
    model_fields_size = model_fields_size -1
    fields_complete = model_fields_size
    complete = true
    started  = true
    model_fields.each do |c |
      if eval("model_stuff[:" + c+ "]").nil?
        fields_complete = fields_complete -1
      end
    end
    amt_complete = fields_complete.to_f / model_fields_size.to_f
    if amt_complete < 0.75
      complete = false
    end
    Category.update( category_id , started: started)
    Category.update( category_id , complete: complete)
  end

def self.remove_category_status(category_id)
    Category.update(category_id, started: false)
    Category.update(category_id, complete: false)
    Category.update(category_id, model_total: '')
end

def self.category_total(category_id, total)
   Category.update(category_id, model_total: total)
end
end