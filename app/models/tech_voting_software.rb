class TechVotingSoftware < ActiveRecord::Base
  def count_questions
    6
  end

  def count_answers
    @total_responses ||= self.attributes.inject(0) do |sum, k_v|
      if ['id', 'updated_at', 'created_at', 'county'].include?(k_v[0])
        sum
      else
        k_v[1].blank? ? sum : sum + 1
      end
    end
  end

  def completed_ratio
    (count_answers.to_f / count_questions.to_f).round(2)
  end

  def percent_complete
    (completed_ratio * 100).to_i
  end
end
