class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :group, null: false
      t.belongs_to :user, null: false
      t.boolean :accepted, null: false, default: false
    end
  end
end
