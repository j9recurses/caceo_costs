class DailyActivity < ActiveRecord::Base

  SURVEYS = [Postage, Salbal, Salbc, Salcan, Saldojo, Salmed, Saloth, Salpp, Salpw, Salvbm, Ssbal, Ssbc, Sscan, Ssmed, Ssoth, Sspp, Sspw, Ssveh]

  def self.county_surveys
    data = CaCountyInfo.where.not(id: 59).map { |county|
      all_relations = SURVEYS.map do |klass| 
        klass.where('county = ? AND updated_at > ?', county.id, Time.now.beginning_of_day)
      end
      non_empty_relations = all_relations.reject { |relation| relation.empty? }
      { county.id => non_empty_relations }
    }.reject { |hash| hash.values.flatten.empty? }
  end
end