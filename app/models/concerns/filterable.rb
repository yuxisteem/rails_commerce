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

    attr_reader :klass, :attr_vals_table_name, :attr_table_name, :table_name, :foreign_key

    def initialize(klass)
      @klass = klass
      @attr_vals_table_name = "#{@klass.name.downcase}_attribute_values"
      @table_name = klass.name.tableize
      @foreign_key = klass.name.foreign_key
    end

    def by_attributes(attributes)
      entities = klass.all
      p attributes
      if attributes
        join_sql = attributes.map do |attr_id, values|

          attr_alias = 'attr_' + attr_id.to_i.to_s # oh...
          attr_values_sql = values
                              .map { |attr_value| "#{attr_alias + '.value'} = #{sanitize(attr_value)}" }
                              .join(' OR ')


          %(
            INNER JOIN #{attr_vals_table_name} #{attr_alias}
            ON #{attr_alias}.#{foreign_key} = #{table_name}.id
            AND  #{attr_alias}.#{klass.name.downcase}_attribute_id = #{attr_id.to_i}
            AND ( #{attr_values_sql} )
          )
        end
      end
      entities = entities.joins(join_sql).distinct
      entities
    end

    def by_keyword(keyword)
      keyword = "%#{sanitize(keyword)}%"
      klass.where('name LIKE ? OR description LIKE ?', keyword, keyword)
    end

    def sanitize(str)
      ActiveRecord::Base.sanitize(str)
    end
  end
end
