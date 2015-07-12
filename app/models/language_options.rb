class LanguageOptions
  SSBAL_LANGUAGES = [
    'English', 'Spanish', 'Tagalog', 'Chinese', 'Vietnamese', 
    'Korean', 'Japanese', 'Hindi', 'Khmer', 'Thai'
  ]

  SSBAL_SSBALPRISB1ML = SSBAL_SSBALPRISB2ML = SSBAL_SSBALPRISB3ML =
  SSBAL_SSBALPRIOB1ML = SSBAL_SSBALPRIOB2ML = SSBAL_SSBALPRIOB3ML = 
  SSBAL_LANGUAGES

  

# class LanguageOptions
#   SSBAL_LANGUAGES = [
#     'English', 'Spanish', 'Tagalog', 'Chinese', 'Vietnamese', 
#     'Korean', 'Japanese', 'Hindi', 'Khmer', 'Thai'
#   ]

#   SSBAL_SSBALPRISB1ML = SSBAL_SSBALPRISB2ML = SSBAL_SSBALPRISB3ML =
#   SSBAL_SSBALPRIOB1ML = SSBAL_SSBALPRIOB2ML = SSBAL_SSBALPRIOB3ML = 
#   SSBAL_LANGUAGES

#   module Accessible
#     extend conc
#     ML_COLUMNS = Ssbal.column_names.find_all { |n| /ssbalpri(\w)b(\d)ml/.match n }
#     ML_COLUMNS.each do |ml_col|
#     ml_setter_method_name = ml_col.gsub('ml', '_multi_lang=')
#     ml_getter_method_name = ml_col.gsub('ml', '_multi_lang')

#     define_method( ml_setter_method_name ) do | languages |
#       self.send "#{ml_col}=", ( (languages & LANGUAGES).map { |l| 2**LANGUAGES.index(l) }.sum )
#     end

#     define_method( ml_getter_method_name ) do
#       LANGUAGES.reject { |l| ( ( self.send( ml_col ) || 0) & 2**LANGUAGES.index(l)).zero? }
#     end
#   end

#   end
# end
end