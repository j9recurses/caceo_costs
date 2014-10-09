class ElectionProfile< ActiveRecord::Base
 include MultiStepModel
validates :county, presence: true
validates :election_year_profile_id, presence: true
validates  :epppbalpap, :epppbalaccsd, :eprv, :eppploc,:epprecwpp,:epbaltype,:epbalsampvip,:epvipinsrt,:epbalofficl,:epvbmmail,:epvbmmailprm,:epvbmmailmbp,:epvbmmailuo,:epvbmotc,:epvbmret,:epvbmretprm,:epvbmretmbp,:epvbmretuo,:epvbmundel,:epvbmchal,:epvbmprovc,:epvbmprovnc,:epcand,:epcandfsc,:epcandcd,:epcandwi,:epcandwifsc,:epcandwicd,:epmeasr,:epmeasrfsc,:epmeasrcd,:eptotindirc,:eptotelectc,:eptotbilled,:eptotcounty,:eptotsb90c,:eptotsb90r, numericality:{only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to  => 30000000,  :allow_nil => true, :allow_blank => false,  message: " Entry is not valid. Please check your entry"  }
validates  :epicrp, :numericality => {  :allow_nil => true, :allow_blank => false}

  def self.total_steps
   c = ElectionProfileDescription.where(model_name: "election_profiles").pluck(:field, :label)
  cfchunks = c.in_groups_of(12)
  numb_of_steps = cfchunks.size
  end

  def self.check_if_started(category)
    if category[:started]
      return true
    else
    return false
  end
end

def self.make_chunks(model_name)
  c = ElectionProfileDescription.where(model_name: model_name).pluck(:field, :label)
  cfchunks = c.in_groups_of(12)
  numb_of_steps = cfchunks.size
  form_chunks = Array.new()
  cfchunks.each do | chunk |
     chunkfields = self.make_form_items(chunk)
     form_chunks << chunkfields
  end
  return form_chunks
end

def self.make_form_items(chunk)
  chunkfields = Array.new()
  chunk.each do | hunk |
    if hunk.nil?
      next
    else
      hunktofix =  hunk[1].titleize
      hunktofix = hunktofix.gsub("Uocava","UOCAVA")
      hunktofix = hunktofix.gsub("Vbm","VBM")
      hunktofix = hunktofix.gsub("Dre","DRE")
      hunktofix = hunktofix.gsub("Sb90","SB90")
      hunktofix  = hunktofix.gsub("Vb Ms", "VBMs")
      hunktofix  = hunktofix.gsub("Icrp", "ICRP")
       hunktofix  = hunktofix.gsub("Vra", "VRA")
     # formline = "f.input :" + hunk[0] +", label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" +  hunk[0] + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}"
       formline = makeformline(hunk[0], hunktofix)
       chunkfields << formline
    end
     end
  return chunkfields
end

def self.makeformline(firsthunk, hunktofix)
  if firsthunk == 'icrp'
    puts "*****awesome*****"
     formline = "f.input :" + firsthunk +", step: 0.01, label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}"
  elsif  firsthunk == 'eplangcaec'
    formline = "f.input :" + firsthunk +", collection:  [ 'Spanish', 'Chinese',  'Vietnamese', 'Japanese', 'Korean', 'Tagalog (Filipino)', 'Asian Indian (Hindi)', 'Other Asian - Not Specified (Gujarati, Bengali)', 'American Indian (Central & South American)',  'American Indian (Yuman)'], label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}, :input_html => { :multiple => true }"
   elsif  firsthunk == 'eplangloc'
    formline = "f.input :" + firsthunk +", collection:  [ 'Spanish', 'Chinese',  'Vietnamese', 'Japanese', 'Korean', 'Tagalog (Filipino)', 'Hindi', 'Khmer', 'Thai' ], label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}, :input_html => { :multiple => true }"
   else
    formline = "f.input :" + firsthunk +", label: \'" +hunktofix + "\ <span class=\"info\"\>\<a href=\"#" + firsthunk + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}"
  end
   return formline
end

  def self.make_modals(category_description)
  mymodals = Array.new()

    category_description.each do |d|
      mylabel = d[:label].titleize
      string = ''
      string = "\<div class=\"modal fade\" id=\"" + d[:field] + "_modal\"\>"
      string = string +"\<div class=\"modal-header\"\>"
      string = string +"\<a class=\"close\" data-dismiss=\"modal\">&times;\<\/a\>"
      string = string +"\<h3\>" + mylabel  +"\<\/h3\>"
      string = string + "\<\/div\>"
      string = string + "\<div class=\"modal-body\"\>"
      string = string + "\<p\>" +  d[:description] +"\<\/p\>"
     string = string + "\<\/div\>"
      string = string + "\<div class=\"modal-footer\"\>"
      string = string + "\<a href=\"#\" class=\"btn\" data-dismiss=\"modal\"\>Close\<\/a\>"
      string = string +"\<\/div\>"
      string = string +"\<\/div\>"
      mymodals << string
end
  return mymodals
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
