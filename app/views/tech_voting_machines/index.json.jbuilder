json.array!(@tech_voting_machines) do |tech_voting_machine|
  json.extract! tech_voting_machine, :id, :voting_equip_type, :purchase_dt, :equip_make, :purchase_price, :quantity, :offset_funds_type, :offset_amount
  json.url tech_voting_machine_url(tech_voting_machine, format: :json)
end
