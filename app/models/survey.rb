class Survey < ActiveRecord::Base
  has_many :survey_responses, inverse_of: :survey, foreign_key: :response_type
  has_many :questions, inverse_of: :survey
  has_many :ssvehs,   through: :survey_responses, source: :response, source_type: 'Ssveh'
  has_many :salvbms,  through: :survey_responses, source: :response, source_type: 'Salvbm'
  has_many :salbals,  through: :survey_responses, source: :response, source_type: 'Salbal'
  has_many :salpps,   through: :survey_responses, source: :response, source_type: 'Salpp'
  has_many :salpws,   through: :survey_responses, source: :response, source_type: 'Salpw'
  has_many :salmeds,  through: :survey_responses, source: :response, source_type: 'Salmed'
  has_many :saldojos, through: :survey_responses, source: :response, source_type: 'Saldojo'
  has_many :salcans,  through: :survey_responses, source: :response, source_type: 'Salcan'
  has_many :salbcs,   through: :survey_responses, source: :response, source_type: 'Salbc'
  has_many :saloths,  through: :survey_responses, source: :response, source_type: 'Saloth'
  has_many :postages, through: :survey_responses, source: :response, source_type: 'Postage'
  has_many :sspps,    through: :survey_responses, source: :response, source_type: 'Sspp'
  has_many :sspws,    through: :survey_responses, source: :response, source_type: 'Sspw'
  has_many :ssoths,   through: :survey_responses, source: :response, source_type: 'Ssoth'
  has_many :ssmeds,   through: :survey_responses, source: :response, source_type: 'Ssmed'
  has_many :sscans,   through: :survey_responses, source: :response, source_type: 'Sscan'
  has_many :ssbals,   through: :survey_responses, source: :response, source_type: 'Ssbal'
  has_many :ssbcs,    through: :survey_responses, source: :response, source_type: 'Ssbc'
  has_many :election_profiles, through: :survey_responses, source: :response, source_type: 'ElectionProfile'
  # has_and_belongs_to_many :subsections, join_table: "survey_subsections", class_name: 'Subsection'
  has_and_belongs_to_many :totals_subsections, join_table: "survey_totals_subsections", class_name: 'Subsection'
  default_scope { order(title: :desc) }

  self.primary_key = :id

  def responses
    send table_name
  end

  def subsections
    Subsection.where(id: questions.pluck(:subsection_id).uniq)
  end

  def election_profile?
    category == "Election Profile" ? true : false
  end

  def salary?
    category == "Salaries" ? true : false
  end

  def service_supply?
    category == "Services and Supplies" ? true : false
  end
end