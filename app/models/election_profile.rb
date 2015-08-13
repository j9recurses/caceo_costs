class ElectionProfile< ActiveRecord::Base
  include Responseable

  EPLANGVRA = [ 'Spanish', 'Chinese', 'Vietnamese', 'Japanese', 'Korean', 
    'Tagalog (Filipino)', 'Asian Indian (Hindi)',
    'Other Asian - Not Specified (Gujarati, Bengali)', 
    'American Indian (Central & South American)',
    'American Indian (Yuman)' ]
  EPLANGCAEC = [ 'Spanish', 'Chinese', 'Vietnamese', 'Japanese', 'Korean', 
    'Tagalog (Filipino)', 'Hindi', 'Khmer', 'Thai' ]

  # def eplangcaec_multi_select=(languages)
  #   self.eplangcaec = (languages & EPLANGCAEC).map { |l| 2**EPLANGCAEC.index(l) }.sum
  # end

  def eplangcaec_multi_select
    EPLANGCAEC.reject { |l| ((eplangcaec || 0) & 2**EPLANGCAEC.index(l)).zero? }
  end

  # def eplangvra_multi_select=(languages)
  #   self.eplangvra = (languages & EPLANGVRA).map { |l| 2**EPLANGVRA.index(l) }.sum
  # end

  def eplangvra_multi_select
    EPLANGVRA.reject { |l| ((eplangvra || 0) & 2**EPLANGVRA.index(l)).zero? }
  end
end
