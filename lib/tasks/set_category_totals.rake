namespace :caceo do
  desc 'update categories with totals, after bug from general survey not sorting on initialize'
  task add_totals: :environment do
    relation = Category.where('updated_at > ?', 5.days.ago)

    relation.each do |cat|
      klass = cat.model_name.camelize.singularize.constantize
      surv = klass.where(county: cat.county, election_year_id: cat.election_year_id).last

      g = GeneralSurvey.new(surv)
      p = SurveyPersistor.new(g)
      p.save
    end
  end
end