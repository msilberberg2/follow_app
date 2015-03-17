class CreateUser < ActiveRecord::Migration
  def self.up
		create_table :users do |t|
      t.string :handle
    end
  end
	
	def self.down
	end
end
