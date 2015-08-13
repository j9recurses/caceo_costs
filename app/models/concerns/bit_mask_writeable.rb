module BitMaskWriteable
  extend ActiveSupport::Concern
  included do
    questions.multi_select.each do |q|
      options = "#{q.survey_id}::#{q.field.upcase}".constantize
      # write array selection to bit mask
      define_method("#{q.field}_multi_select=") do | arr_selection |
        bit_selection = ( ((arr_selection || []) & options).map { |l| 2**options.index(l) }.sum )
        self.send("#{q.field}=", bit_selection)
      end
    end
  end
end