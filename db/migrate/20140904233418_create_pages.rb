class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :text
      t.string :seo_title
      t.text :seo_meta
      t.boolean :visible

      t.timestamps
    end
  end
end
