class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.belongs_to :member, null: false
      t.string   "title"
      t.string   "address"
      t.string   "city"
      t.string   "state"
      t.string   "description"
      t.string   "zip_code"
      t.float    "latitude"
      t.float    "longitude"
      t.string   "img_url"
      t.timestamps
    end
  end
end
