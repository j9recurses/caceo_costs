module Responseable
  extend ActiveSupport::Concern
  include MultiStepModel

  included do
    has_one :survey_response, as: :response, dependent: :destroy
    # accepts_nested_attributes_for :survey_response
    has_one :election, through: :survey_response, foreign_key: 'election_year_id', class_name: "ElectionYear"
    has_one :survey, through: :survey_response
    has_one :county, through: :survey_response
    has_many :questions, through: :survey_response
    belongs_to :election_year

    validates :survey_response, presence: true

    before_validation if: Proc.new { |r| r.survey_response } do
      self.county_id = survey_response.county.id
      self.election_year_id = survey_response.election.id
    end

    # after_save :touch_survey_response
    after_update :touch_survey_response

    # after_save    :sync_respones_values
    # after_update  :sync_respones_values

  private
    # keep survey_response timestamps synced
    def touch_survey_response
      if survey_response
        survey_response.touch
      end
    end
    def sync_respones_values
      ResponseValue.sync_survey_response survey_response
    end
  end
end