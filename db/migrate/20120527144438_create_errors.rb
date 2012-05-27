class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.string :name,   :null => false
      t.integer :count, :default => 0

      t.timestamps
    end
  end
end
