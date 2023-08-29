class CreateFollowerRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :follower_relationships do |t|
      t.integer :follower_id
      t.integer :followable_id
      t.boolean :approved

      t.timestamps
    end
  end
end
