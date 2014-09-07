module Orderable
  extend ActiveSupport::Concern

  included do
    before_create :set_weight
    default_scope { order('weight ASC') }
  end

  module ClassMethods
    def reorder!(ids)
      self.transaction do
        ids.each_with_index do |id, index|
          self.find(id).update_attribute(:weight, index)
        end
      end
    end
  end

  private

  def set_weight
    self.weight = self.class.maximum(:weight)
  end
end
