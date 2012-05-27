class CreateCompaigns < ActiveRecord::Migration
  def change
    create_table :compaigns do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
