class SurveyPersistor

  def initialize(survey)
    @survey = survey
  end
  attr_accessor :survey

  def survey_data
    survey.data
  end

  def save
    save_success = survey.data.save
    status_success = update_status
    if survey.election_profile?
      election_success = true
    else
      election_success = survey.election.year_elements.find_or_create_by( element: survey_data )
    end
    save_success && election_success && status_success
  end

  def destroy
    survey_data.destroy
    remove_category_status unless survey.election_profile?
  end

  def completed_ratio
    all_columns = klass.column_names.size
    non_nil_attrs = survey_data.attributes.inject(0) do |sum, pair|
      pair[1] ? sum + 1 : sum
    end
    non_nil_attrs.to_f / all_columns.to_f
  end

  def update_status
    if survey.election_profile?
      complete = completed_ratio < 0.5 ? false : true
      survey_data.update_attributes( complete: complete, started: true)
    else
      complete = completed_ratio < 0.75 ? false : true
      survey.category.update_attributes( complete: complete, started: true, model_total: survey.total )
    end
  end

  def remove_category_status
    survey.category.update_attributes( complete: false, started: false, model_total: nil)
  end

  def klass
    @klass ||= survey_data.class
  end

#   def self.category_status(category_id, model_stuff)
#     model_fields =  Salpw.column_names
#     model_fields_size = model_fields.size
#     model_fields_size = model_fields_size -1
#     fields_complete = model_fields_size
#     complete = true
#     started  = true
#     model_fields.each do |c |
#       if eval("model_stuff[:" + c+ "]").nil?
#         fields_complete = fields_complete -1
#       end
#     end
#     amt_complete = fields_complete.to_f / model_fields_size.to_f
#     if amt_complete < 0.75
#       complete = false
#     end
#     Category.update( category_id , started: started)
#     Category.update( category_id , complete: complete)
#   end

# def self.remove_category_status(category_id)
#     Category.update(category_id, started: false)
#     Category.update(category_id, complete: false)
#     Category.update(category_id, model_total: '')
# end

# def self.category_total(category_id, total)
#    Category.update(category_id, model_total: total)
# end
end