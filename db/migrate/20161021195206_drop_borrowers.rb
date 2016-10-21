class DropBorrowers < ActiveRecord::Migration
  def change
  	drop_table :borrowers
  end
end
