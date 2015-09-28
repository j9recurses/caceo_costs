module Responseable
  extend ActiveSupport::Concern

  included do
    has_one :survey_response, as: :response, dependent: :destroy
    has_one :election, through: :survey_response
    has_one :county, through: :survey_response
    # has_one :survey, through: :survey_response
    # has_many :questions, through: :survey_response

    def survey
      Survey.find( self.class.to_s )
    end

    def questions
      Question.where(survey_id: self.class.to_s )
    end
  end


  class_methods do
    def questions
      Question.where(survey_id: self.to_s)
    end
  end
  # include BitMaskReadable
end