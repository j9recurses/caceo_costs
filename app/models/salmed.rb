class Salmed < ActiveRecord::Base
 include MultiStepModel
has_one :year_element, :as =>:element, dependent: :destroy
accepts_nested_attributes_for :year_element
has_one :election_year, :through => :year_elements
validates :county, presence: true
validates :election_year_id, presence: true
validates   :salmedprep, :salmedhandl, :salmedtot, :salmedpsrp, :salmedpsop, :salmedtsrp, :salmedtsop, :salmedhrs, :salmedhrsps, :salmedhrsts,   numericality:{only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to  => 10000000,  :allow_nil => true, :allow_blank => false,  message: " Entry is not valid. Please check your entry"  }
validates :salmedbe, :salmedbep, :salmedbeps, :salmedbepsp, :salmedbets, :salmedbetsp, numericality:{only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to  => 100,  :allow_nil => true, :allow_blank => false,  message: 'Entry is not valid. Please check your entry'  }

  def self.total_steps
   c = CategoryDescription.where(model_name: "salmeds").pluck(:field, :label)
  cfchunks = c.in_groups_of(3)
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
  c = CategoryDescription.where(model_name: model_name).pluck(:field, :label)
  cfchunks = c.in_groups_of(3)
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
      formline = "f.input :" + hunk[0] +", label: \'" + hunk[1].titleize + "\ <span class=\"info\"\>\<a href=\"#" +  hunk[0] + "_modal\" data-toggle=\"modal\"\>(what\\'s this?)\</a\>\</span\>\'.html_safe,  :label_html => \{ :class =\> \"form_item\" \}"
       chunkfields << formline
    end
     end
  return chunkfields
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
def self.category_status(category_id, model_stuff)
  model_fields = Salmed.column_names
  complete = true
  started  = true
  model_fields.each do |c |
  if eval("model_stuff[:" + c+ "]").nil?
     complete = false
    end
  end
  Category.update( category_id , started: started)
  Category.update( category_id , complete: complete)
end

def self.remove_category_status(category_id)
    Category.update(category_id, started: false)
    Category.update(category_id, complete: false)
    Category.update(category_id, model_total: '')
end

def self.category_total(category_id, total)
   Category.update(category_id, model_total: total)
end


end
