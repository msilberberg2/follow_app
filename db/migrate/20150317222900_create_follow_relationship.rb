class CreateFollowRelationship < ActiveRecord::Migration
  def change
    create_table :followrelationships do |t|
      t.integer :follower_id
      t.integer :followee_id
			t.timestamps
    end
  end
end
