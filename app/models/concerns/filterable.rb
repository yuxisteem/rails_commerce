module Filterable
  extend ActiveSupport::Concern

  included do
    scope :by_attributes, ->(attributes) { filter.by_attributes(attributes) }
    scope :by_keyword, ->(keyword) { filter.by_keyword(keyword) }
  end

  module ClassMethods
    def filter
      @filter ||= Filterable::Base.new(self)
    end
  end

  class Base
    def initialize(klass)
      @klass = klass
      @attributes_table_name = "#{@klass.name.downcase}_attribute_values"
      @table_name = klass.name.tableize
      @foreign_key = klass.name.foreign_key
    end

    def by_attributes(attributes)
      entities = @klass.all
      if attributes
        join_sql = attributes.map do |key, value|

          attr_values_sql = value.map do |attr_value|
            "#{sanitize('attr_' + key)}.value = #{sanitize(attr_value)}"
          end.join(' OR ')

          %(
            INNER JOIN #{@attributes_table_name} attr_#{key}
            ON #{sanitize('attr_' + key)}.#{@foreign_key} = #{@table_name}.id
            AND ( #{attr_values_sql} )
          )
        end
      end
      entities = entities.joins(join_sql).distinct
      entities
    end

    def by_keyword(keyword)
      keyword = "%#{keyword}%"
      Product.where('name LIKE ? OR description LIKE ?', keyword, keyword)
    end

    def sanitize(str)
      ActiveRecord::Base.sanitize(str)
    end
  end
end
