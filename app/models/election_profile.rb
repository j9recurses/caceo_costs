class ElectionProfile< ActiveRecord::Base
 include MultiStepModel
  belongs_to :county, inverse_of: :election_profiles
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

  # def count_answers
  #   @total_responses ||= self.attributes.inject(0) do |sum, k_v|
  #     if ['id', 'updated_at', 'created_at', 'complete', 'started', 'current_step', 'county', 'election_year_profile_id'].include?(k_v[0])
  #       sum
  #     else
  #       k_v[1].blank? ? sum : sum + 1
  #     end
  #   end
  # end

#   def completed_ratio
#     (count_answers.to_f / count_questions.to_f).round(2)
#   end

#   def percent_complete
#     (completed_ratio * 100).to_i
#   end

#   def self.total_steps
#    c = ElectionProfileDescription.where(model_name: "election_profiles").pluck(:field, :label)
#   cfchunks = c.in_groups_of(16)
#   numb_of_steps = cfchunks.size
#   end

#   def self.check_if_started(category)
#     if category[:started]
#       return true
#     else
#     return false
#   end
# end

# def self.make_chunks(model_name)
#   c = ElectionProfileDescription.where(model_name: model_name).pluck(:field, :label)
#   cfchunks = c.in_groups_of(16)
#   numb_of_steps = cfchunks.size
#   form_chunks = Array.new()
#   cfchunks.each do | chunk |
#      chunkfields = self.make_form_items(chunk)
#      form_chunks << chunkfields
#   end
#   return form_chunks
# end

# def self.make_form_items(chunk)
#   chunkfields = Array.new()
#   chunk.each do | hunk |
#     if hunk.nil?
#       next
#     else
#       hunktofix =  hunk[1].titleize
#       hunktofix = hunktofix.gsub("Uocava","UOCAVA")
#       hunktofix = hunktofix.gsub("Vbm","VBM")
#       hunktofix = hunktofix.gsub("Dre","DRE")
#       hunktofix = hunktofix.gsub("Sb90","SB90")
#       hunktofix  = hunktofix.gsub("Vb Ms", "VBMs")
#       hunktofix  = hunktofix.gsub("Icrp", "ICRP")
#        hunktofix  = hunktofix.gsub("Vra", "VRA")
#        hunktofix = hunktofix.gsub("Dr Es", "DREs")
#         hunktofix = hunktofix.gsub("Hava", "HAVA")
#         hunktofix = hunktofix.gsub("Ca Ec", "CA EC")
#      # formline = "f.input :" + hunk[0] +", label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" +  hunk[0] + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}"
#        formline = makeformline(hunk[0], hunktofix)
#        chunkfields << formline
#     end
#      end
#   return chunkfields
# end




# def self.makeformline(firsthunk, hunktofix)
#   if firsthunk == 'icrp'
#     puts "*****awesome*****"
#      formline = "f.input :" + firsthunk +",  label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}, :input_html => {value: number_with_precision(f.object.icrp, precision: 2, delimiter: '.')    }"
#   elsif firsthunk == 'eplangcaec'
#     formline = "f.input :eplangcaec_multi_lang, collection: #{CAEC_LANGUAGES}, as: :check_boxes,  label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}, :input_html => { :multiple => true }"
#   elsif firsthunk == 'eplangvra'
#     formline = "f.input :eplangvra_multi_lang, collection: #{VRA_LANGUAGES}, as: :check_boxes,  label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}, :input_html => { :multiple => true }"
#    else
#     formline = "f.input :" + firsthunk +", label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}"
#   end
#    return formline
# end

#   def self.make_modals(category_description)
#   mymodals = Array.new()

#     category_description.each do |d|
#       mylabel = d[:label].titleize
#       string = ''
#       string = "\<div class=\"modal fade\" id=\"" + d[:field] + "_modal\"\>"
#       string = string +"\<div class=\"modal-header\"\>"
#       string = string +"\<a class=\"close\" data-dismiss=\"modal\">&times;\<\/a\>"
#       string = string +"\<h3\>" + mylabel  +"\<\/h3\>"
#       string = string + "\<\/div\>"
#       string = string + "\<div class=\"modal-body\"\>"
#       string = string + "\<p\>" +  d[:description] +"\<\/p\>"
#      string = string + "\<\/div\>"
#       string = string + "\<div class=\"modal-footer\"\>"
#       string = string + "\<a href=\"#\" class=\"btn\" data-dismiss=\"modal\"\>Close\<\/a\>"
#       string = string +"\<\/div\>"
#       string = string +"\<\/div\>"
#       mymodals << string
# end
#   return mymodals
# end

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
