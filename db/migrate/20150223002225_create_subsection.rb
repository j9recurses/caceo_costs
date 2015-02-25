class CreateSubsection < ActiveRecord::Migration
  def change
    create_table :subsections do |t|
      t.string :title
      t.boolean :totalable
    end
  end
end
