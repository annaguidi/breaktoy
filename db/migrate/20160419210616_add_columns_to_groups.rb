class AddColumnsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :city, :string, null: false
    add_column :groups, :country, :string, null: false
  end
end
