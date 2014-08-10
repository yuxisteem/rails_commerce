module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter
      @filter ||= Filterable::Base.new(self)
    end
  end

  class Base
    def initialize(instance)
      @instance = instance
      @attributes_table_name = "#{@instance.name.downcase}_attribute_values"
      @table_name = instance.name.tableize
      @foreign_key = instance.name.foreign_key
    end

    def by_attributes(attributes)
      entities = @instance.all
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

    def sanitize(str)
      ActiveRecord::Base.sanitize(str)
    end
  end
end
