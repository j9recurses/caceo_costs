Category.where(:name => 'name').destroy_all

#categories are in the 5.csv...need to delete them out of 4.
fieldstodelete = ['salbaltotbe','salbaltotbep', 'salbaltothrs','salpptotbe','salpptotbep','salpptothrs','salpwtotbe','salpwtotbep','salpwtothrs','salvbmtotbe','salvbmtotbep','salvbmtothrs','salbctotbe','salbctotbep','salbctothrs','salcanbe','salcanbep',' salcantothrs','salmedhrs','saldojobe','saldojobep','saldojohrs','salothbe','salothbep',' salothhrs']
fieldstodelete.each do | fd|
  CategoryDescription.where(:field => fd).destroy_all
end
