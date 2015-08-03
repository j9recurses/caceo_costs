class RemoveBenefitsPercentNaFields < ActiveRecord::Migration
  def change
    remove_column :salbcs, :salbcbepsp_na
    remove_column :salbcs, :salbcbetsp_na
    remove_column :salcans, :salcanbepsp_na
    remove_column :salcans, :salcanbetsp_na
    remove_column :saldojos, :saldojobepsp_na
    remove_column :saldojos, :saldojobetsp_na
    remove_column :salmeds, :salmedbepsp_na
    remove_column :salmeds, :salmedbetsp_na
    remove_column :saloths, :salothbepsp_na
    remove_column :saloths, :salothbetsp_na
    remove_column :salpps, :salppbepsp_na
    remove_column :salpps, :salppbetsp_na
    remove_column :salpws, :salpwbepsp_na
    remove_column :salpws, :salpwbetsp_na
    remove_column :salvbms, :salvbmbepsp_na
    remove_column :salvbms, :salvbmbetsp_na
  end
end
