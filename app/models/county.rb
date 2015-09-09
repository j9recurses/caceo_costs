class County < ActiveRecord::Base
  has_one :access_code, inverse_of: :county
  has_many :users, inverse_of: :county
  has_many :survey_responses, inverse_of: :county
  has_many :responses, through: :survey_responses, as: :county

  # for serialization
  def key
    name.gsub(' County', '').gsub(' ', '-').downcase
  end
end
