module BitMaskable
  extend ActiveSupport::Concern
  included do
    questions.multi_select.each do |q|
      options = "#{q.survey_id}::#{q.field.upcase}".constantize

      define_method( "#{q.field}_multi_select" ) do
        options.reject { |l| ( ( self.send( q.field ) || 0) & 2**options.index(l)).zero? }
      end

      define_method("#{q.field}_multi_select=") do | selection |
        bit_selection = ( ((selection || []) & options).map { |l| 2**options.index(l) }.sum )
        self.send("#{q.field}=", bit_selection)
      end
    end
  end
end
