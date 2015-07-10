module TechResponseable
  extend ActiveSupport::Concern
  included do
    belongs_to :county
  end

  class_methods do
    def fields
      descriptions.keys
    end
  end

  def fields
    self.class.descriptions.keys
  end

  def fields_values
    fields.map { |f| [f, send(f)]  }
  end

  def values
    fields.map { |f| send(f) }
  end

  def un_sum_able_fields
    ['voting_equip_type', 'purchase_dt', 'equip_make', 
      'purchase_price_services', 'quantity', 'offset_funds_src', 
      'offset_amount', 'software_item']
  end

  def total
    @total ||= (fields - un_sum_able_fields).inject(0) do |memo, f|
      memo = memo + send(f).to_i
    end
  end
end