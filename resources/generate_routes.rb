
#need to ruby pluralize everythings
#from the rails console, generate the routes file
routes = Category.uniq.pluck(:model_name)
routes.each do | r|
   puts "resources :" + r + s
  end


categories.each do | c|
2.1.2 :016 >     tbl = "create_table :" + c + "s do |t| \n t.integer :election_year_id \n t.integer :county "
2.1.2 :017?>   fz = CategoryDescription.where(model_name: c).uniq.pluck(:field)
2.1.2 :018?>   fz.each do | f|
2.1.2 :019 >       tbl = tbl + "\n t.integer :" + f + ' '
2.1.2 :020?>     end
2.1.2 :021?>   tbl = tbl + "\n t.timestamps \n end"

categories.each do | d|
2.1.2 :018 >     puts "drop table :" + d
2.1.2 :019?>   end




*******
link_to 'Salaries related to VBM', salvbms_path(:election_year_id => 9,:category_id => 108653)
*******
link_to 'Salaries related to VBM', salvbms_path(:election_year_id => 9,:category_id => 108654)
*******
link_to 'Salaries related to VBM', salvbms_path(:election_year_id => 9,:category_id => 108655)
*******
link_to 'Salaries related to VBM', salvbms_path(:election_year_id => 9,:category_id => 108656)
ink_to 'Ballot Printing and Supplies',sample_ballots_supplies_path(:election_year_id => 17,:category_id => 13000)
*******
link_to 'Postage Supplies',postages_path(:election_year_id => 17,:category_id => 13001)
*******
link_to 'Poll Worker Costs',poll_worker_supplies_path(:election_year_id => 17,:category_id => 13002)
*******
link_to 'Polling Place Costs',polling_place_supplies_path(:election_year_id => 17,:category_id => 13003)
*******
