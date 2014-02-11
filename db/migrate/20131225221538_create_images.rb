class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.timestamps
      t.references :imageable, polymorphic: true, index: true
    end
    add_attachment :images, :image
  end
end
