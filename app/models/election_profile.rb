class ElectionProfile< ActiveRecord::Base
 include MultiStepModel
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
      :less_than_or_equal_to  => 100000000, 
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

#update the category table to indicate that something was started or completed
def self.category_status(election_profile_id, model_stuff)
  model_fields =  ElectionProfile.column_names
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
  if amt_complete < 0.50
   complete = false
    ElectionProfile.update(election_profile_id, complete: complete)
 else
    ElectionProfile.update(election_profile_id, complete: true)
end
 ElectionProfile.update(election_profile_id, started: started)

end

end
