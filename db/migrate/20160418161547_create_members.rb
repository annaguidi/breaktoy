class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :user, null: false
      t.belongs_to :group, null: false
      t.boolean :owner, null: false, default: false
    end
  end
end
