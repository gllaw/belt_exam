class DropLenders < ActiveRecord::Migration
  def change
  	drop_table :lenders
  end
end
