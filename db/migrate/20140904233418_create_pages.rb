class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :text
      t.string :seo_url
      t.boolean :visible

      t.timestamps
    end
  end
end
