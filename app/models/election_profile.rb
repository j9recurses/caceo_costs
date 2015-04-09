class ElectionProfile< ActiveRecord::Base
  include Responseable
  # include NotApplicable
  has_one :survey_response, as: :response, dependent: :destroy
  accepts_nested_attributes_for :survey_response
  has_one :election_year, :through => :survey_response
  
  belongs_to :county, inverse_of: :election_profiles
  belongs_to :election_year_profile, inverse_of: :election_profiles
  validates :county_id, presence: true
  validates :election_year_profile_id, presence: true
  validates  :epppbalpap, :epppbalaccsd, :eprv, :eppploc,:epprecwpp,
    :epbaltype,:epbalsampvip,:epvipinsrt,:epbalofficl,:epvbmmail,
    :epvbmmailprm,:epvbmmailmbp,:epvbmmailuo,:epvbmotc,:epvbmret,
    :epvbmretprm,:epvbmretmbp,:epvbmretuo,:epvbmundel,:epvbmchal,
    :epvbmprovc,:epvbmprovnc,:epcand,:epcandfsc,:epcandcd,:epcandwi,
    :epcandwifsc,:epcandwicd,:epmeasr,:epmeasrfsc,:epmeasrcd,
    :eptotindirc,:eptotelectc,:eptotbilled,:eptotcounty,:eptotsb90c,
    :eptotsb90r, numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 1000000000,
      :allow_nil => true, 
      :allow_blank => false, 
      message: " Entry is not valid. Please check your entry"  }
  validates  :epicrp, numericality: { 
    less_than_or_equal_to: 9999.99, 
    greater_than_or_equal_to: 0.01, 
    :allow_nil => true, 
    :allow_blank => false,  
    message: 'Indirect cost rate is expected to be between 9999.99 and 0.01' }

VRA_LANGUAGES = [ 'Spanish', 'Chinese', 'Vietnamese', 'Japanese', 'Korean', 
                  'Tagalog (Filipino)', 'Asian Indian (Hindi)', 
                  'Other Asian - Not Specified (Gujarati, Bengali)', 
                  'American Indian (Central & South American)',
                  'American Indian (Yuman)' ]
CAEC_LANGUAGES = [ 'Spanish', 'Chinese', 'Vietnamese', 'Japanese', 'Korean', 
                  'Tagalog (Filipino)', 'Hindi', 'Khmer', 'Thai' ]

EPLANGVRA = [ 'Spanish', 'Chinese', 'Vietnamese', 'Japanese', 'Korean', 
                  'Tagalog (Filipino)', 'Asian Indian (Hindi)', 
                  'Other Asian - Not Specified (Gujarati, Bengali)', 
                  'American Indian (Central & South American)',
                  'American Indian (Yuman)' ]
EPLANGCAEC = [ 'Spanish', 'Chinese', 'Vietnamese', 'Japanese', 'Korean', 
                  'Tagalog (Filipino)', 'Hindi', 'Khmer', 'Thai' ]

  def eplangcaec_multi_lang=(languages)
    self.eplangcaec = (languages & CAEC_LANGUAGES).map { |l| 2**CAEC_LANGUAGES.index(l) }.sum
  end

  def eplangcaec_multi_lang
    CAEC_LANGUAGES.reject { |l| ((eplangcaec || 0) & 2**CAEC_LANGUAGES.index(l)).zero? }
  end

  def eplangvra_multi_lang=(languages)
    self.eplangvra = (languages & VRA_LANGUAGES).map { |l| 2**VRA_LANGUAGES.index(l) }.sum
  end

  def eplangvra_multi_lang
    VRA_LANGUAGES.reject { |l| ((eplangvra || 0) & 2**VRA_LANGUAGES.index(l)).zero? }
  end
end
