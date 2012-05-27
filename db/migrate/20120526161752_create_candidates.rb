class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name,         :null => false
      t.integer :counted,     :default => 0
      t.integer :not_counted, :default => 0
      t.integer :compaign_id, :null => false
      t.timestamps
    end
  end
end
