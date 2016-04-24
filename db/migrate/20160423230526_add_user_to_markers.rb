class AddUserToMarkers < ActiveRecord::Migration
  def change
    add_column :markers, :user, :string
  end
end
