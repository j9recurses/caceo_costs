module BitMaskReadable
  extend ActiveSupport::Concern

  included do
    questions.multi_select.each do |q|
      options = "#{q.survey_id}::#{q.field.upcase}".constantize
      # read out array selection, e.g. to populate virtual fields
      define_method( "#{q.field}_multi_select" ) do
        options.reject { |l| ( ( self.send( q.field ) || 0) & 2**options.index(l)).zero? }
      end
    end
  end
end
