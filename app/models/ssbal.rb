class Ssbal < ActiveRecord::Base
  include Responseable
  LANGUAGES = ['English', 'Spanish', 'Tagalog', 'Chinese', 'Vietnamese', 'Korean', 'Japanese', 'Hindi', 'Khmer', 'Thai']
  SSBALPRISB1ML = SSBALPRISB2ML = SSBALPRISB3ML =
  SSBALPRIOB1ML = SSBALPRIOB2ML = SSBALPRIOB3ML = 
  LANGUAGES

  ML_COLUMNS = Ssbal.column_names.find_all { |n| /^ssbalpri(\w)b(\d)ml$/.match n }
  ML_COLUMNS.each do |ml_col|
    # setter
    # define_method( "#{ml_col}_multi_select=" ) do | languages |
      # self.send "#{ml_col}=", ( (languages & LANGUAGES).map { |l| 2**LANGUAGES.index(l) }.sum )
    # end
    # getter
    define_method( "#{ml_col}_multi_select" ) do
      LANGUAGES.reject { |l| ( ( self.send( ml_col ) || 0) & 2**LANGUAGES.index(l)).zero? }
    end
  end
end