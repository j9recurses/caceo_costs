module Responseable
  extend ActiveSupport::Concern

  included do
    has_one :survey_response, as: :response, dependent: :destroy
    has_one :election, through: :survey_response, foreign_key: 'election_year_id', class_name: "ElectionYear"
    has_one :survey, through: :survey_response
    has_one :county, through: :survey_response
    has_many :questions, through: :survey_response

    # remove when election_year_id and county_id are gone
    belongs_to :election_year
    validates :county_id, presence: true
    validates :election_year_id, presence: true
  end

  # class_methods do
  #   def questions
  #     Question.where(survey_id: self.to_s)
  #   end
  # end
  # include BitMaskReadable
end