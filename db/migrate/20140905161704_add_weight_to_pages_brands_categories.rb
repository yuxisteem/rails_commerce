class AddWeightToPagesBrandsCategories < ActiveRecord::Migration
  def change
    columns = [:pages, :categories, :brands]

    columns.each do |column|
      add_column column, :weight, :integer
    end

    columns.map { |x| x.to_s.camelcase.singularize.constantize }.each do |klass|
      klass.all.find_each do |entity|
        entity.update(weight: entity.id)
      end
    end
  end
end
