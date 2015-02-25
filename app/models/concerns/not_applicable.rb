module NotApplicable
  extend ActiveSupport::Concern
  
  module ClassMethods
    def na_questions
      questions.where(na_able: true)
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
    
    klass.na_questions.each do |question|
      define_method "#{question.field}_value" do
        if send(question.field) == SurveyNa::NA_VALUES[ klass.column_types[question.field].type ]
          nil
        else
          send(question.field)
        end
      end

      define_method "#{question.field}_na" do
        if send(question.field) == SurveyNa::NA_VALUES[ klass.column_types[question.field].type ]
          true
        else
          false
        end
      end
    end
  end
end