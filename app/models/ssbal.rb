class Ssbal < ActiveRecord::Base
 include MultiStepModel
  has_one :year_element, :as =>:element, dependent: :destroy
  accepts_nested_attributes_for :year_element
  has_one :election_year, :through => :year_elements
  belongs_to :county, inverse_of: :ssbals
  validates :county_id, presence: true
  validates :election_year_id, presence: true
  validates :ssballayout, :ssbaltransl, :ssbalpri, :ssbalprisb, 
    :ssbalprisben, :ssbalprisbch, :ssbalprisbko, :ssbalprisbsp, 
    :ssbalrpisbvi, :ssbalprisbja, :ssbalprisbta, :ssbalprisbkh, 
    :ssbalprisbhi, :ssbalprisbth, :ssbalprisbfi, :ssbalpriob, 
    :ssbalprioben, :ssbalpriobch, :ssbalpriobko, :ssbalpriobsp, 
    :ssbalpriobvi, :ssbalpriobja, :ssbalpriobta, :ssbalpriobkh, 
    :ssbalpriobhi, :ssbalpriobth, :ssbalpriobfi, :ssbalprivbm, 
    :ssbalpriuo, :ssbalpriprot, :ssbalpriship, :ssbalprioth, 
    numericality: { only_integer: true, 
      :greater_than_or_equal_to => 0, 
      :less_than_or_equal_to  => 500000000, 
      :allow_nil => true, 
      :allow_blank => false, 
      message: " Entry is not valid. Please check your entry" }

  validates :ssbalpriprou, numericality: { 
    less_than_or_equal_to: 9.99, 
    greater_than_or_equal_to: 0.01, 
    :allow_nil => true, 
    :allow_blank => false, 
    message: 'Unit price expected to be between 9.99 and 0.01' }

  LANGUAGES = ['English', 'Spanish', 'Tagalog', 'Chinese', 'Vietnamese', 'Korean', 'Japanese', 'Hindi', 'Khmer', 'Thai']

  ML_COLUMNS = Ssbal.column_names.find_all { |n| /ssbalpri(\w)b(\d)ml/.match n }
  ML_COLUMNS.each do |ml_col|
    ml_setter_method_name = ml_col.gsub('ml', '_multi_lang=')
    ml_getter_method_name = ml_col.gsub('ml', '_multi_lang')

    define_method( ml_setter_method_name ) do | languages |
      self.send "#{ml_col}=", ( (languages & LANGUAGES).map { |l| 2**LANGUAGES.index(l) }.sum )
    end

    define_method( ml_getter_method_name ) do
      LANGUAGES.reject { |l| ( ( self.send( ml_col ) || 0) & 2**LANGUAGES.index(l)).zero? }
    end
  end
end