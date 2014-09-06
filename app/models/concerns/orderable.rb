module Orderable
  extend ActiveSupport::Concern

  included do
    before_create :set_weight
    default_scope { order('weight ASC') }
  end

  private

  def set_weight
    self.weight = self.class.maximum(:weight)
  end
end
