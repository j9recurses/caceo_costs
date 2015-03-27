class Option < ActiveRecord::Base
  belongs_to :question, inverse_of: :options
end