class TechVotingMachine < ActiveRecord::Base
  include TechResponseable

  def self.title
    'Voting Equipment Purchases'
  end

  def self.id
    self.to_s
  end

  def self.descriptions
    {
      'voting_equip_type' => 'Voting Equipment Type',
      'purchase_dt'       => 'Purchase Date',
      'equip_make'        => 'Make and Model',
      'purchase_price'    => 'Purchase Price',
      'purchase_price_services' => 'Purchase Price Includes Some Services?',
      'quantity'          => 'Quantity',
      'offset_funds_src'  => 'Offsetting Funds Source',
      'offset_amount'     => 'Offsetting Funds Amount',
    }
  end
end
