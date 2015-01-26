class Faq < ActiveRecord::Base
  default_scope { order(created_at: :asc) }
end
