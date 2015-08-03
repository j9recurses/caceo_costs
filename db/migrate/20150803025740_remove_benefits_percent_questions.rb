class RemoveBenefitsPercentQuestions < ActiveRecord::Migration
  def change
    remove_column :salbcs, :salbcbepsp
    remove_column :salbcs, :salbcbetsp
    remove_column :salcans, :salcanbepsp
    remove_column :salcans, :salcanbetsp
    remove_column :saldojos, :saldojobepsp
    remove_column :saldojos, :saldojobetsp
    remove_column :salmeds, :salmedbepsp
    remove_column :salmeds, :salmedbetsp
    remove_column :saloths, :salothbepsp
    remove_column :saloths, :salothbetsp
    remove_column :salpps, :salppbepsp
    remove_column :salpps, :salppbetsp
    remove_column :salpws, :salpwbepsp
    remove_column :salpws, :salpwbetsp
    remove_column :salvbms, :salvbmbepsp
    remove_column :salvbms, :salvbmbetsp
  end
end
