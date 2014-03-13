class AddFilterSwitchToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :attribute_filter_enabled, :boolean, default: true
    add_column :categories, :brand_filter_enabled, :boolean, default: true
  end
end
