class TechVotingSoftware < ActiveRecord::Base
  include TechResponseable

  def self.title
    'Tabulation and Other Equipment Purchases'
  end

  def self.id
    self.to_s
  end

  def self.descriptions
    {
      'software_item' => 'Tabulation and Other Equipment Type',
      'purchase_dt'   => 'Purchase Date',
      'purchase_price_hardware' => 'Hardware Purchase Price',
      'purchase_price_software' => 'Software Purchase Price',
      'mat_charges' => 'Annual Maintenance Charges For Software',
      'labor_costs' => 'Average Annual Labor Costs',
    }
  end
end
