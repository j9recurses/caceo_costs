json.array!(@election_technologies) do |election_technology|
  json.extract! election_technology, :id
  json.url election_technology_url(election_technology, format: :json)
end
