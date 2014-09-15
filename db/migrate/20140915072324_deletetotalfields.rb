class Deletetotalfields < ActiveRecord::Migration
def change
remove_column :salbals , :salbaltotbe
remove_column :salbals , :salbaltotbep
remove_column :salbals, :salbaltothrs
remove_column :salpps , :salpptotbe
remove_column :salpps , :salpptotbep
remove_column :salpps , :salpptothrs
remove_column :salpws , :salpwtotbe
remove_column :salpws , :salpwtotbep
remove_column :salpws , :salpwtothrs
remove_column :salvbms  , :salvbmtotbe
remove_column :salvbms  , :salvbmtotbep
remove_column :salvbms  , :salvbmtothrs
remove_column :salbcs , :salbctotbe
remove_column :salbcs , :salbctotbep
remove_column :salbcs , :salbctothrs
remove_column :salcans  , :salcanbe
remove_column :salcans , :salcanbep
remove_column :salcans , :salcantothrs
remove_column :salmeds , :salmedhrs
remove_column :saldojos , :saldojobe
remove_column :saldojos , :saldojobep
remove_column :saldojos , :saldojohrs
remove_column :saloths  , :salothbe
remove_column :saloths  , :salothbep
remove_column :saloths  , :salothhrs
  end
end
