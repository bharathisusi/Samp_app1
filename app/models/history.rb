class History < ActiveRecord::Base
  belongs_to :historiable, polymorphic: true

  class << self

  end
end
