module Surveyable
  extend ActiveSupport::Concern

  included do
    before_action :memo_model_name,  :make_survey_annotations, :make_survey_pages, :make_survey_name,  except: :destroy
  end
  # :make_survey_model,

  def memo_model_name
    @model_name ||= get_model_name
  end

  # to not interfere with #get_category_descriptions defined on all controllers
  def make_survey_annotations
    @survey_annotations ||= CategoryDescription.where(model_name: memo_model_name)
  end

  def make_survey_pages
    questions = @survey_annotations.pluck(:field, :label)
    @survey_pages = questions.compact.in_groups_of(12)
  end

  # def make_cost_type
    # @cost_type = @survey_annotations.pluck(:cost_type).uniq
  # end

  def make_survey_name
    @survey_name ||= @survey_annotations.pluck(:name).first.titleize
  end
end